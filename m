Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:24:58 +0000 (GMT)
Received: from alg133.algor.co.uk ([62.254.210.133]:19693 "EHLO
	oalggw.algor.co.uk") by linux-mips.org with ESMTP
	id <S8225241AbSLKRY5>; Wed, 11 Dec 2002 17:24:57 +0000
Received: from mips.com (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gBBHOnW05984;
	Wed, 11 Dec 2002 17:24:49 GMT
Message-ID: <3DF774DC.3010607@mips.com>
Date: Wed, 11 Dec 2002 17:24:44 +0000
From: Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: GDB patch
References: <15862.15924.283825.28108@hendon.algor.co.uk> <20021210193241.GA15908@nevyn.them.org> <3DF6514E.8040100@mips.com> <20021211165218.GA11767@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:

>>Certainly 'p' is the logical inverse of 'P', so we'll change our gdb 
>>remote stub to use that. So how about accepting Carsten's change, with 
>>the 'R' case removed, and 'r' changed to 'p'?
>>    
>>
>
>Can't do it.  I strongly suspect that it will render the stub unusable
>with current versions of FSF GDB.  Your tools add an explicit size to
>the packet and the community tools do not; so when they probe for and
>discover the P packet, they will probably try to use it and get
>confused.  That's why I'd like to discuss this on the GDB list first.
>  
>

I don't see why it wouldn't work:

1) Existing FSF gdb doesn't use 'p' yet anyway - it will continue to 
work as before, using the 'g' request to fetch all the registers.

2) If and when gdb does use 'p', then there's still no problem - if the 
kernel gdb stub sees a 'p' request without the ":SIZE" extension, it can 
just treat it like the FSF protocol and use the "default" register size.

Nigel
