Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 17:27:23 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36077 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbcHYP1Pqe0YD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 17:27:15 +0200
Received: by mail-pa0-f67.google.com with SMTP id ez1so3290043pab.3;
        Thu, 25 Aug 2016 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lmTjMc+13JI/Z8fNOGJBTzpGcUbxJD82Uh81VefhlIw=;
        b=ubQtWR0UMJu412/hBBkhuH4sFmr6MBBbrrjn/k0vJH1RlIi350eAi7Z0frv2Gyc8sS
         XlvkhPKRf+kw9feYtxYG1ZiBoRm46/vDcKQBSE7RRmakDyKBveKUCqwH+0zGRPKcji2Y
         60y+kiEg9jRzsnvXTYZBGfefa8plpqtzzn3XjOrwYr1g9JkRiBqAsJpTK1LgrEJR6Z2y
         smMTwZmh7p7FQsZ+lDezB5e5u5rUB5t76mFopbqI/EPU+UqQMDUhmASkvxNRs+V+XFOa
         Sy+w/0DGml6+iEbdKJdPD/Z1SbF5H3zWKlzfdh+LohWODF4AYS79bRFkeljpb8hysVW0
         s5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lmTjMc+13JI/Z8fNOGJBTzpGcUbxJD82Uh81VefhlIw=;
        b=Ie/tlS9rVGrnp7OIBPaGbTSIgTgpwK+FcvEF7Qi08kvex0RRg39LC+nksiXHHm3wfP
         3QJSe1UqLOvhCELqkkWU3XfHl6kVRMLxkNWjByBg9Aq0L95QwQIn0483W1jhmEBClx1R
         TI8f5C2Va484LM4U02jGKboDlVvVa8niwe994k3PtmyCRtPIQnpLe4SX9/ARs/JVaZOj
         JJXS2HRJdiUbE2OR+5gKbislHamEBxj6ikVStLDN0o1rJKPQOn70d2awhQ5l6PtfE1Kw
         zZXBcD2loqiiaSHkh4mY2YQiY7XYnOBCPxWwmYBxU52mfcVzK2nb4hZULdumaBEZqF5n
         46Tg==
X-Gm-Message-State: AE9vXwO0jUJqBihBGoYMnFm/nB3mypMYyEylmbrPYEACIZu8EfS/mId42uNUyEIfHPRp1g==
X-Received: by 10.66.165.67 with SMTP id yw3mr17478177pab.8.1472138829801;
        Thu, 25 Aug 2016 08:27:09 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id c7sm21785942pfj.25.2016.08.25.08.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2016 08:27:08 -0700 (PDT)
Subject: Re: [PATCH v3] clk: let clk_disable() return immediately if clk is
 NULL
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
References: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        bcm-kernel-feedback-list@broadcom.com,
        Wan ZongShun <mcuos.com@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <194aebe5-38dd-f43d-fb4d-16ce592a68e8@gmail.com>
Date:   Thu, 25 Aug 2016 08:27:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 08/24/2016 10:26 AM, Masahiro Yamada wrote:
> Many of clk_disable() implementations just return for NULL pointer,
> but this check is missing from some.  Let's make it tree-wide
> consistent.  It will allow clock consumers to call clk_disable()
> without NULL pointer check.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
> 
> I came back after a long pause.
> You can see the discussion about the previous version:
> https://www.linux-mips.org/archives/linux-mips/2016-04/msg00063.html
> 
> 
> Changes in v3:
>   - Return only when clk is NULL.  Do not take care of error pointer.
> 
> Changes in v2:
>   - Rebase on Linux 4.6-rc1
> 
>  arch/arm/mach-mmp/clock.c        | 3 +++
>  arch/arm/mach-w90x900/clock.c    | 3 +++
>  arch/blackfin/mach-bf609/clock.c | 3 +++
>  arch/m68k/coldfire/clk.c         | 4 ++++
>  arch/mips/bcm63xx/clk.c          | 3 +++

For bcm63xx:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
