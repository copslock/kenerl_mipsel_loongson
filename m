Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 09:53:14 +0000 (GMT)
Received: from roasted.cubic.org ([193.108.181.130]:62680 "EHLO
	roasted.cubic.org") by ftp.linux-mips.org with ESMTP
	id S20022689AbXCQJxJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Mar 2007 09:53:09 +0000
Received: from c192151.adsl.hansenet.de ([213.39.192.151] helo=cubic.org)
	by roasted.cubic.org with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.36 #1)
	id 1HSVXz-00078A-00
	for linux-mips@linux-mips.org; Sat, 17 Mar 2007 10:49:59 +0100
Message-ID: <45FBB9C7.9060800@cubic.org>
Date:	Sat, 17 Mar 2007 10:49:59 +0100
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>
In-Reply-To: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Marco Braga wrote:

> my Au1500 based board has a PCI1510 cardbus controller connected to 
> the PCI bus. So far the kernel 2.6.17 supports it as a "yenta_socket". 
> The cardbus is correctly seen and configured, and if I insert a wifi 
> card in the slot I can configure it.


There is a hint on that in the datasheet. Search for deadlock and/or 
delayed read transaction.
Read it carefully. May be you can not use you PCI-Cardbus controller. 
Have in mind, that a PCI-Cardbus controller with a cardbus card inserted 
acts like a PCI to PCI bridge.

Regards,
Michael
