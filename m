Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2009 21:46:38 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:33128 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21102852AbZAFVqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2009 21:46:35 +0000
X-IronPort-AV: E=Sophos;i="4.37,221,1231113600"; 
   d="scan'208";a="32901298"
Received: from rtp-dkim-2.cisco.com ([64.102.121.159])
  by rtp-iport-1.cisco.com with ESMTP; 06 Jan 2009 21:46:28 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n06LkRGE029640;
	Tue, 6 Jan 2009 16:46:27 -0500
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n06LkR62004272;
	Tue, 6 Jan 2009 21:46:28 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Jan 2009 16:46:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] MIPS: unsigned result is always greater than 0
Date:	Tue, 6 Jan 2009 16:46:19 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A2896606BB@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <495E2E47.6080605@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MIPS: unsigned result is always greater than 0
Thread-Index: Acls7EfWnUJEqqivROa5wJWiY2zpvQDWuIJg
References: <495E2E47.6080605@gmail.com>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Roel Kluin" <roel.kluin@gmail.com>, <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Jan 2009 21:46:27.0831 (UTC) FILETIME=[3A81C870:01C97048]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1894; t=1231278387; x=1232142387;
	c=relaxed/simple; s=rtpdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20[PATCH]=20MIPS=3A=20unsigned=20result=2
	0is=20always=20greater=20than=200
	|Sender:=20
	|To:=20=22Roel=20Kluin=22=20<roel.kluin@gmail.com>,=20<ralf
	@linux-mips.org>;
	bh=jWocxyxDaCUg6B9soHVdslVwborpn2SdrpMosvPKt5g=;
	b=o1CdR8E+mq0D2iyvmxmn4adI2dGkEh5rR6b5vBKZUAB+3eke1Fsfu3V7Ur
	JmOMaojtM1NG+J0dARJOWvOdwwCevC5Zr3kKpC4h3HCdN4JK6jCIjmYW4mNT
	G1mZm080s4;
Authentication-Results:	rtp-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim2001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Roel Kluin
> Sent: Friday, January 02, 2009 7:10 AM
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org
> Subject: [PATCH] MIPS: unsigned result is always greater than 0
> 
> unsigned result is always greater than 0
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> I cannot determine whether the same bug occurs as well in assembly.
> Also shouldn't similar checks occur in atomic64_sub_return and in
> atomic64_add_return for negative values of i?
> 
> diff --git a/arch/mips/include/asm/atomic.h 
> b/arch/mips/include/asm/atomic.h
> index 1232be3..3cd07a9 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -296,9 +296,10 @@ static __inline__ int 
> atomic_sub_if_positive(int i, atomic_t * v)
>  
>  		raw_local_irq_save(flags);
>  		result = v->counter;
> -		result -= i;
> -		if (result >= 0)
> +		if (i <= result) {
> +			result -= i;
>  			v->counter = result;
> +		}
>  		raw_local_irq_restore(flags);
>  	}
>  
> @@ -677,9 +678,10 @@ static __inline__ long 
> atomic64_sub_if_positive(long i, atomic64_t * v)
>  
>  		raw_local_irq_save(flags);
>  		result = v->counter;
> -		result -= i;
> -		if (result >= 0)
> +		if (i >= result) {
> +			result -= i;
>  			v->counter = result;
> +		}
>  		raw_local_irq_restore(flags);
>  	}

I agree that the code as it exists is wrong, but, as I see it, the
problem is that the type of result should be changed from unsigned long
to int. This fixes the comparison so it works correctly. In addition,
such a change means that result would be the same type as the counter
element of atomic_t, avoiding possible surprises should longs be larger
than ints.
