Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 09:51:54 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:26817 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224845AbUIAIvt>;
	Wed, 1 Sep 2004 09:51:49 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i818pgS0011466;
	Wed, 1 Sep 2004 04:51:47 -0400
Received: from localhost (mail@vpn50-67.rdu.redhat.com [172.16.50.67])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i818pP318234;
	Wed, 1 Sep 2004 04:51:27 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1C2Qpo-0001Bk-00; Wed, 01 Sep 2004 09:51:16 +0100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Wed, 01 Sep 2004 09:51:16 +0100
In-Reply-To: <20040901.012223.59462025.anemo@mba.ocn.ne.jp> (Atsushi
 Nemoto's message of "Wed, 01 Sep 2004 01:22:23 +0900 (JST)")
Message-ID: <87656yqsmz.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto <anemo@mba.ocn.ne.jp> writes:
> Is this a get_user's problem or gcc's?

The latter.  gcc is putting the empty asm:

	__asm__ ("":"=r" (__gu_val));

into the delay slot of the call.

Part of the problem is that gcc estimates the length of an asm to be the
number of instruction separators + 1.  This means that it estimates the
asm above to be one instruction long, which is perhaps a little silly
for an empty string.

But the real problem is that gcc should never trust this estimate anyway,
since each "instruction" could obviously be a multi-instruction macro.
gcc should certainly never put asms into delay slots.

FWIW, I don't think the bug is specific to 3.3 or 3.4.  It could
probably trigger for other gcc versions too.  It is highly dependent
on scheduling though.

The attached 3.4.x patch fixes the problem there, but if you want to work
around it for old versions, just avoid using empty asms if you can,
or make them volatile if you can't.

Of course, the problem isn't confined to empty asms.  If you have an asm
with a single, multi-instruction macro, gcc might try putting that in a
delay slot too.  You should at least get an assembler warning in that case.

Richard


Index: config/mips/mips.md
===================================================================
RCS file: /cvs/gcc/gcc/gcc/config/mips/mips.md,v
retrieving revision 1.211.4.7
diff -u -p -F^\([(a-zA-Z0-9_]\|#define\) -r1.211.4.7 mips.md
--- config/mips/mips.md	25 Jun 2004 07:35:30 -0000	1.211.4.7
+++ config/mips/mips.md	1 Sep 2004 08:26:02 -0000
@@ -251,7 +251,7 @@ (define_attr "single_insn" "no,yes"
 
 ;; Can the instruction be put into a delay slot?
 (define_attr "can_delay" "no,yes"
-  (if_then_else (and (eq_attr "type" "!branch,call,jump")
+  (if_then_else (and (eq_attr "type" "!branch,call,jump,multi")
 		     (and (eq_attr "hazard" "none")
 			  (eq_attr "single_insn" "yes")))
 		(const_string "yes")
