Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 08:34:47 +0000 (GMT)
Received: from support.romat.com ([IPv6:::ffff:212.143.245.3]:24836 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225011AbUKNIem>;
	Sun, 14 Nov 2004 08:34:42 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 03482EB2CA;
	Sun, 14 Nov 2004 10:34:35 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 36569-08; Sun, 14 Nov 2004 10:34:31 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with SMTP id 75FDBEB2A9;
	Sun, 14 Nov 2004 10:34:31 +0200 (IST)
Message-ID: <09ac01c4ca24$e68a6740$a701a8c0@lan>
From: "Gilad Rom" <gilad@romat.com>
To: <ppopov@embeddedalley.com>, <linux-mips@linux-mips.org>
References: <20041112181335.13362.qmail@web81008.mail.yahoo.com>
Subject: Re: GPIO on the Au1500
Date: Sun, 14 Nov 2004 10:35:30 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Thanks. 
Can't I just mmap /dev/mem and use the
GPIO offset from SYS_BASE?

Gilad.

----- Original Message ----- 
From: "Pete Popov" <ppopov@embeddedalley.com>
To: "Gilad Rom" <gilad@romat.com>; <linux-mips@linux-mips.org>
Sent: Friday, November 12, 2004 8:13 PM
Subject: Re: GPIO on the Au1500


> 
> --- Gilad Rom <gilad@romat.com> wrote:
> 
>> Hello,
>> 
>> I am trying to use the au1000_gpio driver, but I'm a
>> little clueless as to how it is meant to be used. 
>> Can I use the GPIO ioctl's from a userland 
>> program, or must I write a kernel module?
> 
> I'll see if I can dig up some docs and the example
> userland program this weekend. That driver hasn't been
> tested in a while though.
> 
> Pete
> 
>> Thank you,
>> Gilad Rom
>> Romat Telecom
>> 
>> 
>> 
>
