Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 15:43:07 +0000 (GMT)
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:16906 "EHLO
	mallaury.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20021500AbXCUPnE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 15:43:04 +0000
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with SMTP id C068B4F3F6;
	Wed, 21 Mar 2007 16:42:23 +0100 (CET)
Date:	Wed, 21 Mar 2007 16:41:16 +0100
From:	Jean Delvare <khali@linux-fr.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org, i2c@lm-sensors.org
Subject: Re: [PATCH 9/12] drivers: PMC MSP71xx LED driver
Message-Id: <20070321164116.4025ce37.khali@linux-fr.org>
In-Reply-To: <4600812E.7070200@pmc-sierra.com>
References: <4600812E.7070200@pmc-sierra.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Marc,

On Tue, 20 Mar 2007 16:49:50 -0800, Marc St-Jean wrote:
> Jean Delvare wrote:
> > This is confusing. First you write a dedicated driver, then you use the
> > generic name for the device name. This raises a question:
> > 
> > Would it make sense to have generic PCA9554 driver, possibly
> > implementing the new GPIO infrastructure, and have dedicated drivers
> > such as this one build on top of that?
> > 
> > Either way you have to be consistent, if you go with dedicated code,
> > the i2c client name should not be generic.
> 
> I have renamed the driver "pmctwiled" and the client "pmctwiled_pca9554"
> to help avoid confusion.

Are there PMC LED implementations _not_ based on the PCA9554? If not,
then the _pca9554 suffix is not really needed.

> > This driver appears to be a good candidate to become a new-style i2c
> > driver, where devices are instantiated explicitely by the platform code
> > rather than probed for afterwards. The i2c-core changes allowing that
> > will be in the next -mm kernel and will be merged in 2.6.22-rc1.
> 
> OK, I will look at it when it reaches l-m.o. Although the probe still
> allows us to support several demo boards on the same device family
> which could have a different number of clients.

The new code will let you handle that case too, the difference with the
current model being that instead of doing a system-wide probe and
having your driver check that you only attach to the right i2c adapter,
you will specifically ask to probe only that adapter, so the check will
no longer be necessary. And of course it'll be faster, too.

-- 
Jean Delvare
