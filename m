Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 21:45:54 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:56721 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491083Ab0JFTpv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Oct 2010 21:45:51 +0200
Received: by ywh2 with SMTP id 2so2013301ywh.36
        for <linux-mips@linux-mips.org>; Wed, 06 Oct 2010 12:45:44 -0700 (PDT)
Received: by 10.42.171.7 with SMTP id h7mr57910icz.103.1286394344549;
        Wed, 06 Oct 2010 12:45:44 -0700 (PDT)
Received: from localhost (c-24-18-179-55.hsd1.wa.comcast.net [24.18.179.55])
        by mx.google.com with ESMTPS id d13sm1266119ibb.2.2010.10.06.12.45.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 12:45:42 -0700 (PDT)
From:   Kevin Hilman <khilman@deeprootsystems.com>
To:     Arun MURTHY <arun.murthy@stericsson.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "lars\@metafoo.de" <lars@metafoo.de>,
        "kernel\@pengutronix.de" <kernel@pengutronix.de>,
        "philipp.zabel\@gmail.com" <philipp.zabel@gmail.com>,
        "robert.jarzmik\@free.fr" <robert.jarzmik@free.fr>,
        "marek.vasut\@gmail.com" <marek.vasut@gmail.com>,
        "eric.y.miao\@gmail.com" <eric.y.miao@gmail.com>,
        "rpurdie\@rpsys.net" <rpurdie@rpsys.net>,
        "sameo\@linux.intel.com" <sameo@linux.intel.com>,
        "kgene.kim\@samsung.com" <kgene.kim@samsung.com>,
        "linux-omap\@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>,
        "bgat\@billgatliff.com" <bgat@billgatliff.com>
Subject: Re: [PATCHv2 1/7] pwm: Add pwm core driver
Organization: Deep Root Systems, LLC
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
        <1286280002-1636-2-git-send-email-arun.murthy@stericsson.com>
        <20101005122225.6dda30ff.akpm@linux-foundation.org>
        <F45880696056844FA6A73F415B568C6953571D4F05@EXDCVYMBSTM006.EQ1STM.local>
Date:   Wed, 06 Oct 2010 12:45:40 -0700
In-Reply-To: <F45880696056844FA6A73F415B568C6953571D4F05@EXDCVYMBSTM006.EQ1STM.local>
        (Arun MURTHY's message of "Wed, 6 Oct 2010 06:03:28 +0200")
Message-ID: <87ocb7jeaj.fsf@deeprootsystems.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <khilman@deeprootsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khilman@deeprootsystems.com
Precedence: bulk
X-list: linux-mips

Arun MURTHY <arun.murthy@stericsson.com> writes:

[...]

>> 
>> I suggest that you work on Kevin's comments before making any code
>> changes though.
>
> This pwm driver also supports the Davinci pwm driver as suggested by
> Kelvin.

My concern isn't whether it supports davinci or not.  Adapting existing
drivers is the easy part.

My concern is that there are now two proposals for a generic PWM
framework, and I would prefer to see that those projects are aligned
before anything merges.

Kevin
