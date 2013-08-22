Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 13:49:23 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:50906 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831922Ab3HVLtTkRRBT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Aug 2013 13:49:19 +0200
Received: by mail-wg0-f46.google.com with SMTP id k13so1474728wgh.1
        for <multiple recipients>; Thu, 22 Aug 2013 04:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A0pNCL0zKGgCxW+V1odCYxsdmr1EYOsbfBVuKuDR1VM=;
        b=nxKRKSkA+NYBYVGfRJkS3RTW1tEjjXmOuMeHx3LJax85/S7Ii2axdDDqbsgL+tZ6mE
         /fPwDCORUPvmHcbQ63M4xQxh3MuioNS2AtmZJ0WO/pwL607bK96G/oBU8tzjoJ0xUjBU
         D+g/cPC0L3i0x+jAwVgPLVyll6SFSjCW0Ch+NkPYOJqG+fjQkY6kZ/w0zSkBN879pTEg
         DpzwAUOSFROgEuJ6Qe7KxOPt3xKcSopUEs5W/hdEc5ZPuos0Cz0EQY08rUdsOLKabu1Z
         pvSFlBNswsnBEfsITAZvxOafe0cAVNRnNB5eifrwIDQQE6B72lTgJougniKsSWlMYd06
         Rd1g==
MIME-Version: 1.0
X-Received: by 10.194.77.2 with SMTP id o2mr1260593wjw.57.1377172154152; Thu,
 22 Aug 2013 04:49:14 -0700 (PDT)
Received: by 10.180.86.71 with HTTP; Thu, 22 Aug 2013 04:49:14 -0700 (PDT)
In-Reply-To: <1377165434-28926-1-git-send-email-juhosg@openwrt.org>
References: <1377165434-28926-1-git-send-email-juhosg@openwrt.org>
Date:   Thu, 22 Aug 2013 13:49:14 +0200
Message-ID: <CAGXE3d9h6x=edxhSkqJ3zG_pEcjLqGJBkY+V6=1sLiHUwHJc3g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: don't hardwire cpu_has_dsp{2} to 0
From:   Helmut Schaa <helmut.schaa@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <helmut.schaa@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helmut.schaa@googlemail.com
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

On Thu, Aug 22, 2013 at 11:57 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The ath79 code supports various SoCs which are using either a 24Kc
> or a 74Kc core. The 74Kc core has DSP support, so don't hardwire
> the values to zero.
>
> Commit 00dc5ce2a653a332190aa29b2e1f3bceaa7d5b8d (MIPS: ath79: don't
> hardcode the unavailability of the DSP ASE) has fixed this already,
> but that change got reverted by 475032564ed96c94c085e3e7a90e07d150a7cec9
> (MIPS: Hardwire detection of DSP ASE Rev 2 for systems, as required.)
>
> Reported-by: Helmut Schaa <helmut.schaa@googlemail.com>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

Thanks Gabor!
