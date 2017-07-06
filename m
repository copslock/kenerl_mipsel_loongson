Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 15:06:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25740 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993155AbdGFNGM0P7Bx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 15:06:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6491CD68CE256;
        Thu,  6 Jul 2017 14:06:02 +0100 (IST)
Received: from BADAG04.ba.imgtec.org (10.20.40.112) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Jul
 2017 14:06:06 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 BADAG04.ba.imgtec.org ([fe80::b930:4082:95b0:e446%15]) with mapi id
 14.03.0266.001; Thu, 6 Jul 2017 06:06:01 -0700
From:   Miodrag Dinic <Miodrag.Dinic@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH v2 10/10] MIPS: generic: Add optional support for
 Android kernel
Thread-Topic: [PATCH v2 10/10] MIPS: generic: Add optional support for
 Android kernel
Thread-Index: AQHS8Ca9zlAfXYdNtUK+8mWZP2VRZaI67AoAgAvjOKc=
Date:   Thu, 6 Jul 2017 13:06:00 +0000
Message-ID: <232DDC0A2B605E4F9E85F6904417885F015D929D04@BADAG02.ba.imgtec.org>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-11-git-send-email-aleksandar.markovic@rt-rk.com>,<20170628162756.GA16759@kroah.com>
In-Reply-To: <20170628162756.GA16759@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Miodrag.Dinic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Greg,

> Why is this a MIPS config file?  What about the "generic" android
> configs we already have?  Shouldn't they work just as well here?

You are right, this should not be MIPS specific config.
This patch will be omitted in the next version.

Thanks!

Kind regards,
Miodrag

________________________________________
From: Greg Kroah-Hartman [gregkh@linuxfoundation.org]
Sent: Wednesday, June 28, 2017 6:27 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; David S. Miller; Douglas Leung; James Hogan; linux-kernel@vger.kernel.org; Martin K. Petersen; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle
Subject: Re: [PATCH v2 10/10] MIPS: generic: Add optional support for Android kernel

On Wed, Jun 28, 2017 at 05:47:03PM +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
>
> This commit adds new android.config configuration file including
> the most common prerequisites for running Android operating system.
>
> The selected set of platform independent configuration parameters
> have been taken from the official Android kernel repo:
> https://android.googlesource.com/kernel/common/+
> /android-4.4/android/configs/android-base.cfg
>
> android.config will be merged with the selected generic kernel
> configuration only if explicitly specified through environment
> variable OS=android.
>
> Example:
> make ARCH=mips 64r6el_defconfig BOARDS="list of boards" OS=android
>
> android.config file should be occasionally revisited and updated
> with latest requirements from Google.
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  MAINTAINERS                              |   1 +
>  arch/mips/Makefile                       |   8 +-
>  arch/mips/configs/generic/android.config | 173 +++++++++++++++++++++++++++++++

Why is this a MIPS config file?  What about the "generic" android
configs we already have?  Shouldn't they work just as well here?

And finally, does this config file fragment pass the latest tests that
Google has for kernel config requirements?

thanks,

greg k-h
