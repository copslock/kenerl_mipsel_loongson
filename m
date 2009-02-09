Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2009 11:19:30 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:54969 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S21365433AbZBILT1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2009 11:19:27 +0000
Received: from vivaldi.localnet (unknown [150.101.102.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id BD649DDD1C;
	Mon,  9 Feb 2009 22:19:19 +1100 (EST)
From:	Rusty Russell <rusty@rustcorp.com.au>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Subject: Strange initialization in  arch/mips/kernel/smtc.c:1094?
Date:	Mon, 9 Feb 2009 21:49:16 +1030
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.2.0; i686; ; )
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902092149.16573.rusty@rustcorp.com.au>
Return-Path: <rusty@rustcorp.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
Precedence: bulk
X-list: linux-mips

Latest Linus kernel, but it's been there a while:

static struct irqaction irq_ipi = {
	.handler	= ipi_interrupt,
	.flags		= IRQF_DISABLED,
	.name		= "SMTC_IPI",
	.flags		= IRQF_PERCPU
};

.flags is initialized twice: I'm amazed this even compiles.

Cheers,
Rusty.
