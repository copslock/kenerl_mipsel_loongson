Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 15:29:18 +0000 (GMT)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:23981
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225335AbVAUP3N>; Fri, 21 Jan 2005 15:29:13 +0000
Received: from [192.168.50.222] ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 21 Jan 2005 07:29:11 -0800
Message-ID: <41F11EB8.3010703@sunrisetelecom.com>
Date:	Fri, 21 Jan 2005 10:24:40 -0500
From:	Karl Lessard <klessard@sunrisetelecom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Bootloader for mips
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2005 15:29:11.0768 (UTC) FILETIME=[F50A2D80:01C4FFCD]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

Hi all!

let's say that I want a very very very simple bootloader for MIPS that 
boots from flash roms, as trivial
as 'start and go', without interaction, commands, etc.. any idea where I 
can find it?

Or at least how can I write it? (i.e. is there something else to do than 
setting up kernel parameters
and jumping to the kernel start address?)

Thanks a lot,
Karl
