Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 18:50:11 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:35854 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225290AbTDPRuG>;
	Wed, 16 Apr 2003 18:50:06 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id 9F6DBB4F5; Wed, 16 Apr 2003 19:50:04 +0200 (CEST)
Message-ID: <3E9D9827.F2565C70@ekner.info>
Date: Wed, 16 Apr 2003 19:51:35 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: MIPS32 cache functions now using c-r4k?
References: <3E9D0C34.38FE2749@ekner.info> <20030416165919.A15111@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I'll test it out a little later this evening. But I think there is a typo and this patch should
be applied:

Index: pg-r4k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/pg-r4k.S,v
retrieving revision 1.2.2.4
diff -u -r1.2.2.4 pg-r4k.S
--- pg-r4k.S    16 Apr 2003 17:00:23 -0000      1.2.2.4
+++ pg-r4k.S    16 Apr 2003 17:46:36 -0000
@@ -63,7 +63,7 @@
        sw      zero, 4(a0)
        sw      zero, 8(a0)
        sw      zero, 12(a0)
-       addiu   a0, 64
+       addiu   a0, 32
        sw      zero, -16(a0)
        sw      zero, -12(a0)
        sw      zero, -8(a0)

/Hartvig


Ralf Baechle wrote:

> On Wed, Apr 16, 2003 at 09:54:28AM +0200, Hartvig Ekner wrote:
>
> > It seems much of the r4k cache code assumes the presence of SD - which
> > breaks on all MIPS32 CPU's?
>
> Nothing a soldering iron and some patience couldn't fix ;)
>
> Try below patch,
>
>   Ralf
