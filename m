Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 11:46:22 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:59659 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224950AbUHQKqS>;
	Tue, 17 Aug 2004 11:46:18 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Bx1el-00027L-00; Tue, 17 Aug 2004 11:57:31 +0100
Received: from holborn.mips.com ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Bx1TT-0000jw-00; Tue, 17 Aug 2004 11:45:51 +0100
Message-ID: <4121E1DF.9020801@mips.com>
Date: Tue, 17 Aug 2004 11:45:51 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Roman Mashak <mrv@tusur.ru>
CC: linux-mips@linux-mips.org
Subject: Re: Yamon compiling and linking
References: <001601c483fd$9e3ae180$1422bdd3@roman>
In-Reply-To: <001601c483fd$9e3ae180$1422bdd3@roman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.912, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Roman Mashak wrote:
> When I compile little-endian only image, as far as I understood, I got image
> without RESET code at the beginning, so according to the memory map and link
> script (link_el.xn) - starting entry point is __RESET_HANDLER_END (locating
> in init.S) and its address is 0x9fc10000.
> So, I don't quite understand, how will be going after CPU reset? As
> documentation's saying "following a reset, hardware fetches instructions
> starting at the reset exception vector 0xBFC00000". But what is waiting at
> this address, because reset code (reset.S) is not compiled and is not
> linked?

   I think you are using modified YAMON sources... I can tell you how 
the build process works for the distributed version of YAMON:

   Invoking make in the  yamon/bin directory build two YAMON images (one 
big-endian & one little-endian) in the EB & EL subdirectories.  In 
addition some endianess independent reset code (reset.o) is built in 
yamon/bin. These three images are combined together to make a single 
yamon-02.xx.rec image that can run in either endianess.

   If you're only interested in running little-endian you should be able 
to simply combine the reset-02.xx.rec and EL/yamon-02.xx_el.rec images.

	Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
