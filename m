Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 14:20:20 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:18679 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21103557AbZAMOUR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 14:20:17 +0000
Received: by bwz6 with SMTP id 6so83930bwz.0
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 06:20:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5zrVlxErMebRBTLOeExn+B0oBeXsmDTxkUUzYHrte8g=;
        b=LdMevHpIcLIoPzhVsWGIQ+h42mIEGmH8I+yj45j5zCmCNNDsOllvBY3VOeaV5tnhRb
         T/2J8gdzvzvU49UZvMna9qhpV2bVW44poPDRNd+DJAr3PGAflkaSSE0aCQce/OE2320R
         wbjustD040wz6JarsK36TEFRXVJziCm1V9IMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=XUpRNbTDVyWzb6Nr41Car8Op1edrQbYnFeAsjU3ydC5LNRe+xOyhYRajnvqn7RgL46
         IbDQCKfW/0288MQoodefZH1DBIXOP2+sW/o048a5amWK0Pho5h3vR0s2Ru34dmk6JK5J
         CmuFvlwxDZSHlPgyJz7LPxMReHb4TWxjzlv0g=
MIME-Version: 1.0
Received: by 10.181.216.12 with SMTP id t12mr11399669bkq.122.1231856410419; 
	Tue, 13 Jan 2009 06:20:10 -0800 (PST)
In-Reply-To: <1231855886.25974.22.camel@EPBYMINW0568>
References: <1231855886.25974.22.camel@EPBYMINW0568>
Date:	Tue, 13 Jan 2009 16:20:10 +0200
Message-ID: <fce2a370901130620r33e97c7bp18594245bde66d1d@mail.gmail.com>
Subject: Re: [PATCH] Added serial UART support for PNX833X devices.
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry guys. That patch had a wrong signer one ;) Resent.

On Tue, Jan 13, 2009 at 4:11 PM, Ihar Hrachyshka
<ihar.hrachyshka@gmail.com> wrote:
> Enabled serial UART driver for PNX833X devices.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/serial/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 3e525e3..7d7f576 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -982,7 +982,7 @@ config SERIAL_SH_SCI_CONSOLE
>
>  config SERIAL_PNX8XXX
>        bool "Enable PNX8XXX SoCs' UART Support"
> -       depends on MIPS && SOC_PNX8550
> +       depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
>        select SERIAL_CORE
>        help
>          If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
> --
> 1.5.6.3
>
>
>
