Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2004 14:36:26 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:53004 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224986AbUH0NgW>;
	Fri, 27 Aug 2004 14:36:22 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1C0h4Y-0002Gm-00; Fri, 27 Aug 2004 14:47:18 +0100
Received: from holborn.mips.com ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1C0gtb-0003fO-00; Fri, 27 Aug 2004 14:35:59 +0100
Message-ID: <412F38BF.4000101@mips.com>
Date: Fri, 27 Aug 2004 14:35:59 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: usha davuluri <ranidavuluri@yahoo.com>
CC: linux-mips@linux-mips.org
Subject: Re: Vmlinux-2.4.18 booting problems on Malta
References: <20040827002837.82864.qmail@web50307.mail.yahoo.com>
In-Reply-To: <20040827002837.82864.qmail@web50307.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.907, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

usha davuluri wrote:
> * Exception (user) : Reserved instruction *

> Debug    = 0x0000dc3f  EPC      = 0x802e0024

> Hi all,
>  I am getting the above error output when I say go
> (starting address) after loading the kernel source.
> please help me on this.
> Thank you,
>  Usha.


   Make sure you're really building a Malta kernel of the correct 
endianess and CPU type.  It's easy to load a big-endian kernel on a 
little endian board when using srecord downloads.

   Try disassembling the code at 0x802e0024 to see if it makes sense:
YAMON> dis 0x802e0024

   You didn't say what CPU you were using.  It's possible that the 
kernel is really using an instruction (eg a cacheop) that is not 
supported by your CPU.

	Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
