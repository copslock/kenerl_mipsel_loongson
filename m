Received:  by oss.sgi.com id <S42390AbQFWRRB>;
	Fri, 23 Jun 2000 10:17:01 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:7528 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42182AbQFWRQu>;
	Fri, 23 Jun 2000 10:16:50 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA24288
	for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 10:11:52 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA30909
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 23 Jun 2000 10:16:19 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00149
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 10:16:17 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from ernie.physik.uni-konstanz.de (bert.physik.uni-konstanz.de) [134.34.144.19] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 135X3z-0004hJ-00; Fri, 23 Jun 2000 19:16:19 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Fri, 23 Jun 2000 19:07:24 +0200
Date:   Fri, 23 Jun 2000 19:07:24 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     "Bradley D. LaRonde" <brad@ltc.com>
Cc:     linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
Message-ID: <20000623190723.B20888@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@gmx.net>,
	"Bradley D. LaRonde" <brad@ltc.com>,
	linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <019501bfdd35$bb301940$0701010a@ltc.com>; from brad@ltc.com on Fri, Jun 23, 2000 at 01:09:03PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2000 at 01:09:03PM -0400, Bradley D. LaRonde wrote:
[..snip..] 
> May I have a copy of those patches for review?
They look basically like this(Imake.cf additionally checks for mipsel):

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips.diff"

Index: xfree86/xc/config/cf/Imake.cf
diff -c xfree86/xc/config/cf/Imake.cf:1.1.1.1 xfree86/xc/config/cf/Imake.cf:1.2
*** xfree86/xc/config/cf/Imake.cf:1.1.1.1	Mon May  8 10:58:59 2000
--- xfree86/xc/config/cf/Imake.cf	Mon May  8 19:45:56 2000
***************
*** 603,608 ****
--- 603,612 ----
  #  endif
  #  undef __sparc__
  # endif
+ # ifdef mips
+ #  define MipsArchitecture
+ #  undef mips
+ # endif
  /* for compatibility with 3.3.x */
  # ifdef PpcArchitecture
  #  define PowerPCArchitecture
Index: xfree86/xc/config/cf/linux.cf
diff -c xfree86/xc/config/cf/linux.cf:1.1.1.1 xfree86/xc/config/cf/linux.cf:1.4
*** xfree86/xc/config/cf/linux.cf:1.1.1.1	Mon May  8 10:58:57 2000
--- xfree86/xc/config/cf/linux.cf	Wed May 31 15:26:31 2000
***************
*** 5,10 ****
--- 5,15 ----
  #define LinuxElfDefault		YES
  #endif
  
+ /* Loadable Modules are currently not working on mips */
+ #ifdef MipsArchitecture
+ #define DoLoadableServer NO
+ #endif
+ 
  #ifndef UseElfFormat
  #define UseElfFormat		LinuxElfDefault
  #endif
***************
*** 289,294 ****
--- 294,302 ----
  #define MkdirHierCmd		mkdir -p
  #if LinuxElfDefault
  #if UseElfFormat
+ # ifdef MipsArchitecture
+ #  define AsCmd                   gcc -c -x assembler-with-cpp
+ # endif /* MipsArchitecure */
  #ifndef CcCmd
  #define CcCmd			gcc
  #endif
***************
*** 468,473 ****
--- 476,488 ----
  #define PositionIndependentCFlags -fpic
  #define PositionIndependentCplusplusFlags -fpic
  #endif
+ 
+ #ifdef MipsArchitecture
+ #define OptimizedCDebugFlags	-O2
+ #define LinuxMachineDefines	-D__mips__
+ #define ServerOSDefines		XFree86ServerOSDefines -DDDXTIME -DPART_NET
+ #define ServerExtraDefines	-DGCCUSESGAS XFree86ServerDefines
+ #endif 
  
  #ifndef StandardDefines
  #define StandardDefines		-Dlinux LinuxMachineDefines LinuxSourceDefines
***************
*** 264,269 ****
--- 264,301 ----
  #  define XF86CardDrivers	fbdev XF86ExtraCardDrivers
  # endif
  
