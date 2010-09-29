Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 14:12:42 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:33203 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491082Ab0I2MMi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 14:12:38 +0200
Received: by yxm34 with SMTP id 34so295559yxm.36
        for <linux-mips@linux-mips.org>; Wed, 29 Sep 2010 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=BDb1VoXr0QTpBmdQQlZnJ32JgAA5ubCktBPJfaf38a4=;
        b=W5UisLfLmu6QOOQIyhNrukRK2lT/kokJDrs1hfFqULhdF7hVDTlKReVCWjHfvTlDI+
         q9WUI4UalgXVJ9V3bayqBBjlESr8otLJ+dYkFld2y0cmRbVvR+OWY8/tSnOaucqZbFqd
         JdkxQyTID6sDyDjIExBv3BZavRKEOS2dWsluU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=URJiCDWYde7QVyI/Mgel9xqucXpNCJsnCoEEXRpEpNlMhz+bxZFiZ2YIqPYwWQUs1R
         R6y87d3hQjmIkDblQrJjwuKfRr+qg/taJXL/byPBPu7st6ZN9JUKunI1mUmYIcwPrIul
         DQYFmBIuzJ8xdtou65yUtekzr+3gLvfX5VFq4=
MIME-Version: 1.0
Received: by 10.42.8.18 with SMTP id g18mr1795405icg.34.1285762351189; Wed, 29
 Sep 2010 05:12:31 -0700 (PDT)
Received: by 10.42.164.68 with HTTP; Wed, 29 Sep 2010 05:12:31 -0700 (PDT)
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
        <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
        <4CA1AD2B.8000905@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
        <4CA1BC16.3020702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
        <4CA25841.4090702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
Date:   Wed, 29 Sep 2010 17:42:31 +0530
Message-ID: <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
From:   Trilok Soni <soni.trilok@gmail.com>
To:     Arun MURTHY <arun.murthy@stericsson.com>
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
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: soni.trilok@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 23257

Hi Arun,

Adding Bill Gatliff (anyway, CC list already crowded)

On Wed, Sep 29, 2010 at 10:19 AM, Arun MURTHY
<arun.murthy@stericsson.com> wrote:
>> Arun MURTHY wrote:
>> >>>> Shouldn't PWM_DEVICES select HAVE_PWM?
>> >>>
>> >>> No not required, the entire concept is to remove HAVE_PWM and use
>> >> PWM_CORE.

There is already nice and clean framework written by Bill for PWM, if
you grep the LKML and linux-embedded mailing list archive then you
will get his patches, and it seems that he had promised to send the
updated version few week back, but not heard from him (may be because
he was travelling as per FB status).

Please evaluate that framework too.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
