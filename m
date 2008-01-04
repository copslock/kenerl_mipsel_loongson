Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 22:28:09 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:21339 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20025791AbYADW2B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2008 22:28:01 +0000
Received: from [192.168.32.225] ([192.168.32.225]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 4 Jan 2008 17:27:54 -0500
Message-ID: <477EB2EA.7060009@raritan.com>
Date:	Fri, 04 Jan 2008 17:27:54 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E6296.7090605@raritan.com> <20080104172136.GD22809@networkno.de> <477E7DAE.2080005@raritan.com> <20080104192310.GE22809@networkno.de>
In-Reply-To: <20080104192310.GE22809@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2008 22:27:54.0971 (UTC) FILETIME=[0CF13AB0:01C84F21]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Hm, your start address is 0x80020000, but the load address of the jmr3927
> (in the www.linux-mips.org tree) is 0x80050000. So maybe the address is
> wrong, comparing with the old 2.4 kernel should tell.
>   

I compared that against the working 2.4.12 kernel, which does indeed 
have 80020000 in arch/mips/Makefile. I changed load-$(CONFIG...TX3927) 
to use 80020000 instead of 80050000, but it still fails the same way. 
There was also something that I had changed in our 2.4.12 that I had 
forgotten, but my coworker reminded me that, in jmr3927.h, I changed 
JMR3927_ROMCE0  from 0x1fc000000 to 0x1f000000 to have the proper 
address to access some raw memory for internal purposes. I do not recall 
whether that address is specific to our hardware or a typo, but I do not 
think that it impacts the normal kernel anyway.

Our 2.4.12 kernel uses -mcpu=r3000 -mips1 to build the kernel. I tried 
switching the arch to r3000 from r3900 in 2.6.23.9, but that did not 
help. Perhaps -mips1 or an equivalent could help? I will try on Monday.

I am grasping at straws here.

Thanks to Thiemo and Florian for trying to help.

Have a good weekend.
