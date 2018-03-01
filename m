Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 11:46:24 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:53978 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992404AbeCAKqLpMYLD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 11:46:11 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E3D7E60390; Thu,  1 Mar 2018 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1519901161;
        bh=NyaP+CB1BNHml+MR00XVatwm9gxtkBNpn4AUCYGhX3k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=epiTZmVFMyNUv6l6/r46WBHoRm/DxLKrs/AUkK2WwCv5m6Wv0sFDKui0RM1GNBFR4
         nEu9yra8fr1UDRDd9hBqZk9ht3OSCMK60Q02somSfQk7R9yVAdZkCgHqUxombqyX43
         EYOlTxdMPe6SyayCDD8uIfVnwCAnB6yi0s6KfIFM=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FCC2600E6;
        Thu,  1 Mar 2018 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1519901161;
        bh=NyaP+CB1BNHml+MR00XVatwm9gxtkBNpn4AUCYGhX3k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=epiTZmVFMyNUv6l6/r46WBHoRm/DxLKrs/AUkK2WwCv5m6Wv0sFDKui0RM1GNBFR4
         nEu9yra8fr1UDRDd9hBqZk9ht3OSCMK60Q02somSfQk7R9yVAdZkCgHqUxombqyX43
         EYOlTxdMPe6SyayCDD8uIfVnwCAnB6yi0s6KfIFM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FCC2600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     <zajec5@gmail.com>, <linux-wireless@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <jhogan@kernel.org>
Subject: Re: [PATCH v2] bcma: Prevent build of PCI host features in module
References: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
Date:   Thu, 01 Mar 2018 12:45:57 +0200
In-Reply-To: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com> (Matt
        Redfearn's message of "Thu, 1 Mar 2018 09:58:12 +0000")
Message-ID: <87lgfcnkey.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Matt Redfearn <matt.redfearn@mips.com> writes:

> Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
> a build error due to use of symbols not exported from vmlinux:
>
> ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
> ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>
> To prevent this, don't allow the host mode feature to be built if
> CONFIG_BCMA=m
>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>
> ---
>
> Changes in v2:
> Rebase on v4.16-rc1
>
>  drivers/bcma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
> index ba8acca036df..cb0f1aad20b7 100644
> --- a/drivers/bcma/Kconfig
> +++ b/drivers/bcma/Kconfig
> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>  
>  config BCMA_DRIVER_PCI_HOSTMODE
>  	bool "Driver for PCI core working in hostmode"
> -	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
> +	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY && BCMA = y

Due to the recent regression in bcma I would prefer extra careful review
before I apply this. So does this look ok to everyone?

-- 
Kalle Valo
