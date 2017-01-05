Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 11:12:50 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:37701 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992143AbdAEKMixo6qB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jan 2017 11:12:38 +0100
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_2C+sayIKvD8GebMvPRdaCA)"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OJA00TSAXOU2H10@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Thu, 05 Jan 2017 19:12:30 +0900 (KST)
Received: from epsmges1p8.samsung.com (unknown [182.195.40.65])
 by     epcas1p3.samsung.com (KnoxPortal)
 with ESMTP id  20170105101230epcas1p3d4028bddec3bd230cda6a245074a588c~W2HsgXRYN2130221302epcas1p3n;
        Thu,  5 Jan 2017 10:12:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45])
 by     epsmges1p8.samsung.com (Symantec Messaging Gateway)
 with SMTP id   E4.EF.19842.E0C1E685; Thu,  5 Jan 2017 19:12:30 +0900 (KST)
Received: from epcpsbgm1new.samsung.com
 (u26.gpu120.samsung.co.kr      [203.254.230.26])
 by epcas1p4.samsung.com (KnoxPortal)
 with ESMTP id  20170105101230epcas1p4db3c7c528757a9a66488d42905f986cc~W2HsIiZCn0143001430epcas1p4J;
        Thu,  5 Jan 2017 10:12:30 +0000 (GMT)
X-AuditID: b6c32a3c-f79646d000004d82-e7-586e1c0ef9d6
Received: from epmmp2 ( [203.254.227.17]) by epcpsbgm1new.samsung.com   (EPCPMTA)
 with SMTP id 1B.CF.28252.D0C1E685; Thu,  5 Jan 2017 19:12:30 +0900     (KST)
Received: from [10.113.62.212] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0OJA002MOXOTZZC0@mmp2.samsung.com>; Thu,
 05 Jan 2017 19:12:29 +0900 (KST)
Message-id: <586E1C0D.20102@samsung.com>
Date:   Thu, 05 Jan 2017 19:12:29 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option
In-reply-to: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjH995dewUpnBXZm+oGXDQREhhXQV4UtrGR5RbNglmWdJIFLuVG
        ie216VEzjFMYG1XoBKcDKZ1TZ7YUa9AKBmQZpqAz4UcFAjoR5oYR5wRcWBHWjezKSeJ/n+d5
        vs/3fZ/nzavCNVdIrapUKONtAmeilZHElZ6klJTojYI+bbQxEQUm/DjyOHciX/UMQFXtQYAq
        z40Q6MmMF0N1U3/iKBC4SKI5/0Mc+abGFGjkqluJ6r/+ikTzX/YC1P7HLIZOBn7CkPvfEzgK
        PVtWoPvnZ5Sov29YgeaWctHh3gUcXQqyb8axD3xDgO10TZCsr+WIkq24FiDYe2M/KtnrngsY
        e/ncIXZ8eQpnAyfPSLKOeYxtq5O0baMOgnUvLRDsvO/V/Og9fLaR54p5WwIvGCzFpUJJDr3z
        /cK3CzO2pTEpTBbKpBMEzszn0Hm78lPeKTVJo9MJ+ziTXUrlc6JIv/Z6ts1iL+MTjBaxLIcu
        YBhdKpOWmarT6VLTt360XZchSYp44y++f4C1X/1JyH+oAjyOrAERKkilw4HPlhQyx8Fbk63K
        GhCp0lAdAA5PN64UNJQDg0edhtWG2TEvLovcAI7f7APhgppaCxePTxJhxql8eGo8+NxpEsAb
        dZ+TNUAlibbAH9xrw0hQm+EXrhVPJZUMux/dUYY5hkqEo4tTK5brKT3s/HaBDNvEUgM4DFZP
        EOEAp55gsGPw1Mrt1lG74dDtEBbmCKoINh97gMk3bY6APSFN+DBIvQJ913A5nQdDi6u8Dj7+
        uY2UeQNsWb6Lhf0hdRzAmgv/4XLgBLDSe10pq7bCX+9P4vKU0XA26FTIB6jh4WqNLGGhZ7YJ
        yJwLB242EfIiLkk+jm68HsS7XliY64WFyZwE27taSZdki1PxsHd4r5xOg3VDPUDmRNhwtuI5
        Z8GZ9qeK04BsAXG8VTSX8CJjRakiZxbtQkmqwWL2gZV/kpzdAYYHd/kBpQJ0lLpiwaTXKLh9
        YrnZDzZJRr9fPH8LaAnBIvB0rNoYJ+g16mKufD9vsxTa7CZe9IMM6d2O4dr1Bov0A4WyQiZ9
        G5OuS2eYTF2ajn5Z/X3lDr2GKuHK+L08b+Vtq32YKkJbAYqqupK/OfDeCXTw3huGhtGuD521
        UdPTDSA672Hrmp5YZ60n6u5vvqw1263Tf9Xuz/376NNI752CQW35jqb6A2PActrx3SO+ufzg
        nviCD1JGDBvfBZdfutrpmPvYAxzd8ZtGBzfHDByp3ZCUYTfeXu5/5rHd2GKK4avI5L5G8tPd
        3rdoQjRyTDJuE7n/AY0Bw69JBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsVy+t9jQV0+mbwIg+P3OCzO3z3EbLGyx9ti
        U9tbRovmrV8ZLRqXXGaxePN2DZNF/+PXzBbnz29gt3h/6BmzxabH11gtLu+aw2YxYeokdovP
        vUcYLba+fMdkMeP8PiaLOX+mMFv8/v6P1eLB6rdsFmdOX2K1eP/T0aLjyDdmi41fPRzEPJ5s
        usjosXPWXXaPTas62TwaDpxn8bhzbQ+bx9GVa5k8Ni+p97j97zGzx/kZC4HKdnxm8tjSD1S7
        5Wo7i8ecn99YPD5vkgvgi3KzyUhNTEktUkjNS85PycxLt1UKDXHTtVBSyEvMTbVVitD1DQlS
        UihLzCkF8owM0ICDc4B7sJK+XYJbxuL3c5kLDvBWrOs/xNLAeI+ri5GTQ0LAROLdtTXMELaY
        xIV769m6GLk4hARmMUo8fveSHSTBKyAo8WPyPZYuRg4OZgE/ib4r6hA1Dxgl3v1dxwoS5xXQ
        kFg+RxDEZBFQlWidlQzSySagJbH/xQ02EJtfQFHi6o/HjCAlogIREt0nKkGmiAicZZY493se
        C0gNs8AbJol3EypAbGEBf4lFLVOZIFZtZpR4Mnct2DmcAgkSy3+sYp3ACHQkwnWzEK6bBTZK
        XWLSvEXMEGF5iSOXsiHCehL/D31ngQkfPC8LETaXeHZrC8sCRvZVjBKpBckFxUnpuYZ5qeV6
        xYm5xaV56XrJ+bmbGMEp6pnUDsaDu9wPMQpwMCrx8HoI5EYIsSaWFVfmHmJUARr1aMPqC4xS
        LHn5ealKIrxS0nkRQrwpiZVVqUX58UWlOanFhxhNgaE0kVlKNDkfmFbzSuINTcxNzI0NLMwt
        LU2MlMR5G2c/CxcSSE8sSc1OTS1ILYLpY+LglGpg5JLLYV5encUpwRi+xbl8Sdqffkc7rbf7
        F7XdV9llnbJJ7ZudvLbq/gI29cn/jzKtWxq6/91pfStNzug/gY+MJXSCPfN+fMwveBsRdeuV
        +U6/zWUvzCaqr35t8EfSLatLeNekv3Ja8992N1ler/c/dLhvu/jm7KT//PeljnXEb7ZLWXPq
        +fwYJZbijERDLeai4kQA0Se4h3MDAAA=
