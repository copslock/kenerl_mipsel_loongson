Received:  by oss.sgi.com id <S553809AbRAYDNU>;
	Wed, 24 Jan 2001 19:13:20 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:13328 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553805AbRAYDNJ>;
	Wed, 24 Jan 2001 19:13:09 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id EE675205FB; Wed, 24 Jan 2001 19:13:03 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Wed, 24 Jan 2001 19:07:21 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id 57E601595F; Wed, 24 Jan 2001 19:13:04 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 9C430686D; Wed, 24 Jan 2001 19:13:29 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Pete Popov <ppopov@mvista.com>
Subject: Re: floating point on Nevada cpu
Date:   Wed, 24 Jan 2001 18:57:04 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F94E0.4AB07CEB@mvista.com>
In-Reply-To: <3A6F94E0.4AB07CEB@mvista.com>
Cc:     linux-mips@oss.sgi.com <linux-mips@oss.sgi.com>
MIME-Version: 1.0
Message-Id: <0101241913291R.00834@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 24 Jan 2001, you wrote:
> Justin Carlson wrote:
> > 
> > On Wed, 24 Jan 2001, Pete Popov wrote:
> > > This simple test fails on a Nevada (5231) cpu:
> > >
> > > int main()
> > > {
> > >     float x1,x2,x3;
> > >
> > >     x1 = 7.5;
> > >     x2 = 2.0;
> > >     x3 = x1/x2;
> > >     printf("x3 = %f\n", x3);
> > > }
> > >
> > 
> > Ummm...care to tell *how* it fails?
> 
> Here it is:
> 
> sh-2.03# ./fl
> x3 = 0.000000
> 
> 
> I'm running a test9 based kernel, but the same kernel compiled for my
> Indigo2 produces the right result.  

Hmmm...the only thing here that should involve kernel support is the lazy FPU
register saving.   I'm not terribly familiar with that portion of the kernel,
but it should take an unimplemented instruction trap on the first fpu op, set
up a flag for saving FP state on context switches, enable the FPU, then let the
program run.  From what I *have* seen of that code, it's shared between many
processors; doesn't seem like a likely candidate for such a simple problem.

If you compile that code snippet and optimize it with gcc, you actually won't
invoke any fpu ops, as gcc is smart enough to precalculate the result, and
just load that before jumping to printf().

How are you compiling the code?  And are you compiling it the same way on both
platforms?  Do you have fpu emulation enabled on a kernel that doesn't need it? 

These are the potential problems that jump to mind...

-Justin
