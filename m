Received:  by oss.sgi.com id <S305155AbQCLNWs>;
	Sun, 12 Mar 2000 05:22:48 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:63610 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCLNWa>; Sun, 12 Mar 2000 05:22:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA00960; Sun, 12 Mar 2000 05:25:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA18064
	for linux-list;
	Sun, 12 Mar 2000 05:00:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA03530
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Mar 2000 05:00:49 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA09773
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Mar 2000 05:00:45 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA27906;
	Sun, 12 Mar 2000 05:00:32 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA06611;
	Sun, 12 Mar 2000 05:00:25 -0800 (PST)
Message-ID: <008a01bf8c23$65dd01f0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: FP emulation patch available
Date:   Sun, 12 Mar 2000 14:03:35 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0087_01BF8C2B.C1CC7E70"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_0087_01BF8C2B.C1CC7E70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

>My DS 5000/133 (R3000A) with FPU disabled and FPU emulation shows:
> Illegal instruction 00000034 at 801ce924, ...
>
>System.map shows:
> 801ce920 b dsemul_insns
> 801ce928 b dsemul_cpc
>
>Looks like your trick in mips_dsemul() doesn't work too well for ISA-I CPUs. Do
>you have an idea for an alternative?


I have come up with a slightly-less-pretty hack that uses the
Load Address Error trap instead of the Trap instruction to force
kernel entry in the delay slot emulator. It seems just as functional
as the previous version (i.e. operational but "paranoia" finds an
exponentiation problem), and is currently being tortured with crashme
to see if it holds up under corrupted instruction streams and corrupted
process states.  I attach a pseudo-patch (cvs diff -c output) for the changes
relative to the version obtained by applying the previous patches on the
paralogos.com server, and would appreicate verification that it does
indeed work on an R3K.  If it does, I'll check it into the MIPS repository
and it will be included in the next web distribution (and maybe our
CD-ROMS).

My apologies to those of you whose mailers can't handle
attachments.

            Regards,

            Kevin K.



------=_NextPart_000_0087_01BF8C2B.C1CC7E70
Content-Type: application/octet-stream;
	name="cp1emu.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cp1emu.patch"

Index: cp1emu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: =
/home/repository/sw/linux-2.2.12/linux/arch/mips/fpu_emulator/cp1emu.c,v
retrieving revision 1.5
diff -c -r1.5 cp1emu.c
*** cp1emu.c	2000/02/27 15:19:18	1.5
--- cp1emu.c	2000/03/12 12:24:06
***************
*** 767,772 ****
--- 767,774 ----
  static unsigned int	dsemul_sr;
  static void *dsemul_osys;
 =20
+ #define AdEL 4
+ #define AdELOAD 0x8fa00001
 =20
  int
  do_dsemulret(struct pt_regs *xcp)
***************
*** 774,781 ****
  #ifdef DSEMUL_TRACE
      _mon_printf ("desemulret\n");
  #endif
!     /* Restore previous Trap instruction vector */
!     (void)set_except_vector(13, dsemul_osys);
      /* Set EPC to return to post-branch instruction */
      xcp->cp0_epc =3D VA_TO_REG (dsemul_cpc);
      /*=20
--- 776,783 ----
  #ifdef DSEMUL_TRACE
      _mon_printf ("desemulret\n");
  #endif
!     /* Restore previous exception vector */
!     (void)set_except_vector(AdEL, dsemul_osys);
      /* Set EPC to return to post-branch instruction */
      xcp->cp0_epc =3D VA_TO_REG (dsemul_cpc);
      /*=20
***************
*** 811,833 ****
       */
      dsemul_insns =3D (mips_instruction *)(xcp->regs[29] & ~3);
      dsemul_insns -=3D 3; /* Two instructions, plus one for luck ;-) */
!     /* Verify that space exists, or can be grown, on the stack */
      if(verify_area(VERIFY_WRITE, dsemul_insns, =
sizeof(mips_instruction)*2))=20
  	return SIGBUS;
     =20
      dsemul_insns[0] =3D ir;
      /*=20
       * Algorithmics used a system call instruction, and
!      * borrowed that vector.  It seems more prudent, and
!      * is simpler in Linux, to use a TEQ instruction, though
!      * this does require a MIPS II CPU.
       */
- #define TEQ_R0_R0 0x00000034=20
-     dsemul_insns[1] =3D TEQ_R0_R0;
 =20
      dsemul_cpc =3D cpc;
      dsemul_sr =3D xcp->cp0_status;
!     dsemul_osys =3D set_except_vector(13, handle_dsemulret);
  =20
      xcp->cp0_epc =3D VA_TO_REG &dsemul_insns[0];
      xcp->cp0_status &=3D ~ST0_IM;	/* interrupt disabled inside dsemul! =
*/
--- 813,841 ----
       */
      dsemul_insns =3D (mips_instruction *)(xcp->regs[29] & ~3);
      dsemul_insns -=3D 3; /* Two instructions, plus one for luck ;-) */
!     /* Verify that the stack pointer is not competely insane */
      if(verify_area(VERIFY_WRITE, dsemul_insns, =
sizeof(mips_instruction)*2))=20
  	return SIGBUS;
     =20
      dsemul_insns[0] =3D ir;
      /*=20
       * Algorithmics used a system call instruction, and
!      * borrowed that vector.  As that would be catastrophic
!      * if a reschedule happens, a TEQ instruction was used
!      * in early versions of the Linux kernel emulator, since=20
!      * Linux does nothing useful with Trap instructions.
!      * That does not work on R3000s, however, so here we
!      * steal the Address Error on Load vector and
!      * generate an address error on an unaligned load.
       */
 =20
+     /* If one is *really* paranoid, one tests for a bad stack pointer =
*/
+     if((xcp->regs[29] & 0x3) =3D=3D 0x3) dsemul_insns[1] =3D AdELOAD - =
1;
+     else dsemul_insns[1] =3D AdELOAD;
+=20
      dsemul_cpc =3D cpc;
      dsemul_sr =3D xcp->cp0_status;
!     dsemul_osys =3D set_except_vector(AdEL, handle_dsemulret);
  =20
      xcp->cp0_epc =3D VA_TO_REG &dsemul_insns[0];
      xcp->cp0_status &=3D ~ST0_IM;	/* interrupt disabled inside dsemul! =
*/

------=_NextPart_000_0087_01BF8C2B.C1CC7E70--