X-MTR:  20000000000000000@CPGS
X-CMS-MailID: 20170105101230epcas1p4db3c7c528757a9a66488d42905f986cc
X-Msg-Generator: CA
X-Sender-IP: 203.254.230.26
X-Local-Sender: =?UTF-8?B?7LWc7LCs7JqwG1RpemVuIFBsYXRmb3JtIExhYihTL1fshLw=?=
        =?UTF-8?B?7YSwKRvsgrzshLHsoITsnpAbUzUo7LGF7J6EKS9DaGFuZ2UgQWdlbnQ=?=
X-Global-Sender: =?UTF-8?B?Q2hhbndvbyBDaG9pG1RpemVuIFBsYXRmb3JtIExhYi4bU2Ft?=
        =?UTF-8?B?c3VuZyBFbGVjdHJvbmljcxtTNS9TZW5pb3IgRW5naW5lZXI=?=
X-Sender-Code: =?UTF-8?B?QzEwG1NUQUYbQzEwVjgxMTE=?=
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-HopCount: 7
X-CMS-RootMailID: 20170105082939epcas4p4b494945ce55c949dc7a030ebf9dbdd4c
X-RootMTR: 20170105082939epcas4p4b494945ce55c949dc7a030ebf9dbdd4c
References: <CGME20170105082939epcas4p4b494945ce55c949dc7a030ebf9dbdd4c@epcas4p4.samsung.com>
 <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
Return-Path: <cw00.choi@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw00.choi@samsung.com
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

This is a multi-part message in MIME format.

--Boundary_(ID_2C+sayIKvD8GebMvPRdaCA)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT

Hi Viresh,

On 2017년 01월 05일 17:27, Viresh Kumar wrote:
> This doesn't have any benefit apart from saving a small amount of memory
> when it is disabled. The ifdef hackery in the code makes it dirty
> unnecessarily.
> 
> Clean it up by removing the Kconfig option completely. Few defconfigs
> are also updated and CONFIG_CPU_FREQ_STAT_DETAILS is replaced with
> CONFIG_CPU_FREQ_STAT now in them, as users wanted stats to be enabled.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig         |  2 +-
>  arch/arm/configs/multi_v5_defconfig       |  2 +-
>  arch/arm/configs/multi_v7_defconfig       |  2 +-
>  arch/arm/configs/mvebu_v5_defconfig       |  2 +-
>  arch/arm/configs/pxa_defconfig            |  2 +-
>  arch/arm/configs/shmobile_defconfig       |  2 +-
>  arch/mips/configs/lemote2f_defconfig      |  1 -
>  arch/powerpc/configs/ppc6xx_defconfig     |  1 -
>  arch/sh/configs/sh7785lcr_32bit_defconfig |  2 +-
>  drivers/cpufreq/Kconfig                   |  8 --------
>  drivers/cpufreq/cpufreq_stats.c           | 14 --------------
>  11 files changed, 7 insertions(+), 31 deletions(-)


I agree. Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

--Boundary_(ID_2C+sayIKvD8GebMvPRdaCA)
Content-type: text/x-vcard; CHARSET=EUC-KR; name=cw00_choi.vcf
Content-transfer-encoding: base64
Content-disposition: attachment; filename=cw00_choi.vcf

bnVsbA0K

--Boundary_(ID_2C+sayIKvD8GebMvPRdaCA)--
