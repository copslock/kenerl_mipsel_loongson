Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:48:52 +0200 (CEST)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34863 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006684AbbEVRsuf3geJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:48:50 +0200
Received: by qgew3 with SMTP id w3so12708098qge.2
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m8p48cVarmWI/j6lMi8JHuRsO3u+tia4ek5B3NkIq+A=;
        b=D7x0yaSioSNhsd4JwW9Hry+Sak7xfB9/Q4OlKlfvdLc97Phu+1iDG9GPCeCp8NHTes
         r5YMBHTitd/sfhi22v+pcYlXmzcrTDsyZJf8Aqm9tTv1BIaqr4Cwm1zz2e6LZnZAPIsZ
         vm/Gtio+/laEyY3m0K6eMREAvRdjEdoKyYEYuYtmKFZCdKi1ZdIL45nMBCM5jpFewZB4
         DBCTyw7YJy2ZdaJZsJsLLkdFD2uFg1fUrYezyIA43xCw+8NxJta3X37p+ZWA/gShJVfC
         8zncsgCc++7JQqvA3zwqpr0Vc994ptl3OxFIre6+odJHpnFHnXLP4100R4HS6aj5g5li
         O+eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m8p48cVarmWI/j6lMi8JHuRsO3u+tia4ek5B3NkIq+A=;
        b=hB38Lo0nTvFGsMTjmu2IZA0ff3zEwKAk76pTsUMwhpi5XwHS9oV4lM8CG6urtetOXb
         sqAhqZpx9uuYEQ8y1CJUghQ4zrgp47+YXT1z/i5Xmf5PP3NAbOgmD4aEHul0C0YIusDt
         nKHjL9mjUor4slg/0msEZmCvwd4cXCoSey+Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=m8p48cVarmWI/j6lMi8JHuRsO3u+tia4ek5B3NkIq+A=;
        b=QNMfoFUJs0UNGNI966wQhuGYWsRz64tr0A3ZiGHPwzfGz1pSGi+VsjHfM9Ct0hGfKZ
         GSCsqWqtoEbIybTqH2smXnUVNd69kKmBtQnkv4F2Wm+h9Fwp3KDQbbzjPnuXFO4LWKP9
         U8WEO7osoOK9pUMave4B/s8fHZ4cnTXiVGWtprRpLoGZHFBg/ih7s0pede5j2Ee1+y1i
         G/aGblEY4VfB8/LZvUon4sXQPaIIbCA3lnkWnJvpNQLp1GvnG0Qb4xv+PaprfP4u/H2p
         W6nu7Gu15hqfO5chdTdVq7+Ek2Zo4/eK0VqoacILyUa9+J5ACaU4vshoApS/Ddcx72ki
         y84A==
X-Gm-Message-State: ALoCoQnS9pTTk1W6oREPPRE3FEWre6FeTrGAOIxuecX3RxETl7wS1eZ+vAoaFGSXX5iEuPZf3C96
MIME-Version: 1.0
X-Received: by 10.140.108.195 with SMTP id j61mr12468315qgf.83.1432316927516;
 Fri, 22 May 2015 10:48:47 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:48:47 -0700 (PDT)
In-Reply-To: <1432252663-31318-9-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-9-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:48:47 -0700
X-Google-Sender-Auth: rQ_Hf8YYNK-8tP07B38BV57AIDk
Message-ID: <CAL1qeaE=JeErsEn8peh2Ys1pJWgDWRFV3d2_KFGF2VoiJjnxVg@mail.gmail.com>
Subject: Re: [PATCH 8/9] clk: pistachio: Add sanity checks on PLL configuration
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47583
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

On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> From: Kevin Cernekee <cernekee@chromium.org>
>
> When setting the PLL rates, check that:
>
>  - VCO is within range
>  - PFD is within range
>  - PLL is disabled when postdiv is changed
>  - postdiv2 <= postdiv1
>
> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
