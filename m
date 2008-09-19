Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 17:11:46 +0100 (BST)
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:8850 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20321209AbYISQHE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 17:07:04 +0100
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id GaTR1a00C0FhH24A1g6kzT; Fri, 19 Sep 2008 16:06:44 +0000
Received: from darkforest.org ([24.17.204.71])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id Gg6u1a0091YweuG8Ug6vXz; Fri, 19 Sep 2008 16:06:55 +0000
X-Authority-Analysis: v=1.0 c=1 a=OLL_FvSJAAAA:8 a=l8pUnwY1uIyeGwZ2KFwA:9
 a=AOytGTasxAENNLUyIgoA:7 a=V3_9GQRVZhPlHavre7IJUdvRmZoA:4 a=LY0hPdMaydYA:10
Received: from asteroid-254.terran (asteroid-254.terran [192.168.216.254])
	(authenticated bits=0)
	by darkforest.org (8.13.8/8.13.8) with ESMTP id m8JG6rHB007633;
	Fri, 19 Sep 2008 09:06:54 -0700 (PDT)
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Message-Id: <7AC05355-B44A-4AF0-ADF7-A2027781B991@terran.org>
From:	Bryan Phillippe <u1@terran.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0809191315590.29711@cliff.in.clinika.pl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MIPS checksum bug
Date:	Fri, 19 Sep 2008 09:04:47 -0700
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl> <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl> <20080918.002705.78730226.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl> <20080918220734.GA19222@linux-mips.org> <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl> <20080919112304.GB13440@linux-mips.org> <Pine.LNX.4.55.0809191315590.29711@cliff.in.clinika.pl>
X-Mailer: Apple Mail (2.929.2)
Return-Path: <u1@terran.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: u1@terran.org
Precedence: bulk
X-list: linux-mips

On Sep 19, 2008, at 5:26 AM, Maciej W. Rozycki wrote:

> On Fri, 19 Sep 2008, Ralf Baechle wrote:
>
>>> Seriously though, I smell a caller somewhere fails to call  
>>> csum_fold() on
>>> the result obtained from csum_partial() where it should, so it  
>>> would be
>>> good to fix the bug rather than trying to cover it.  Bryan, would  
>>> you be
>>> able to track down the caller?
>>
>> Not quite.  Internally the IP stack maintains the checksum as a 32- 
>> bit
>> value for performance sake.  It only folds it to 16-bit when it has  
>> to.
>
> That's been my understanding from my little investigation yesterday
> evening, but Bryan's problem has come from somewhere after all and
> Atsushi-san's 32-bit addition fix didn't reportedly work while full
> folding did, so I have assumed there must be some dependency somewhere
> where the final folding does not happen.  I have referred to the  
> original
> report concerning SPARC64 now and it seems to narrow the problem  
> down to
> the 32 MSBs only, so I would prefer to have any confusion cleared.
>
> Bryan, can you please verify whether Ralf's fix works for you or not?


Ralph is correct on the usage of the checksum by the IP stack, and the  
original problem report on the Sparc64 list is pretty thorough about  
describing how the bug affects the stack.

original report: http://www.spinics.net/lists/sparclinux/msg00173.html
resolution: http://www.spinics.net/lists/sparclinux/msg00179.html

A synopsis is that when TCP resends a portion of a segment whose  
checksum was already previously calculated (correctly), it splits the  
segment into a new and shortened old segment [see net/ipv4/ 
tcp_output.c:tcp_fragment "Copy and checksum data tail into the new  
buffer" ~ line 737ish].  The new segment has its checksum calculated  
via csum_partial_copy_nocheck(), and the shortened old segment has its  
checksum calculated via csum_block_sub() (for fast checksum delta).   
It is the path through csum_block_sub() where the bug occurs, in which  
the output from csum_block_sub() has the upper bits of the csum set  
for the carry, and later when tcp_v4_send_check() is called with the  
skb->csum, the csum is off-by-one.  Obviously all of these need to be  
in the non-hardware checksum case.

I can test a patch later today on the Cavium CN3010 64bit; I have been  
running with the suboptimal but apparently effective fold-relocation  
patch and the problem is completely gone, fwiw.

Also... I was thinking it would be trivial to extract the relevant  
bits of the trigger from this repro and just write a small native app  
to test the csum generation-and-return; I though about doing it myself  
earlier, because I have a tcpdump capture of the segment that was  
triggering the bug.

--
-bp
