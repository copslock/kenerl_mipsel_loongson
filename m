Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:35:34 +0000 (GMT)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:50238
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225198AbTBTVfd>; Thu, 20 Feb 2003 21:35:33 +0000
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h1KLYG6n014153;
	Thu, 20 Feb 2003 22:34:16 +0100
Message-ID: <3E554A1F.7080307@murphy.dk>
Date: Thu, 20 Feb 2003 22:35:27 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] allow CROSS_COMPILE override
References: <20030220124703.H7466@mvista.com> <3E55455A.8080403@murphy.dk> <20030220132300.I7466@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

>Is this allowed?  Can't find any such usage in kernel other
>than the worrisome comment below:
>
>arch/arm/Makefile:# Grr, ?= doesn't work as all the other assignment operators do.  Make bug?
>  
>
>  
>
It worked for me when I tested the patch, at least for this simple case.
Might have something to do with the make version, when was the comment
written?

brm@brian:~$ make -v
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.

/Brian
