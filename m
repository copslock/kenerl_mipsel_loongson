Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2004 09:19:36 +0100 (BST)
Received: from mail.oricom.de ([IPv6:::ffff:62.116.167.249]:58298 "EHLO
	oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225471AbUFDITc>; Fri, 4 Jun 2004 09:19:32 +0100
Received: from mycable.de (d003054.adsl.hansenet.de [80.171.3.54])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id i548GaKd026500;
	Fri, 4 Jun 2004 10:16:36 +0200
Message-ID: <40C03028.9090705@mycable.de>
Date: Fri, 04 Jun 2004 10:17:44 +0200
From: "Tiemo Krueger - mycable.de" <tk@mycable.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitriy Tochansky <toch@dfpost.ru>
CC: linux-mips@linux-mips.org
Subject: Re: bootloader
References: <40C029F5.3040506@dfpost.ru> <40C02A6A.2040400@mycable.de> <40C02E21.8060009@dfpost.ru>
In-Reply-To: <40C02E21.8060009@dfpost.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

Yes, it can!
There are two options, use a kernel simply compiled for ram,
load it via tftp, cp it to an erased flashed area.
then you can start it by copying it to ram and jump to the start address 
inside the kernel.
the second more simple solution is to build a compressed kernel,
flash it e.g. to 0xbfd00000 and then simply go there for start.

Pls refer the Yamon help for any details, you can add a start variable 
to the Yamon
config which is executed after two seconds if you don't stop this with 
Ctrl-c via serial.

(set start 'go 0xbfd00000 root=/dev/mtdblock1' or whatever...)

Tiemo


Dmitriy Tochansky wrote:

> Tiemo Krueger - mycable.de wrote:
>
>> Yamon should be in Flash of that board and start automatically...
>> If it doesn't start check the DIP Switches on the board for correct 
>> settings.
>> (little/big endian, and I think you can switch between the flashes)
>>
>>
>> Tiemo
>>
>> Dmitriy Tochansky wrote:
>> Does anybody can advice me some bootloader for my Zinfandel(Db1500) 
>> board?
>>
> Oops! Sorry. :) I mean another bootloader insted YAMON. I need to load 
> kernel from flash but not from LAN(tftp and etc). Can YAMON to do that?
>
> CU
>
>
