Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2004 08:01:31 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:9159 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225009AbUG2HB1>;
	Thu, 29 Jul 2004 08:01:27 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i6T71Qe1016478;
	Thu, 29 Jul 2004 03:01:26 -0400
Received: from localhost (mail@vpnuser3.surrey.redhat.com [172.16.9.3])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i6T71Pa05066;
	Thu, 29 Jul 2004 03:01:25 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1Bq4uq-0000Lk-00; Thu, 29 Jul 2004 08:01:24 +0100
To: greg.roelofs@philips.com
Cc: <linux-mips@linux-mips.org>
Subject: Re: apparent math-emu hang on movf instruction
References: <OFFE4A0198.56A3A2A2-ON88256EDF.006D0D9F@philips.com>
	<876587uwud.fsf@redhat.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Thu, 29 Jul 2004 08:01:24 +0100
In-Reply-To: <876587uwud.fsf@redhat.com> (Richard Sandiford's message of
 "Thu, 29 Jul 2004 07:54:50 +0100")
Message-ID: <871xivuwjf.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rsandifo@redhat.com> writes:
> Does the patch below (against 2.6) fix things?  Only the first hunk
> is needed to fix the bug, the rest is just there for consistency.

Oops!  Serves me right for dabbling in new code.  Only the first
hunk is correct.

Richard


Index: arch/mips/math-emu/cp1emu.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/cp1emu.c,v
retrieving revision 1.32
diff -u -p -F^\([(a-zA-Z0-9_]\|#define\) -r1.32 cp1emu.c
--- arch/mips/math-emu/cp1emu.c	19 Jan 2004 16:25:21 -0000	1.32
+++ arch/mips/math-emu/cp1emu.c	29 Jul 2004 06:42:53 -0000
@@ -528,9 +528,8 @@ static int cop1Emulate(struct pt_regs *x
 		if (MIPSInst_FUNC(ir) != movc_op)
 			return SIGILL;
 		cond = fpucondbit[MIPSInst_RT(ir) >> 2];
-		if (((ctx->fcr31 & cond) != 0) != ((MIPSInst_RT(ir) & 1) != 0))
-			return 0;
-		xcp->regs[MIPSInst_RD(ir)] = xcp->regs[MIPSInst_RS(ir)];
+		if (((ctx->fcr31 & cond) != 0) == ((MIPSInst_RT(ir) & 1) != 0))
+			xcp->regs[MIPSInst_RD(ir)] = xcp->regs[MIPSInst_RS(ir)];
 		break;
 #endif
 
