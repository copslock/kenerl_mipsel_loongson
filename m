Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 13:48:34 +0000 (GMT)
Received: from roasted.cubic.org ([193.108.181.130]:40667 "EHLO
	roasted.cubic.org") by ftp.linux-mips.org with ESMTP
	id S20022742AbXCQNs3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Mar 2007 13:48:29 +0000
Received: from c192151.adsl.hansenet.de ([213.39.192.151] helo=cubic.org)
	by roasted.cubic.org with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.36 #1)
	id 1HSZDj-0007ix-00
	for linux-mips@linux-mips.org; Sat, 17 Mar 2007 14:45:19 +0100
Message-ID: <45FBF0F1.70302@cubic.org>
Date:	Sat, 17 Mar 2007 14:45:21 +0100
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>	 <45FBB9C7.9060800@cubic.org> <d459bb380703170554l3fb40d60h6f68b70472ad7cb@mail.gmail.com>
In-Reply-To: <d459bb380703170554l3fb40d60h6f68b70472ad7cb@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Marco Braga wrote:

> I've found the datasheet of PCI1510 and the section you pointed. Sadly 
> I don't understand fully the problem, so I'll discuss it with out 
> hardware enginers. Do you have any reference to the effects of that 
> problem? Can it cause the hand of reads on the bus?

I am sory, I meant the datasheet of the Au1500. I do not find the 
paragraph anymore, but can tell you more on monday.
One interesting paragraph is "AMD Alchemy Au1500 Processor Data Book" - 
4.3.10 "Other Notes" first paragraph.

The note I meant descibes a situration where a delayed read transaction 
on a pci device behind a pci-pci bridge can cause to a racing condition, 
where the whole system stalls. The CPU does not get the chance to do 
anything anymore, because the PCI subsystem blocks it.

Regards,
Michael
