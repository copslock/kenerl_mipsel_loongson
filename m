Received:  by oss.sgi.com id <S42197AbQF0H7C>;
	Tue, 27 Jun 2000 00:59:02 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:8 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42189AbQF0H6v>; Tue, 27 Jun 2000 00:58:51 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA08086
	for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 01:04:07 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id AAA15319 for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 00:58:20 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA85887;
	Tue, 27 Jun 2000 00:56:32 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA01502; Tue, 27 Jun 2000 00:56:29 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id LAA17683;
	Tue, 27 Jun 2000 11:56:36 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id LAA14653; Tue, 27 Jun 2000 11:39:04 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id LAA13973; Tue, 27 Jun 2000 11:49:16 +0400 (MSD)
Message-ID: <39585F40.67B6FA74@niisi.msk.ru>
Date:   Tue, 27 Jun 2000 12:01:04 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>,
        "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
References: <20000623181736.A13410@bert.physik.uni-konstanz.de>
		<014f01bfdd33$8877b3c0$0701010a@ltc.com>
		<20000623185553.A20888@bert.physik.uni-konstanz.de>
		<019501bfdd35$bb301940$0701010a@ltc.com>
		<20000623190723.B20888@bert.physik.uni-konstanz.de>
		<01cb01bfdd3a$fc43b2c0$0701010a@ltc.com>
		<39547DB3.4FF35339@niisi.msk.ru>
		<20000624131218.A17554@bilbo.physik.uni-konstanz.de>
		<20000625001255.C894@bacchus.dhis.org> <14678.31422.353864.773880@calypso.engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------48626968E62A39AA49D3BEE9"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------48626968E62A39AA49D3BEE9
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Ulf Carlsson wrote:
> 
> Ralf Baechle writes:
>  > On Sat, Jun 24, 2000 at 01:12:18PM +0200, Guido Guenther wrote:
>  >
>  > > [..snip..]
>  > > > If you cross-compile, you just redefine most of the stuff like CcCmd,
>  > > > ArCmd, etc, anyway.
>  > > Yes, but you have to make sure the redefinitions don't get redefined
>  > > again, therefore IMHO an "#ifdef AsCmd" is needed. Otherwise the
>  > > definition in hosts.def will be overriden by the one in linux.cf.
>  >
>  > Does X building ever need the hostcompiler?  If not, then you can easily
>  > do crossbuilds like:
>  >
>  >   PATH=<prefix>/<target>/bin:$PATH make ...
> 
> Yes.  You need the hostcompiler when you do X builds.  It is possible
> to get around it though.  I have the commands that I used in two shell
> scripts.
> 
> First I have to to prepare for the cross build:
> 
> #!/bin/sh
> make clean
> make Makefile.boot
> make Makefiles
> (cd config; make)
> make includes
> make depend
> (cd fonts/bdf; for i in $(find -name 'Makefile'); do sed -e 's/\$(XBUILDBINDIR)\///' < $i > $i.tmp; mv $i.tmp $i; done)
> 
> Then I'm ready to build the rest with the cross compiler:
> 
> #!/bin/sh
> export PATH=/usr/glibc-mips/bin:$PATH
> make -k CC=mips-linux-gcc LD=mips-linux-ld AS=mips-linux-as RANLIB=mips-linux-ranlib $@
> 
> You probably have a better solution though :-)

Sure, host.def attached.
--------------48626968E62A39AA49D3BEE9
Content-Type: image/x-xbitmap;
 name="host.def"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="host.def"

#define BuildServersOnly YES
/* #define DoLoadableServer NO */
#define XprtServer NO
#define XVirtualFramebufferServer NO
#define XnestServer NO
#define BuildFontServer        NO
#define BuildFonts NO
#define BuildScreenSaverExt    NO
/* #define BuildXF86MiscExt       YES */
#define MipsArchitecture
#define __mips
#undef i386Architecture
#define OSName Linux 2.2.1 mips [ELF]
#define OSMajorVersion 2
#define OSMinorVersion 2
#define OSTeenyVersion 1
#define LinuxCLibMajorVersion 6
#define LinuxCLibMinorVersion 0
#define LinuxCLibTeenyVersion 6
#define LinuxBinUtilsMajorVersion 28
#define CcCmd mips-linux-gcc -g
#define AsCmd mips-linux-gcc -c -x assembler-with-cpp -g
#define LdCmd mips-linux-ld -g
#define ArCmdBase mips-linux-ar
#define RanlibCmd mips-linux-ranlib
#define CrossCompiling YES
#define ComplexHostProgramTarget(program)                               @@\
              CC=cc                                                     @@\
    STD_INCLUDES=                                                       @@\
          CFLAGS=$(TOP_INCLUDES) $(INCLUDES) $(BOOTSTRAPCFLAGS)         @@\
EXTRA_LOAD_FLAGS=                                                       @@\
        PROGRAM = program                                               @@\
                                                                        @@\
AllTarget(program)                                                      @@\
                                                                        @@\
program: $(OBJS) $(DEPLIBS)                                             @@\
	RemoveTargetProgram($@)                                         @@\
	HostLinkRule($@,$(_NOOP_),$(OBJS),$(DEPLIBS) $(LOCAL_LIBRARIES)) @@\
                                                                        @@\
DependTarget()                                                          @@\
                                                                        @@\
LintTarget()                                                            @@\
                                                                        @@\
clean::                                                                 @@\
	RemoveFile(ProgramTargetName(program))

#define SimpleHostProgramTarget(program)                                @@\
           OBJS = program.o                                             @@\
           SRCS = program.c                                             @@\
                                                                        @@\
ComplexHostProgramTarget(program)

#define HostLinkRule(target, flags, src, libs)  gcc -o target flags src libs $(EXTRA_LOAD_FLAGS)

--------------48626968E62A39AA49D3BEE9--
