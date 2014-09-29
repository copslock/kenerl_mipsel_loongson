Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 22:18:39 +0200 (CEST)
Received: from mail-yh0-f50.google.com ([209.85.213.50]:46046 "EHLO
        mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010103AbaI2UShLFuyj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 22:18:37 +0200
Received: by mail-yh0-f50.google.com with SMTP id z6so1255281yhz.9
        for <multiple recipients>; Mon, 29 Sep 2014 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RZpjpEym3vrG45Dt1JP4GO0GDPzqDW99O4ERP7r3xC4=;
        b=mnZJ/8QWPJvezhvvo5L/B7x0SsOAZ0rSfimLv5A+eQjbhmsYVppEmg9yr7w+ZXOBSz
         PrV+hgAwX1jgojhG+I3Ynu7At/a59eZ029mCi5D8IqNpY0Zkwxhj3zoegEuAsEHpL/Gh
         mvW/wVH8iC2ChTUF4O81gDLkoQpgbglGuWsoUwpjH+RXnWmCqoRlg1Mgl3Ne5sXpwkOp
         HLSAdHwhpzEz7LTMrpqdspqfYWnQZiVw6y3AVvH+fiUkqw2QKSMYxL2OkQO1hYCgkciB
         2x61mSHmj2F9f63Mqv1Q2zVNvuCaCNwpV/dpEFLKz36dyiMFeLDr6KcByZI4dqLCU3ib
         rhmw==
X-Received: by 10.236.229.138 with SMTP id h10mr4437564yhq.122.1412021911235;
 Mon, 29 Sep 2014 13:18:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Mon, 29 Sep 2014 13:18:11 -0700 (PDT)
In-Reply-To: <CACRpkda2nNqb9iARw+ze=vsdmXVePGu+Fb5PMGo75FSCGJ+tDA@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
 <1410723213-22440-9-git-send-email-ryazanov.s.a@gmail.com> <CACRpkda2nNqb9iARw+ze=vsdmXVePGu+Fb5PMGo75FSCGJ+tDA@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 30 Sep 2014 00:18:11 +0400
Message-ID: <CAHNKnsRtzHXmdqDADVqt1hmAriEK5PUEHw4Mak4X9dv1Pw7mRA@mail.gmail.com>
Subject: Re: [RFC 08/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-09-29 13:03 GMT+04:00 Linus Walleij <linus.walleij@linaro.org>:
> On Sun, Sep 14, 2014 at 9:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
>> Atheros AR5312 SoC have a builtin GPIO controller, which could be accessed
>> via memory mapped registers. This patch adds new driver for them.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: linux-gpio@vger.kernel.org
> (...)
>
>> diff --git a/arch/mips/ar231x/Kconfig b/arch/mips/ar231x/Kconfig
>> diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
>> diff --git a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
>
> Please put these MIPS-related changes into a separate patch
> to be handled through the MIPS git tree.
>
Already do that in non RFC patch.

-- 
BR,
Sergey
