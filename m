Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2004 13:48:20 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:24580 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225215AbUA0NsT>;
	Tue, 27 Jan 2004 13:48:19 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AlTU5-0002Cw-00; Tue, 27 Jan 2004 13:42:29 +0000
Received: from holborn.mips.com ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AlTYm-0004RP-00; Tue, 27 Jan 2004 13:47:20 +0000
Message-ID: <40166BE8.2030009@mips.com>
Date: Tue, 27 Jan 2004 13:47:20 +0000
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK) Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: navin <navgrex@cyberspace.org>
CC: linux-mips@linux-mips.org
Subject: Re: Clock interrupt simulation on sde-gdb
References: <Pine.SUN.3.96.1040127074316.1295C-100000@grex.cyberspace.org>
In-Reply-To: <Pine.SUN.3.96.1040127074316.1295C-100000@grex.cyberspace.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.067, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

navin wrote:
> As such my bootup code seems to be configuring thigs (Count, Compare, and
> Status registers) properly. Is it that such timer interrupt CAN'T BE 
> SIMULATED on sde-gdb? I have tried trace32 simulator software 

   The simulator built into sde-gdb does not support exceptions. 
sde-gdb can connect to MIPSsim which is a full ISS. If you're interested 
in trying this, drop me a line and I will get someone to contact you.

	Regards
		Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
