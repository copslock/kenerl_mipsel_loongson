Received:  by oss.sgi.com id <S554010AbRAYUJK>;
	Thu, 25 Jan 2001 12:09:10 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:38919 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S554001AbRAYUIp>;
	Thu, 25 Jan 2001 12:08:45 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id BADA4205FA; Thu, 25 Jan 2001 12:08:39 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Thu, 25 Jan 2001 12:02:56 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id EEB451595F; Thu, 25 Jan 2001 12:08:39 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 90601686D; Thu, 25 Jan 2001 12:09:02 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
Date:   Thu, 25 Jan 2001 12:01:05 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
Cc:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
References: <3A6F8F66.6258801@mvista.com> <0101241917341S.00834@plugh.sibyte.com> <20010125092601.B1026@bacchus.dhis.org>
In-Reply-To: <20010125092601.B1026@bacchus.dhis.org>
MIME-Version: 1.0
Message-Id: <01012512090221.00834@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 25 Jan 2001, Ralf Baechle wrote:
> On Wed, Jan 24, 2001 at 07:16:04PM -0800, Justin Carlson wrote:
> 
> > int main()
> > {
> > 	printf("%f\n", (float)3.14159);
> > }
> 
> Note that above cast is useless; in C all floats are implicitly converted
> to doubles for passing to a varargs function.

Yah, I remembered this after I sent it.  I sometimes get confused with K&R
rules on promotion vs. ANSI, and forgot the varargs handling...

>All MIPS FPUs need it; the architecture specification leaves it to the
>implementor of a CPU which parts of the FP architecture are implemented
>in hardware if at all; the missing parts have to be replaced in
>software.

And here I was remembering the i386 FPU configuration options.  Just spewing
all sorts if incorrect information today!  <sigh>

Thanks for the corrections,
-Justin
