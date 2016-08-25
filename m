Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 09:53:03 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:34907 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991948AbcHYHwyU7qxT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 09:52:54 +0200
Received: by mail-it0-f66.google.com with SMTP id f6so5087065ith.2;
        Thu, 25 Aug 2016 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=g3UEftNZtkx7nWFRPZ8ewqn+V9mvCyDct7cMSdqv/IY=;
        b=0C9LedTmVHqxM3TCOFHGhdlLwSIBdsNDbsoqsyi8Y1WbLamFVftVU2qC5uG8bdcFiP
         I41rLygvkMAogfnyePlSAl/ciyMpW4p/Y8w39DsZJEoPD1nSvTsvBD1tEj2rmfhpuVWU
         CLOD76pz8xQqjc+8EBw5aguXn9zApg4weyvx16f4FgowPpcBRGFAAnpqVrbRcpI8nU2a
         ylkfwudpmoRhJ/4t7RdPep8WeApiLpH2akpjEYFUhWzHDPiRBwysOxPRxuPYRWJbte78
         mEHh4hbwWgBw9bwhfDp7v/TFnoVIImUKLym7VQjGE1IqFk9UdY74cHPCCAJAB8Hvao+H
         iqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=g3UEftNZtkx7nWFRPZ8ewqn+V9mvCyDct7cMSdqv/IY=;
        b=XMj7dj32Ef6SNdgvdI0YOHlfM0xybqKpLbs4SsJG+JZOtrQ3dmmH0xrOkUl9M9zMMF
         8YiTEk7mKZm+Gt2tZMdHM4N6aD+/K3vFCuo/jQ2pHpOVEfHw0RBAjK8pJKSQbZEXdI4b
         Q3BJ/Ua7M/bHR5PBVz0WCLYdmgq5HVpcfJejCD87lQvL6gC64KGrgvez5iYgis/yz+4j
         HupFuA2ootbRDWi0EB9uaWS4i1cz/h6Kn6maVGsxEpUH/ZUSIPe6ypIG1gcahj2jcEG8
         N0r8EOk5vFO+QHrabRYkJ5PanrYnSTwcXoR1/CeZRJgGFF9SLyjzK87idaZeCY5SOpMl
         Sbog==
X-Gm-Message-State: AE9vXwM4vixzV87VHjpcIgCzAf4JY9lanUwirbyrY7GCPdjYP8yM0IE+N0xGJdz7hk2RkT7AqkxxKnI1vyNn+w==
X-Received: by 10.107.43.16 with SMTP id r16mr8662890ior.81.1472111568229;
 Thu, 25 Aug 2016 00:52:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.232 with HTTP; Thu, 25 Aug 2016 00:52:47 -0700 (PDT)
In-Reply-To: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
References: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Aug 2016 09:52:47 +0200
X-Google-Sender-Auth: RvVXJ6BwomGd3GaWI6pLcmKMFAk
Message-ID: <CAMuHMdUC9d4KNPTDY51DCptmMFQ1F2jLmRDO9WLt=WZA09qRew@mail.gmail.com>
Subject: Re: [PATCH v3] clk: let clk_disable() return immediately if clk is NULL
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Aug 24, 2016 at 7:26 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Many of clk_disable() implementations just return for NULL pointer,
> but this check is missing from some.  Let's make it tree-wide
> consistent.  It will allow clock consumers to call clk_disable()
> without NULL pointer check.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
