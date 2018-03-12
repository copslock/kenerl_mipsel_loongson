Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:27:56 +0100 (CET)
Received: from mx2.mailbox.org ([80.241.60.215]:37860 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990423AbeCLV1q2C-qf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 22:27:46 +0100
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2C4B940EBE;
        Mon, 12 Mar 2018 22:27:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id tlB02Q71BNd2; Mon, 12 Mar 2018 22:27:40 +0100 (CET)
Subject: Re: [PATCH 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-3-hauke@hauke-m.de>
Message-ID: <e33d511d-be79-e3e2-5e0d-932e92adff08@hauke-m.de>
Date:   Mon, 12 Mar 2018 22:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180311174123.2578-3-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 03/11/2018 06:41 PM, Hauke Mehrtens wrote:
> From: Mathias Kresin <dev@kresin.me>
> 
> Enable syscon to use it for the RCU MFD on Amazon SE as well.
> 
> Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/lantiq/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
> index 692ae85a3e3d..8e3a1fc2bc39 100644
> --- a/arch/mips/lantiq/Kconfig
> +++ b/arch/mips/lantiq/Kconfig
> @@ -13,6 +13,8 @@ choice
>  config SOC_AMAZON_SE
>  	bool "Amazon SE"
>  	select SOC_TYPE_XWAY
> +	select MFD_SYSCON
> +	select MFD_CORE
>  
>  config SOC_XWAY
>  	bool "XWAY"
> 
