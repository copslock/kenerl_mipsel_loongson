Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 20:19:09 +0200 (CEST)
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:62415 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493431AbZGYSTC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Jul 2009 20:19:02 +0200
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML106.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Sat, 25 Jul 2009 20:19:02 +0200
From:	Frans Pop <elendil@planet.nl>
To:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Sat, 25 Jul 2009 20:18:58 +0200
User-Agent: KMail/1.9.9
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <20090725174449.GC14062@dtor-d630.eng.vmware.com>
In-Reply-To: <20090725174449.GC14062@dtor-d630.eng.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907252019.01266.elendil@planet.nl>
X-OriginalArrivalTime: 25 Jul 2009 18:19:02.0479 (UTC) FILETIME=[631DC5F0:01CA0D54]
Return-Path: <elendil@planet.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elendil@planet.nl
Precedence: bulk
X-list: linux-mips

On Saturday 25 July 2009, Dmitry Torokhov wrote:
> On Wed, Jul 22, 2009 at 05:18:39PM +0200, Manuel Lauss wrote:
> > Cc: Frans Pop <elendil@planet.nl>
> > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> >
> > +
> > +static struct dev_pm_ops au1xmmc_pmops = {
> > +	.resume		= au1xmmc_resume,
> > +	.suspend	= au1xmmc_suspend,
> > +};
> > +
>
> Was suspend to disk tested? It requires freeze()/thaw().

Is that a regression introduced by this patch then? If so, many more of 
the recent dev_pm_ops conversion patches would need to be revisited.
