Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 14:52:25 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:39258 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903479Ab2FPMwT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2012 14:52:19 +0200
Received: by lbbgg6 with SMTP id gg6so3597875lbb.36
        for <multiple recipients>; Sat, 16 Jun 2012 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=a+vznQthRXo4wGO5lvJXIMc8THXgBDGf1nuMU/f6Kig=;
        b=YTEQIAKtk1SLoTV6WB7VSuXTHftz3WXj2Vi0XVbviw8ZR8wLg++mLAYVZi1CL0h3gL
         FIzKil5yQHx9jDSu3Mq8rKt7kyDPea0P0iZjaacyISNJgbzFYZdzNM0r55TQa31AWBdl
         wKH3v+WyuvwC+4jxEynVy9cLmMDLyNN+3wciH1pIuPUt8P02fL1L8B2hnkBgWHMlRVFe
         BaqO8k/R0kHCcJEpc3YtC+6pF1V6tfFDW46WeC4NOUN7NO841LTYt9Rr/wDOVJbenvjv
         oDfy9YLjVBov+/AUmYMfg3bnBtLmf6IZWJQSGsEXFSZBetG691qXHSLiMW+WMGTb1qg0
         0JHA==
MIME-Version: 1.0
Received: by 10.152.105.51 with SMTP id gj19mr8481996lab.38.1339851134313;
 Sat, 16 Jun 2012 05:52:14 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Sat, 16 Jun 2012 05:52:14 -0700 (PDT)
In-Reply-To: <20120615143718.GD15800@gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-15-git-send-email-chenhc@lemote.com>
        <20120615143718.GD15800@gmail.com>
Date:   Sat, 16 Jun 2012 20:52:14 +0800
Message-ID: <CAAhV-H7FYUS=Q4VE8SOcA4fMxhLUKGyVTyrTPRETH7gX7RkAwg@mail.gmail.com>
Subject: Re: [PATCH 14/14] MIPS: Loongson: Add a Loongson 3 default config file.
From:   huacai chen <chenhuacai@gmail.com>
To:     LIU Qi <liuqi82@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Thank you, I'll do this later.

On Fri, Jun 15, 2012 at 10:37 PM, LIU Qi <liuqi82@gmail.com> wrote:
> On Fri, Jun 15, 2012 at 04:10:01PM +0800, Huacai Chen wrote:
>  > Signed-off-by: Huacai Chen <chenhc@lemote.com>
>  > Signed-off-by: Hongliang Tao <taohl@lemote.com>
>  > Signed-off-by: Hua Yan <yanh@lemote.com>
>  > ---
>  >  arch/mips/configs/loongson3_defconfig |  704 +++++++++++++++++++++++++++++++++
>  >  1 files changed, 704 insertions(+), 0 deletions(-)
>  >  create mode 100644 arch/mips/configs/loongson3_defconfig
>
> It is better to generate the defconfig file using `make savedefconfig`.
>
> LIU Qi
