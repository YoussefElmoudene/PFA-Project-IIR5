/* eslint-disable */
import {FuseNavigationItem} from '@fuse/components/navigation';

export const defaultNavigation: FuseNavigationItem[] = [
    {
        id: 'home',
        title: 'Dashboard',
        type: 'basic',
        icon: 'heroicons_outline:chart-pie',
        link: '/admin/home'
    }, {
        id: 'users',
        title: 'Demandeurs',
        type: 'basic',
        icon: 'heroicons_outline:users',
        link: '/admin/users'
    }
];
export const compactNavigation: FuseNavigationItem[] = [
    {
        id: 'home',
        title: 'Home',
        type: 'basic',
        icon: 'heroicons_outline:chart-pie',
        link: '/demandeur/home'
    },
    {
        id: 'demandes',
        title: 'Demandes',
        type: 'basic',
        icon: 'heroicons_outline:chart-pie',
        link: '/demandeur/demandes'
    }
];
export const futuristicNavigation: FuseNavigationItem[] = [
    {
        id: 'home',
        title: 'Home',
        type: 'basic',
        icon: 'heroicons_outline:chart-pie',
        link: '/demandeur/home'
    }
];
export const horizontalNavigation: FuseNavigationItem[] = [
    {
        id: 'home',
        title: 'Home',
        type: 'basic',
        icon: 'heroicons_outline:chart-pie',
        link: '/demandeur/home'
    }
];
