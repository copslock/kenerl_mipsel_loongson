Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 18:16:50 +0100 (BST)
Received: from fed1rmmtao12.cox.net ([IPv6:::ffff:68.230.241.27]:13042 "EHLO
	fed1rmmtao12.cox.net") by linux-mips.org with ESMTP
	id <S8225228AbUJTRQp>; Wed, 20 Oct 2004 18:16:45 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao12.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041020171627.FPQW9689.fed1rmmtao12.cox.net@opus>
          for <linux-mips@linux-mips.org>; Wed, 20 Oct 2004 13:16:27 -0400
Date: Wed, 20 Oct 2004 10:16:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-mips@linux-mips.org
Subject: [PATCH 2.6.9] Export phys_cpu_present_map
Message-ID: <20041020171626.GG12544@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

In net/ipv6/icmp.c::icmpv6_init() there is a call to cpu_possible()
which preprocesses down to "test_bit(((i)), (phys_cpu_present_map).bits)"
If ipv6 is a module, phys_cpu_present_map (or cpu_possible_map which is
defined t phys_cpu_present_map) needs to be exported.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.9.orig/arch/mips/kernel/smp.c
+++ linux-2.6.9/arch/mips/kernel/smp.c
@@ -44,6 +44,7 @@ cpumask_t cpu_online_map;		/* Bitmask of
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
 int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
 
+EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(cpu_online_map);
 
 cycles_t cacheflush_time;

-- 
Tom Rini
http://gate.crashing.org/~trini/
