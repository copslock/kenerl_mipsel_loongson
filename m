Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 12:21:31 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:8722 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225072AbTHLLV1>;
	Tue, 12 Aug 2003 12:21:27 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19mXEG-0000Xn-00; Tue, 12 Aug 2003 12:22:16 +0100
Received: from holborn.algor.co.uk ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 19mXDA-0001wE-00; Tue, 12 Aug 2003 12:21:08 +0100
Message-ID: <3F38CDA4.40208@mips.com>
Date: Tue, 12 Aug 2003 12:21:08 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK) Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: C0 config reg for 5k core
References: <Pine.GSO.4.44.0308111422220.4449-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-1.5, required 4, AWL,
	EMAIL_ATTRIBUTION, QUOTED_EMAIL_TEXT, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

David Kesselring wrote:
> Has anyone else built linux 2.4 for a 5k or 5kf core? When comparing cpu.h

   I have :)

> and the MIPS64 5K Processor Core Family Software Users Manual it doesn't
> look to me that the c0-config1 reg is defined the same way. Am I reading
> something wrong? For example in the spec FPU flag is bit0 while in cpu.h
> it is bit4. Seems pretty basic.

   The option bits defined in cpu.h are software flags.  See 
arch/mips/kernel/setup.c where these flags are set for each processor by 
reading appropriate registers.

	Regards
		Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
