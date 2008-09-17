Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 12:41:05 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:39635 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20219996AbYIQLk7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 12:40:59 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8HBeqTQ027791;
	Wed, 17 Sep 2008 07:40:52 -0400
Received: from shell.devel.redhat.com (shell.devel.redhat.com [10.10.36.195])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8HBepKH009692;
	Wed, 17 Sep 2008 07:40:51 -0400
Received: from shell.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by shell.devel.redhat.com (8.13.8/8.13.8) with ESMTP id m8HBepL7031159;
	Wed, 17 Sep 2008 07:40:51 -0400
Received: (from jgarzik@localhost)
	by shell.devel.redhat.com (8.13.8/8.13.8/Submit) id m8HBepFY031158;
	Wed, 17 Sep 2008 07:40:51 -0400
Date:	Wed, 17 Sep 2008 07:40:51 -0400
From:	Jeff Garzik <jgarzik@redhat.com>
To:	Weiwei Wang <weiwei.wang@windriver.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] convert sbmac tx to spin_lock_irqsave to prevent early IRQ enable
Message-ID: <20080917114051.GA30734@shell.devel.redhat.com>
References: <6781da3918e3c34d23e5f7e9cf777ab463a17d5e.1221613284.git.weiwei.wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6781da3918e3c34d23e5f7e9cf777ab463a17d5e.1221613284.git.weiwei.wang@windriver.com>
User-Agent: Mutt/1.4.2.2i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <jgarzik@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@redhat.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 17, 2008 at 10:25:37AM +0800, Weiwei Wang wrote:
> Netpoll will call the interrupt handler with interrupts
> disabled when using kgdboe, so spin_lock_irqsave() should
> be used instead of spin_lock_irq() to prevent interrupts
> from being incorrectly enabled.
> 
> Signed-off-by: Weiwei Wang <weiwei.wang@windriver.com>
> ---
>  drivers/net/sb1250-mac.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)

Please send to jeff@garzik.org or jgarzik@pobox.com.

	Jeff
