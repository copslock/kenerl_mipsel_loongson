Received:  by oss.sgi.com id <S553750AbQJSW7h>;
	Thu, 19 Oct 2000 15:59:37 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:28156 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553744AbQJSW7Q>;
	Thu, 19 Oct 2000 15:59:16 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9JMvtx08407;
	Thu, 19 Oct 2000 15:57:55 -0700
Message-ID: <39EF7D17.56C8C527@mvista.com>
Date:   Thu, 19 Oct 2000 16:00:39 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: pthread_create() gets BUS ERROR
References: <39EF765A.EC787ED6@mvista.com> <20001020003946.E20887@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Thu, Oct 19, 2000 at 03:31:54PM -0700, Jun Sun wrote:
> 
> > I am running a simple pthread_create() test.  The thread gets created,
> > but the creating thread gets BUS error after the function call.  In
> > fact, it gets SIGUSR1 signal.  Does anybody know what is wrong here?
> >
> > It looks to me that creating thread is waiting for the created thread to
> > start up, but somehow did not install the signal handler correctly!?
> >
> > I am running with the "stable" toolchain that I generated recently,
> > i.e., binutil 2.8.1, egcs 1.0.3a and glibc2.0.6.
> 
> Which libc release exactly?
> 
> I've uploaded another release glibc-2.0.6-7lm to oss:/pub/linux/mips/glibc/.
> In case you're running big endian, could you try that release?
> 
> (Sorry, no source, will upload the srpm tomorrow.)
> 
>   Ralf

I am running little endian - and I am running with my own setup.

Can you post the diff file first?  Assuming no other changes ...

Jun
