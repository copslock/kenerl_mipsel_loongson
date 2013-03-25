Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 17:50:38 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:62508 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826580Ab3CYQuhT0jQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Mar 2013 17:50:37 +0100
Received: by mail-ob0-f173.google.com with SMTP id dn14so6270684obc.18
        for <linux-mips@linux-mips.org>; Mon, 25 Mar 2013 09:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=EHWEI8jXjs6lNzCEIMSxUE8rQgHkiV0ZyaVCKZKOvSA=;
        b=ks1pMWPmZkk9YP2zyif3jZShlQ945r61pHrpq8KmfRwsiUvyrfDvOMN9WIlSVWB3fg
         5QddlC1sSIAuMIlhpK6QaDGHIPSOmut3ERsTHCdUyf37kQiCW1bb1sMWtshy6zY+9b8e
         N1P9Rc5wdCo9d0V9rkPH1nV7gBXXdrfzTS6D+qPHy3rWlQTEdMH4NgMVZbVtfwhLcWE0
         Y7UvGaQ7h3Fx0Sk4Lpby4xaJB2VVogjgwPN1x4CBk5RxGe88cpIruh+95yc0tGt1xU2J
         VN7nepOkwdicLtETIG7oBVoU2C2SFYD40hkw7HPo/4yBpjLx8ilVRxvBGq+eYZ//qpit
         xDLg==
MIME-Version: 1.0
X-Received: by 10.60.14.226 with SMTP id s2mr11829600oec.124.1364230230712;
 Mon, 25 Mar 2013 09:50:30 -0700 (PDT)
Received: by 10.182.52.198 with HTTP; Mon, 25 Mar 2013 09:50:30 -0700 (PDT)
In-Reply-To: <51507FEA.8040306@wwwdotorg.org>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
        <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
        <51507FEA.8040306@wwwdotorg.org>
Date:   Mon, 25 Mar 2013 22:20:30 +0530
Message-ID: <CAKohpokSmEYbW0YRasAg3MV16B3Bo8uYDqc0jLJhgR8VfbSVUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arvind.chauhan@arm.com,
        robin.randhawa@arm.com, Steve.Bannister@arm.com,
        Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
        linaro-kernel@lists.linaro.org, Sekhar Nori <nsekhar@ti.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Renninger <trenn@suse.de>,
        Borislav Petkov <bp@alien8.de>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        cbe-oss-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlF09yUqJTuu3Q6+dPEBM6+PvDBQA5WTTG2lWvJ2ipndVzfTNxqax7lXCdHeQogK/OZeAmT
X-archive-position: 35977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 25 March 2013 22:18, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/24/2013 11:19 PM, Viresh Kumar wrote:
>> On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> policy->cpus contains all online cpus that have single shared clock line. And
>>> their frequencies are always updated together.
>>>
>>> Many SMP system's cpufreq drivers take care of this in individual drivers but
>>> the best place for this code is in cpufreq core.
>>>
>>> This patch modifies cpufreq_notify_transition() to notify frequency change for
>>> all cpus in policy->cpus and hence updates all users of this API.
>>
>> Another fixup for tegra:
>
> This series including this patch (although I had a devil of a time
> applying this fixup since all the TABs got converted to spaces when it
> was pasted into email)

So sorry for that, I keep pushing them here:

http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/cpufreq-fix-notify
