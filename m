Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 11:15:47 +0100 (CET)
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37472 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010865AbcBRKPpkL-dr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 11:15:45 +0100
Received: by mail-wm0-f51.google.com with SMTP id g62so17945866wme.0
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H2wFngdn2suIAkdKgN3j1x//gBKnR3O+AwAutwilFho=;
        b=E/GuptHBpzA5pP5JuDJfv9E4PjMi7Fig8FSfp0WPtC4aLPx0PUNrEzYMyzIy6ev1U1
         YNouZj6L+CwLGNQT92/fYfaacFigTuOwzSozkUg3eKnIYIaAcG+7I3Gi63wRVvvnNV/3
         I/gbe5aWfJLoKwiyKwxObkbUMWqRf265Hv3FoHTHkYiubXXTmwyxFZoolnQ4fbYp9wEE
         mWOltIWqbtBnOtS2NrIYbMoabWgqFzoe1T5jJcS6Mz9Qdsf4wSXXMHnkuRdY6VQ7dWzi
         Q77myCNwfv/qrEtcb96Km9awxhqskRugPVBHVIQNgvju7qSSHWEQasy22i3K0rBpDORr
         Zf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H2wFngdn2suIAkdKgN3j1x//gBKnR3O+AwAutwilFho=;
        b=iMCPVAjQhh1c/Zk8jEEXILjzk6U4jkIZZInI+ZJoskolT/GHxTQrTjLrbdODrR/zP3
         +4s5SSQ9F3AlkNu8ZFivQdh/9EEs8C2HpHPIz1vw6/4vt2PgEwmYpziBP+pUJVELDaqQ
         tfnircAOjTavdm3uE0rx6mIuHmUOHHWq5hTo7ZSknNKFp5WIVGXhmyTo9tfXe+WeB+rU
         euubTV5+M2XvZ7GxxAfRZjsH51NyXQ+GGQHn6886IHjrPFbpqIpXw03mn2/4F0RmC3li
         d/Z/JcUSvpkVe74SggcNRW7DBht8b335Sld5OSdyxbSZ4rDzTAJw56fmwVQbUaMN1Tmj
         An0w==
X-Gm-Message-State: AG10YOSDWDZpZ/S0+nMzBSwVpdUTxV0JB7/ACqoQ7CPq21XdL4ABShPas3y5a1v0vM55yg==
X-Received: by 10.194.220.230 with SMTP id pz6mr6665843wjc.39.1455790540329;
        Thu, 18 Feb 2016 02:15:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d9sm5765173wjf.43.2016.02.18.02.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2016 02:15:39 -0800 (PST)
Date:   Thu, 18 Feb 2016 11:15:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave@sr71.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        dave.hansen@linux.intel.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] signals, ia64, mips: update arch-specific siginfos with
 pkeys field
Message-ID: <20160218101537.GA5540@gmail.com>
References: <20160217181703.E99B6656@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160217181703.E99B6656@viggo.jf.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Dave Hansen <dave@sr71.net> wrote:

> 
> This fixes a compile error that Ingo was hitting with MIPS when the
> x86 pkeys patch set is applied.
> 
> ia64 and mips have separate definitions for siginfo from the
> generic one.  Patch them to have the pkey fields.
> 
> Note that this is exactly what we did for MPX as well.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-ia64@vger.kernel.org
> ---
> 
>  b/arch/ia64/include/uapi/asm/siginfo.h |   13 +++++++++----
>  b/arch/mips/include/uapi/asm/siginfo.h |   13 +++++++++----
>  2 files changed, 18 insertions(+), 8 deletions(-)

This solved the MIPS and IA64 build problems, but there's still one bug left: UML 
does not build:

 /home/mingo/tip/mm/gup.c: In function ‘check_vma_flags’:
 /home/mingo/tip/mm/gup.c:456:2: error: implicit declaration of function ‘arch_vma_access_permitted’ [-Werror=implicit-function-declaration]
   if (!arch_vma_access_permitted(vma, write, false, foreign))
 [...]

Please send a delta patch for this too.

Thanks,

	Ingo
