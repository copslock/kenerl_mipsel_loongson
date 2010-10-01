Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 05:27:54 +0200 (CEST)
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:47225 "EHLO
        eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490968Ab0JAD1v convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Oct 2010 05:27:51 +0200
Received: from source ([167.4.1.35]) (using TLSv1) by eu1sys200aob108.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKVVAoqoRfhVWLwdiaEv/5lFteiDoEQ1@postini.com; Fri, 01 Oct 2010 03:27:50 UTC
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 487F99E;
        Fri,  1 Oct 2010 03:22:43 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 0C26E734;
        Fri,  1 Oct 2010 03:25:58 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 2FEDA24C075;
        Fri,  1 Oct 2010 05:25:55 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.230.100.3]) by
 exdcvycastm003.EQ1STM.local ([10.230.100.1]) with mapi; Fri, 1 Oct 2010
 05:25:57 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Trilok Soni <soni.trilok@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "broonie@opensource.wolfsonmicro.com" 
        <broonie@opensource.wolfsonmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>,
        Bill Gatliff <bgat@billgatliff.com>
Date:   Fri, 1 Oct 2010 05:25:54 +0200
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Thread-Topic: [PATCH 1/7] pwm: Add pwm core driver
Thread-Index: Actfz5masNZDgiefSeWpuNJKQ5oopwBRtuSg
Message-ID: <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
        <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
        <4CA1AD2B.8000905@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
        <4CA1BC16.3020702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
        <4CA25841.4090702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
In-Reply-To: <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
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
X-archive-position: 27907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

Hi Trilok,

> Hi Arun,
> 
> Adding Bill Gatliff (anyway, CC list already crowded)
> 
> On Wed, Sep 29, 2010 at 10:19 AM, Arun MURTHY
> <arun.murthy@stericsson.com> wrote:
> >> Arun MURTHY wrote:
> >> >>>> Shouldn't PWM_DEVICES select HAVE_PWM?
> >> >>>
> >> >>> No not required, the entire concept is to remove HAVE_PWM and
> use
> >> >> PWM_CORE.
> 
> There is already nice and clean framework written by Bill for PWM, if
> you grep the LKML and linux-embedded mailing list archive then you
> will get his patches, and it seems that he had promised to send the
> updated version few week back, but not heard from him (may be because
> he was travelling as per FB status).
> 
> Please evaluate that framework too.
> 
Thanks for this information, I did search in linux-embedded mailing list
archive. Below are my views on that patch set.
Many of the functions that has been defined in pwm core driver
written by Bill Gatliff is not being used by the most of the pwm drivers
except Atmel PWM driver. I rather felt the pwm core driver was an attempt
made to generalize the Atmel pwm driver.
And moreover this was posted long back somewhere in the beginning of this
year i.e Feb and the thread is dead thereafter.

This patch has been submitted focusing all the existing pwm drivers and
only these are the functions that are being used by pwm drivers.
This patch set also included patch to align all the existing pwm driver
with the pwm core driver.
So it is an attempt to generalize most of the pwm drivers and
conclude with a pwm core driver.

Thanks and Regards,
Arun R Murthy
-------------
