Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 17:01:57 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:35830 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992336AbeC1PBuJMnYx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 17:01:50 +0200
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 0/8] Ingenic JZ47xx Timer/Counter Unit drivers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 28 Mar 2018 17:01:47 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
Subject: 
In-Reply-To: <aeb57b92-6932-9774-dc50-7563d30846bf@linaro.org>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
 <aeb57b92-6932-9774-dc50-7563d30846bf@linaro.org>
Message-ID: <2fb3344b4034385ed89bcdf7da2347d4@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Le 2018-03-18 23:13, Daniel Lezcano a écrit :
> On 18/03/2018 00:28, Paul Cercueil wrote:
>> Hi,
>> 
>> This is the 4th version of my TCU patchset.
>> 
>> The major change is a greatly improved documentation, both in-code
>> and as separate text files, to describe how the hardware works and
>> how the devicetree bindings should be used.
>> 
>> There are also cosmetic changes in the irqchip driver, and the
>> clocksource driver will now use as timers all TCU channels not
>> requested by the TCU PWM driver.
> 
> Hi Paul,
> 
> I don't know why but you series appears in reply to [PATCH v3 2/9]. Not
> sure if it is my mailer or how you are sending the patches but if it is
> the latter can you in the future, when resending a new version, not use
> the in-reply-to option. It will be easier to follow the versions.
> 
> Thanks.
> 
>  -- Daniel

Hi Daniel,

I guess I did a mistake. I always reply to the first patch of the 
previous
version of the patchset (is that correct?).

Thanks,
-Paul
