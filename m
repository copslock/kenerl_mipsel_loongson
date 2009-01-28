Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 16:36:17 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9098 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21103451AbZA1QgP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 16:36:15 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B498089620000>; Wed, 28 Jan 2009 11:35:46 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Jan 2009 08:35:03 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Jan 2009 08:35:02 -0800
Message-ID: <49808936.2040407@caviumnetworks.com>
Date:	Wed, 28 Jan 2009 08:35:02 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Cyril HAENEL <chaenel@free.fr>
CC:	linux-mips@linux-mips.org
Subject: Re: Question about the SMP8634/SMP8635 MIPS processor
References: <49804660.8040802@free.fr>
In-Reply-To: <49804660.8040802@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2009 16:35:02.0947 (UTC) FILETIME=[5E893F30:01C98166]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Cyril HAENEL wrote:
[...]
> The SMP8635 processor comes from Sigma Design and I found on its FTP 
> site a 2.6.15 kernel with associated patches for the SMP863x processors 
> serie.
> 
> My problem is that they doesn't provide the datasheet alone, visibly 
> they provide it with the SMP8634 developement board 
> (http://www.sigmadesigns.com/public/Products/SMP8630/SMP8630_series.html).
> 

In the past the datasheet was only available under NDA...

> And to begin to developp on this board, I need at least to know where is 
> located the JTAG. It will be the starting point to try to access the NOR 
> flash to backup the original firmware, and play with the board.
> I don't see any SPI eeprom/flash thus I think even the boot loader is 
> located the 16MB nor flash, so I thing at startup the processor directly 
> try to execute code from the NOR, maybe at adress 0x0.
> 

The 8634 has an internal 'security' processor that executes code out of 
on-chip flash/RAM.  This security processor boots the main CPU only 
after verifying that the boot loader's cryptographic signatures are 
valid.    Unless the factory firmware is permissive, there is very 
little you can do with it.

> Is someone has some information on this processor ? Or maybe the 
> datasheet ? With the datasheet I will be have to locate the JTAG pin :)

The JTAG is multiplexed with the second serial port.  Often you have to 
change a strapping pin so that JTAG is enabled when the board is powered 
on.  Different boards have a variety of JTAG connectors, you would have 
to search for it on your board.  Generally it is some form of 14 pin 
dual-inline header.

If you haven't already found it, probably the first thing you want to do 
is find primary serial port.  Most configurations print at least a 
couple of lines indicating DRAM configuration before booting.  If you 
are lucky you may be able to get to a YAMON prompt from the serial port.

The zboot loader may read a character from the serial port. '0', '1', 
'2', and '3' will override the default boot image.


David Daney
