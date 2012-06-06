Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 04:09:42 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37901 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901351Ab2FFCJg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 04:09:36 +0200
Received: by wgbdr1 with SMTP id dr1so5236838wgb.24
        for <multiple recipients>; Tue, 05 Jun 2012 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cPZ151Y6aGK5cKhj70/fonGE6C4r0st8Ka/c2P9f+dY=;
        b=WwTxHrZXCinEONce5uopVB0ExwajYiHyztQgmpY20VNvtptJ08LDeWMBSoXygmWvd8
         y72YRQ66OAqCRYSgLGdCzVhgcLK9GWce3Cb7VcTICNy3aNWyRsyANIzIEnu0L+M3Wvrx
         7cOPk+Fq8sz5b1Y0f1t+N4P6Rtc+YOWBWEoMQUBFtgdqsVYrn0EGvR5PFZ2Piwrn/uLA
         R+GwIgp91xU7WXMvIw0/bKgz9/xHVXLm6l5x5zuT1GxFIkHZIDPrfug4YqBQwrbEfHVF
         ACkmNVSpPLub1m+Pyg1eVuGxP/7D78q95tKFGAm7Jb5fdD/MbLGouBxTyYYUSleAIm9n
         Ql2g==
MIME-Version: 1.0
Received: by 10.216.218.77 with SMTP id j55mr14586963wep.179.1338948570421;
 Tue, 05 Jun 2012 19:09:30 -0700 (PDT)
Received: by 10.180.84.136 with HTTP; Tue, 5 Jun 2012 19:09:30 -0700 (PDT)
In-Reply-To: <1338931179-9611-10-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-10-git-send-email-sjhill@mips.com>
Date:   Wed, 6 Jun 2012 11:09:30 +0900
X-Google-Sender-Auth: TATboqki2c51xhnUkc_XQmH6Q7E
Message-ID: <CACBHAey3xTKQwU1PqFQTJSyudm4yOR53mphZa1Q7sAJ_BuTkKw@mail.gmail.com>
Subject: Re: [PATCH 09/35] MIPS: Cobalt: Cleanup files effected by firmware changes.
From:   Yuasa Yoichi <yuasa@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Hi,

2012/6/6 Steven J. Hill <sjhill@mips.com>:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Make headers consistent across the files and make changes based on
> running the checkpatch script.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/cobalt/setup.c |   24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Do we really need it ?

Yoichi
