Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 16:50:37 +0100 (BST)
Received: from www.clearcore.com ([IPv6:::ffff:69.20.152.109]:40614 "EHLO
	sam.clearcore.com") by linux-mips.org with ESMTP
	id <S8225229AbTGXPuf>; Thu, 24 Jul 2003 16:50:35 +0100
Received: from clearcore.com (clrsrv.clearcore.com [192.168.1.1])
	by sam.clearcore.com (Postfix) with ESMTP
	id 87CAC136B3; Thu, 24 Jul 2003 09:50:31 -0600 (MDT)
Message-ID: <3F200047.2050506@clearcore.com>
Date: Thu, 24 Jul 2003 09:50:31 -0600
From: Joe George <joeg@clearcore.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: boot requirements
References: <Pine.GSO.4.44.0307241019450.23101-100000@ares.mmc.atmel.com>
In-Reply-To: <Pine.GSO.4.44.0307241019450.23101-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <joeg@clearcore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joeg@clearcore.com
Precedence: bulk
X-list: linux-mips

I found Jun's porting howto to be an immense help.

http://linux.junsun.net/porting-howto/

I found it easier to port Linux to my board than
Yamon.  But I guess it probably depends a lot on
the kind of port.

Joe

David Kesselring wrote:
> I am trying to determine what has to be included in our boot code to start
> linux. I didn't think I needed to port yamon. What does yamon or pmon
> provide for starting or debugging(gdb) linux? Does the processor need to
> be in a specific state or context before jumping from the boot code to the
> linux downloaded image? If someone can point me to a simple example, I
> would greatly appreciate it.
> 
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
> 
