Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:22:49 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:38788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994630AbeAPPWlOamEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:22:41 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 837E46083C; Tue, 16 Jan 2018 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516116158;
        bh=Uuo6o96uj8B5eKKAzhQpmiUAYDQx2y1kms/S9sIU7BQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MDdHJdQGLTmHIduB3Wh9Thv006+N7orMaKPUBVvOrz/A4/VJwq7a53mp2yRVPgaeI
         aZLxF1hmydECXyDmu/aYP40oQ8tjBgmqXIPSToYlJyM8Ccs2C8icHVzym9wRqaxlqw
         W54NeqUx64C66twLF19RTZLqV8M6/kezK+mij/+g=
Received: from potku.adurom.net (a88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25184601D4;
        Tue, 16 Jan 2018 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516116157;
        bh=Uuo6o96uj8B5eKKAzhQpmiUAYDQx2y1kms/S9sIU7BQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=bCKpi8prX9ohwl2Z+U9CQCgpWtKHyutsVbbhOr1nmsT96ZU6x8O4ZfvHQerg3+sj5
         s8F+aeag/yJIMUoKwjTZXks+L3hCBR6AVT95uxSV5zfSpk0mYl4E9+QJV7EysIGT7w
         WAUA1oCyVxDJlx3HfClXFa/pkdZymeXVMOkih8rw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25184601D4
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
Message-Id: <20180116152238.837E46083C@smtp.codeaurora.org>
Date:   Tue, 16 Jan 2018 15:22:38 +0000 (UTC)
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62174
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

I'm planning to push this to 4.15 but not sure if there's enough time.

-- 
https://patchwork.kernel.org/patch/10165371/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
