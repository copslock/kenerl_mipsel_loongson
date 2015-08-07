Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 07:49:34 +0200 (CEST)
Received: from smtprelay2.synopsys.com ([198.182.60.111]:58886 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010604AbbHGFt3a82qG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 07:49:29 +0200
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3F1C610C07F5;
        Thu,  6 Aug 2015 22:49:21 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id 0A65B4E213;
        Thu,  6 Aug 2015 22:49:21 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id 9ACBF4E202;
        Thu,  6 Aug 2015 22:49:20 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7C782F84;
        Thu,  6 Aug 2015 22:49:20 -0700 (PDT)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 62E66F83;
        Thu,  6 Aug 2015 22:49:19 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Thu, 6 Aug 2015 22:48:35 -0700
Received: from IN01WEMBXB.internal.synopsys.com ([169.254.4.157]) by
 IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0195.001; Fri, 7
 Aug 2015 11:18:32 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "heiko@sntech.de" <heiko@sntech.de>,
        "dianders@chromium.org" <dianders@chromium.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v4 4/9] arc: axs10x_defconfig: remove
 CONFIG_MMC_DW_IDMAC
Thread-Topic: [RFC PATCH v4 4/9] arc: axs10x_defconfig: remove
 CONFIG_MMC_DW_IDMAC
Thread-Index: AQHQ0BP8Nqiz3G01PEyP6SpNm1KFNg==
Date:   Fri, 7 Aug 2015 05:48:32 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B17BF@IN01WEMBXB.internal.synopsys.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843526-23976-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Thursday 06 August 2015 12:19 PM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
