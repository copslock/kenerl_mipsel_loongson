Received:  by oss.sgi.com id <S553914AbRAYBNa>;
	Wed, 24 Jan 2001 17:13:30 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:17402 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553891AbRAYBNS>;
	Wed, 24 Jan 2001 17:13:18 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0P1ADI17155;
	Wed, 24 Jan 2001 17:10:13 -0800
Message-ID: <3A6F7DC2.C9F60797@mvista.com>
Date:   Wed, 24 Jan 2001 17:13:38 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        Paul Lambert <Paul.Lambert@cosinecom.com>
Subject: Re: MIPS platform recommendations
References: <7EB7C6B62C4FD41196A80090279A29113D7399@exchsrv1.cosinecom.com> <20010124161700.E863@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Wed, Jan 24, 2001 at 11:23:00AM -0800, John Van Horne wrote:
> 
> > Can anyone recommend an R5000/R7000 machine
> > which can run Linux 2.4 and would be an appropriate
> > platform on which to build the libraries for an R5000/R7000
> > embedded Linux application? Which platform has the
> > most stable version of Linux 2.4 available?
> 
> I'm doing all this work on a SGI's Origin 200/2000 series machines.  They
> may be a tad on the expensive side but they're the only thing that avoids
> the major pain of having to modify large amounts of software for propper
> crosscompilation and also has serious compute power.

Yes, that's a pain in the neck. But we already have the entire cross
environment built and available at ftp.mvista.com for both, little and
big endian. The only issue is that test10 and beyond require a slighly
newer tools, but those are coming up as well.  


Pete
