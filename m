Received:  by oss.sgi.com id <S42335AbQFTSnJ>;
	Tue, 20 Jun 2000 11:43:09 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42321AbQFTSmo>; Tue, 20 Jun 2000 11:42:44 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA04571
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 11:47:47 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA21859
	for <linux@engr.sgi.com>;
	Tue, 20 Jun 2000 11:42:08 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA00481
	for <linux@engr.sgi.com>; Tue, 20 Jun 2000 11:42:07 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id LAA32681;
	Tue, 20 Jun 2000 11:41:11 -0700
Message-ID: <394FBAC6.3D29C4A7@mvista.com>
Date:   Tue, 20 Jun 2000 11:41:10 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Dominic Sweetman <dom@algor.co.uk>
CC:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, nigel@algor.co.uk
Subject: Re: R5000 support (specifically two-way set-associative cache...)
References: <394EA5A0.B882F66A@mvista.com> <200006200947.KAA08574@mudchute.algor.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Dominic Sweetman wrote:
> 
> Jun Sun (jsun@mvista.com) writes:
> 
> > 2. Specifically, NEC Vr5000 has two-way set-associative cache.  I
> > browsed through the cache code, and got concerned that I don't see any
> > code that seems to take care of that.  Do I miss something?
> 
> The two-way cache on the R5000 (and its R4600 parent) is implemented
> so that the cache operations used during running don't have to know
> about the cache organisation.  Even initialisation of an R5000 cache
> can be done by a piece of code which has no reference to two-wayness
> and just works over R4x00/R5000 CPUs.
> 
> So this is not *necessarily* a problem.
> 

I am not sure here.

Vr5000 uses vAddr:0 (bit 0) to select the way in a set.  I just cannot
imagine how you can invalidate both ways without referring to some
vAddrs that end with 1.

I understand some CPUs (perhaps R4600 is so?) uses the most-significant
bit within the cache line to select the way.  In that case, one can just
treat the line size as half as what the actual line size is, and the
cache can be treated as if they are directed mapped.  But I believe this
can not be the case with Vr5000.

Can someone familiar with R4600 tell us more about how R4600 cache is
setup to hide two-wayness?  Thanks.

Jun
