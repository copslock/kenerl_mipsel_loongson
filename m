Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2004 08:55:06 +0100 (BST)
Received: from mail.oricom.de ([IPv6:::ffff:62.116.167.249]:50873 "EHLO
	oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225472AbUFDHzC>; Fri, 4 Jun 2004 08:55:02 +0100
Received: from mycable.de (d003054.adsl.hansenet.de [80.171.3.54])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id i547q5Kd025640;
	Fri, 4 Jun 2004 09:52:06 +0200
Message-ID: <40C02A6A.2040400@mycable.de>
Date: Fri, 04 Jun 2004 09:53:14 +0200
From: "Tiemo Krueger - mycable.de" <tk@mycable.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitriy Tochansky <toch@dfpost.ru>
CC: linux-mips@linux-mips.org
Subject: Re: bootloader
References: <40C029F5.3040506@dfpost.ru>
In-Reply-To: <40C029F5.3040506@dfpost.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

Yamon should be in Flash of that board and start automatically...
If it doesn't start check the DIP Switches on the board for correct 
settings.
(little/big endian, and I think you can switch between the flashes)


Tiemo

Dmitriy Tochansky wrote:

> Hi!
> Does anybody can advice me some bootloader for my Zinfandel(Db1500) 
> board?
>
> CU.
>
>
