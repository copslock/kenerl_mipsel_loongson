Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2004 09:30:30 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:10472 "EHLO
	mail.postwin.ru") by linux-mips.org with ESMTP id <S8225471AbUFDIaZ>;
	Fri, 4 Jun 2004 09:30:25 +0100
Received: by mail.postwin.ru (Postfix, from userid 7896)
	id 093CD844F8; Fri,  4 Jun 2004 12:29:15 +0400 (MSD)
Received: from dfpost.ru (unknown [192.168.9.4])
	by mail.postwin.ru (Postfix) with ESMTP
	id E09DD844F5; Fri,  4 Jun 2004 12:29:14 +0400 (MSD)
Message-ID: <40C0338F.2050408@dfpost.ru>
Date: Fri, 04 Jun 2004 12:32:15 +0400
From: Dmitriy Tochansky <toch@dfpost.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tiemo Krueger - mycable.de" <tk@mycable.de>
Cc: linux-mips@linux-mips.org
Subject: Re: bootloader
References: <40C029F5.3040506@dfpost.ru> <40C02A6A.2040400@mycable.de> <40C02E21.8060009@dfpost.ru> <40C03028.9090705@mycable.de>
In-Reply-To: <40C03028.9090705@mycable.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Tiemo Krueger - mycable.de wrote:

> Yes, it can!
> There are two options, use a kernel simply compiled for ram,
> load it via tftp, cp it to an erased flashed area.
> then you can start it by copying it to ram and jump to the start 
> address inside the kernel.
> the second more simple solution is to build a compressed kernel,
> flash it e.g. to 0xbfd00000 and then simply go there for start.
>
> Pls refer the Yamon help for any details, you can add a start variable 
> to the Yamon
> config which is executed after two seconds if you don't stop this with 
> Ctrl-c via serial.
>
> (set start 'go 0xbfd00000 root=/dev/mtdblock1' or whatever...)
>
Yes I did it that way. :) Thanks.
So is there other nice loaders for this board?

CU