+ #endif
+ 
+ /* Mips drivers */
+ 
+ #ifdef MipsArchitecture
+ # ifndef XF86Server
+ #  define XF86Server            YES
+ # endif
+ /* shadow fb module */
+ # ifndef XFShadowFB
+ #  define XFShadowFB            YES
+ # endif
+ /* XAA module */
+ # ifndef XF86XAA
+ #  define XF86XAA		YES
+ # endif
+ /* ramdac module */
+ # ifndef XF86Ramdac
+ #  define XF86Ramdac		YES
+ # endif
+ /* RAC (Resource Access Control) module */
+ # ifndef XF86RAC
+ #  define XF86RAC		YES
+ # endif
+ /* int10 module */
+ # ifndef XF86Int10
+ #  define XF86Int10		YES
+ # endif
+ 
+ # ifndef XF86CardDrivers
+ #  define XF86CardDrivers      XF86ExtraCardDrivers
+ # endif
  #endif
  
  /*
Index: xfree86/xc/programs/Xserver/hw/xfree86/Imakefile
diff -c xfree86/xc/programs/Xserver/hw/xfree86/Imakefile:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/Imakefile:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/Imakefile:1.1.1.1	Mon May  8 11:03:25 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/Imakefile	Mon May  8 19:50:23 2000
***************
*** 65,71 ****
  
  #if !defined(OsfArchitecture) && !defined(AmoebaArchitecture) && \
      !defined(ArcArchitecture) && !defined(Arm32Architecture) && \
!     !defined(PpcArchitecture)
  SUPERPROBE = SuperProbe
  #endif
  
--- 65,71 ----
  
  #if !defined(OsfArchitecture) && !defined(AmoebaArchitecture) && \
      !defined(ArcArchitecture) && !defined(Arm32Architecture) && \
!     !defined(PpcArchitecture) && !defined(MipsArchitecture)
  SUPERPROBE = SuperProbe
  #endif
  
Index: xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Bus.c
diff -c xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Bus.c:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Bus.c:1.3
*** xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Bus.c:1.1.1.1	Mon May  8 11:03:45 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Bus.c	Mon May 15 10:30:07 2000
***************
*** 2802,2808 ****
  static void
  CheckGenericGA()
  {
! #if !defined(__sparc__) && !defined(__powerpc__) /* FIXME ?? */
      CARD16 GenericIOBase = VGAHW_GET_IOBASE();
      CARD8 CurrentValue, TestValue;
  
--- 2802,2808 ----
  static void
  CheckGenericGA()
  {
! #if !defined(__sparc__) && !defined(__powerpc__) && !defined(__mips__) /* FIXME ?? */
      CARD16 GenericIOBase = VGAHW_GET_IOBASE();
      CARD8 CurrentValue, TestValue;
  
Index: xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Io.c
diff -c xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Io.c:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Io.c:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Io.c:1.1.1.1	Mon May  8 11:03:48 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/common/xf86Io.c	Mon May  8 19:50:50 2000
***************
*** 396,402 ****
    return (Success);
  }
  
