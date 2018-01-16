Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 20:16:45 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:60212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994634AbeAPTQiWmYqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 20:16:38 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B3E5605A4; Tue, 16 Jan 2018 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516130196;
        bh=xer2VscLd1W3OrSdRqPZybL6fttrRhR8tYUk+XUY0Mk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Q3E2MDbDKTDamg/cRqpEiddIEm7/PumaQwzzO6dD+W+IrZ1+hTcNgOsjZ1lIl+yg8
         kyNKtX1S8tO9J7hOfm4/KzYLyf3UMrQ3A39z9i7eBbKTE6SFlVZRa+nWju6ngrJajZ
         KjNjYo60pIlLcDiVFITQe1uftZXk23g5ij2dsQdE=
Received: from potku.adurom.net (a88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D5C76021C;
        Tue, 16 Jan 2018 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516130195;
        bh=xer2VscLd1W3OrSdRqPZybL6fttrRhR8tYUk+XUY0Mk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=j9mr6L1rsxc4b8qAQHGloR//o3qSyyllPfquQfdATfXXjJFDech5MTs1cdAzYPowB
         KN+mXS4wxfpqBE1hzTCUWoy9HltdnFigKIEZaf7/LMK0UhA5tAkTOlF7LYOimGa1Zb
         DIZM4EW4RvdK5m+pi5fliKjYAKUpOmKiXQUmcrec=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D5C76021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [for-4.15] ssb: Disable PCI host for PCI_DRIVERS_GENERIC
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180115211714.24009-1-jhogan@kernel.org>
References: <20180115211714.24009-1-jhogan@kernel.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180116191636.6B3E5605A4@smtp.codeaurora.org>
Date:   Tue, 16 Jan 2018 19:16:36 +0000 (UTC)
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62191
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

James Hogan <jhogan@kernel.org> wrote:

> Since commit d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type
> as generic") changed the default MIPS platform to the "generic"
> platform, which uses PCI_DRIVERS_GENERIC instead of PCI_DRIVERS_LEGACY,
> various files in drivers/ssb/ have failed to build.
> 
> This is particularly due to the existence of struct pci_controller being
> dependent on PCI_DRIVERS_LEGACY since commit c5611df96804 ("MIPS: PCI:
> Introduce CONFIG_PCI_DRIVERS_LEGACY"), so add that dependency to Kconfig
> to prevent these files being built for the "generic" platform including
> all{yes,mod}config builds.
> 
> Fixes: c5611df96804 ("MIPS: PCI: Introduce CONFIG_PCI_DRIVERS_LEGACY")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Michael Buesch <m@bues.ch>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Patch applied to wireless-drivers.git, thanks.

58eae1416b80 ssb: Disable PCI host for PCI_DRIVERS_GENERIC

-- 
https://patchwork.kernel.org/patch/10165371/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
