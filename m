Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2011 17:09:35 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:60201 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903631Ab1KOQJ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Nov 2011 17:09:26 +0100
Received: by faar25 with SMTP id r25so684827faa.36
        for <multiple recipients>; Tue, 15 Nov 2011 08:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Tv6U6hb6TeizM+sj1FVQxm12di05y1nW34b0N998itg=;
        b=qvsKQ506EwgXVSEvG5zRZrtKqdxCl1Xa6b/jFuWRlvBEMgcvLRSg3PCKiXzNL7MVJ+
         /d+V41MdGl/gT1wdjm7USmuBVeMz+7Uq4ljIqoJzqm34FAnv9AnYXphifreHetc3xNUI
         OrzuhZaOg7Kpo3ywSxsjp3UIc8++tdI6JiTF4=
Received: by 10.182.45.3 with SMTP id i3mr6218135obm.62.1321373361089; Tue, 15
 Nov 2011 08:09:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.23.6 with HTTP; Tue, 15 Nov 2011 08:09:00 -0800 (PST)
In-Reply-To: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>
References: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>
From:   "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date:   Tue, 15 Nov 2011 08:09:00 -0800
X-Google-Sender-Auth: pXTmV_OWmm-lSEEqIjVelUdRWvY
Message-ID: <CAB=NE6UB6KzJ2p+sou4wcgnZ9jyQxhpWMr2qZ2=jwqaGc2L5Xw@mail.gmail.com>
Subject: Re: [PATCH] ath9k: rename ath9k_platform.h to ath_platform.h
To:     Sangwook Lee <sangwook.lee@linaro.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Imre Kaloz <kaloz@openwrt.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, ath9k-devel@lists.ath9k.org,
        ralf@linux-mips.org, linville@tuxdriver.com,
        rmanohar@qca.qualcomm.com, patches@linaro.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcgrof@frijolero.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12582

On Tue, Nov 15, 2011 at 3:23 AM, Sangwook Lee <sangwook.lee@linaro.org> wrote:
> The patch series proposes to rename ath9k_platform.h to "ath_platform.h
> This header file handles platform data used only for ath9k,
> but it can used by ath6k as well.

Adding the actual OpenWrt stakeholders. Is there any public hardware
platform that uses this yet?

  Luis