! #if !defined(AMOEBA) && !(defined (sun) && defined(i386) && defined (SVR4)) && !defined(MINIX) && !defined(__mips__) && !defined(QNX4)
  /*
   * These are getting tossed in here until I can think of where
   * they really belong
--- 396,402 ----
    return (Success);
  }
  
! #if !defined(AMOEBA) && !(defined (sun) && defined(i386) && defined (SVR4)) && !defined(MINIX) && !(defined(__mips__) && !defined(linux)) && !defined(QNX4)
  /*
   * These are getting tossed in here until I can think of where
   * they really belong
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/Xinstall.sh
diff -c xfree86/xc/programs/Xserver/hw/xfree86/etc/Xinstall.sh:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/etc/Xinstall.sh:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/etc/Xinstall.sh:1.1.1.1	Mon May  8 11:04:38 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/Xinstall.sh	Wed May 24 14:58:49 2000
***************
*** 417,422 ****
--- 417,432 ----
  				;;
  			esac
  			;;
+ 		mips)
+ 			case "$OsLibcMajor.$OsLibcMinor" in
+ 			6.0)
+ 				DistName="Linux-mips-glibc20"
+ 				;;
+ 			*)	
+ 				Message="No Linux/Mips binaries for this libc version"
+ 				;;
+ 			esac
+ 			;;
  		*)
  			Message="No Linux binaries available for this architecture"
  			;;
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/bin-excl
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/bin-excl:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/bin-excl	Thu Jun 22 13:56:31 2000
***************
*** 0 ****
--- 1,10 ----
+ bin/XF86_*
+ bin/XF98_*
+ bin/XF86Setup
+ bin/Xnest
+ bin/Xprt
+ bin/Xvfb
+ bin/X
+ bin/xfs
+ bin/xmseconfig
+ bin/XFree86
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/bin-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/bin-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/bin-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1,60 ----
+ bin
+ lib/libGL.so.1.2
+ lib/libGL.so.1
+ lib/libGL.so
+ lib/libICE.so.6.3
+ lib/libICE.so.6
+ lib/libICE.so
+ lib/libPEX5.so.6.0
+ lib/libPEX5.so.6
+ lib/libPEX5.so
+ lib/libSM.so.6.0
+ lib/libSM.so.6
+ lib/libSM.so
+ lib/libX11.so.6.1
+ lib/libX11.so.6
+ lib/libX11.so
+ lib/libXIE.so.6.0
+ lib/libXIE.so.6
+ lib/libXIE.so
+ lib/libXaw.so.6.1
+ lib/libXaw.so.6
+ lib/libXaw.so.7.0
+ lib/libXaw.so.7
+ lib/libXaw.so
+ lib/libXext.so.6.4
+ lib/libXext.so.6
+ lib/libXext.so
+ lib/libXfont.so.1.3
+ lib/libXfont.so.1
+ lib/libXfont.so
+ lib/libXi.so.6.0
+ lib/libXi.so.6
+ lib/libXi.so
+ lib/libXmu.so.6.1
+ lib/libXmu.so.6
+ lib/libXmu.so
+ lib/libXp.so.6.2
+ lib/libXp.so.6
+ lib/libXp.so
+ lib/libXpm.so.4.11
+ lib/libXpm.so.4
+ lib/libXpm.so
+ lib/libXt.so.6.0
+ lib/libXt.so.6
+ lib/libXt.so
+ lib/libXtst.so.6.1
+ lib/libXtst.so.6
+ lib/libXtst.so
+ lib/libdps.so.1.0
+ lib/libdps.so.1
+ lib/libdps.so
+ lib/libdpstk.so.1.0
+ lib/libdpstk.so.1
+ lib/libdpstk.so
+ lib/libpsres.so.1.0
+ lib/libpsres.so.1
+ lib/libpsres.so
+ lib/libxrx.so.6.3
+ lib/libxrx.so.6
+ lib/libxrx.so
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/dir
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/dir:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/dir	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1 ----
+ usr/X11R6
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/etc-dir
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/etc-dir:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/etc-dir	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1 ----
+ etc/X11
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/etc-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/etc-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/etc-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1 ----
+ .
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/fsrv-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/fsrv-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/fsrv-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1,2 ----
+ bin/xfs
+ man/man1/xfs.1x
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/host.def
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/host.def:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/host.def	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1,5 ----
+ /*
+  * Host.def for building Linux/Mips bindists
+  *
+  */
+ #define DoLoadableServer NO
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/lib-excl
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/lib-excl:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/lib-excl	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1,14 ----
+ lib/X11/XF86Setup
+ lib/X11/app-defaults
+ lib/X11/config
+ lib/X11/doc
+ lib/X11/fonts
+ lib/X11/fs
+ lib/X11/lbxproxy
+ lib/X11/proxymngr
+ lib/X11/rstart
+ lib/X11/twm
+ lib/X11/xdm
+ lib/X11/xinit
+ lib/X11/xsm
+ lib/X11/xserver
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/lib-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/lib-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/lib-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1,2 ----
+ lib/X11
+ include/X11/bitmaps
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/man-excl
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/man-excl:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/man-excl	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1,3 ----
+ man/man1/XF86Setup.1x
+ man/man1/xfs.1x
+ man/man1/xmseconfig.1x
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/man-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/man-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/man-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1 ----
+ man
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/mod-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/mod-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/mod-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1 ----
+ lib/modules
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/nest-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/nest-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/nest-list	Thu Jun 22 13:56:32 2000
***************
*** 0 ****
--- 1 ----
+ bin/Xnest
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prog-excl
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prog-excl:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prog-excl	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1,5 ----
+ lib/Server
+ lib/X11
+ lib/lib*.so*
+ lib/modules
+ include/X11/bitmaps
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prog-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prog-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prog-list	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1,3 ----
+ lib
+ include
+ lib/X11/config
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prt-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prt-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/prt-list	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1 ----
+ bin/Xprt
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/set-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/set-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/set-list	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1,5 ----
+ bin/XF86Setup
+ bin/xmseconfig
+ lib/X11/XF86Setup
+ man/man1/XF86Setup.1x
+ man/man1/xmseconfig.1x
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/var-dir
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/var-dir:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/var-dir	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1 ----
+ var
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/var-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/var-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/var-list	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1 ----
+ state
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/vfb-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/vfb-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/vfb-list	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1 ----
+ bin/Xvfb
Index: xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/xserv-list
diff -c /dev/null xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/xserv-list:1.1
*** /dev/null	Fri Jun 23 09:28:49 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/etc/bindist/Linux-mips/xserv-list	Thu Jun 22 13:56:33 2000
***************
*** 0 ****
--- 1,2 ----
+ bin/XFree86
+ bin/X
Index: xfree86/xc/programs/Xserver/hw/xfree86/os-support/Imakefile
diff -c xfree86/xc/programs/Xserver/hw/xfree86/os-support/Imakefile:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/os-support/Imakefile:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/os-support/Imakefile:1.1.1.1	Mon May  8 11:04:56 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/os-support/Imakefile	Mon May  8 19:51:48 2000
***************
*** 13,19 ****
  #if defined(i386Architecture) || defined(ia64Architecture) || \
  	(defined(LinuxArchitecture) && defined(AlphaArchitecture)) || \
  	(defined(FreeBSDArchitecture) && defined(AlphaArchitecture)) || \
