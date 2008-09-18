Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 05:45:22 +0100 (BST)
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:64203 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S28577086AbYIREpQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 05:45:16 +0100
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id G1mB1a00317UAYkA44l8hx; Thu, 18 Sep 2008 04:45:08 +0000
Received: from darkforest.org ([24.17.204.71])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id G4l71a0051YweuG8Z4l7rB; Thu, 18 Sep 2008 04:45:08 +0000
X-Authority-Analysis: v=1.0 c=1 a=161NQUJDNoXpyuhj_2IA:9
 a=RQPGhOa4WquVVmfzdyAA:7 a=MamjmIKnoj8wCavzHv-SKnDyiV4A:4 a=1DbiqZag68YA:10
 a=c06vB5MgL9cA:10
Received: from asteroid-254.terran (asteroid-254.terran [192.168.216.254])
	(authenticated bits=0)
	by darkforest.org (8.13.8/8.13.8) with ESMTP id m8I4j6Bw019383;
	Wed, 17 Sep 2008 21:45:06 -0700 (PDT)
Cc:	linux-mips@linux-mips.org
Message-Id: <4A385D69-6A36-46B5-84C2-32D4C60C3543@terran.org>
From:	Bryan Phillippe <u1@terran.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MIPS checksum bug
Date:	Wed, 17 Sep 2008 21:43:02 -0700
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org> <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org> <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
X-Mailer: Apple Mail (2.929.2)
Return-Path: <u1@terran.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: u1@terran.org
Precedence: bulk
X-list: linux-mips


FWIW... your patch (below) seems to actually fix the checksum problem  
in my testing.  What was your concern about it?

--
-bp


On Sep 17, 2008, at 3:40 AM, Maciej W. Rozycki wrote:

> On Tue, 16 Sep 2008, Bryan Phillippe wrote:
>
>> I've experimented with the following change:
>>
>> --- /home/bp/tmp/csum_partial.S.orig	2008-09-16 12:01:00.000000000  
>> -0700
>> +++ arch/mips/lib/csum_partial.S	2008-09-16 11:51:44.000000000 -0700
>> @@ -281,6 +281,23 @@
>> 	.set	reorder
>> 	/* Add the passed partial csum.  */
>> 	ADDC(sum, a2)
>> +
>> +	/* fold checksum again to clear the high bits before returning */
>> +	.set	push
>> +	.set	noat
>> +#ifdef USE_DOUBLE
>> +	dsll32	v1, sum, 0
>> +	daddu	sum, v1
>> +	sltu	v1, sum, v1
>> +	dsra32	sum, sum, 0
>> +	addu	sum, v1
>> +#endif
>> +	sll	v1, sum, 16
>> +	addu	sum, v1
>> +	sltu	v1, sum, v1
>> +	srl	sum, sum, 16
>> +	addu	sum, v1
>> +
>> 	jr	ra
>> 	.set	noreorder
>> 	END(csum_partial)
>>
>> and it seems to fix the problem for me.  Can you comment?
>
> It seems obvious that a carry from the bit #15 in the last addition of
> the passed checksum -- ADDC(sum, a2) -- will negate the effect of the
> folding.  However a simpler fix should do as well.  Try if the  
> following
> patch works for you.  Please note this is completely untested and  
> further
> optimisation is possible, but I've skipped it in this version for  
> clarity.
>
> Thanks for raising the issue.
>
>  Maciej
>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> --- a/arch/mips/lib/csum_partial.S	2008-05-05 02:55:23.000000000
> +0000
> +++ b/arch/mips/lib/csum_partial.S	2008-09-17 10:32:37.000000000
> +0000
> @@ -253,6 +253,9 @@ LEAF(csum_partial)
>
> 1:	ADDC(sum, t1)
>
> +	/* Add the passed partial csum.  */
> +	ADDC(sum, a2)
> +
> 	/* fold checksum */
> 	.set	push
> 	.set	noat
> @@ -278,11 +281,8 @@ LEAF(csum_partial)
> 	andi	sum, 0xffff
> 	.set	pop
> 1:
> -	.set	reorder
> -	/* Add the passed partial csum.  */
> -	ADDC(sum, a2)
> 	jr	ra
> -	.set	noreorder
> +	 nop
> 	END(csum_partial)
>
>
