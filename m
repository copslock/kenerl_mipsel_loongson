Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jun 2010 12:12:33 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:62586 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491770Ab0FVKM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jun 2010 12:12:28 +0200
Received: by wyi11 with SMTP id 11so437038wyi.36
        for <linux-mips@linux-mips.org>; Tue, 22 Jun 2010 03:12:22 -0700 (PDT)
Received: by 10.216.160.66 with SMTP id t44mr1120856wek.75.1277201542650;
        Tue, 22 Jun 2010 03:12:22 -0700 (PDT)
Received: from [192.168.1.6] (host81-136-218-57.in-addr.btopenworld.com [81.136.218.57])
        by mx.google.com with ESMTPS id y39sm74183weq.3.2010.06.22.03.12.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 03:12:20 -0700 (PDT)
Subject: Re: [PATCH v4] alsa: ASoC: Add JZ4740 codec driver
From:   Liam Girdwood <lrg@slimlogic.co.uk>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <1277160391-14737-1-git-send-email-lars@metafoo.de>
References: <1276958993-9012-1-git-send-email-lars@metafoo.de>
         <1277160391-14737-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 22 Jun 2010 11:12:19 +0100
Message-ID: <1277201539.4537.2.camel@odin>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 27242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@slimlogic.co.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15089

On Tue, 2010-06-22 at 00:46 +0200, Lars-Peter Clausen wrote:
> This patch adds support for the JZ4740 internal codec.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: alsa-devel@alsa-project.org
> 
> ---
> Changes since v1
> - Put Kconfig entry in alphabetic order
> - Drop codec_set_fmt since the codec supports only one format
> - Rename "Capture Volume" control to "Master Capture Volume"
> - Drop unnecessary format checks
> - Add suspend/resume
> - Cleanup jz4740_codec_set_bias_level
> 
> Changes since v2
> - Drop codec prefix from the filename. Note that I keeped it for the object
>   name, because otherwise when build as a module it will clash with the ASoC
>   JZ4740 platform support.
> 
> Changes since v3
> - Hook up suspend/resume callbacks to the codec instead of the platform device

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
