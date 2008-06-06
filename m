Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 08:17:32 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:23249 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022937AbYFFHRa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jun 2008 08:17:30 +0100
Received: (qmail 16558 invoked by uid 1000); 6 Jun 2008 09:17:29 +0200
Date:	Fri, 6 Jun 2008 09:17:29 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH 8/9] au1xmmc: abort requests early if no card is present
Message-ID: <20080606071729.GB16498@roarinelk.homelinux.net>
References: <20080519080339.GA21985@roarinelk.homelinux.net> <20080519080804.GI21985@roarinelk.homelinux.net> <20080605230552.68c14b2d@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080605230552.68c14b2d@mjolnir.drzeus.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Pierre,

On Thu, Jun 05, 2008 at 11:05:52PM +0200, Pierre Ossman wrote:
> On Mon, 19 May 2008 10:08:04 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > From ec41439903048bf98e301dbd03426c63156ebc0e Mon Sep 17 00:00:00 2001
> > From: Manuel Lauss <mlau@msc-ge.com>
> > Date: Sun, 18 May 2008 15:52:43 +0200
> > Subject: [PATCH] au1xmmc: abort requests early if no card is present
> > 
> > Don't process a request if no card is present.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > ---
> >  drivers/mmc/host/au1xmmc.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> > index be09a14..0b30582 100644
> > --- a/drivers/mmc/host/au1xmmc.c
> > +++ b/drivers/mmc/host/au1xmmc.c
> > @@ -689,6 +689,13 @@ static void au1xmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  	host->mrq = mrq;
> >  	host->status = HOST_S_CMD;
> >  
> > +	/* fail request immediately if no card is present */
> > +	if (0 == au1xmmc_card_inserted(host)) {
> > +		mrq->cmd->error = -ETIMEDOUT;
> > +		au1xmmc_finish_request(host);
> > +		return;
> > +	}
> > +
> >  	if (mrq->data) {
> >  		FLUSH_FIFO(host);
> >  		ret = au1xmmc_prepare_data(host, mrq->data);
> 
> You should use -ENOMEDIUM for this case.

Didn't know it existed, consider it changed.

Thanks!
	Manuel Lauss
