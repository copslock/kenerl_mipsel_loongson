Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 22:07:32 +0000 (GMT)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:56894
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225208AbTBTWHc>; Thu, 20 Feb 2003 22:07:32 +0000
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h1KM5g6n014313;
	Thu, 20 Feb 2003 23:05:42 +0100
Message-ID: <3E55517E.40905@murphy.dk>
Date: Thu, 20 Feb 2003 23:06:54 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] allow CROSS_COMPILE override
References: <20030220124703.H7466@mvista.com> <20030220215725.GA31222@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:

>Silly question: why does this matter if CROSS_COMPILE is on the command
>line?  Command line definitions override anything in the makefile.  Is
>it falling off the command line in a recursive make?
>  
>
You need ?= to allow the define in the top level makefile to override 
that in
the sub-makefile. You also need it if you want to get the value from an
environment variable and not from something like this:

make CROSS_COMPILE=xxx

which is the only case where it works now.

/Brian
