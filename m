Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 06:24:28 +0100 (BST)
Received: from straum.hexapodia.org ([64.81.70.185]:10016 "EHLO
	straum.hexapodia.org") by ftp.linux-mips.org with ESMTP
	id S8133374AbVJTFXw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 06:23:52 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 6C69D29E; Wed, 19 Oct 2005 22:23:50 -0700 (PDT)
Date:	Wed, 19 Oct 2005 22:23:50 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] fix git tip for sibyte
Message-ID: <20051020052350.GD12605@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

Use x & ~bitmask to turn bits off, rather than x & bitmask.

Signed-Off-By: Andy Isaacson <adi@hexapodia.org>

Index: lmo/arch/mips/kernel/cpu-probe.c
===================================================================
--- lmo.orig/arch/mips/kernel/cpu-probe.c	2005-10-19 22:20:09.000000000 -0700
+++ lmo/arch/mips/kernel/cpu-probe.c	2005-10-19 22:20:48.000000000 -0700
@@ -618,7 +618,7 @@
 	 * cache code which eventually will be folded into c-r4k.c.  Until
 	 * then we pretend it's got it's own cache architecture.
 	 */
-	c->options &= MIPS_CPU_4K_CACHE;
+	c->options &= ~MIPS_CPU_4K_CACHE;
 	c->options |= MIPS_CPU_SB1_CACHE;
 
 	switch (c->processor_id & 0xff00) {
