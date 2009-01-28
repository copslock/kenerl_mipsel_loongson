Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 11:50:02 +0000 (GMT)
Received: from smtp6-g21.free.fr ([212.27.42.6]:40901 "EHLO smtp6-g21.free.fr")
	by ftp.linux-mips.org with ESMTP id S21366439AbZA1Lt7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 11:49:59 +0000
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 46F0FE0808B
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2009 12:49:55 +0100 (CET)
Received: from [192.168.1.100] (server.a3ip.com [82.229.124.93])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4F242E08056
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2009 12:49:53 +0100 (CET)
Message-ID: <49804660.8040802@free.fr>
Date:	Wed, 28 Jan 2009 12:49:52 +0100
From:	Cyril HAENEL <chaenel@free.fr>
User-Agent: Thunderbird 2.0.0.19 (X11/20090114)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Question about the SMP8634/SMP8635 MIPS processor
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chaenel@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chaenel@free.fr
Precedence: bulk
X-list: linux-mips

Hi,

I am new to the list, I recently bought a set-top-box (Netbox 8160) 
which uses a SMP8635 MIPS processor.
The original fimware is a disaster and for fun I want to try to build my 
own linux based firmware for this set-to-box.

I am absolutely not afraid, because I do a lot of embedded linux at 
office (on ARM9 arch and Blackfin arch).

The board of this set-top-box is pretty simple, there is the SMP8635 
processor, 256MB of DDRAM, 16 MB of NOR flash, mini pci with atheros 
wifi card, ethernet MII phy, and 2 DVB-T tuners (maybe USB2 or PCI, for 
now I don't now).

The SMP8635 processor comes from Sigma Design and I found on its FTP 
site a 2.6.15 kernel with associated patches for the SMP863x processors 
serie.

My problem is that they doesn't provide the datasheet alone, visibly 
they provide it with the SMP8634 developement board 
(http://www.sigmadesigns.com/public/Products/SMP8630/SMP8630_series.html).

And to begin to developp on this board, I need at least to know where is 
located the JTAG. It will be the starting point to try to access the NOR 
flash to backup the original firmware, and play with the board.
I don't see any SPI eeprom/flash thus I think even the boot loader is 
located the 16MB nor flash, so I thing at startup the processor directly 
try to execute code from the NOR, maybe at adress 0x0.

Is someone has some information on this processor ? Or maybe the 
datasheet ? With the datasheet I will be have to locate the JTAG pin :)

Thank you for reading my message, and sorry because my english is not 
perfect.

I wish you a good day

Regards,
Cyril HAENEL

-- 

Cyril Haenel
Registered Linux User #332632
