Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2004 10:23:16 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:2566 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224936AbUHCJXL>;
	Tue, 3 Aug 2004 10:23:11 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Brvh5-0000pM-00; Tue, 03 Aug 2004 10:34:51 +0100
Received: from kingsx.mips.com ([192.168.192.254] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BrvV5-0003uH-00; Tue, 03 Aug 2004 10:22:27 +0100
Message-ID: <410F5964.3010109@mips.com>
Date: Tue, 03 Aug 2004 10:22:44 +0100
From: Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Sandiford <rsandifo@redhat.com>
CC: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>	<87hds49bmo.fsf@redhat.com>	<Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>	<20040719213801.GD14931@redhat.com>	<Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>	<20040723202703.GB30931@redhat.com>	<20040723211232.GB5138@linux-mips.org>	<Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>	<410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com>
In-Reply-To: <87acxcbxfl.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.85, required 4, AWL,
	BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Richard Sandiford wrote:

>Nigel Stephens <nigel@mips.com> writes:
>  
>
>>I have a patch against gcc-3.4 
>><snip>
>>If people really don't like the inline expansion, then maybe it could be
>>enabled or disabled by a new -m option.
>>    
>>
>
>IMO, controlling with optimize_size would be enough.  
>

Yes, that sounds right.

>But it sounds from
>your description like the patch just adds a new hard-coded multi-insn
>asm string.  Is that right?  If so, I'd really like to avoid that.
>
>  
>

Yes, and I totally agree with you.

>It would much better IMO if we handle this in the target-independent
>parts of the compiler.  We can already open-code certain non-native
>operations, it's "just" that wide shifts are a missing case.
>
>  
>

>If we handle it in a target-independent way, with each insn exposed
>separately, we will be able to optimize special cases better.
>We'll also get the usual scheduling benefits.
>  
>

I agree that we should open-code it for the obvious reasons, but does it 
have to be target independent, or could/should we prototype it with 
define_expand?

Nigel
