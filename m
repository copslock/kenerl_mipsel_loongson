Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 22:03:44 +0000 (GMT)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:55102
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225208AbTBTWDo>; Thu, 20 Feb 2003 22:03:44 +0000
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h1KM2Q6n014300;
	Thu, 20 Feb 2003 23:02:27 +0100
Message-ID: <3E5550BA.4050107@murphy.dk>
Date: Thu, 20 Feb 2003 23:03:38 +0100
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
X-archive-position: 1497
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
The arm code does this:

# Only set INCDIR if its not already defined above
# Grr, ?= doesn't work as all the other assignment operators do.  Make bug?
ifeq ($(origin INCDIR), undefined)
INCDIR          := $(MACHINE)
endif

where the make docs say:

INCDIR ?= $(MACHINE)

is the same as

ifeq ($(origin INCDIR), undefined)
INCDIR          = $(MACHINE)
endif

which means INCDIR will reflect changes to MACHINE.
The := form sets INCDIR once and for all. What do you want?
I can't see that this should be a problem in the arm makefile.
Perhaps I'm missing something.

/Brian
