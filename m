Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 03:47:49 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:25488 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012448AbbEDBrqhthg3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2015 03:47:46 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNS0086OYBHY110@mailout3.w1.samsung.com>; Mon,
 04 May 2015 02:47:41 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-4c-5546cfbc1672
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 1A.FE.04846.CBFC6455; Mon,
 4 May 2015 02:47:40 +0100 (BST)
Received: from [10.252.80.64] by eusync2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NNS0076ZYB92T70@eusync2.samsung.com>; Mon,
 04 May 2015 02:47:40 +0100 (BST)
Message-id: <5546CFB5.3040105@samsung.com>
Date:   Mon, 04 May 2015 10:47:33 +0900
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
MIME-version: 1.0
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Turquette <mturquette@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 3/8] clk: tegra: Fix inconsistent indenting
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
 <1430196383-9190-4-git-send-email-k.kozlowski@samsung.com>
 <20150501184655.GA29653@codeaurora.org>
In-reply-to: <20150501184655.GA29653@codeaurora.org>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xK7p7zruFGrz5r2/x5FAvs8X1L89Z
        Lc69esRi8f/Ra1aLSfcnsFh8e7iQ0eL1C0OL/sevmS02Pb7GavGx5x6rxeVdc9gsJkydxG7x
        6cF/ZosZ5/cxWXR+mcVm8XTCRTaLSWunMlrcnJ9mcWmPisXhN+2sFj/OdLNYvDrYxmLxc9c8
        FotVu/4wOkh4XO7rZfLYOesuu8emVZ1sHneu7WHzOLpyLZPH5iX1Hr3N79g8+rasYvTYfm0e
        s8fnTXIeG+eGBnBHcdmkpOZklqUW6dslcGUs27WVreAyS8WdKUtYGxjvMXcxcnBICJhILDyQ
        38XICWSKSVy4t56ti5GLQ0hgKaPEkQMbmSCcp4wSk878AGvgFdCSeLNfEaSBRUBVYvrbQ2wg
        NpuAscTm5UvYQEpEBSIkuk9UgoR5BQQlfky+xwJiiwioS3zfcRJsPrPABjaJrVefsYMkhAWc
        JDb9f8oOsWsto8TMbd8ZQQZxAh33rFsFpIZZwFZiwft1LBC2vMTmNW+ZJzAKzEKyYxaSsllI
        yhYwMq9iFE0tTS4oTkrPNdQrTswtLs1L10vOz93ECInfLzsYFx+zOsQowMGoxMNrOc01VIg1
        say4MvcQowQHs5II771DbqFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeefueh8iJJCeWJKanZpa
        kFoEk2Xi4JRqYFznt6owzKToTm1MYM3q3oBddy4cV3Epj2wvc+GxPP9VJ8mzyiplGhdr3TXv
        GqeF91P4wphDdnaki3V5zQv0fvpNb6vxzeMy/qYy7a+KrQ5ErnmeWVT7iq1KvrheMVqvdlp/
        vP/aRWtfME5f3HWm/79Qr+2ExHtfr0v/8VXvy4wuP10r9j1EiaU4I9FQi7moOBEAhsc2vNsC        AAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 02.05.2015 03:46, Stephen Boyd wrote:
> On 04/28, Krzysztof Kozlowski wrote:
>> Fix the indentation - spaces used instead of tabs and actually wrong
>> number of spaces.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>   drivers/clk/tegra/clk-emc.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> What branch is this against? I don't see this in linux-next or
> clk-next.

It was rebased on next-20150427. But now I cannot find it in newer 
next... Could you skip these two patches then?

Best regards,
Krzysztof
