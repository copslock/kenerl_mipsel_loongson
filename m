Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 09:47:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16011 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021395AbXIRIrP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 09:47:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8I8lAGM026686;
	Tue, 18 Sep 2007 09:47:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8I8l8jJ026685;
	Tue, 18 Sep 2007 09:47:08 +0100
Date:	Tue, 18 Sep 2007 09:47:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>, Kumba <kumba@gentoo.org>
Subject: Re: O2 RM7000 Issues
Message-ID: <20070918084708.GA26585@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469C8600.7090208@niisi.msk.ru> <20070717122711.GA19977@linux-mips.org> <46EF0BBC.3020302@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46EF0BBC.3020302@avtrex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 17, 2007 at 04:20:28PM -0700, David Daney wrote:

Hi David,

> Ralf Baechle wrote:
> 
> >Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> >
> >diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> >index f599e79..7ee0cb0 100644
> >--- a/arch/mips/kernel/cpu-probe.c
> >+++ b/arch/mips/kernel/cpu-probe.c
> >@@ -75,6 +75,26 @@ static void r4k_wait_irqoff(void)
> > 	local_irq_enable();
> > }
> > 
> >+/*
> >+ * The RM7000 variant has to handle erratum 38.  The workaround is to not
> >+ * have any pending stores when the WAIT instruction is executed.
> >+ */
> >+static void rm7k_wait_irqoff(void)
> >+{
> >+	local_irq_disable();
> >+	if (!need_resched())
> >+		__asm__(
> >+		"	.set	push		\n"
> >+		"	.set	mips3		\n"
> >+		"	.set	noat		\n"
> >+		"	mfc0	$1, $12		\n"
> >+		"	sync			\n"
> >+		"	mtc0	$1, $12		\n"
> >+		"	wait			\n"
> >+		"	.set	pop		\n");
> >+	local_irq_enable();
> >+}
> >+
> 
> Technically, shouldn't that __asm__ be volatile?

Gcc won't delete this asm because it has no return value that is it will
treat it like a volatile asm.

  Ralf
