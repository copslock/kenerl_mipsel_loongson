Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2018 17:48:26 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:44446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990405AbeCMQsOB1tDg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2018 17:48:14 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 428F860390; Tue, 13 Mar 2018 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1520959687;
        bh=8XnE+MmbXXlOodQehkDr77mZKUQ6zMEADY9VAO819Ec=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=h1WPi62ps2Fu4orNKdZHv5XGHiqrS5nDBKAsMOPyHCR3KxUQ74HgJSA/lum6lQrtu
         +AlhgWXuE5NTAoTqiXx3XN/fylTjndQwyX01x8+Zar6C+JVIVkN1FK+JRolXgf997C
         DyeV2r8TerqkEYMPdd2PonDRM1uJeQ5KPok6vahA=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A43B600C1;
        Tue, 13 Mar 2018 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1520959686;
        bh=8XnE+MmbXXlOodQehkDr77mZKUQ6zMEADY9VAO819Ec=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=DVcdQrBTlYcwPUKQV1ogBXr6QKsIF+OHF9ocrVcf4qkwkqv8qSn4SwxSJ2rb5UBd9
         QmFLY0laEP8gKiPb0uR8IF1RTfkZiQGkuNAslZdCFgfkoLeduL9dId3F3siNExjcvg
         iiZz8UTS17TkGJJE6cKOu774XMgbVuF/3Yy4wp7s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A43B600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] bcma: Prevent build of PCI host features in module
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
References: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     <zajec5@gmail.com>, <linux-wireless@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180313164807.428F860390@smtp.codeaurora.org>
Date:   Tue, 13 Mar 2018 16:48:07 +0000 (UTC)
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62963
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

Matt Redfearn <matt.redfearn@mips.com> wrote:

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

Patch applied to wireless-drivers-next.git, thanks.

79ca239a68f8 bcma: Prevent build of PCI host features in module

-- 
https://patchwork.kernel.org/patch/10250739/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
