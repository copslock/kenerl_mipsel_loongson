Received:  by oss.sgi.com id <S553807AbRAXUaH>;
	Wed, 24 Jan 2001 12:30:07 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:8947 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553801AbRAXU3u>;
	Wed, 24 Jan 2001 12:29:50 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0OKQdI03997;
	Wed, 24 Jan 2001 12:26:39 -0800
Message-ID: <3A6F3B50.C721F304@mvista.com>
Date:   Wed, 24 Jan 2001 12:30:08 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     John Van Horne <JohnVan.Horne@cosinecom.com>
CC:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        Paul Lambert <Paul.Lambert@cosinecom.com>
Subject: Re: MIPS platform recommendations
References: <7EB7C6B62C4FD41196A80090279A29113D7399@exchsrv1.cosinecom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> John Van Horne wrote:
> 
> Hello,
> 
> Can anyone recommend an R5000/R7000 machine
> which can run Linux 2.4 and would be an appropriate
> platform on which to build the libraries for an R5000/R7000
> embedded Linux application? Which platform has the
> most stable version of Linux 2.4 available?

The EV96100 (PMC RM7000 cpu) might do the job. It's overall stable and
runs with primary and secondary caches turned on.  I merged a network
fix yesterday so I need to do a new kernel release and uploaded it to
ftp.mvista.com. The previous kernel with the network bug is on the ftp
site already.

However, if you're only interested in rebuilding libraries for those
cpus, why not do a cross-build?  We cross build all userland apps
including the libraries.  

Pete
