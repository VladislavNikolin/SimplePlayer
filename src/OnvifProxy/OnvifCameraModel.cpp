// local headers
#include "OnvifCameraModel.hpp"

OnvifCameraModel::OnvifCameraModel(QObject *parent) : QAbstractListModel(parent), _count(0)
{
}

QQmlListProperty<OnvifCamera> OnvifCameraModel::content()
{
    return QQmlListProperty<OnvifCamera>(
        this,
        nullptr, // no need for data in funcs below
        &OnvifCameraModel::onvifCameraModelAppend,
        &OnvifCameraModel::onvifCameraModelCount,
        &OnvifCameraModel::onvifCameraModelAt,
        &OnvifCameraModel::onvifCameraModelClear);
}

void OnvifCameraModel::onvifCameraModelAppend(QQmlListProperty<OnvifCamera> *list, OnvifCamera *camera)
{
    OnvifCameraModel *model = qobject_cast<OnvifCameraModel *>(list->object);
    if (model && camera)
        model->append(camera);
}

qsizetype OnvifCameraModel::onvifCameraModelCount(QQmlListProperty<OnvifCamera> *list)
{
    OnvifCameraModel *model = qobject_cast<OnvifCameraModel *>(list->object);
    if (model)
        return model->_cameras.count();

    return 0;
}

OnvifCamera *OnvifCameraModel::onvifCameraModelAt(QQmlListProperty<OnvifCamera> *list, qsizetype i)
{
    OnvifCameraModel *model = qobject_cast<OnvifCameraModel *>(list->object);
    if (model)
        return model->get(i);

    return 0;
}

void OnvifCameraModel::onvifCameraModelClear(QQmlListProperty<OnvifCamera> *list)
{
    OnvifCameraModel *model = qobject_cast<OnvifCameraModel *>(list->object);
    if (model)
        model->_cameras.clear();
}

QHash<int, QByteArray> OnvifCameraModel::roleNames() const
{
    static QHash<int, QByteArray> *pHash;
    if (!pHash)
    {
        pHash = new QHash<int, QByteArray>;
        (*pHash)[Qt::UserRole + 1] = "onvifCameraModel";
    }
    return *pHash;
}

int OnvifCameraModel::rowCount(const QModelIndex &parent) const
{
    return _cameras.count();
}

QVariant OnvifCameraModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role)
    return QVariant::fromValue(_cameras[index.row()]);
}

int OnvifCameraModel::count() const
{
    return _count;
}

void OnvifCameraModel::setCount(int count)
{
    if (_count == count)
        return;

    _count = count;
    emit countChanged(_count);
}

void OnvifCameraModel::append(OnvifCamera *camera)
{
    int i = _cameras.size();
    beginInsertRows(QModelIndex(), i, i);
    _cameras.append(camera);

    // Emit changed signals
    emit countChanged(count());

    endInsertRows();
}

void OnvifCameraModel::insert(OnvifCamera *camera, int i)
{
    beginInsertRows(QModelIndex(), i, i);
    _cameras.insert(i, camera);

    // Emit changed signals
    emit countChanged(count());

    endInsertRows();
}

void OnvifCameraModel::remove(int i)
{
    beginRemoveRows(QModelIndex(), i, i);
    _cameras.remove(i);

    // Emit changed signals
    emit countChanged(count());

    endRemoveRows();
}

// void OnvifCameraModel::removeAll(int i)
// {
//     beginInsertRows(QModelIndex(), i, i);
//     _cameras.remove(i);

//     // Emit changed signals
//     emit countChanged(count());

//     endInsertRows();
// }

OnvifCamera *OnvifCameraModel::get(int i)
{
    return _cameras[i];
}

void OnvifCameraModel::reset()
{
    beginResetModel();

    _cameras.clear();
    
    endResetModel();
}

void OnvifCameraModel::scan()
{
    reset();

    OnvifSession session;
    initializeSession(&session);
    int camera_count = broadcast(&session);
    for (int i = 0; i < camera_count; i++)
    {
        OnvifData data;
        prepareOnvifData(i, &session, &data);
        OnvifCamera *camera = new OnvifCamera(data);
        append(camera);
    }
    closeSession(&session);
}
