Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 15:54:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20945 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039427AbXBRPyM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Feb 2007 15:54:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1IFs95i025618;
	Sun, 18 Feb 2007 15:54:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1IFs8Mi025617;
	Sun, 18 Feb 2007 15:54:08 GMT
Date:	Sun, 18 Feb 2007 15:54:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make __declare_dbe_table() static
Message-ID: <20070218155408.GA24660@linux-mips.org>
References: <20070219.004435.25910295.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070219.004435.25910295.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 19, 2007 at 12:44:35AM +0900, Atsushi Nemoto wrote:

> Make __declare_dbe_table() static and call it explicitly to ensure not
> optimized out.

That's what __attribute_used__ was meant to be used for.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cfd1785..db0a9a2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -340,7 +340,7 @@ NORET_TYPE void ATTRIB_NORET die(const char * str, struct pt_regs * regs)
 extern const struct exception_table_entry __start___dbe_table[];
 extern const struct exception_table_entry __stop___dbe_table[];
 
-void __declare_dbe_table(void)
+static void __attribute_used__ __declare_dbe_table(void)
 {
 	__asm__ __volatile__(
 	".section\t__dbe_table,\"a\"\n\t"
