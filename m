Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA502206; Mon, 18 Aug 1997 14:24:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA04191 for linux-list; Mon, 18 Aug 1997 14:23:29 -0700
Received: from sydney.sydney.sgi.com (sydney.sydney.sgi.com [134.14.48.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA04160 for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 14:23:25 -0700
Received: from zephyr.sydney.sgi.com by sydney.sydney.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/930416.SGI)
	for <@sydney.sydney.sgi.com:linux@cthulhu.engr.sgi.com> id HAA07504; Tue, 19 Aug 1997 07:23:23 +1000
Received: (from stepheng@localhost) by zephyr.sydney.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id HAA02301 for linux@cthulhu.engr.sgi.com; Tue, 19 Aug 1997 07:23:21 +1000
From: "Stephen Gass" <stepheng@zephyr.sydney.sgi.com>
Message-Id: <9708190723.ZM2299@zephyr.sydney.sgi.com>
Date: Tue, 19 Aug 1997 07:23:20 -0500
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: NFS booting from IRIX
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi All,

After a couple of hours yeaterday, I managed to get the precompiled vmlinux and
root distribution going without too many problems from linux. I had more
trouble setting up NFS booting than anything else, so I have expanded on some
of the instruction already produced to help those who want to nfs boot from
IRIX. I think I have covered some of the gotchas below. I have two questions
though :

(a) How do you install rpms without rpm ??? root-be-0.00.cpio.gz does not
contain rpm.

(b) Where are the ext2fs tools ?? Are they an RPM in e2fsprogs-1.10-0.mips.rpm
??

Regards,


Stephen Gass


--------------------------------------------------------------------------------


                  Booting Linux from IRIX via NFS

1) From ftp://ftp.linux.sgi.com/pub/mips-linux/, retrieve the following files :

    - glibc-2.0.4-1.tar.gz
    - root-be-0.00.cpio.gz

   From ftp://ftp.linux.sgi.com/pub/test/, retrieve the following files :

    - vmlinux-970813-jwr.gz

2) Scrounge for disk space (115Mb min. ) on any 5.3 or > machine. Create / link
a folder to the linux root. eg

     /tftpboot/linux

Copy root-be-0.00.cpio.gz, glibc-2.0.4-1.tar.gz and vmlinux-970813-jwr.gz to
the directory, and execute the following commands from the linux directory :

     gzip -dc root-be-0.00.cpio.gz | cpio -id
     gzip -dc root-be-0.00.cpio.gz | tar -xvf -
     gzip -d vmlinux-970813-jwr.gz
     mv vmlinux-970813-jwr vmlinux

This should spool the O/S image onto the IRIX NFS server, use cpio -idv for
verbose mode. Remember you may need as much as 115Mb for the initial install (
including root image, RPMs etc etc ). Also before going much further it would
be worth making sure that the graphics board in the Indy is not an XZ, when you
do an hinv from IRIX, and your graphics board is reported as :

    Graphics board: GR3-XZ, rather than

    Graphics board: Indy 8-bit,  or
    Graphics board: Indy 24-bit

Then, you better find a different Indy now.

3) from the directory you installed the linux root filesystem, go to the linux
etc directory and edit mtab, and optionally create/edit the hosts file and
resolv.conf file to be applicable to your domain.

4) Make sure rarpd and bootp have been enabled on the NFS server by checking
the following :

(i) In /usr/etc/inetd.conf, the bootp and tftp entries should look ike this :

       bootp   dgram   udp     wait    root    /usr/etc/bootp  bootp
       tftp    dgram   udp     wait    guest   /usr/etc/tftpd  tftpd

(ii) execute :  chkconfig rarpd on

5) Make sure that there are entries in /etc/ethers on the NFS server for each
of the Indys you wish to boot linux, eg :

#
# /etc/ethers maps Ethernet addresses to hostnames
#
# The library routine ether_line() uses this file.
#
# The format of a line is:
#
#       x:x:x:x:x:x     hostname
#
# where the first field is the 48-bit Ethernet address
# expressed as 6 hexadecimal bytes.
#
8:0:69:9:3f:f8  zephyr

Similarly, make sure that there are /etc/hosts entries on the NFS server for
each of the Indys you will be booting, eg :

134.14.48.107   democage.sydney.sgi.com democage
134.14.48.73    zephyr.sydney.sgi.com zephyr


6) Finally, for each of the machines booting linux, you need to provide a mount
point off  /tftpboot. The mount directory should be the ip address of the Indy
you will be booting from eg :

for zephyr,

/tftpboot/134.14.48.73

After this the NFS server is ready for booting from. If you have modified
/usr/etc/inetd.conf, then you will need to :

         /etc/killall -HUP inetd

7) From the Indy you will be booting, power down the machine. Re-apply poer and
wait for the power-on diags to finish. When the splash screen comes up 'Hit esc
for maintenance' go into mainetance mode and start up the PROM monitor. From
here, you need to type the following :

boot -f bootp()<nfs.server>:<path to vmlinux> nfsaddrs=<client.ip>:<host.ip>
 eg

boot -f bootp()democage.sydney:/tftpboot/linux/vmlinux nfsaddrs=134.14.48.73:
134.14.48.107

If all goes well, this command should start linux up on any Newport graphics
equipped Indy, with or without disks !

-- 
Silicon Graphics Pty Ltd    |  E-mail: stepheng@sydney.sgi.com
446 Victoria Rd             |  Phone : +61-2-9879-9500  VM#: 56721
Gladesville, 2111, NSW      |  Mobile :+61-419-879-504

      "Force - the result of pushing on a door marked pull"
