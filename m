Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2004 09:07:20 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:61158 "EHLO
	mail.postwin.ru") by linux-mips.org with ESMTP id <S8225471AbUFDIHQ>;
	Fri, 4 Jun 2004 09:07:16 +0100
Received: by mail.postwin.ru (Postfix, from userid 7896)
	id B6105844F8; Fri,  4 Jun 2004 12:06:05 +0400 (MSD)
Received: from dfpost.ru (unknown [192.168.9.4])
	by mail.postwin.ru (Postfix) with ESMTP
	id 99EF2844F5; Fri,  4 Jun 2004 12:06:05 +0400 (MSD)
Message-ID: <40C02E21.8060009@dfpost.ru>
Date: Fri, 04 Jun 2004 12:09:05 +0400
From: Dmitriy Tochansky <toch@dfpost.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tiemo Krueger - mycable.de" <tk@mycable.de>
Cc: linux-mips@linux-mips.org
Subject: Re: bootloader
References: <40C029F5.3040506@dfpost.ru> <40C02A6A.2040400@mycable.de>
In-Reply-To: <40C02A6A.2040400@mycable.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Tiemo Krueger - mycable.de wrote:

> Yamon should be in Flash of that board and start automatically...
> If it doesn't start check the DIP Switches on the board for correct 
> settings.
> (little/big endian, and I think you can switch between the flashes)
>
>
> Tiemo
>
> Dmitriy Tochansky wrote:
> Does anybody can advice me some bootloader for my Zinfandel(Db1500) 
> board?
>
Oops! Sorry. :) I mean another bootloader insted YAMON. I need to load 
kernel from flash but not from LAN(tftp and etc). Can YAMON to do that?

CU
