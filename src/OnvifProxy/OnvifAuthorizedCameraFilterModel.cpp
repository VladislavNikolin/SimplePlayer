#include "OnvifAuthorizedCameraFilterModel.hpp"

bool OnvifAuthorizedCameraFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    return sourceModel()->get(source_row)->isAuthorized();
}

OnvifCameraModel *OnvifAuthorizedCameraFilterModel::sourceModel() const
{
    return static_cast<OnvifCameraModel *>(QSortFilterProxyModel::sourceModel());
}

void OnvifAuthorizedCameraFilterModel::setSourceModel(OnvifCameraModel *sourceModel)
{
    QSortFilterProxyModel::setSourceModel(sourceModel);
}

void OnvifAuthorizedCameraFilterModel::append(OnvifCamera *camera)
{
    sourceModel()->append(camera); 
}

void OnvifAuthorizedCameraFilterModel::insert(OnvifCamera *camera, int i)
{
    sourceModel()->insert(camera, i); 
}

void OnvifAuthorizedCameraFilterModel::remove(int i)
{
    sourceModel()->remove(i); 
}

OnvifCamera *OnvifAuthorizedCameraFilterModel::get(int i)
{
    return sourceModel()->get(i); 
}

void OnvifAuthorizedCameraFilterModel::filter()
{
    invalidateFilter();
}
