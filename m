Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 08:23:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44728 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990552AbdBQHXHpHO4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 08:23:07 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 89017F5BCFCF7;
        Fri, 17 Feb 2017 07:22:59 +0000 (GMT)
Received: from PUMAIL01.pu.imgtec.org (192.168.91.250) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 17 Feb 2017 07:23:01 +0000
Received: from [192.168.91.23] (192.168.91.23) by PUMAIL01.pu.imgtec.org
 (192.168.91.250) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 17 Feb
 2017 12:52:59 +0530
Subject: Re: [PATCH] MIPS: DTS: add img directory to Makefile
To:     Ian Pozella <Ian.Pozella@imgtec.com>
References: <1487248410-9493-1-git-send-email-Ian.Pozella@imgtec.com>
CC:     <ralf@linux-mips.org>, <James.Hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
From:   Rahul Bedarkar <Rahul.Bedarkar@imgtec.com>
Message-ID: <974d44f8-c234-b708-b9e9-4bb84745d776@imgtec.com>
Date:   Fri, 17 Feb 2017 12:52:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1487248410-9493-1-git-send-email-Ian.Pozella@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.91.23]
Return-Path: <Rahul.Bedarkar@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rahul.Bedarkar@imgtec.com
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

Hello,

On Thursday 16 February 2017 06:03 PM, Ian Pozella wrote:
> An img directory exists for the Pistchio Soc but the directory
> itself isn't in the dts Makefile meaning the dtbs never get built.
>
> Signed-off-by: Ian Pozella <Ian.Pozella@imgtec.com>
> ---
>  arch/mips/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index fc7a0a9..b9db492 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>  dts-dirs	+= brcm
>  dts-dirs	+= cavium-octeon
> +dts-dirs	+= img
>  dts-dirs	+= ingenic
>  dts-dirs	+= lantiq
>  dts-dirs	+= mti
>

Thanks for fixing this. You might want to consider adding 'Fixes' tag to 
refer to original commit that this patch fixes.

Fixes: daa10170da27 ("MIPS: DTS: img: add device tree for Marduk board")

I had tested original change with Buildroot configuration that builds 
DTS out of the tree, so failed to notice that 'img' directory needs to 
be added to Makefile.

Thanks,
Rahul
