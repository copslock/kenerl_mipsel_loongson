Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f777gqR13680
	for linux-mips-outgoing; Tue, 7 Aug 2001 00:42:52 -0700
Received: from webo.vtcif.telstra.com.au (webo.vtcif.telstra.com.au [202.12.144.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f777glV13668
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 00:42:47 -0700
Received: (from uucp@localhost) by webo.vtcif.telstra.com.au (8.8.2/8.6.9) id RAA05353; Tue, 7 Aug 2001 17:42:40 +1000 (EST)
Received: from maili.vtcif.telstra.com.au(202.12.142.17)
 via SMTP by webo.vtcif.telstra.com.au, id smtpdftwVJ_; Tue Aug  7 17:42:38 2001
Received: (from uucp@localhost) by maili.vtcif.telstra.com.au (8.8.2/8.6.9) id RAA13798; Tue, 7 Aug 2001 17:42:37 +1000 (EST)
Received: from localhost(127.0.0.1), claiming to be "mail.cdn.telstra.com.au"
 via SMTP by localhost, id smtpd0S9.t1; Tue Aug  7 17:42:16 2001
Received: from ntmsg0028.corpmail.telstra.com.au (ntmsg0028.corpmail.telstra.com.au [192.168.174.24]) by mail.cdn.telstra.com.au (8.8.2/8.6.9) with ESMTP id RAA02658; Tue, 7 Aug 2001 17:42:16 +1000 (EST)
Received: by ntmsg0028.corpmail.telstra.com.au with Internet Mail Service (5.5.2653.19)
	id <QNW565BD>; Tue, 7 Aug 2001 17:38:17 +1000
Message-ID: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAB6@ntmsg0080.corpmail.telstra.com.au>
From: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Cc: "'Keith Wesolows'" <wesolows@foobazco.org>
Subject:  MIPS-INDIGO2-KERNEL BUG
Date: Tue, 7 Aug 2001 17:38:15 +1000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Sirs 

BELOW is the ERROR

1.
make vmlinux
.................................
.................................
.................................
ld: drivers/media/media.o: uses different e_flags (0x0) fields than previous
modules (0x100)
Bad value: failed to merge target specific data of file
drivers/media/media.o
make: *** [vmlinux] Error 1


2.
 Error compiling a new kernel.

3.
 ld (linker)

4.
bash-2.04# cat  /proc/version
Linux version 2.2.14 (wesolows@fallout) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2
 release)) #2 Thu May 18 16:27:14 PDT 2000
bash-2.04#

5.N/A

6 N/A

7.
bash-2.04# set
BASH=/usr/bin/bash
BASH_VERSINFO=([0]="2" [1]="04" [2]="0" [3]="1" [4]="release"
[5]="mips-unknown-linux-
gnu")
BASH_VERSION='2.04.0(1)-release'
COLUMNS=80
DIRSTACK=()
EUID=0
GROUPS=()
HISTFILE=//.bash_history
HISTFILESIZE=500
HISTSIZE=500
HOME=/
HOSTNAME=Roland
HOSTTYPE=mips
IFS='
'
LINES=24
LOGNAME=root
MACHTYPE=mips-unknown-linux-gnu
MAIL=/var/spool/mail/root
MAILCHECK=60
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/sbin:/bin:/usr/sbin:/usr/bin
PIPESTATUS=([0]="0")
PPID=1
PS1='\s-\v\$ '
PS2='> '
PS4='+ '
PWD=/
SHELL=/usr/bin/bash
SHELLOPTS=braceexpand:hashall:histexpand:monitor:history:interactive-comment
s:emacs
SHLVL=1
TERM=vt100
UID=0
_=/proc/version
bash-2.04#

7.1
> VERSIONS:::::::::::::::::::::::::::::::
> #################################################################
> bash-2.04# /linux/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux Roland 2.2.14 #2 Thu May 18 16:27:14 PDT 2000 mips unknown
> 
> Gnu C                  egcs-2.91.66
> Gnu make               3.79
> binutils               000425
> util-linux             2.10m
> mount                  2.10m
> modutils               2.3.11
> e2fsprogs              1.18
> Linux C Library        2.0.6
> Dynamic linker (ldd)   2.0.6
> Linux C++ Library      2.9.0
> Procps                 2.0.6
> Net-tools              1.55
> Kbd                    command
> Sh-utils               2.0i
> cat: /proc/modules: No such file or directory
> Modules Loaded
> bash-2.04#
> 
7.2
bash-2.04# cat  /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : SGI Indy
BogoMIPS                : 49.97
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 670
VCEI exceptions         : 169
bash-2.04#

7.3
No modules

7.4
bash-2.04# ls -l  /proc/ioports
-r--r--r--    1 root     sys             0 Aug  8 07:33 /proc/ioports
bash-2.04# ls -l  /proc/iomem
ls: /proc/iomem: No such file or directory
bash-2.04#

7.5
No PCI

7.6
bash-2.04# ls -lt  /proc/scsi
total 0
dr-xr-xr-x    2 root     sys             0 Aug  8 07:35 SGIWD
-rw-r--r--    1 root     sys             0 Aug  8 07:35 scsi
bash-2.04#
bash-2.04# ls -lt  /proc/scsi
total 0
dr-xr-xr-x    2 root     sys             0 Aug  8 07:35 SGIWD
-rw-r--r--    1 root     sys             0 Aug  8 07:35 scsi
bash-2.04#


7.7

AND here are some details


ARCH:		  indigo 2 IP22
SYSTEM :	  Simple Linux built as per
http://foobazco.org/~wesolows/Install-HOWTO.html
KERNEL:	[Simple Linux/MIPS 0.1 (kernel 2.2.14)]
	    or	[Simple Linux/MIPS 0.1 (kernel 2.4.3)]	
>> hinv
                   System: IP22
                Processor: 100 Mhz R4000, with FPU
     Primary I-cache size: 8 Kbytes
     Primary D-cache size: 8 Kbytes
     Secondary cache size: 1024 Kbytes
              Memory size: 64 Mbytes
                 Graphics: XL
                SCSI Disk: scsi(0)disk(1)
               SCSI CDROM: scsi(0)cdrom(3)
>>

BOTH "CONFIG_CROSS_COMPILE" has been turned on or off without any change.

Error again: 

> mips-linux-ld: drivers/media/media.o: uses different e_flags (0x0) fields
than previous modules (0x100)
> Bad value: failed to merge target specific data of file
drivers/media/media.o
> make: [vmlinux] Error 1 (ignored)
> mips-linux-nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map



> #################################################################
> 
