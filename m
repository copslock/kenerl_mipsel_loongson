Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 20:02:43 +0000 (GMT)
Received: from DSL022.labridge.com ([206.117.136.22]:19469 "EHLO perches.com")
	by ftp.linux-mips.org with ESMTP id S20029065AbXLQUCg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2007 20:02:36 +0000
Received: from [192.168.1.128] (192-168-1-128.LABridge.com [192.168.1.128] (may be forged))
	by perches.com (8.9.3/8.9.3) with ESMTP id LAA00757;
	Mon, 17 Dec 2007 11:13:56 -0800
Subject: Re: [PATCH] include/asm-mips/: Spelling fixes
From:	Joe Perches <joe@perches.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <4766D3BE.7070509@ru.mvista.com>
References: <1197919875-5288-10-git-send-email-joe@perches.com>
	 <4766D3BE.7070509@ru.mvista.com>
Content-Type: text/plain
Date:	Mon, 17 Dec 2007 12:02:09 -0800
Message-Id: <1197921729.27386.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.0-2mdv2008.0 
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

On Mon, 2007-12-17 at 22:53 +0300, Sergei Shtylyov wrote:
> > - * PCI interrupts will come in on either the INTA or INTD interrups lines,
> > + * PCI interrupts will come in on either the INTA or INTD interrupts lines,
>     "interrupt" here.

Quite right.
I did them by script and inspected, but didn't notice that one.
cheers, Joe

Signed-off-by: Joe Perches <joe@perches.com>
---
diff --git a/include/asm-mips/mach-wrppmc/mach-gt64120.h b/include/asm-mips/mach-wrppmc/mach-gt64120.h
index 00d8bf6..465234a 100644
--- a/include/asm-mips/mach-wrppmc/mach-gt64120.h
+++ b/include/asm-mips/mach-wrppmc/mach-gt64120.h
@@ -45,7 +45,7 @@
 #define GT_PCI_IO_SIZE	0x02000000UL
 
 /*
- * PCI interrupts will come in on either the INTA or INTD interrups lines,
+ * PCI interrupts will come in on either the INTA or INTD interrupt lines,
  * which are mapped to the #2 and #5 interrupt pins of the MIPS.  On our
  * boards, they all either come in on IntD or they all come in on IntA, they
  * aren't mixed. There can be numerous PCI interrupts, so we keep a list of the
