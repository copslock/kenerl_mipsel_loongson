Received:  by oss.sgi.com id <S42223AbQGAB2H>;
	Fri, 30 Jun 2000 18:28:07 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:6716 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42200AbQGAB1p>;
	Fri, 30 Jun 2000 18:27:45 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA15577
	for <linux-mips@oss.sgi.com>; Fri, 30 Jun 2000 18:22:44 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id SAA30913 for <linux-mips@oss.sgi.com>; Fri, 30 Jun 2000 18:25:58 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA24727
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 30 Jun 2000 18:24:00 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA09261
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jun 2000 18:24:00 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id SAA23174;
	Fri, 30 Jun 2000 18:22:59 -0700
Message-ID: <395D47F2.266CE27D@mvista.com>
Date:   Fri, 30 Jun 2000 18:22:58 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Dominic Sweetman <dom@algor.co.uk>
CC:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, nigel@algor.co.uk
Subject: Re: R5000 support (specifically two-way set-associative cache...)
References: <394EA5A0.B882F66A@mvista.com>
		<200006200947.KAA08574@mudchute.algor.co.uk>
		<394FBAC6.3D29C4A7@mvista.com>
		<394FBF91.76AE6FD0@mvista.com> <200006202059.VAA19304@mudchute.algor.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> Fundamentally:
> 
> o "index" operations just go first through one set, then the other.
>   So long as initialisation routines are applied to each possible
>   index in turn, both sets get initialised.
> 
> o "hit" operations "just work".
> 
> So long as initialisation is done carefully (basic rule: perform one
> stage to the whole cache before going on to the next), run-time cache
> maintenance can and should be done with "hit" instructions, and you
> don't need to worry whether the CPU is direct mapped, 2- or 4-way set
> associative.
> 
> (it's all explained in my book, "See MIPS Run", of course...)
> 
> Even with the Vr5432 you only have to know the difference when first
> setting up the CPU.
> 

Not exactly - the current Linux/MIPS implementation uese index
operations to flush cache.
As a result flush_all_cache() does not really flush all cache.


> Dominic Sweetman
> Algorithmics Ltd

Jun
> dom@algor.co.uk
