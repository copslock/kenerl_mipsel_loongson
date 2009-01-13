Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 18:13:19 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:54163 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21103627AbZAMSNR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 18:13:17 +0000
Received: by bwz6 with SMTP id 6so448758bwz.0
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 10:13:11 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=kBAcKo0UxlTgn8Lbgf28BmpiYtMqHq1WUP5K6uORiWs=;
        b=H58lblTLpH72oCtLikcBblmmByIeH2lBcB4qEyQ7h32oG5WzwQsaEuYAQdYHkTuFLH
         ivGsCmmMxPaXwOt/5xcCIS4MgnPLvx6hX0v5HI4a7K8Tx16q1EabKf36S4xK0r4XufzQ
         z4SyhacGnOcFgbObBLCgFp+qBGqfUFDWZGV58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=HxAX6tLBXOU0lb0IcZxJS+KM5Ze5L6SOgoh117C/rPxjnk77f2KgvuQOo7jcbO39ZY
         7XaPMTVfSqST1XoQYpUv6Vb/UeWmz+tKmOELtPTp9r15w4YRciRrV3RtIKUxlkqpkrIX
         TqlZvBxnQeoICqs1eJ9Oqou9o7Xuhinf+pVwA=
MIME-Version: 1.0
Received: by 10.181.197.1 with SMTP id z1mr11458354bkp.118.1231870390825; Tue, 
	13 Jan 2009 10:13:10 -0800 (PST)
In-Reply-To: <C13DBBE85AD6974B85C118C35890CA5F1A85149CC6@EU1RDCRDC1WX029.exi.nxp.com>
References: <1231859270.25974.32.camel@EPBYMINW0568>
	 <C13DBBE85AD6974B85C118C35890CA5F1A85149CC6@EU1RDCRDC1WX029.exi.nxp.com>
Date:	Tue, 13 Jan 2009 20:13:10 +0200
Message-ID: <fce2a370901131013r240abe16l576ef6269aba945f@mail.gmail.com>
Subject: Re: [pnx833x_port]: device name prefix - ttyS or ttySA?
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	Daniel James Laird <daniel.j.laird@nxp.com>,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2009 at 7:09 PM, Daniel James Laird
<daniel.j.laird@nxp.com> wrote:
> I cant find the file you are talking about however

Sorry, I misspelled the file name. It's 'drivers/serial/pnx8xxx_uart.c' instead.

> I think that the major number should infact be 4 with a minor number of 64,65,66 etc.  This seems to be what other devices do.  This would mean you can still be ttyS... but not clash with SA1100 if that's what you mean.

You're wrong. There are lots of board specific serial drivers that
define special major-minor numbers. For example look at sc26xx,
mpc52xx_uart, bfin_5xx drivers. The problem with pnx8xxx_uart driver
is that it uses special major:minor numbers for generic ttyS* devices.

I think we need one of these changes:
1) make a special CONFIG_PNX8XXX_UART_TTYS option for switching
between ttyS*+4:64 and ttySA*+204:5 variants (see f.e. atmel_serial
driver). Of course this CONFIG_PNX8XXX_UART_TTYS option will be
disabled if CONFIG_SERIAL_8250 enabled.
2) Just stick with ttySA*+204:5 (not with ttyS*+204:5 as it's now).

Please tell me what you prefer and I'll send you a patch.

>
> With regards,
> Daniel Laird
>
> Daniel Laird, Software Engineer
> NXP Semiconductors, BU Home, BL STB
>
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ihar Hrachyshka
> Sent: 2009 Jan 13 15:08
> To: linux-mips@linux-mips.org
> Subject: [pnx833x_port]: device name prefix - ttyS or ttySA?
>
> In 'drivers/serial/pnx833x_port.c' we define the prefix for UART serial
> device as "ttyS". Anyway, we use major:minor numbers for SA1100 serial
> driver (that are 204:5). Why don't we use "ttySA" prefix then? That's
> what different embedded build systems expect for populating /dev (f.e.
> buildroot).
>
>
>
