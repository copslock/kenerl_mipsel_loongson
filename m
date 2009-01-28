Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 17:01:55 +0000 (GMT)
Received: from smtp1-g21.free.fr ([212.27.42.1]:30862 "EHLO smtp1-g21.free.fr")
	by ftp.linux-mips.org with ESMTP id S21366333AbZA1RBx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 17:01:53 +0000
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 9AD879401FF;
	Wed, 28 Jan 2009 18:01:49 +0100 (CET)
Received: from [192.168.1.100] (server.a3ip.com [82.229.124.93])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7968C940167;
	Wed, 28 Jan 2009 18:01:45 +0100 (CET)
Message-ID: <49808F73.1000301@free.fr>
Date:	Wed, 28 Jan 2009 18:01:39 +0100
From:	Cyril HAENEL <chaenel@free.fr>
User-Agent: Thunderbird 2.0.0.19 (X11/20090114)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Question about the SMP8634/SMP8635 MIPS processor
References: <49804660.8040802@free.fr> <49808936.2040407@caviumnetworks.com>
In-Reply-To: <49808936.2040407@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <chaenel@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chaenel@free.fr
Precedence: bulk
X-list: linux-mips



David Daney a écrit :
> Cyril HAENEL wrote:
> [...]
>> The SMP8635 processor comes from Sigma Design and I found on its FTP 
>> site a 2.6.15 kernel with associated patches for the SMP863x 
>> processors serie.
>>
>> My problem is that they doesn't provide the datasheet alone, visibly 
>> they provide it with the SMP8634 developement board 
>> (http://www.sigmadesigns.com/public/Products/SMP8630/SMP8630_series.html). 
>>
>>
>
> In the past the datasheet was only available under NDA...
Maybe I can ask them....
Or maybe I must buy the development kit, but I thing price will be very 
high !

>
>> And to begin to developp on this board, I need at least to know where 
>> is located the JTAG. It will be the starting point to try to access 
>> the NOR flash to backup the original firmware, and play with the board.
>> I don't see any SPI eeprom/flash thus I think even the boot loader is 
>> located the 16MB nor flash, so I thing at startup the processor 
>> directly try to execute code from the NOR, maybe at adress 0x0.
>>
>
> The 8634 has an internal 'security' processor that executes code out 
> of on-chip flash/RAM.  This security processor boots the main CPU only 
> after verifying that the boot loader's cryptographic signatures are 
> valid.    Unless the factory firmware is permissive, there is very 
> little you can do with it.
Ok, thus the 8635 has an internal flash and some security routine at 
startup. Not a good new for me :(
This cryptographic signature are only done on the boot loader ?

>
>> Is someone has some information on this processor ? Or maybe the 
>> datasheet ? With the datasheet I will be have to locate the JTAG pin :)
>
> The JTAG is multiplexed with the second serial port.  Often you have 
> to change a strapping pin so that JTAG is enabled when the board is 
> powered on.  Different boards have a variety of JTAG connectors, you 
> would have to search for it on your board.  Generally it is some form 
> of 14 pin dual-inline header.
Ok, so I have found it. With the scope when I power up the board I can 
see a clock signal and a data signal on a non connected 14 pin header. 
It should be the second serial port you talk about.

>
> If you haven't already found it, probably the first thing you want to 
> do is find primary serial port.  Most configurations print at least a 
> couple of lines indicating DRAM configuration before booting.  If you 
> are lucky you may be able to get to a YAMON prompt from the serial port.
>
> The zboot loader may read a character from the serial port. '0', '1', 
> '2', and '3' will override the default boot image.
I really don't know where the first serial port can be located. The 
other non mounter header are connected to an auxiliary microcontroller. 
I need to search again !

Regards,
Cyril
>
>
> David Daney
>
>
>

-- 

Cyril Haenel
Registered Linux User #332632
