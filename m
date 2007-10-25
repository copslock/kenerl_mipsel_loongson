Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 17:10:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8620 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022921AbXJYQKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 17:10:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9PGAOLC024963;
	Thu, 25 Oct 2007 17:10:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9PGANTX024962;
	Thu, 25 Oct 2007 17:10:23 +0100
Date:	Thu, 25 Oct 2007 17:10:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use a sensible tlbex default for unknown CPUs
Message-ID: <20071025161023.GA24715@linux-mips.org>
References: <20071025155912.GD3994@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071025155912.GD3994@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 04:59:12PM +0100, Thiemo Seufer wrote:

> currently the kernel panics when it boots on an unknown CPU model
> (with an unknown PRID). Based on the assumption that the majority
> of newly supported CPU will conform to Release 2 standard, I wrote
> the appended patch which handles unknown CPUs as R2. It isn't
> completely bulletproof, as (yet unsupported) non-R1/R2 CPUs may
> use the AT config bits for different purposes. I still think this
> is good enough a test.
> 
> This patch allows me to boot Linux on a "generic" MIPS64R2 Qemu
> without making up a potentially conflicting PRID. All-zeroes
> like for other undefined fields does fine.

It's a little more elegant with cpu_has_mips_r2.  So how about below patch.

  Ralf

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a61246d..91a7380 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -935,14 +935,6 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 		tlbw(p);
 		break;
 
-	case CPU_4KEC:
-	case CPU_24K:
-	case CPU_34K:
-	case CPU_74K:
-		i_ehb(p);
-		tlbw(p);
-		break;
-
 	case CPU_RM9000:
 		/*
 		 * When the JTLB is updated by tlbwi or tlbwr, a subsequent
@@ -982,8 +974,13 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 		break;
 
 	default:
-		panic("No TLB refill handler yet (CPU type: %d)",
-		      current_cpu_data.cputype);
+		/* Panic if this isn't a Release 2 CPU. */
+		if (!cpu_has_mips_r2)
+			panic("No TLB refill handler yet (CPU type: %d)",
+			      current_cpu_data.cputype);
+		/* fall through */
+		i_ehb(p);
+		tlbw(p);
 		break;
 	}
 }
