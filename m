Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 06:51:45 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:12226 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22469651AbYJ0Gvl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 06:51:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9R6pau6006763;
	Mon, 27 Oct 2008 06:51:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9R6pZO2006761;
	Mon, 27 Oct 2008 06:51:35 GMT
Date:	Mon, 27 Oct 2008 06:51:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	Linux-Mips List <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] irq handler must disable the handled irq
Message-ID: <20081027065135.GA6183@linux-mips.org>
References: <20081026103635.GA10490@linux-mips.org> <1225071026-32739-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225071026-32739-1-git-send-email-n0-1@freewrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 02:30:26AM +0100, Phil Sutter wrote:

>  drivers/ata/pata_rb532_cf.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Please send this patch to the IDE maintainer & list.

  Ralf
