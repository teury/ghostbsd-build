#!/bin/sh

set -e -u

lightdm_setup()
{
  if [ -f ${release}/usr/local/etc/lightdm/lightdm.conf ] ; then
    sed -i "" '/#exit-on-failure=false/a\
autologin-user=${liveuser}\
autologin-user-timeout=0\
' ${release}/usr/local/etc/lightdm/lightdm.conf
  fi

  if [ -f ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf ] ; then
    echo "background=/usr/local/share/backgrounds/ghostbsd/White-Trees-Empire.jpg" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
    echo "user-background=true" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
    #echo "theme-name=Ambiance-Blackout-Flat-Aqua" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
    #echo "icon-theme-name=Vivacious-Colors-Full-Dark" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
  fi
  setup_xinit

}

gdm_setup()
{
  echo 'gdm_enable="YES"' >> ${release}/etc/rc.conf
  setup_xinit
}

setup_xinit()
{
  if [ "${desktop}" == "mate" ] ; then
    echo "exec ck-launch-session mate-session" > ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec ck-launch-session mate-session" > ${release}/root/.xinitrc
  elif [ "${desktop}" == "xfce" ] ; then
    echo "exec ck-launch-session startxfce4" > ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec ck-launch-session startxfce4" > ${release}/root/.xinitrc
  fi
}
