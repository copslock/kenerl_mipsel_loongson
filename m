Received:  by oss.sgi.com id <S553746AbQJSWk1>;
	Thu, 19 Oct 2000 15:40:27 -0700
Received: from u-176.karlsruhe.ipdial.viaginterkom.de ([62.180.19.176]:32015
        "EHLO u-176.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553743AbQJSWkN>; Thu, 19 Oct 2000 15:40:13 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870161AbQJSWjq>;
        Fri, 20 Oct 2000 00:39:46 +0200
Date:   Fri, 20 Oct 2000 00:39:46 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: pthread_create() gets BUS ERROR
Message-ID: <20001020003946.E20887@bacchus.dhis.org>
References: <39EF765A.EC787ED6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39EF765A.EC787ED6@mvista.com>; from jsun@mvista.com on Thu, Oct 19, 2000 at 03:31:54PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 19, 2000 at 03:31:54PM -0700, Jun Sun wrote:

> I am running a simple pthread_create() test.  The thread gets created,
> but the creating thread gets BUS error after the function call.  In
> fact, it gets SIGUSR1 signal.  Does anybody know what is wrong here?
> 
> It looks to me that creating thread is waiting for the created thread to
> start up, but somehow did not install the signal handler correctly!?
> 
> I am running with the "stable" toolchain that I generated recently,
> i.e., binutil 2.8.1, egcs 1.0.3a and glibc2.0.6.

Which libc release exactly?

I've uploaded another release glibc-2.0.6-7lm to oss:/pub/linux/mips/glibc/.
In case you're running big endian, could you try that release?

(Sorry, no source, will upload the srpm tomorrow.)

  Ralf
