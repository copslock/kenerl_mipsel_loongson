Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 21:37:54 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36670 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013228AbbGFThw5-qZI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 21:37:52 +0200
Received: by wguu7 with SMTP id u7so149410488wgu.3;
        Mon, 06 Jul 2015 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MV6xfpw+bJcMZWYIaBiAN2Fs+TxFNUg20XaGx99lk4Y=;
        b=a4xkqRIoM0cWExHxhdNbf/AgNgIlU4/Wki7CiOzL5zO6NhVcUYjs//EYTR44wkgK9h
         jlwLm1XtEZwoli31W6xvCXinJa1+0BySwNfUkP8yAj/GEJ+NnomBk+zI2HkDzJu7Uzpp
         MBg4ht2y7W4xOiA68cu1hI/VyDyznapI5uqVqi/9z9Xcw/7oB+w3Z5I8oBOh0OKMAmOD
         GtN4LF91VWsv8nnkx5oPMsqFp2wJH478Wnddw9JJnN7EDpDjjc8p3RTYZiHSZAsao1Ud
         N/FqRa61gM/IhrWfl/KYuFxVFVySP3uWoKFIHamTUBfcqQKMkzM1KRObQN6hZEewU2bT
         DScw==
X-Received: by 10.180.210.234 with SMTP id mx10mr57363711wic.42.1436211467781;
 Mon, 06 Jul 2015 12:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.248.193 with HTTP; Mon, 6 Jul 2015 12:37:08 -0700 (PDT)
In-Reply-To: <7b140cad62ca40bc9dbe6678c34b6b5d42848a0d.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org> <7b140cad62ca40bc9dbe6678c34b6b5d42848a0d.1436180306.git.viresh.kumar@linaro.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 6 Jul 2015 21:37:08 +0200
Message-ID: <CAOLZvyFnd8+Z4M66wYnq7+E4U4c6OaMxfFEuUw5QQiJcmQUcsg@mail.gmail.com>
Subject: Re: [PATCH 01/14] MIPS/alchemy/time: Migrate to new 'set-state' interface
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Jul 6, 2015 at 1:11 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Migrate alchemy driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> We weren't doing anything in the ->set_mode() callback. So, this patch
> doesn't provide any set-state callbacks.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/mips/alchemy/common/time.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
> index 50e17e13c18b..f99d3ec17a45 100644
> --- a/arch/mips/alchemy/common/time.c
> +++ b/arch/mips/alchemy/common/time.c
> @@ -69,11 +69,6 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
>         return 0;
>  }
>
> -static void au1x_rtcmatch2_set_mode(enum clock_event_mode mode,
> -                                   struct clock_event_device *cd)
> -{
> -}
> -
>  static irqreturn_t au1x_rtcmatch2_irq(int irq, void *dev_id)
>  {
>         struct clock_event_device *cd = dev_id;
> @@ -86,7 +81,6 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
>         .features       = CLOCK_EVT_FEAT_ONESHOT,
>         .rating         = 1500,
>         .set_next_event = au1x_rtcmatch2_set_next_event,
> -       .set_mode       = au1x_rtcmatch2_set_mode,
>         .cpumask        = cpu_all_mask,
>  };

That's broken.  You need at least something like this (tested):
the cevt-r4k.c is broken the same way.

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 50e17e1..ef1ca39 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -69,9 +69,9 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
        return 0;
 }

-static void au1x_rtcmatch2_set_mode(enum clock_event_mode mode,
-                                   struct clock_event_device *cd)
+static int au1x_rtcmatch2_set_nop(struct clock_event_device *cd)
 {
+       return 0;
 }

 static irqreturn_t au1x_rtcmatch2_irq(int irq, void *dev_id)
@@ -86,7 +86,8 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
        .features       = CLOCK_EVT_FEAT_ONESHOT,
        .rating         = 1500,
        .set_next_event = au1x_rtcmatch2_set_next_event,
-       .set_mode       = au1x_rtcmatch2_set_mode,
+       .set_state_oneshot      = au1x_rtcmatch2_set_nop,
+       .set_state_shutdown     = au1x_rtcmatch2_set_nop,
        .cpumask        = cpu_all_mask,
 };


Manuel
