Return-Path: <SRS0=bCcf=OZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F6C43387
	for <linux-mips@archiver.kernel.org>; Sun, 16 Dec 2018 22:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13CB206BA
	for <linux-mips@archiver.kernel.org>; Sun, 16 Dec 2018 22:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="bKs2lZFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeLPW2e (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:28:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35978 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbeLPW2e (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 16 Dec 2018 17:28:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so5171427plo.3
        for <linux-mips@vger.kernel.org>; Sun, 16 Dec 2018 14:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dl2AuByQJpjLrjeXXkAhsFe1RZ8E2MixfRbKPwOveOg=;
        b=bKs2lZFnC9ySsEDlG5hPSOxX1erTQjt183voI9UH5ghoBHO2nLz7jzqGkLZbLrzFps
         BPQ5FSUvinhdjqVEBfMQ2BwRgogYGCofXYObsRW8f7vmBfoSvZMvhsq8Nrtc37htvSDv
         fICCaB1gun6zqFnG7wkeWfLIUWcnHUoEm9vZKNrKjKybVL0h5nttVefzd+45myz5qTKi
         F1Nulm+1YkrgzSeOV4DjKrTp+yD5/N5koN927HRSxIsruvgUO6O7MRpfUKnuXNkMnG/r
         SUvBXOIhEHoaXmF3I5PFislXqTFn0B9MbtsPvMVMabxA2Zqaqi4pQ6A8DsFBlt0uIASu
         Y/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dl2AuByQJpjLrjeXXkAhsFe1RZ8E2MixfRbKPwOveOg=;
        b=G7Mxf0JF7j2EtEtyNyZuDiuTRdaQecQvGuJ5ZqueyFLbdzt6vvBMc8PDTAsXluTaKJ
         vJr4BQL9dy0whlg2YgJ3lltyCOktvkHCqwLq/UdPOQTKJ5mrY73O6LZeO56wobYohI4G
         bVB3H0ChjOOuhPdOfu8UjNZX8iz8kt/Tie77GvEV2CXuAUmfvPx5vMDSNfQQffQnvjbK
         oUoarrwKkqCeXE/dTLs49DeZmssDLcE/Uz705bvaVeYteSkRXmixSdQkTTcJx1yy+1cj
         +DoZ5G3+aOh9+8/4uEREGgjU/sd9LCf3MTi0u+YSdsoRblTOrybYJMkNBHwrt1w/SjBJ
         cihg==
X-Gm-Message-State: AA+aEWajcLnrwWbh6Iue9dZPgn2HPEdWBejg626xDUlANM3WxxnKTT/j
        VEnSBewLawGRWS7gS7YNYxHhtKMflos8diHqgy9rBw==
X-Google-Smtp-Source: AFSGD/V6PZ+UVFXWsdMuHVGXGYEepNbbn4p0ya+l7UVZ/GrdYww8fP3KcYRdtfo7XdCxauKsdRg4EYtNUuVq/pZlMKQ=
X-Received: by 2002:a17:902:d68c:: with SMTP id v12mr10445280ply.4.1544999313671;
 Sun, 16 Dec 2018 14:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com> <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop> <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com> <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
In-Reply-To: <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 16 Dec 2018 19:28:22 -0300
Message-ID: <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
To:     Paul Burton <paul.burton@mips.com>
Cc:     Marek Vasut <marex@denx.de>,
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

On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Ezequiel,
>
> On Sun, Dec 16, 2018 at 06:52:53PM -0300, Ezequiel Garcia wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c
> > b/drivers/tty/serial/8250/8250_port.c
> > index c39482b96111..fac19cbc51d1 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *por=
t)
> >         /*
> >          * Clear the FIFO buffers and disable them.
> >          * (they will be reenabled in set_termios())
> >          */
> >         serial8250_clear_fifos(up);
> > +       serial_out(up, UART_FCR, 0);
> >
> >         /*
> >          * Clear the interrupt registers.
> >          */
> >         serial_port_in(port, UART_LSR);
> >
>
> This helps, but it only addresses one part of one of the 4 reasons I
> listed as motivation for my revert. For example serial8250_do_shutdown()
> also clearly intends to disable the FIFOs.
>

OK. So, let's fix that :-)

By all means, it would be really nice to push forward and fix the garbage
issue on JZ4780, as well as the transmission issue on AM335x.

AM335x is a wildly popular platform, and it's not funny to break it.
So, let's please stop discussing which board we'll break and just fix both.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
