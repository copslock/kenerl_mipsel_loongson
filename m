Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 17:15:02 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:63245 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224935AbUIPQO5>;
	Thu, 16 Sep 2004 17:14:57 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1C7z4H-0001hx-00; Thu, 16 Sep 2004 17:25:09 +0100
Received: from holborn.mips.com ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1C7yu8-0000uy-00; Thu, 16 Sep 2004 17:14:40 +0100
Message-ID: <4149BBEF.1020800@mips.com>
Date: Thu, 16 Sep 2004 17:14:39 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: gautam@koperasw.com
CC: linux-mips@linux-mips.org
Subject: Re: Problem with yamon (2.06) and TLB on Malta
References: <1095345079.4149a3b74bd1c@koperasw.com>
In-Reply-To: <1095345079.4149a3b74bd1c@koperasw.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.012, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

gautam@koperasw.com wrote:
> Hi,
> I am trying to write the kernel image to flash / IDE using yamon's disk write,
> load,cp commands . I have a recurring error message that says "Mapped entry not
> found in TLB" (something to that effect,just in case these are not the exact words).
> For e.g. I get the error evenn when I do a memory erase at the flash address
> sucessfully and later use the same starting address for cp .
> Does the TLB need to be edited in any specific way or can I direct these
> commands to execute without them needing to refer to the TLB?
> I know the answer must be pretty apparent, but have already scoured through
> google in vain searching for exact/relevant documentation.(and am pretty
> desperate now!)

   Are you trying to use the physical addresses when accessing the 
FLASH/memory?  You need to use KSEG0/KSEG1 addresses:

YAMON> erase be100000 2e0000  		# Erase the FLASH "user" area
The following area will be erased:
Start address = 0x1e100000
Size          = 0x002e0000
Confirm ? (y/n) y
Erasing...Done
YAMON>
YAMON> dump be100000 20			# Check that it's erased

BE100000: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ................
BE100010: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ................

YAMON> fill 80100000 20 55		# Set up some data in RAM
Filling from 0x80100000 to 0x8010001f with byte data 0x55.
YAMON> copy 80100000 be100000 20	# copy data to FLASH
Copying...Done
YAMON> dump be100000 20			# Check that FLASH contains data

BE100000: 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55  UUUUUUUUUUUUUUUU
BE100010: 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55  UUUUUUUUUUUUUUUU


	Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
