Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 17:47:21 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:37047 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022915AbXFFQrT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 17:47:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l56GeJwW031742;
	Wed, 6 Jun 2007 17:40:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l56GeIFC031741;
	Wed, 6 Jun 2007 17:40:18 +0100
Date:	Wed, 6 Jun 2007 17:40:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"tiansm@lemote.com" <tiansm@lemote.com>, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH] cheat for support of more than 256MB memory
Message-ID: <20070606164018.GA30017@linux-mips.org>
References: <11811049622818-git-send-email-tiansm@lemote.com> <11811049643791-git-send-email-tiansm@lemote.com> <cda58cb80706052338y461f707fq790e204f55a23cc0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706052338y461f707fq790e204f55a23cc0@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 08:38:18AM +0200, Franck Bui-Huu wrote:

> >diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >index 4975da0..62ef100 100644
> >--- a/arch/mips/kernel/setup.c
> >+++ b/arch/mips/kernel/setup.c
> >@@ -509,6 +509,14 @@ static void __init resource_init(void)
> >                res->end = end;
> >
> >                res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> >+#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
> >+               /* to keep memory continous, we tell system 0x10000000 - 
> >0x20000000 is reserved
> >+                * for memory, in fact it is io region, don't occupy it
> >+                *
> >+                * SPARSEMEM?
> 
> Definetly yes ! It has been designed for such issue and it should save
> you some memory.

A hole of 256MB size in the memory address map will cost 3.5MB with a 64-bit
kernel.  The other reason why I don't like this patch is that it drags
platform specific code into the generic MIPS code.

  Ralf
