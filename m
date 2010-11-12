Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 23:01:32 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:52880 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492173Ab0KLWB0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Nov 2010 23:01:26 +0100
Received: by gwb11 with SMTP id 11so175446gwb.36
        for <multiple recipients>; Fri, 12 Nov 2010 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qFLhrmdTE+YCdbDtmePaJfcWdb2tsW6igdjCkNVs9no=;
        b=MIRXGztMvjAtrLn+K9HWd4+3G02QahLvnB40c4IvJjX26Si4+EwZxwd3Wn+mMR70zY
         vg7DvF3GCL4bl20qyw8qxRfEAJd9jG+W1zJQZaWeFfzhL7M7K24cxhtVeQevgxaBTxo9
         RPsTUwd7FdZRzyzUHUmnLLSAyI/917dD3yUf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pHGeDoEtz4FSyd6T5+FaBZXAZk5qib7owlyWkOeZM1SzvbQOFJt6i3hE0DFSiU3ZMs
         p82Zro6QLg+HdPXEgH5veuaGVSGANE6bP23AM/c8SAyAVN5WfMJYJvs5yynZ2d4bvuc8
         NqvyH4K+nSpKE9YpJ7PX9gm3Td4resH9zITpg=
Received: by 10.42.204.17 with SMTP id fk17mr2594963icb.324.1289599279313;
 Fri, 12 Nov 2010 14:01:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.174.209 with HTTP; Fri, 12 Nov 2010 14:00:56 -0800 (PST)
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
From:   "Luis R. Rodriguez" <mcgrof@gmail.com>
Date:   Fri, 12 Nov 2010 14:00:56 -0800
Message-ID: <AANLkTinR6QCdf5hvT6H+a6M=NKoY5qaGjt+5OOyizHCk@mail.gmail.com>
Subject: Re: [RFC 00/18] MIPS: initial support for the Atheros
 AR71XX/AR724X/AR913X SoCs
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Cliff Holden <Cliff.Holden@atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <mcgrof@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcgrof@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 12, 2010 at 1:51 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> This patch set contains initial support for the
> Atheros AR71XX/AR724X/AR913X SoCs.
>
> Gabor Juhos (18):
>  MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X SoCs
>  MIPS: ath79: add GPIOLIB support
>  MIPS: add generic support for multiple machines within a single kernel
>  MIPS: ath79: utilize the MIPS multi-machine support
>  MIPS: ath79: add initial support for the Atheros PB44 reference board
>  MIPS: ath79: add common GPIO LEDs device
>  watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs
>  MIPS: ath79: add common watchdog device
>  input: add input driver for polled GPIO buttons
>  MIPS: ath79: add common GPIO buttons device
>  spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X SoCs
>  MIPS: ath79: add common SPI controller device
>  USB: ehci: add workaround for Synopsys HC bug
>  USB: ehci: add bus glue for the Atheros AR71XX/AR724X/AR913X SoCs
>  USB: ohci: add bus glue for the Atheros AR71XX/AR7240 SoCs
>  MIPS: ath79: add common USB Host Controller device
>  MIPS: ath79: add initial support for the Atheros AP81 reference board
>  MIPS: ath79: add common WMAC device for AR913X based boards

Awesome, thanks a lot!

 Luis
