Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Apr 2013 12:11:31 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54540 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816206Ab3DCKLaAk3lk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Apr 2013 12:11:30 +0200
Message-ID: <515BFF6B.3060000@phrozen.org>
Date:   Wed, 03 Apr 2013 12:07:39 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     viresh.kumar@linaro.org
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 5/9] mips: cpufreq: move cpufreq driver to drivers/cpufreq
References: <cover.1364229828.git.viresh.kumar@linaro.org>        <199e0d0a282290544ff562b904a0028a104aad45.1364229828.git.viresh.kumar@linaro.org>        <CAKohpom4sckvmB12=KRX4aMJDJjpT=nN++_xyL=p_0ZY7v6oMQ@mail.gmail.com> <CAKohpome32G=Nn4Uy3kHJyeJ2cTUOBTwHy9nKo2r6Cb1=KVS7A@mail.gmail.com>
In-Reply-To: <CAKohpome32G=Nn4Uy3kHJyeJ2cTUOBTwHy9nKo2r6Cb1=KVS7A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 36007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 03/04/13 11:28, Viresh Kumar wrote:
> On 31 March 2013 09:31, Viresh Kumar<viresh.kumar@linaro.org>  wrote:
>> On 25 March 2013 22:24, Viresh Kumar<viresh.kumar@linaro.org>  wrote:
>>> This patch moves cpufreq driver of MIPS architecture to drivers/cpufreq.
>>>
>>> Cc: Ralf Baechle<ralf@linux-mips.org>
>>> Cc: linux-mips@linux-mips.org
>>> Signed-off-by: Viresh Kumar<viresh.kumar@linaro.org>
>>> ---
>>>   arch/mips/Kconfig                                  |  9 ++++-
>>>   arch/mips/kernel/Makefile                          |  2 --
>>>   arch/mips/kernel/cpufreq/Kconfig                   | 41 ----------------------
>>>   arch/mips/kernel/cpufreq/Makefile                  |  5 ---
>>>   drivers/cpufreq/Kconfig                            | 18 ++++++++++
>>>   drivers/cpufreq/Makefile                           |  1 +
>>>   .../kernel =>  drivers}/cpufreq/loongson2_cpufreq.c |  0
>>>   7 files changed, 27 insertions(+), 49 deletions(-)
>>>   delete mode 100644 arch/mips/kernel/cpufreq/Kconfig
>>>   delete mode 100644 arch/mips/kernel/cpufreq/Makefile
>>>   rename {arch/mips/kernel =>  drivers}/cpufreq/loongson2_cpufreq.c (100%)
>>
>> Ralf or any other mips guy,
>>
>> Can i have your ack or comments for this patch?
>
> Ping!!
>
>

sorry for the delay ...

Acked-by: John Crispin <blogic@openwrt.org>
