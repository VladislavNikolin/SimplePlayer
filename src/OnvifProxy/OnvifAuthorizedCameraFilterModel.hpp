#pragma once

// Qt headers
#include <QSortFilterProxyModel> 

// local headers
#include "OnvifCameraModel.hpp"


class OnvifAuthorizedCameraFilterModel : public QSortFilterProxyModel {
    Q_OBJECT

    Q_PROPERTY(OnvifCameraModel* sourceModel READ sourceModel WRITE setSourceModel)

public:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
    OnvifCameraModel *sourceModel() const;
    void setSourceModel(OnvifCameraModel *sourceModel);

    Q_INVOKABLE void append(OnvifCamera *camera);
    Q_INVOKABLE void insert(OnvifCamera *camera, int i);
    Q_INVOKABLE void remove(int i);
    Q_INVOKABLE OnvifCamera *get(int i);
    
    Q_INVOKABLE void filter();
};
 