! 	defined(PpcArchitecture) || defined(SparcArchitecture)
  BUS_SUBDIR = bus
  #endif
  
--- 13,20 ----
  #if defined(i386Architecture) || defined(ia64Architecture) || \
  	(defined(LinuxArchitecture) && defined(AlphaArchitecture)) || \
  	(defined(FreeBSDArchitecture) && defined(AlphaArchitecture)) || \
! 	defined(PpcArchitecture) || defined(SparcArchitecture) || \
! 	(defined(LinuxArchitecture) && defined(MipsArchitecture))
  BUS_SUBDIR = bus
  #endif
  
Index: xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Imakefile
diff -c xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Imakefile:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Imakefile:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Imakefile:1.1.1.1	Mon May  8 11:04:57 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Imakefile	Mon May  8 19:52:03 2000
***************
*** 21,27 ****
  PCIDRVRSRC = sparcPci.c
  PCIDRVROBJ = sparcPci.o
  
! #elif defined(LinuxArchitecture) && defined(PpcArchitecture)
  
  XCOMM generic linux PCI driver (using /proc/bus/pci, requires kernel 2.2)
  
--- 21,27 ----
  PCIDRVRSRC = sparcPci.c
  PCIDRVROBJ = sparcPci.o
  
! #elif defined(LinuxArchitecture) && (defined(PpcArchitecture) || defined(MipsArchitecture))
  
  XCOMM generic linux PCI driver (using /proc/bus/pci, requires kernel 2.2)
  
Index: xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Pci.h
diff -c xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Pci.h:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Pci.h:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Pci.h:1.1.1.1	Mon May  8 11:04:57 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/os-support/bus/Pci.h	Mon May  8 19:52:03 2000
***************
*** 136,142 ****
  /*
   * Select architecture specific PCI init function
   */
! #if defined(__powerpc__) && defined(linux)
  # define ARCH_PCI_INIT linuxPciInit
  # define INCLUDE_XF86_MAP_PCI_MEM
  #elif defined(__powerpc__)
--- 136,142 ----
  /*
   * Select architecture specific PCI init function
   */
! #if (defined(__powerpc__) || defined(__mips__)) && defined(linux)
  # define ARCH_PCI_INIT linuxPciInit
  # define INCLUDE_XF86_MAP_PCI_MEM
  #elif defined(__powerpc__)
