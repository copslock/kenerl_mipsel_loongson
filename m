Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6ICIwI32053
	for linux-mips-outgoing; Wed, 18 Jul 2001 05:18:58 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6ICIsV32048
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 05:18:55 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id QAA22696
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 16:19:24 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id QAA01257 for linux-mips@oss.sgi.com; Wed, 18 Jul 2001 16:16:55 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id QAA29667 for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 16:06:39 +0400 (MSD)
Message-ID: <3B557BF3.22C43175@niisi.msk.ru>
Date: Wed, 18 Jul 2001 16:07:15 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Content-Type: multipart/mixed;
 boundary="------------7241F4AE3BBCA1C849A25667"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------7241F4AE3BBCA1C849A25667
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Hello,

"H . J . Lu" wrote:
> The next thing on my todo list is to cross compile XFree86 :-(.
> 

It has been done already for Xserver only. I use to cross-compile FBDev
XServer for a long time. My host.def is attached here for reference. In
order to cross-compile entire XFree86 cleanly you need to patch
config/util/Imakefile first, it's primary source of problems during
cross-compilation. It may be just workarounded though, if you don't
pretend to be perfectionist.

Regards,
Gleb.
--------------7241F4AE3BBCA1C849A25667
Content-Type: image/x-xbitmap;
 name="host.def"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="host.def"

#define BuildServersOnly YES
/* #define DoLoadableServer NO */


/* Servers never be needed */
#define XprtServer NO
#define XVirtualFramebufferServer NO
#define XnestServer NO
#define BuildFontServer        NO
#define BuildFonts NO
#define SharedLibFont		NO
#define NormalLibFont		YES


/* HW stuff */
#define XF86CardDrivers  fbdev
#define XInputDrivers    mouse void
#define XF86FBDevHw             YES
#define XF24_32Bpp		YES


/* May be needed */
#define BuildXIE    NO
#define XF86XAA		NO
/* #define BuildXF86MiscExt       YES */


/* Never be needed */
#define BuildScreenSaverExt    NO
#define BuildPexExt    NO
#define BuildGLXLibrary NO
#define BuildGlxExt NO
#define XF86Ramdac	NO
#define XF86Int10	NO
#define XF86INT10_BUILD	X86INT10_STUB
#define UseX86Emu	NO


/* Definitions for cross compilation */ 
#define MipsArchitecture
#define __mips
#undef i386Architecture
#undef SparcArchitecture
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


--------------7241F4AE3BBCA1C849A25667--
