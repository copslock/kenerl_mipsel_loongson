Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 00:39:21 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:15885 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225214AbUHDXjQ>;
	Thu, 5 Aug 2004 00:39:16 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BsVXB-0004A9-00; Thu, 05 Aug 2004 00:51:01 +0100
Received: from kingsx.mips.com ([192.168.192.254] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BsVLT-0007OW-00; Thu, 05 Aug 2004 00:38:55 +0100
Message-ID: <4111739F.8010701@mips.com>
Date: Thu, 05 Aug 2004 00:39:11 +0100
From: Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl> <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl> <20040719213801.GD14931@redhat.com> <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl> <20040723202703.GB30931@redhat.com> <20040723211232.GB5138@linux-mips.org> <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com> <410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com> <410F60DF.9020400@mips.com> <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl> <411148F0.2040605@mips.com> <Pine.LNX.4.58L.0408042239260.11595@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0408042239260.11595@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.712, required 4, AWL,
	BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Maciej W. Rozycki wrote:

>On Wed, 4 Aug 2004, Nigel Stephens wrote:
>
>  
>
>>>Here are my proposals I've referred to previously.  Instruction counts
>>>are 9, 9 and 10, respectively, as I've missed an additional instruction
>>>required to handle shifts by 0 (or actually any multiples of 64). 
>>>      
>>>
>>IMHO handling a shift by zero correctly is important.
>>    
>>
>
> Agreed, hence an additional instruction needed.
>
>  
>
>>>		"not	%1, %3\n\t"
>>>		"srlv	%1, %L2, %1\n\t"
>>>		"srl	%1, %1, 1\n\t"
>>>
>>>      
>>>
>>Why not the shorter:
>>
>>    
>>
>>>		"neg	%1, %3\n\t"
>>>		"srlv	%1, %L2, %1\n\t"
>>>      
>>>
>
> Notice the difference -- this shorter code doesn't handle shifts by zero
>correctly. ;-)
>  
>

Ah yes, I see. I did it with a conditional move to fix up after the 
shift, but same result.

>>And then in __ashrdi3:
>>
>>		"andi	%1, %3, 0x20\n\t"
>>		".set	push\n\t"
>>		".set	noat\n\t"
>>		"sra	$1, %M2, 31\n\t"
>>		"movn	%L0, %M0, %1\n\t"
>>		"movn	%M0, $1, %1\n\t"
>>		".set	pop"
>>
>>Cute, but I think that should be
>>
>>	"sra	$1, %M0, 31\n\t"
>>
>>(i.e %M0 not %M2)
>>    
>>
>
> Well, I've tested it for all shift counts and it works properly as is --
>we care of the value of bit #31 to be shifted only and at this stage it's
>the same in both registers.  So it's just a matter of style.
>
>  
>

OK, I see

Nigel
