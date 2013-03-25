Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 17:48:56 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:55002 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834881Ab3CYQsyDqAoE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Mar 2013 17:48:54 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id D2AEE643C;
        Mon, 25 Mar 2013 10:49:05 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id F1A39E4103;
        Mon, 25 Mar 2013 10:48:43 -0600 (MDT)
Message-ID: <51507FEA.8040306@wwwdotorg.org>
Date:   Mon, 25 Mar 2013 10:48:42 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
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
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org> <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
In-Reply-To: <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 35976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 03/24/2013 11:19 PM, Viresh Kumar wrote:
> On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> policy->cpus contains all online cpus that have single shared clock line. And
>> their frequencies are always updated together.
>>
>> Many SMP system's cpufreq drivers take care of this in individual drivers but
>> the best place for this code is in cpufreq core.
>>
>> This patch modifies cpufreq_notify_transition() to notify frequency change for
>> all cpus in policy->cpus and hence updates all users of this API.
> 
> Another fixup for tegra:

This series including this patch (although I had a devil of a time
applying this fixup since all the TABs got converted to spaces when it
was pasted into email)

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
