Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 15:36:20 +0000 (GMT)
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:54276 "EHLO
	mallaury.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20021500AbXCUPgP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 15:36:15 +0000
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with SMTP id 0E98F4F437;
	Wed, 21 Mar 2007 16:35:34 +0100 (CET)
Date:	Wed, 21 Mar 2007 16:34:26 +0100
From:	Jean Delvare <khali@linux-fr.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org, i2c@lm-sensors.org
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver]
Message-Id: <20070321163426.0a442deb.khali@linux-fr.org>
In-Reply-To: <46007F7F.9030604@pmc-sierra.com>
References: <46007F7F.9030604@pmc-sierra.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Marc,

On Tue, 20 Mar 2007 16:42:39 -0800, Marc St-Jean wrote:
> Jean Delvare wrote:
> > Why are you making a separate algorithm driver? This should really only
> > be done when the algorithm is very generic. This is the exception, not
> > the rule. These days I tend to move algorithm code back into the only
> > bus driver that uses them (i2c-algo-sibyte done recently, i2c-algo-sgi
> > is next on my list.)
> 
> I believe it was done to separate the algorithm for the TWI sub-system,
> which is used in several devices, from the device family code. If this
> is no longer acceptable I will merge the algo code with the adapter.

You should be able to have a single i2c bus driver handling all the
different devices, by using the platform data to provide the
device-specific configuration. The i2c-algorithm concept is quite old,
now that we have a clean new device driver model it should no longer be
necessary in most cases.

-- 
Jean Delvare
