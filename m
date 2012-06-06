Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 04:20:25 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:42426 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901351Ab2FFCUS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 04:20:18 +0200
Received: by wgbdr1 with SMTP id dr1so5241285wgb.24
        for <multiple recipients>; Tue, 05 Jun 2012 19:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dtG6V1RJWsv91sD9+jC5WnDiHgcCe1TzoXpfq9AEGcA=;
        b=OvbS9w6SZq06WMtgdgmzrBoMGn1gYRU2uxKfEHS0kGVXiZvgII7P4e538w/8n5jbAX
         2BOo6iiNBsW8YqSa0IMKp6v/XBb5bXm4FskPwBx3hVxI6y/C7EP72TAXP1Zto1B3Ae2D
         dLcCtgVBUNdwcdGY8OIA1RpMU/LKLxExmsCiX3IPeHkeMxxbnwNSMQCu6AA2lmAL22HR
         BwRmpE+DzSgfXv4qFLRTJ5dPGzxqoz7mMU470UUsTiwtZ8mHbsTcU2rJpWqOQT7CafBw
         3677e13NS5g1yalbsgo6336WS8Q8VW0aki454VL8bxN1nHCo0VxCAc6D02is1h+fxxGa
         Th1Q==
MIME-Version: 1.0
Received: by 10.216.212.157 with SMTP id y29mr15971709weo.146.1338949213227;
 Tue, 05 Jun 2012 19:20:13 -0700 (PDT)
Received: by 10.180.84.136 with HTTP; Tue, 5 Jun 2012 19:20:13 -0700 (PDT)
In-Reply-To: <1338931179-9611-35-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-35-git-send-email-sjhill@mips.com>
Date:   Wed, 6 Jun 2012 11:20:13 +0900
X-Google-Sender-Auth: EHGpRQIJemgdm3-A_cJT27sZIzg
Message-ID: <CACBHAezRk6T6xonHHM+mwBgOQ4qR0+pbZ0ok+kms8zOv3QGmHA@mail.gmail.com>
Subject: Re: [PATCH 34/35] MIPS: vr41xx: Cleanup firmware support for vr41xx platforms.
From:   Yuasa Yoichi <yuasa@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33553
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
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/vr41xx/common/init.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
> index 2391632..a2fa7f0 100644
> --- a/arch/mips/vr41xx/common/init.c
> +++ b/arch/mips/vr41xx/common/init.c
> @@ -22,8 +22,8 @@
>  #include <linux/irq.h>
>  #include <linux/string.h>

You can remove #include <linux/string.h> too.

Yoichi
