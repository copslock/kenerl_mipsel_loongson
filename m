Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 22:17:59 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54587 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823068Ab2JOUR35XPcI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2012 22:17:29 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so5431089pad.36
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2012 13:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=1ENCQ460bwG/H7tt6SwNgyG/Rt9q+n1blFfzCqhuKl0=;
        b=UiYIWk8FquTEe0rcWf59LbxXkpxqIA2We8/Moam1EfJfUjE4aeRsf1pZrg7wCQCZrO
         ZeW2ym0RSXu7DiV43W7+KlwY/UlCeXq3o699s2NbwNMe1PdLnHsFezpmukxKlktYe4N9
         rLlCLaR/nU0TcOKqhKp0K94hWzlrFQtN675DD3g4XAmifD7weYdvT+MTJq23HDh/h1uV
         FQyOetZsCC+ms67lDTNyJFEQdoskOpBVaDagd8mhhbJ85lTaW3+MyCI6XSCs0RwqmwtU
         fA5DX824G4hbuBRCjsBk891T1dTwYA5wbIjl98G1xMukC2cBiEsRjq8kSHV8DXcjR+HJ
         dmkw==
Received: by 10.68.248.33 with SMTP id yj1mr40863499pbc.141.1350332242767;
        Mon, 15 Oct 2012 13:17:22 -0700 (PDT)
Received: from localhost ([12.216.224.66])
        by mx.google.com with ESMTPS id ru4sm9526410pbc.25.2012.10.15.13.17.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 13:17:21 -0700 (PDT)
Date:   Mon, 15 Oct 2012 13:17:19 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     stable@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH stable] MIPS: ath79: Fix CPU/DDR frequency calculation
 for SRIF PLLs
Message-ID: <20121015201719.GB16888@kroah.com>
References: <1350231436-27436-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1350231436-27436-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQm9S18OsnHl5ziOS0khHKjV2Xo7Wrs1nu7QR9DvivvYVAk+z3/Hf116mL6ZEYUe3WgKQLW+
X-archive-position: 34704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Oct 14, 2012 at 06:17:16PM +0200, Gabor Juhos wrote:
> commit 97541ccfb9db2bb9cd1dde6344d5834438d14bda upstream.
> 
> Besides the CPU and DDR PLLs, the CPU and DDR frequencies
> can be derived from other PLLs in the SRIF block on the
> AR934x SoCs. The current code does not checks if the SRIF
> PLLs are used and this can lead to incorrectly calculated
> CPU/DDR frequencies.
> 
> Fix it by calculating the frequencies from SRIF PLLs if
> those are used on a given board.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/4324/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
> The original change was a candidate for stable (3.5+) however it was
> rejected during the stable-review process due to conflicts in
> 'arch/mips/include/asm/mach-ath79/ar71xx_regs.h'
> 
> This is a backport of the aforementioned commit, and it is applicable 
> to 3.5.7 and 3.6.2.

3.5 is now end-of-life, but 3.6 is still alive, so I've applied this
there.

greg k-h
