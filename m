Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77EWLp21255
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:32:21 -0700
Received: from epic8.Stanford.EDU (epic8.Stanford.EDU [171.64.15.41])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77EWHV21248
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:32:17 -0700
Received: (from johnd@localhost)
	by epic8.Stanford.EDU (8.11.1/8.11.1) id f77EVio27607;
	Tue, 7 Aug 2001 07:31:44 -0700 (PDT)
Date: Tue, 7 Aug 2001 07:31:44 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
   "'Keith Wesolows'" <wesolows@foobazco.org>
Subject: Re: MIPS-INDIGO2-KERNEL BUG
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAB6@ntmsg0080.corpmail.telstra.com.au>
Message-ID: <Pine.GSO.4.31.0108070728330.27075-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Roger-

When I did a native compile for an indy, I had the same problem. I
commented out the media.o line in the top level Makefile. I looked at the
media.o file and there was not much there.  Try compiling with the
Makefile change. I don't think media.o is necessary for mips, at least it
is not used for the indy box that I have.  I hope that helps.  I may need
a kernel patch as well, if you have not already gotten one.

john

On Tue, 7 Aug 2001, Salisbury, Roger wrote:

> Sirs
>
> BELOW is the ERROR
>
> 1.
> make vmlinux
> .................................
> .................................
> .................................
> ld: drivers/media/media.o: uses different e_flags (0x0) fields than previous
> modules (0x100)
> Bad value: failed to merge target specific data of file
> drivers/media/media.o
> make: *** [vmlinux] Error 1
>
>
> 2.
>  Error compiling a new kernel.
>
> 3.
>  ld (linker)
>
> 4.
> bash-2.04# cat  /proc/version
> Linux version 2.2.14 (wesolows@fallout) (gcc version egcs-2.91.66 19990314
> (egcs-1.1.2
>  release)) #2 Thu May 18 16:27:14 PDT 2000
> bash-2.04#
>
> 5.N/A
>
> 6 N/A
>
> 7.
> bash-2.04# set
> BASH=/usr/bin/bash
> BASH_VERSINFO=([0]="2" [1]="04" [2]="0" [3]="1" [4]="release"
> [5]="mips-unknown-linux-
> gnu")
> BASH_VERSION='2.04.0(1)-release'
> COLUMNS=80
> DIRSTACK=()
> EUID=0
> GROUPS=()
> HISTFILE=//.bash_history
> HISTFILESIZE=500
> HISTSIZE=500
> HOME=/
> HOSTNAME=Roland
> HOSTTYPE=mips
> IFS='
> '
> LINES=24
> LOGNAME=root
> MACHTYPE=mips-unknown-linux-gnu
> MAIL=/var/spool/mail/root
> MAILCHECK=60
> OPTERR=1
> OPTIND=1
> OSTYPE=linux-gnu
> PATH=/sbin:/bin:/usr/sbin:/usr/bin
> PIPESTATUS=([0]="0")
> PPID=1
> PS1='\s-\v\$ '
> PS2='> '
> PS4='+ '
> PWD=/
> SHELL=/usr/bin/bash
> SHELLOPTS=braceexpand:hashall:histexpand:monitor:history:interactive-comment
> s:emacs
> SHLVL=1
> TERM=vt100
> UID=0
> _=/proc/version
> bash-2.04#
>
> 7.1
> > VERSIONS:::::::::::::::::::::::::::::::
> > #################################################################
> > bash-2.04# /linux/scripts/ver_linux
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> >
> > Linux Roland 2.2.14 #2 Thu May 18 16:27:14 PDT 2000 mips unknown
> >
> > Gnu C                  egcs-2.91.66
> > Gnu make               3.79
> > binutils               000425
> > util-linux             2.10m
> > mount                  2.10m
> > modutils               2.3.11
> > e2fsprogs              1.18
> > Linux C Library        2.0.6
> > Dynamic linker (ldd)   2.0.6
> > Linux C++ Library      2.9.0
> > Procps                 2.0.6
> > Net-tools              1.55
> > Kbd                    command
> > Sh-utils               2.0i
> > cat: /proc/modules: No such file or directory
> > Modules Loaded
> > bash-2.04#
> >
> 7.2
> bash-2.04# cat  /proc/cpuinfo
> cpu                     : MIPS
> cpu model               : R4000SC V3.0
> system type             : SGI Indy
> BogoMIPS                : 49.97
> byteorder               : big endian
> unaligned accesses      : 0
> wait instruction        : no
> microsecond timers      : no
> extra interrupt vector  : no
> hardware watchpoint     : yes
> VCED exceptions         : 670
> VCEI exceptions         : 169
> bash-2.04#
>
> 7.3
> No modules
>
> 7.4
> bash-2.04# ls -l  /proc/ioports
> -r--r--r--    1 root     sys             0 Aug  8 07:33 /proc/ioports
> bash-2.04# ls -l  /proc/iomem
> ls: /proc/iomem: No such file or directory
> bash-2.04#
>
> 7.5
> No PCI
>
> 7.6
> bash-2.04# ls -lt  /proc/scsi
> total 0
> dr-xr-xr-x    2 root     sys             0 Aug  8 07:35 SGIWD
> -rw-r--r--    1 root     sys             0 Aug  8 07:35 scsi
> bash-2.04#
> bash-2.04# ls -lt  /proc/scsi
> total 0
> dr-xr-xr-x    2 root     sys             0 Aug  8 07:35 SGIWD
> -rw-r--r--    1 root     sys             0 Aug  8 07:35 scsi
> bash-2.04#
>
>
> 7.7
>
> AND here are some details
>
>
> ARCH:		  indigo 2 IP22
> SYSTEM :	  Simple Linux built as per
> http://foobazco.org/~wesolows/Install-HOWTO.html
> KERNEL:	[Simple Linux/MIPS 0.1 (kernel 2.2.14)]
> 	    or	[Simple Linux/MIPS 0.1 (kernel 2.4.3)]
> >> hinv
>                    System: IP22
>                 Processor: 100 Mhz R4000, with FPU
>      Primary I-cache size: 8 Kbytes
>      Primary D-cache size: 8 Kbytes
>      Secondary cache size: 1024 Kbytes
>               Memory size: 64 Mbytes
>                  Graphics: XL
>                 SCSI Disk: scsi(0)disk(1)
>                SCSI CDROM: scsi(0)cdrom(3)
> >>
>
> BOTH "CONFIG_CROSS_COMPILE" has been turned on or off without any change.
>
> Error again:
>
> > mips-linux-ld: drivers/media/media.o: uses different e_flags (0x0) fields
> than previous modules (0x100)
> > Bad value: failed to merge target specific data of file
> drivers/media/media.o
> > make: [vmlinux] Error 1 (ignored)
> > mips-linux-nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
> \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
>
>
>
> > #################################################################
> >
>
