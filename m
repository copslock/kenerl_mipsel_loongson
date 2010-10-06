Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 05:47:32 +0200 (CEST)
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:50230 "EHLO
        eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490946Ab0JFDr2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Oct 2010 05:47:28 +0200
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob112.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKvxFYFt2RxWPJ4mW/kWgGoJ3kER+Qtu@postini.com; Wed, 06 Oct 2010 03:47:28 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 48C45106;
        Wed,  6 Oct 2010 03:46:08 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 033D89F3;
        Wed,  6 Oct 2010 03:46:08 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 9C8CF24C075;
        Wed,  6 Oct 2010 05:46:04 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.6.6.68]) by
 exdcvycastm022.EQ1STM.local ([10.230.100.30]) with mapi; Wed, 6 Oct 2010
 05:46:07 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Kevin Hilman <khilman@deeprootsystems.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>,
        "bgat@billgatliff.com" <bgat@billgatliff.com>
Date:   Wed, 6 Oct 2010 05:46:02 +0200
Subject: RE: [PATCHv2 0/7] PWM core driver for pwm based led and backlight
 driver
Thread-Topic: [PATCHv2 0/7] PWM core driver for pwm based led and backlight
 driver
Thread-Index: Actknrb4TxfICNkPRv+PuXsOPvAcIQAaZA9w
Message-ID: <F45880696056844FA6A73F415B568C6953571D4EFD@EXDCVYMBSTM006.EQ1STM.local>
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
 <87wrpwu1cw.fsf@deeprootsystems.com>
In-Reply-To: <87wrpwu1cw.fsf@deeprootsystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

> Arun Murthy <arun.murthy@stericsson.com> writes:
> 
> > PWM core driver for pwm based led and backlight driver.
> > The intention of the pwm core driver is not to break the build if two
> or more
> > pwm drivers are enabled.
> > Align the existing pwm drivers to make use of the pwm core driver
> 
> Hi Arun,
> 
> Because you have Bill Gatliff on Cc, I'm guessing you've already looked
> at his RFC for a generic PWM framework?
> 
> There's recently been a proposal on DaVinci that is similar to yours
> that enables multiple PWM drivers, but it would be nice to have a
> common
> framework for this, and what Bill has proposed seems to be a good
> solution.
> 
Thanks for the information. This patch set of implementing pwm core driver
is aligned with the one in Davinci. Davinci pwm devices can make use of this
core driver framework.

Thanks and Regards,
Arun R Murthy
-------------
