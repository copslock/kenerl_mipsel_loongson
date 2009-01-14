Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 22:20:36 +0000 (GMT)
Received: from yx-out-1718.google.com ([74.125.44.154]:7651 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21365088AbZANWUd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Jan 2009 22:20:33 +0000
Received: by yx-out-1718.google.com with SMTP id 36so310251yxh.24
        for <linux-mips@linux-mips.org>; Wed, 14 Jan 2009 14:20:31 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=suHlho8mOWVv6b1X1SO9K9SqMQXTrAcYJbSCeNHQDYA=;
        b=nciNnATQ0NSYleHGRUVaTV1JJHXoQawls5U58XRWEhUXwm8hfJBJigEGdUHc71bjJu
         S0QS+ubKZZ7jriNj96mCjx1fjdcEoN8fBIAhqvCUU0V3+3TAgC8pB246Bj2B7gbHao4R
         Ru/HBevVySnYyJ7cngrPn9OHVWXSISFIDSlRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tB9V4xq8OrgF0Qm1m37Wuk7YsxQwwh3tkoW6kq5BRcJOs0SMMrXFB91MJv/w31c07S
         IsU++Va2if/dFNzqhUyoC+jUaIn3YUvnnFIei7StEpDwPRmmOK06rx9aC5CAPHbMzwPy
         1rSO0pcITPWgRoCuPOqNt0XqGvUJleBxi3JZU=
MIME-Version: 1.0
Received: by 10.150.11.14 with SMTP id 14mr2679057ybk.101.1231971630835; Wed, 
	14 Jan 2009 14:20:30 -0800 (PST)
In-Reply-To: <496E615E.9060006@ru.mvista.com>
References: <1231943742.8457.6.camel@EPBYMINW0568>
	 <496E615E.9060006@ru.mvista.com>
Date:	Thu, 15 Jan 2009 00:20:30 +0200
Message-ID: <fce2a370901141420g64194488h85f6ef777ab57083@mail.gmail.com>
Subject: Re: [PATCH] Don't use ttyS* serial device name for board specific 
	PNX8XXX UART serial
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 15, 2009 at 12:04 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Ihar Hrachyshka wrote:
>>
>> I think that's a better solution for the problem I said so please commit
>> this patch rather previous one...
>>
>
>  Such comments are to be placed after --- tearline. Using several such
> tearlines makes it harder to apply your patch...
>  And why do you expect the MIPS maintainer to commit a patch to the serial
> driver? Such patches should be addressed to linux-serial@vger.kernel.org and
> (most probably) Alan Cox...

I thought that if it's a driver for mips piece of hardware then I need
to send it to mips guys. Ok, I'll send it to linux-serial.

>
>> ---
>>
>> Don't use ttyS[0-1] serial device name for board specific PNX8XXX UART
>> serial. Rather create ttyPNX[0-1]. Also changed minor number to be
>> different with sa1100 serial driver one.
>>
>> Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
>>
>
> [...]
>>
>> diff --git a/drivers/serial/pnx8xxx_uart.c b/drivers/serial/pnx8xxx_uart.c
>> index 22e30d2..96870f1 100644
>> --- a/drivers/serial/pnx8xxx_uart.c
>> +++ b/drivers/serial/pnx8xxx_uart.c
>> @@ -34,9 +34,8 @@
>>  #include <asm/io.h>
>>  #include <asm/irq.h>
>>  -/* We'll be using StrongARM sa1100 serial port major/minor */
>>  #define SERIAL_PNX8XXX_MAJOR   204
>> -#define MINOR_START            5
>> +#define MINOR_START            96
>>
>
>  This major-minor pair is reserved for the Altix serial cards. Have you
> tried registering the minor on http://www.lanana.org

Thanks for info. I sent the request.

>
> WBR, Sergei
>
>
>
