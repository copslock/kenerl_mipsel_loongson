Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA16416 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Mar 1999 17:20:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA04291
	for linux-list;
	Fri, 12 Mar 1999 17:19:16 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA74258
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 12 Mar 1999 17:19:15 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-7-5.swipnet.se [130.244.71.101]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09758
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Mar 1999 17:18:59 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by calypso.saturn (8.8.7/8.8.7) id WAA00965;
	Fri, 12 Mar 1999 22:23:36 -0500
Date: Fri, 12 Mar 1999 22:23:35 -0500
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: gkm@total.net, linux@cthulhu.engr.sgi.com
Subject: Re: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded
Message-ID: <19990312222335.A867@bun.falkenberg.se>
Mail-Followup-To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	gkm@total.net, linux@cthulhu.engr.sgi.com
References: <19990227001617.A4022@alpha.franken.de> <199902270430.XAA21725@wacky.total.net> <19990227120144.A601@alpha.franken.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=vkogqOf2sHV7VnPd
X-Mailer: Mutt 0.95.3us
In-Reply-To: <19990227120144.A601@alpha.franken.de>; from Thomas Bogendoerfer on Sat, Feb 27, 1999 at 12:01:44PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii

On Sat, Feb 27, 1999 at 12:01:44PM +0100, Thomas Bogendoerfer wrote:
> On Fri, Feb 26, 1999 at 11:30:50PM -0500, gkm@total.net wrote:
> > How has everyone else faired in the compiling game?  :)
> 
> it worked out of the box, but not on an out of the box HardHat:-(
> 
> HardHat has still gcc-2.7.2 as the default C compiler and this
> compiler has different defines. So either use egcs or update your
> gcc specs file (sorry, I couldn't find the patch right now, anyone ?)

Ooops, sorry about the delay but here's the specs man and here's his specs file!

The specs man says: Take this specs file and put it in
/usr/local/lib/gcc-lib/mips-linux/2.7.2.2 or similar..

- Ulf

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=specs

*asm:
%{mcpu=*} %{m4650} %{mmad:-m4650} %{G*} %{EB} %{EL} %{mips1} %{mips2} %{mips3} %{mips4} %{v} %{noasmopt:-O0} %{!noasmopt:%{O:-O2} %{O1:-O2} %{O2:-O2} %{O3:-O3}} %{g} %{g0} %{g1} %{g2} %{g3} %{ggdb:-g} %{ggdb0:-g0} %{ggdb1:-g1} %{ggdb2:-g2} %{ggdb3:-g3} %{gstabs:-g} %{gstabs0:-g0} %{gstabs1:-g1} %{gstabs2:-g2} %{gstabs3:-g3} %{gstabs+:-g} %{gstabs+0:-g0} %{gstabs+1:-g1} %{gstabs+2:-g2} %{gstabs+3:-g3} %{gcoff:-g} %{gcoff0:-g0} %{gcoff1:-g1} %{gcoff2:-g2} %{gcoff3:-g3} %{!fno-PIC:%{!fno-pic:-KPIC}} %{fPIC:-KPIC} %{fpic:-KPIC} %{fno-PIC:-non_shared} %{fno-pic:-non_shared} %{membedded-pic}

*asm_final:


*cpp:
%{.cc:	-D__LANGUAGE_C_PLUS_PLUS__ -D__LANGUAGE_C_PLUS_PLUS -D_LANGUAGE_C_PLUS_PLUS  %{!ansi:-DLANGUAGE_C_PLUS_PLUS}} %{.cxx:	-D__LANGUAGE_C_PLUS_PLUS__ -D__LANGUAGE_C_PLUS_PLUS -D_LANGUAGE_C_PLUS_PLUS %{!ansi:-DLANGUAGE_C_PLUS_PLUS}} %{.C:	-D__LANGUAGE_C_PLUS_PLUS__ -D__LANGUAGE_C_PLUS_PLUS -D_LANGUAGE_C_PLUS_PLUS %{!ansi:-DLANGUAGE_C_PLUS_PLUS}} %{.m:	-D__LANGUAGE_OBJECTIVE_C__ -D__LANGUAGE_OBJECTIVE_C -D_LANGUAGE_OBJECTIVE_C %{!ansi:-DLANGUAGE_OBJECTIVE_C}} %{.S:	-D__LANGUAGE_ASSEMBLY__ -D__LANGUAGE_ASSEMBLY -D_LANGUAGE_ASSEMBLY %{!ansi:-DLANGUAGE_ASSEMBLY }} %{.s:	-D__LANGUAGE_ASSEMBLY__ -D__LANGUAGE_ASSEMBLY -D_LANGUAGE_ASSEMBLY %{!ansi:-DLANGUAGE_ASSEMBLY }} %{!.S:%{!.s:-D__LANGUAGE_C__ -D__LANGUAGE_C -D_LANGUAGE_C %{!ansi:-DLANGUAGE_C }}} %{mfp32: -D_MIPS_FPSET=16}%{!mfp32: -D_MIPS_FPSET=32} %{mips1: -D_MIPS_ISA=_MIPS_ISA_MIPS1} %{mips2: -D_MIPS_ISA=_MIPS_ISA_MIPS2} %{mips3: -D_MIPS_ISA=_MIPS_ISA_MIPS3} %{mips4: -D_MIPS_ISA=_MIPS_ISA_MIPS4} %{!mips1: %{!mips2: %{!mips3: !
%{!mips4: -D_MIPS_ISA=_MIPS_ISA_MIPS1}}}} %{mint64:-D_MIPS_SZINT=64 %{!mlong64:-D__SIZE_TYPE__=long\ unsigned\ int -D__SSIZE_TYPE__=long\ int -D__PTRDIFF_TYPE__=long\ int -D_MIPS_SZLONG=64 -D_MIPS_SZPTR=64}} %{!mint64:-D_MIPS_SZINT=32 %{!mlong64:-D__SIZE_TYPE__=unsigned\ int -D__SSIZE_TYPE__=int -D__PTRDIFF_TYPE__=int -D_MIPS_SZLONG=32 -D_MIPS_SZPTR=32}} %{mlong64:-D__SIZE_TYPE__=long\ unsigned\ int -D__SSIZE_TYPE__=long\ int -D__PTRDIFF_TYPE__=long\ int -D_MIPS_SZLONG=64 -D_MIPS_SZPTR=64} %{mips3:-U__mips -D__mips=3 -D__mips64} %{mips4:-U__mips -D__mips=4 -D__mips64} %{mgp32:-U__mips64} %{mgp64:-D__mips64} %{EB:-UMIPSEL -U__MIPSEL__ -D__MIPSEB__ %{!ansi:-DMIPSEB}} %{EL:-UMIPSEB -U__MIPSEB__ -D__MIPSEL__ %{!ansi:-DMIPSEL}} %{fno-PIC:-U__PIC__ -U__pic__} %{fno-pic:-U__PIC__ -U__pic__} %{fPIC:-D__PIC__ -D__pic__} %{fpic:-D__PIC__ -D__pic__} %{-D__HAVE_FPU__ } %{posix:-D_POSIX_SOURCE}

*cc1:
%{gline:%{!g:%{!g0:%{!g1:%{!g2: -g1}}}}} %{mips1:-mfp32 -mgp32}%{mips2:-mfp32 -mgp32}%{mips3:%{!msingle-float:%{!m4650:-mfp64}} -mgp64} %{mips4:%{!msingle-float:%{!m4650:-mfp64}} -mgp64} %{mfp64:%{msingle-float:%emay not use both -mfp64 and -msingle-float}} %{mfp64:%{m4650:%emay not use both -mfp64 and -m4650}} %{m4650:-mcpu=r4650} %{G*} %{EB:-meb} %{EL:-mel} %{EB:%{EL:%emay not use both -EB and -EL}} %{pic-none:   -mno-half-pic} %{pic-lib:    -mhalf-pic} %{pic-extern: -mhalf-pic} %{pic-calls:  -mhalf-pic} %{save-temps: }

*cc1plus:


*endfile:
%{!shared:crtend.o%s} %{shared:crtendS.o%s} crtn.o%s

*link:
%{G*} %{EB} %{EL} %{mips1} %{mips2} %{mips3} %{mips4} %{bestGnum} %{shared} %{non_shared} %{call_shared} %{no_archive} %{exact_version}   %{!shared:       %{!static: 	%{rdynamic:-export-dynamic} 	%{!dynamic-linker:-dynamic-linker /lib/ld.so.1}} 	%{static:-static}}

*lib:
%{!shared: %{mieee-fp:-lieee} %{p:-lgmon} %{pg:-lgmon}      %{!ggdb:-lc} %{ggdb:-lg}}

*libgcc:
%{!shared:-lgcc}

*startfile:
%{!shared:      %{pg:gcrt1.o%s} %{!pg:%{p:gcrt1.o%s}                        %{!p:%{profile:gcrt1.o%s}                          %{!profile:crt1.o%s}}}}    crti.o%s %{!shared:crtbegin.o%s} %{shared:crtbeginS.o%s}

*switches_need_spaces:


*signed_char:
%{funsigned-char:-D__CHAR_UNSIGNED__}

*predefines:
-D__ELF__ -D_MIPS_SIM=_MIPS_SIM_ABI32 -D__PIC__ -D__pic__ -Dunix -Dmips -DR3000 -DMIPSEB -Dlinux -Asystem(linux) -Asystem(posix) -Acpu(mips) -Amachine(mips)

*cross_compile:
1

*multilib:
. !EL !EB;el EL !EB;eb !EL EB;


--vkogqOf2sHV7VnPd--
