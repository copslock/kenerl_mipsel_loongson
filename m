Received:  by oss.sgi.com id <S553798AbRAYCdU>;
	Wed, 24 Jan 2001 18:33:20 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:59407 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553690AbRAYCdI>;
	Wed, 24 Jan 2001 18:33:08 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id E06C3205FB; Wed, 24 Jan 2001 18:33:02 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Wed, 24 Jan 2001 18:27:20 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id 30F4A1595F; Wed, 24 Jan 2001 18:33:03 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 8FB36686D; Wed, 24 Jan 2001 18:33:28 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
Date:   Wed, 24 Jan 2001 18:33:05 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <3A6F8F66.6258801@mvista.com>
In-Reply-To: <3A6F8F66.6258801@mvista.com>
MIME-Version: 1.0
Message-Id: <0101241833281Q.00834@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 24 Jan 2001, Pete Popov wrote:
> This simple test fails on a Nevada (5231) cpu:
> 
> int main()
> {
>     float x1,x2,x3;
> 
>     x1 = 7.5;
>     x2 = 2.0;
>     x3 = x1/x2;
>     printf("x3 = %f\n", x3);
> }
> 

Ummm...care to tell *how* it fails?

-Justin
