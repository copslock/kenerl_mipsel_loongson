Return-Path: <SRS0=bCcf=OZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE86EC43444
	for <linux-mips@archiver.kernel.org>; Sun, 16 Dec 2018 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F88421841
	for <linux-mips@archiver.kernel.org>; Sun, 16 Dec 2018 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="Xa9LZZ9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbeLPVxG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:53:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39621 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbeLPVxF (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 16 Dec 2018 16:53:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so5123587pgl.6
        for <linux-mips@vger.kernel.org>; Sun, 16 Dec 2018 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZoHKhsnFGN3CIqkdEEKeYxt2PoWsCz+gYbY0r5efL9s=;
        b=Xa9LZZ9QV8bw/khoLhw/D4d00eV5tFXrgyPZ/dt8DmcfCd2X9h9xLvhwwf/FxGGqrl
         W+hIj772Z2+icSUjvlU3LvR0sopt4IEpM/gsm4pvkzZGc9vQTNCza9mJoZwIxbPBf07v
         tNUMXZvVsPFGUbI8RRZJNClYkpTGxbQIf6lIEqnoX2fUBIKsZasb5eQunrl485mYMXt/
         6Tg9WFO3Sghjb0wyns06jDTRdRdQaBGo78yUIfuybUjWJr44+jHdgzw01po+J3CxgEBe
         dCXBt4OxcD+V3jcb8zhdsOMz7/f1KlaHmqFJnKl7f8fC2wHRSq+/WfmpDmwWzamj2GUV
         L3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZoHKhsnFGN3CIqkdEEKeYxt2PoWsCz+gYbY0r5efL9s=;
        b=QAVBsxLmZqvU+4f/EY/dOXbEJiDsDBR/dqwywpVKUshYyljr4ydx3YQFe+cLK+Awjk
         IfTPrZEtIM1/0KBbcaQ219/J+N2gMlnX3nrEA4zj/LAEfWTteXV0YYfPOPyRJdDH4YAC
         iivC5OGLR+GnRKpS/hwhkSnEjUiGy7h3w6M4J0iTOtx1Arcc4cM1iwIcoJqhSuZVdiGh
         svfxKkM2TW/O1v09A109KFuWlHw+bei7NcOJi5kygRCJOCqnBH3nQZMA1GAYYHi+VIIh
         +asqp5Ljw3STu9xYe/qfwgNZ/mwr/juQSPrByn5FZstUYjFtYoobyYEzGVrlkM5/Nb8N
         IXfw==
X-Gm-Message-State: AA+aEWbouZ7wSDhTeBYCU+I1tVapv/AuzxS758AJFM+MscYsVFtAf/Jf
        X/vg7/7tRoeyL7FHTYz5AjwmRmsTfCFnZxxbTooNpg==
X-Google-Smtp-Source: AFSGD/W3QOHEF1EiOnAWMcYGMslfU64+wpdoWqzMfiSDs7cLOymEgK5beqh+Y5bKOLzGWlwA7qbAVMf8iUXQEaxSL74=
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr9644219pgc.366.1544997184661;
 Sun, 16 Dec 2018 13:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com> <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop> <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
In-Reply-To: <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 16 Dec 2018 18:52:53 -0300
Message-ID: <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
To:     Marek Vasut <marex@denx.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sun, 16 Dec 2018 at 18:45, Marek Vasut <marex@denx.de> wrote:
[skips discussion]
>
> > Ultimately it's Greg's decision but it sounds like you're asking me to
> > say it's OK to break the JZ4780 in a stable kernel with a patch that I
> > think would be risky anyway, and I won't do that.
>
> I am saying this revert breaks AM335x, so this is a stalemate. I had a
> discussion with Ezequiel (on CC) and he seems to have a different
> smaller patch coming for this problem.
>

Can you guys test this? Note that serial8250_do_startup has a comment
stating clearly that it has the intention of disabling the FIFOs,
so it seems this is the right thing to do.

Paul, this removes the garbage on my CI20 (rev.1)

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index c39482b96111..fac19cbc51d1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *port)
        /*
         * Clear the FIFO buffers and disable them.
         * (they will be reenabled in set_termios())
         */
        serial8250_clear_fifos(up);
+       serial_out(up, UART_FCR, 0);

        /*
         * Clear the interrupt registers.
         */
        serial_port_in(port, UART_LSR);


--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