Index: xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnxResource.c
diff -c xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnxResource.c:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnxResource.c:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnxResource.c:1.1.1.1	Mon May  8 11:05:02 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnxResource.c	Mon May  8 19:53:04 2000
***************
*** 150,156 ****
      return ret;
  }
  
! #elif defined(__powerpc__)
  
   /* XXX this isn't exactly correct but it will get the server working 
    * for now until we get something better.
--- 150,156 ----
      return ret;
  }
  
! #elif defined(__powerpc__) || defined(__mips__)
  
   /* XXX this isn't exactly correct but it will get the server working 
    * for now until we get something better.
Index: xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_video.c
diff -c xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_video.c:1.1.1.1 xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_video.c:1.2
*** xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_video.c:1.1.1.1	Mon May  8 11:05:02 2000
--- xfree86/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_video.c	Mon May  8 19:53:04 2000
***************
*** 385,391 ****
  	if (ExtendedEnabled)
  		return;
  
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__)
  	if (iopl(3))
  		FatalError("%s: Failed to set IOPL for I/O\n",
  			   "xf86EnableIOPorts");
--- 385,391 ----
  	if (ExtendedEnabled)
  		return;
  
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__) && !defined(__mips__)
  	if (iopl(3))
  		FatalError("%s: Failed to set IOPL for I/O\n",
  			   "xf86EnableIOPorts");
***************
*** 401,407 ****
  	if (!ExtendedEnabled)
  		return;
  
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__)
  	iopl(0);
  #endif
  	ExtendedEnabled = FALSE;
--- 401,407 ----
  	if (!ExtendedEnabled)
  		return;
  
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__) && !defined(__mips__)
  	iopl(0);
  #endif
  	ExtendedEnabled = FALSE;
***************
*** 418,428 ****
  xf86DisableInterrupts()
  {
  	if (!ExtendedEnabled)
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__)
  		if (iopl(3))
  			return (FALSE);
  #endif
! #if defined(__alpha__) || defined(__mc68000__) || defined(__powerpc__) || defined(__sparc__)
  #else
  #ifdef __GNUC__
  #if defined(__ia64__)
--- 418,428 ----
  xf86DisableInterrupts()
  {
  	if (!ExtendedEnabled)
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__) && !defined(__mips__)
  		if (iopl(3))
  			return (FALSE);
  #endif
! #if defined(__alpha__) || defined(__mc68000__) || defined(__powerpc__) || defined(__sparc__) || defined(__mips__)
  #else
  #ifdef __GNUC__
  #if defined(__ia64__)
***************
*** 434,440 ****
  	asm("cli");
  #endif
  #endif
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__)
  	if (!ExtendedEnabled)
  		iopl(0);
  #endif
--- 434,440 ----
  	asm("cli");
  #endif
  #endif
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__) && !defined(__mips__)
  	if (!ExtendedEnabled)
  		iopl(0);
  #endif
***************
*** 445,455 ****
  xf86EnableInterrupts()
  {
  	if (!ExtendedEnabled)
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__)
  		if (iopl(3))
  			return;
  #endif
! #if defined(__alpha__) || defined(__mc68000__) || defined(__powerpc__) || defined(__sparc__)
  #else
  #ifdef __GNUC__
  #if defined(__ia64__)
--- 445,455 ----
  xf86EnableInterrupts()
  {
  	if (!ExtendedEnabled)
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__) && !defined(__mips__)
  		if (iopl(3))
  			return;
  #endif
! #if defined(__alpha__) || defined(__mc68000__) || defined(__powerpc__) || defined(__sparc__) || defined(__mips__)
  #else
  #ifdef __GNUC__
  #if defined(__ia64__)
***************
*** 461,467 ****
  	asm("sti");
  #endif
  #endif
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__)
  	if (!ExtendedEnabled)
  
  		iopl(0);
--- 461,467 ----
  	asm("sti");
  #endif
  #endif
! #if !defined(__mc68000__) && !defined(__powerpc__) && !defined(__sparc__) && !defined(__mips__)
  	if (!ExtendedEnabled)
  
  		iopl(0);

--ZPt4rx8FFjLCG7dd--
