Received:  by oss.sgi.com id <S553807AbRAYDFv>;
	Wed, 24 Jan 2001 19:05:51 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:6647 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553799AbRAYDFb>;
	Wed, 24 Jan 2001 19:05:31 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0P32QI21008;
	Wed, 24 Jan 2001 19:02:26 -0800
Message-ID: <3A6F9814.3E39027@mvista.com>
Date:   Wed, 24 Jan 2001 19:05:56 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:
> 
> On Wed, 24 Jan 2001, Pete Popov wrote:
> > This simple test fails on a Nevada (5231) cpu:
> >
> > int main()
> > {
> >     float x1,x2,x3;
> >
> >     x1 = 7.5;
> >     x2 = 2.0;
> >     x3 = x1/x2;
> >     printf("x3 = %f\n", x3);
> > }
> >
> 
> Ummm...care to tell *how* it fails?

Looks like there's something more basic that fails here.  This:

#include <stdio.h>
int main()
{
    float x1,x2,x3,x4,x5;

    x1 = 7.5;
    x2 = 2.0;
    x3 = x1/x2;
    x4 = x1*x2;
    x5 = x1-x2;
    printf("x1 %f x2 %f x3 %f x4 %f x5 %f\n", x1, x2, x3, x4, x5);
}


produces this:

sh-2.03# ./fl 
x1 0.000000 x2 0.000000 x3 0.000000 x4 0.000000 x5 0.000000


Pete
