Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 23:29:26 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:22997 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226909AbVGSW3G>; Tue, 19 Jul 2005 23:29:06 +0100
Received: from steiner.cc.vt.edu (IDENT:mirapoint@evil-steiner.cc.vt.edu [10.1.1.14])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j6JMUXqB007361
	for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 18:30:43 -0400
Received: from [192.168.1.2] (68-232-96-93.chvlva.adelphia.net [68.232.96.93])
	by steiner.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DNH04891 (AUTH spbecker);
	Tue, 19 Jul 2005 18:30:31 -0400 (EDT)
Message-ID: <42DD7F06.8020403@gentoo.org>
Date:	Tue, 19 Jul 2005 18:30:30 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: module loading on 64-bit kernel
References: <20050719183546.GA3923@gaspode.automagically.de> <20050719192105.GF2071@hattusa.textio>
In-Reply-To: <20050719192105.GF2071@hattusa.textio>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips


> This seems to be a bug which crept in for (at least) 64bit Indy kernels
> in IIRC 2.6.12-rc3.

I'm fairly certain it happened with the initial 2.6.11-rc1 import.  I'd 
have to go back and double check to be 100% on that.

>>It happens with every module. If I'd need other tools these messages are
>>confusing. I didn't try "vmalloc=..." as I think module loading wouldn't
>>be "disabled" in such a way by default...
> 
> 
> It happens also for any significant memory pressure.

...including significant use of dd, mounting of ricerfs partitions, 
mounting of swap, etc.

-Steve
