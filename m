Received:  by oss.sgi.com id <S553939AbRAYDRU>;
	Wed, 24 Jan 2001 19:17:20 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:16144 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553813AbRAYDRO>;
	Wed, 24 Jan 2001 19:17:14 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 9DD36205FA; Wed, 24 Jan 2001 19:17:08 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Wed, 24 Jan 2001 19:11:26 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id 08DBE1595F; Wed, 24 Jan 2001 19:17:09 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 7C3F7686D; Wed, 24 Jan 2001 19:17:34 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Pete Popov <ppopov@mvista.com>
Subject: Re: floating point on Nevada cpu
Date:   Wed, 24 Jan 2001 19:16:04 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F9814.3E39027@mvista.com>
In-Reply-To: <3A6F9814.3E39027@mvista.com>
MIME-Version: 1.0
Message-Id: <0101241917341S.00834@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 24 Jan 2001, Pete Popov wrote:

> Looks like there's something more basic that fails here.  This:
> 
> #include <stdio.h>
> int main()
> {
>     float x1,x2,x3,x4,x5;
> 
>     x1 = 7.5;
>     x2 = 2.0;
>     x3 = x1/x2;
>     x4 = x1*x2;
>     x5 = x1-x2;
>     printf("x1 %f x2 %f x3 %f x4 %f x5 %f\n", x1, x2, x3, x4, x5);
> }
> 
> 
> produces this:
> 
> sh-2.03# ./fl 
> x1 0.000000 x2 0.000000 x3 0.000000 x4 0.000000 x5 0.000000
> 

Try this:

int main()
{
	printf("%f\n", (float)3.14159);
}

If *that* fails, check your libraries and make sure the calling conventions,
etc. match what you think they should be...

-Justin
