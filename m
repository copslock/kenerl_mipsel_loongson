Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:23:26 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34593 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012667AbbHFQXYkvmwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:23:24 +0200
Received: by igk11 with SMTP id 11so14846254igk.1
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K2zQktrOnf0983HDbB08wGYRSFSZVotPvOsVzmcUfjk=;
        b=gTwFTLqNMLx9IlNjHq47yHlGEO7HWTu/kWrW6untnNG+XyDJsq/DLOKiLhIXxDDXzJ
         kCCkeelcz6M1U4S3Phlp3Xwlb8ra6N2hRo0rtCgXCi/YrxUGWauZwGQZDxeP2USZSXya
         LK1pbOElyG6InR98+zgv+CLd28eIpmHHy/fZ3IlSkNuzgt+yE824lJaaQcMCfmFMcTcd
         xxz4TEw2seMxhwvtwsOvFjwRvrrgJ36NPFpR9Yi0VMbPBLfQ6K4/1wmaW5CJZOtKxT0e
         dm9OgSL4Km32Pv3DL9ducFwiTIqSa2YXmGWHVz6agcNJLwS7BNGaoAMM2dpIFgmkyhI2
         EcKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K2zQktrOnf0983HDbB08wGYRSFSZVotPvOsVzmcUfjk=;
        b=BBZzz2w6A2gXhW414J0tgONi/J5C1zNvwWREkhX3GNTQZcKyXG/yW5n812CSn8Z6bm
         Zitzu4OcWKtFgvoN0S1C/c/vRPa8DeaL/k574FCWGZhuO0nGig68HsCVDJ7vFCLk7l7F
         MHNE2c1lMLI3SXnsbRTdWaY7R076Cvhu2rQ+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K2zQktrOnf0983HDbB08wGYRSFSZVotPvOsVzmcUfjk=;
        b=R9ep8LRWISZrsvDnH56gJR+g84A/geiQLCAsSaJM5tI79XnDPvqxzkKqltQDKcjF27
         9mhgIJRR4RhjuNqBi5LpNqpVZIdzWPVBZFcC7eH47O8Yfd83D6DhCnpjg7XANuVm/WTl
         CD762p38CosZThcH9ivVWAGzJTz9DJY54MwNvWLR7uImfkHkG5U09WIUXUsqyyarXMhz
         cnmLJpuijnDNcDYlpyjs4VnaBcZ1J+7VOH4sVyByTFIIcMLmljw5iwJOT14szD5yRjLh
         Jkpi9nRowLrSjPyAdbkvHryVyi/7isJqPPpvUtKeS3cGgPu71iZz4vh8nS/m1t0runU/
         uMfg==
X-Gm-Message-State: ALoCoQkdB/MFvpyJRjGIx8svIKemZQkYI05rL5+rjuGIZd37Vhl8JZxx2p6SthufOIJU2RIRz7JU
MIME-Version: 1.0
X-Received: by 10.50.138.73 with SMTP id qo9mr4873028igb.64.1438878198876;
 Thu, 06 Aug 2015 09:23:18 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Thu, 6 Aug 2015 09:23:18 -0700 (PDT)
In-Reply-To: <1438868614-7672-3-git-send-email-govindraj.raja@imgtec.com>
References: <1438868614-7672-1-git-send-email-govindraj.raja@imgtec.com>
        <1438868614-7672-3-git-send-email-govindraj.raja@imgtec.com>
Date:   Thu, 6 Aug 2015 09:23:18 -0700
X-Google-Sender-Auth: Ijye1rTubDR2ZDwzgXizo4Y-qvk
Message-ID: <CAL1qeaEEndYJc7kVW9hgEZYGnVs8tFBy7y0sObiS8GVj=ta88w@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: pistachio: Fix override of clk-pll settings from
 boot loader
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <govindraj.raja@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Govindraj,

On Thu, Aug 6, 2015 at 6:43 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
>
> Pll enable callbacks are overriding PLL mode (int/frac) and
> Noise reduction (on/off) settings set by the boot loader which
> results in the incorrect clock rate.

Please be consistent about how "PLL" is written out.  Since it's an
acronym, it should be in caps.

> PLL mode and noise reduction are defined by the DSMPD and DACPD bits
> of the pll control register. Pll .enable() callbacks enable pll
> by deasserting all power-down bits of the pll control register,
> including DSMPD and DACPD bits, which is not necessary since
> these bits don't actually enable/disable pll.
>
> This commit fixes the problem by removing DSMPD and DACPD bits
> from the "pll enable" mask.
>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>

Otherwise,

Reviewed-by: Andrew Bresitcker <abrestic@chromium.org>
