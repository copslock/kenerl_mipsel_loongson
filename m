Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2THSha06168
	for linux-mips-outgoing; Thu, 29 Mar 2001 09:28:43 -0800
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2THSgM06163
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 09:28:42 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K1S3PFS8JU000NH7@research.kpn.com> for
 linux-mips@oss.sgi.com; Thu, 29 Mar 2001 19:28:40 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id TAA01350; Thu,
 29 Mar 2001 19:28:37 +0200 (MET DST)
Date: Thu, 29 Mar 2001 19:28:37 +0200
From: "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: Recommended toolchain
In-reply-to: "Your message of Tue, 27 Mar 2001 21:02:33 +0200."
 <Pine.GSO.3.96.1010327205904.17103B-100000@delta.ds2.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Karel van Houten <K.H.C.vanHouten@research.kpn.com>,
   Simon Gee <simong@oz.agile.tv>, linux-mips@oss.sgi.com,
   K.H.C.vanHouten@research.kpn.com
Reply-to: vhouten@kpn.com
Message-id: <200103291728.TAA01350@sparta.research.kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi all,

"Maciej W. Rozycki" writes:
> What's wrong with the toolchain wrt the kernel now?  I've been compiling
>2.4 kernels successfully till the end of January -- it's just a lack of
>time and a nasty bug I want to track down that stop me from trying to
>compile a new kernel these days.

This happens when I compile kernel 2.4.0-test9 with
binutils 2.10.1, gcc 2.95.3, glibc 2.2.2 on my 5000/260 (R4k)
(the same source/config compiles fine with 2.8.1/egcs-2.90.27/glibc-2.0.6):

# make boot
....
ld -static -G 0 -T arch/mips/ld.script.little -Ttext 0x80040000 arch/mips/kernel
/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/f
s.o ipc/ipc.o arch/mips/dec/dec.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/ne
t/net.o drivers/media/media.o drivers/parport/parport.a  drivers/scsi/scsidrv.o 
drivers/cdrom/cdrom.a drivers/tc/tc.a \
        net/network.o \
        arch/mips/lib/lib.a /usr/src/linux/lib/lib.a arch/mips/dec/prom/rexlib.a
 \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aU] \)\|\(\.\.ng$\)\|\(LASH[RL
]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux-2.4.0t9-R4k/arch/mips/boot'
./elf2ecoff /usr/src/linux/vmlinux vmlinux.ecoff -a
wrote 20 byte file header.
wrote 56 byte a.out header.
wrote 240 bytes of section headers.
wrote 4 byte pad.
writing 30560 bytes...
Intersegment gap (-2147256160 bytes) too large.
make[1]: *** [vmlinux.ecoff] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.0t9-R4k/arch/mips/boot'
make: *** [boot] Error 2
