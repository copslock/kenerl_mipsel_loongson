Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA07344 for <linux-archive@neteng.engr.sgi.com>; Mon, 1 Dec 1997 15:42:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA03682 for linux-list; Mon, 1 Dec 1997 15:37:22 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03674 for <linux@engr.sgi.com>; Mon, 1 Dec 1997 15:37:20 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA28376
	for <linux@engr.sgi.com>; Mon, 1 Dec 1997 15:37:18 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA25680
	for <linux@engr.sgi.com>; Tue, 2 Dec 1997 00:37:13 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA10678;
	Tue, 2 Dec 1997 00:31:21 +0100
Message-ID: <19971202003120.47636@uni-koblenz.de>
Date: Tue, 2 Dec 1997 00:31:20 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Terminal type "linux"
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

since I often use the Linux text consoles I found it a little bit
annoying that IRIX doesn't know the terminal type linux.  The terminfo
descriptions below are based on the data collection included with
ncurses for the terminal types ``linux'', ``linux-m'' and ``linux-nic''.
I modified the descriptions such that they don't refer to other
terminal types anymore.  You can simply compile them with tic.

  Ralf

# This entry is good for the 1.2.13 version of the Linux console driver.
#
# Note: there are numerous broken linux entries out there, which didn't screw
# up BSD termcap but hose ncurses's smarter cursor-movement optimization.
# One common pathology is an incorrect tab length of 4.
#
# ***************************************************************************
# *                                                                         *
# *                           WARNING:                                      *
# * Linuxes come with a default keyboard mapping kcbt=^I.  This entry, in   *
# * response to user requests, assumes kcbt=\E[Z, the ANSI/ECMA reverse-tab *
# * character. Here are the keymap replacement lines that will set this up: *
# *                                                                         *
#	keycode  15 = Tab             Tab
#		alt     keycode  15 = Meta_Tab
#		shift	keycode  15 = F26
#	string F26 ="\033[Z"
# *                                                                         *
# * This has to use a key slot which is unfortunate (any unused one will    *
# # do, F26 is the higher-numbered one).  The change ought to be built      *
# * into the kernel tables.                                                 *
# *                                                                         *
# ***************************************************************************
#
# The 1.3.x kernels add color-change capabilities; if yours doesn't have this
# and it matters, turn off <ccc>.  The %02x escape used to implement this is
# not back-portable to SV curses and not supported in ncurses versions before
# 1.9.9.
#
# From: Eric S. Raymond <esr@snark.thyrsus.com> 15 Dec 1995
linux|linux console, 
	am, bce, ccc, eo, mir, msgr, xenl, xon, 
	cols#80, it#8, lines#25, 
	bel=^G, civis=\E[?25l, clear=\E[H\E[J, 
	cnorm=\E[?25h, cr=^M, csr=\E[%i%p1%d;%p2%dr, 
	cub1=^H, cud1=^J, cuf1=\E[C, cup=\E[%i%p1%d;%p2%dH, 
	cuu1=\E[A, dch=\E[%p1%dP, dch1=\E[P, dim=\E[2m, 
	dl=\E[%p1%dM, dl1=\E[M, ed=\E[J, el=\E[K, 
	flash=\E[?5h\E[?5l$<200/>, home=\E[H, 
	hpa=\E[%i%p1%dG, ht=^I, hts=\EH, ich=\E[%p1%d@, 
	ich1=\E[@, il=\E[%p1%dL, il1=\E[L, ind=^J, 
	initc=\E]P%p1%x%p2%02x%p3%02x%p4%02x, kb2=\E[G, 
	kbs=\177, kcbt=\E[Z, kcub1=\E[D, kcud1=\E[B, 
	kcuf1=\E[C, kcuu1=\E[A, kdch1=\E[3~, kend=\E[4~, 
	kf1=\E[[A, kf10=\E[21~, kf11=\E[23~, kf12=\E[24~, 
	kf13=\E[25~, kf14=\E[26~, kf15=\E[28~, kf16=\E[29~, 
	kf17=\E[31~, kf18=\E[32~, kf19=\E[33~, kf2=\E[[B, 
	kf20=\E[34~, kf3=\E[[C, kf4=\E[[D, kf5=\E[[E, 
	kf6=\E[17~, kf7=\E[18~, kf8=\E[19~, kf9=\E[20~, 
	khome=\E[1~, kich1=\E[2~, knp=\E[6~, kpp=\E[5~, 
	kspd=^Z, nel=^M^J, oc=\E]R, op=\E[m, rc=\E8, 
	rev=\E[7m, ri=\EM, rmir=\E[4l, rmul=\E[24m, 
	rs1=\Ec, sc=\E7, 
	sgr=\E[0;10%?%p1%t;7%;%?%p2%t;4%;%?%p3%t;7%;%?%p4%t;5%;%?%p5%t;2%;%?%p6%t;1%;%?%p7%t;8%;%?%p9%t;11%;m, 
	smir=\E[4h, tbc=\E[3g, u6=\E[%i%d;%dR, u7=\E[6n, 
	u8=\E[?6c, u9=\E[c, vpa=\E[%i%p1%dd,
	blink=\E[5m, bold=\E[1m, invis=\E[8m, rev=\E[7m, 
	rmacs=\E[10m, rmpch=\E[10m, rmso=\E[m, rmul=\E[m, 
	sgr=\E[0;10%?%p1%t;7%;%?%p2%t;4%;%?%p3%t;7%;%?%p4%t;5%;%?%p6%t;1%;%?%p7%t;8%;%?%p9%t;11%;m, 
	sgr0=\E[0;10m, smacs=\E[11m, smpch=\E[11m, 
	smso=\E[7m, smul=\E[4m, 
	colors#8, ncv#3, pairs#64, 
	op=\E[37;40m, setab=\E[4%p1%dm, setaf=\E[3%p1%dm, 
	setb=\E[%p1%{40}%+%dm, setf=\E[%p1%{30}%+%dm, 
	acsc=`\004a\261f\370g\361h\260j\331k\277l\332m\300n\305o~q\304r\362s_t\303u\264v\301w\302x\263y\371z\372{\373|\374}\375~\376.\031-\030\054\021+^P0\333p\304r\304y\363z\362{\343|\330}\234, 
	rmacs=\E[10m, smacs=\E[11m, 
linux-m|Linux console no color, 
	colors@, pairs@, 
	setab@, setaf@, setb@, setf@, use=linux,
linux-nic|linux with ich/ich1 suppressed for non-curses programs, 
	ich@, ich1@, use=linux,
