Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 15:56:58 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:57482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991172AbeAZO4vJicWD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jan 2018 15:56:51 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8DD060A08; Fri, 26 Jan 2018 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516978607;
        bh=mdwulGhsLrb73+BQWp3gzfbrVDFeFKrQ9Qrp0vLoZyE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=W0jPwjES3t2igx2On+hrUs4UlMMJWf2+KkOCyrVDC3LtWV20+jtyhc7WXaXmsBlnT
         NN5O+grNnXsmEQoY1JUlb8fyQhr7LhJ4iiyZdk7AZD0fn5xVM9etfROHEoQxLXYIuf
         p9P8m6UyXJG2Sa7LnFPSZYiuWCdZFH2IxWFjZ4FU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAA3860218;
        Fri, 26 Jan 2018 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516978606;
        bh=mdwulGhsLrb73+BQWp3gzfbrVDFeFKrQ9Qrp0vLoZyE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=T+clyMxjAaHvw/+ztFrntDGJIyoXFIbjXlxKh69W92j1TlHO7bIA2ZFWA6Yg7AUb9
         yjhCR+JIYL++kleQknnpByj2oBvVImh3wtpWSkvimdYFfpu3IS2W/njNNviOCyLcCh
         H1ErO3qfB5pkrJGBZQ/qr99j0nFdVx4KBhsdCUqs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAA3860218
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ssb: Do not disable PCI host on non-Mips
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <87vafpq7t2.fsf@turtle.gmx.de>
References: <87vafpq7t2.fsf@turtle.gmx.de>
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180126145647.D8DD060A08@smtp.codeaurora.org>
Date:   Fri, 26 Jan 2018 14:56:47 +0000 (UTC)
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62339
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

Sven Joachim <svenjoac@gmx.de> wrote:

> After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
> wlan0 interfaces had disappeared.  It turns out that the b43 and b44
> drivers require SSB_PCIHOST_POSSIBLE which depends on
> PCI_DRIVERS_LEGACY, a config option that only exists on Mips.
> 
> Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
> Cc: stable@vger.org
> Signed-off-by: Sven Joachim <svenjoac@gmx.de>
> Reviewed-by: James Hogan <jhogan@kernel.org>

Patch applied to wireless-drivers.git, thanks.

a9e6d44ddecc ssb: Do not disable PCI host on non-Mips

-- 
https://patchwork.kernel.org/patch/10185397/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
