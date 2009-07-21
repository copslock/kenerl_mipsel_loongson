Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 16:48:59 +0200 (CEST)
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:52286 "EHLO
	CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493285AbZGUOss (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2009 16:48:48 +0200
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML101.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 21 Jul 2009 16:48:45 +0200
From:	Frans Pop <elendil@planet.nl>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] au1xmmc: dev_pm_ops conversion
Date:	Tue, 21 Jul 2009 16:48:43 +0200
User-Agent: KMail/1.9.9
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	manuel.lauss@gmail.com
References: <1248115882-20221-1-git-send-email-manuel.lauss@gmail.com> <200907202200.39288.elendil@planet.nl> <f861ec6f0907202212h4b28982fjcb9787a3915d7ee7@mail.gmail.com>
In-Reply-To: <f861ec6f0907202212h4b28982fjcb9787a3915d7ee7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907211648.44433.elendil@planet.nl>
X-OriginalArrivalTime: 21 Jul 2009 14:48:45.0243 (UTC) FILETIME=[590158B0:01CA0A12]
Return-Path: <elendil@planet.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elendil@planet.nl
Precedence: bulk
X-list: linux-mips

On Tuesday 21 July 2009, Manuel Lauss wrote:
> >> -#ifdef CONFIG_PM
> >
> > Won't the removal of this test cause a build failure if CONFIG_PM is
> > not set? If the removal of the test is safe, this should IMHO at
> > least be explained in the commit message.
>
> No, it builds just fine without CONFIG_PM; it was there to shave off a
> few bytes from the kernel image.  But not everyone tests this driver
> with CONFIG_PM=y, because apparently noone really needed PM on
> this platform (Alchemy), and a full build of most of the boards using
> this driver fails with PM enabled.

OK.

> This way the PM methods at least get a compile-test in the non-pm case.

Not sure that is a sufficiently valid argument. In any case it *is* a 
separate change to "dev_pm_ops conversion" so it really should at least 
be documented and justified in the commit log.

> I like what Magnus Damm did for some of the SuperH drivers:
>
> #ifdef CONFIG_PM
> [...]
> #define DRIVER_PM_OPS (&driver_pm_ops)
> #else
> #define DRIVER_PM_OPS NULL
> #endif

Yes, that's quite elegant.

> I'd like to keep the pm stuff enabled at all times since it doesn't
> hurt in the non-pm case and if kernel size becomes a problem I can add
> the #defines back.

I guess that's up to the maintainers of the mips port.

Cheers,
FJP
