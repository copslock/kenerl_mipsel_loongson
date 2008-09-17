Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 23:59:23 +0100 (BST)
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:59611 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S36914187AbYIQWzJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 23:55:09 +0100
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id FthL1a0051GXsucA7yv1Us; Wed, 17 Sep 2008 22:55:01 +0000
Received: from darkforest.org ([24.17.204.71])
	by OMTA07.emeryville.ca.mail.comcast.net with comcast
	id Fyuz1a00C1YweuG8Tyv0wx; Wed, 17 Sep 2008 22:55:01 +0000
X-Authority-Analysis: v=1.0 c=1 a=iQfbmxE-p7wREfp1iJgA:9
 a=on3x3uFwuXk1wYIeFU4A:7 a=QPxLmjnllyBTcEqOLXxk8cDah4gA:4 a=1DbiqZag68YA:10
 a=b8hG5vVbyAkA:10
Received: from [10.0.0.153] (dsl081-006-226.sea1.dsl.speakeasy.net [64.81.6.226])
	(authenticated bits=0)
	by darkforest.org (8.13.8/8.13.8) with ESMTP id m8HMsrqG014421;
	Wed, 17 Sep 2008 15:54:58 -0700 (PDT)
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Message-Id: <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org>
From:	Bryan Phillippe <u1@terran.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MIPS checksum bug
Date:	Wed, 17 Sep 2008 15:52:45 -0700
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org> <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org> <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl> <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
X-Mailer: Apple Mail (2.929.2)
Return-Path: <u1@terran.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: u1@terran.org
Precedence: bulk
X-list: linux-mips

Hello All,

I tested the simplified patch below (ADDC32), and it does not address  
the checksum bug.  I suspect the problem is that we're still leaving  
the carry bit in the upper 16 bits of the 32 bit csum returned, and  
this is resulting in a computed checksum that is 1 greater than it  
should be.  The upper 16 bits of the return value of this function  
must be 0, right?

Thanks,
--
-bp


On Sep 17, 2008, at 6:23 AM, Atsushi Nemoto wrote:

> On Wed, 17 Sep 2008 11:40:01 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org 
> > wrote:
>>> and it seems to fix the problem for me.  Can you comment?
>>
>> It seems obvious that a carry from the bit #15 in the last addition  
>> of
>> the passed checksum -- ADDC(sum, a2) -- will negate the effect of the
>> folding.  However a simpler fix should do as well.  Try if the  
>> following
>> patch works for you.  Please note this is completely untested and  
>> further
>> optimisation is possible, but I've skipped it in this version for  
>> clarity.
>
> Well, csum_partial()'s return value is __wsum (32-bit).  So strictly
> there is no need to folding into 16-bit.
>
> I think this bug was introduced by my commit
> ed99e2bc1dc5dc54eb5a019f4975562dbef20103 ("[MIPS] Optimize
> csum_partial for 64bit kernel").  This commit changed ADDC to using
> daddu for 64-bit kernel and that was wrong for the last addition of
> partial csum which should be 32-bit addition.
>
> Here is my proposal fix.  Bryan, could you try it too?
>
> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/ 
> csum_partial.S
> index 8d77841..8b15766 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -60,6 +60,14 @@
> 	ADD	sum, v1;					\
> 	.set	pop
>
> +#define ADDC32(sum,reg)						\
> +	.set	push;						\
> +	.set	noat;						\
> +	addu	sum, reg;					\
> +	sltu	v1, sum, reg;					\
> +	addu	sum, v1;					\
> +	.set	pop
> +
> #define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
> 	LOAD	_t0, (offset + UNIT(0))(src);			\
> 	LOAD	_t1, (offset + UNIT(1))(src);			\
> @@ -280,7 +288,7 @@ LEAF(csum_partial)
> 1:
> 	.set	reorder
> 	/* Add the passed partial csum.  */
> -	ADDC(sum, a2)
> +	ADDC32(sum, a2)
> 	jr	ra
> 	.set	noreorder
> 	END(csum_partial)
> @@ -681,7 +689,7 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
> 	.set	pop
> 1:
> 	.set reorder
> -	ADDC(sum, psum)
> +	ADDC32(sum, psum)
> 	jr	ra
> 	.set noreorder
>
