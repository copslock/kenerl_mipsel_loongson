Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 19:32:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55261 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859948AbaFTRcjbFq6h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jun 2014 19:32:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 88AB1BAE316EB;
        Fri, 20 Jun 2014 18:32:29 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 20 Jun
 2014 18:32:32 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (192.168.5.97) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 20 Jun
 2014 18:32:32 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 20 Jun 2014 18:32:31 +0100
Received: from [10.20.2.221] (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 20 Jun
 2014 10:32:30 -0700
Message-ID: <53A4702D.3090503@imgtec.com>
Date:   Fri, 20 Jun 2014 10:32:29 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        "Qais Yousef" <Qais.Yousef@imgtec.com>
CC:     <linux-kernel@vger.kernel.org>,
        Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Subject: Re: [PATCH 1/1] MIPS: APRP: Fix an issue when device_create() fails.
References: <1403209823-6376-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <1403209823-6376-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

On 06/19/2014 01:30 PM, Sebastien Bourdelin wrote:
> If a call to device_create() fails for a channel during the initialize
> loop, we need to clean the devices entries already created before
> leaving.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
>   arch/mips/kernel/rtlx-cmp.c | 3 +++
>   arch/mips/kernel/rtlx-mt.c  | 3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
> index 758fb3c..d26dcc4 100644
> --- a/arch/mips/kernel/rtlx-cmp.c
> +++ b/arch/mips/kernel/rtlx-cmp.c
> @@ -77,6 +77,9 @@ int __init rtlx_module_init(void)
>   		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
>   				    "%s%d", RTLX_MODULE_NAME, i);
>   		if (IS_ERR(dev)) {
> +			while (i--)

--i?

> +				device_destroy(mt_class, MKDEV(major, i));
> +
>   			err = PTR_ERR(dev);
>   			goto out_chrdev;
>   		}
> diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
> index 5a66b97..cb95470 100644
> --- a/arch/mips/kernel/rtlx-mt.c
> +++ b/arch/mips/kernel/rtlx-mt.c
> @@ -103,6 +103,9 @@ int __init rtlx_module_init(void)
>   		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
>   				    "%s%d", RTLX_MODULE_NAME, i);
>   		if (IS_ERR(dev)) {
> +			while (i--)

Same here.

> +				device_destroy(mt_class, MKDEV(major, i));
> +
>   			err = PTR_ERR(dev);
>   			goto out_chrdev;
>   		}



Deng-Cheng
