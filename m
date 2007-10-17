Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 18:26:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64665 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038738AbXJQR0Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 18:26:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HHQOE8009964;
	Wed, 17 Oct 2007 18:26:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HHQOPB009963;
	Wed, 17 Oct 2007 18:26:24 +0100
Date:	Wed, 17 Oct 2007 18:26:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22 fix hang due to messing with timer interrupt
	handler
Message-ID: <20071017172623.GB7313@linux-mips.org>
References: <20071017171517.GA16678@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071017171517.GA16678@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 07:15:17PM +0200, Thomas Bogendoerfer wrote:

> As IP22 is now using do_IRQ for timer interrupt, don't mess with
> interrupt handler any longer

The diffstat of your fix clearly says "apply me" ;-)

Thanks,

   Ralf
