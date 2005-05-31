Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 15:57:26 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:22536 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225796AbVEaO5M>; Tue, 31 May 2005 15:57:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6DFDBF5978; Tue, 31 May 2005 16:57:02 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16840-07; Tue, 31 May 2005 16:57:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 39E20F5977; Tue, 31 May 2005 16:57:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j4VEv5LN010300;
	Tue, 31 May 2005 16:57:05 +0200
Date:	Tue, 31 May 2005 15:57:13 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Michael Belamina <belamina1@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 64 bit kernel for BCM1250
In-Reply-To: <20050526185931.58037.qmail@web32510.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0505311544130.30850@blysk.ds.pg.gda.pl>
References: <20050526185931.58037.qmail@web32510.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/901/Tue May 31 15:33:04 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 May 2005, Michael Belamina wrote:

> I have tried the patch on kernel version 2.4.28 and it
> seems that the fix is not working for this kernel
> version. I used gcc version 2.95.4 and it is working. 

 Hmm, you may need additional fixes...  How about just switching to 2.6?  
Currently 2.4 is over 4 years old and it shouldn't be used for new 
development.

> 1. What is the best way to translate 32 bit ioctl
> codes to 64 bit?

 Use arch/mips64/kernel/ioctl32.c, but in 2.6 there may be a generic 
solution available.

> 2. How 64 bit kernel space buffers will  be used by a
> 32 bit application (using mmap)? 

 As usual.  Except you can't get more than 2GB of them.

> 3.What is the maximum usable ram out of 2GB I will
> have if I am using a 32 bit application and 64 bit
> kernel and the kernel is allocating the buffers using
> __get_free_pages (I need the buffers for DMA - and I
> need them to be physically continuous)?

 2GB minus what's used by Linux for other purposes.  Physically 
contiguous?  That sounds like a problem (and broken hardware)...

  Maciej
