Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 09:41:42 +0000 (GMT)
Received: from mta4-svc.business.ntl.com ([IPv6:::ffff:62.253.164.44]:29641
	"EHLO mta4-svc.business.ntl.com") by linux-mips.org with ESMTP
	id <S8225200AbTBNJll>; Fri, 14 Feb 2003 09:41:41 +0000
Received: from metrowerks.com ([80.1.9.105]) by mta4-svc.business.ntl.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20030214094139.MIYL29609.mta4-svc.business.ntl.com@metrowerks.com>;
          Fri, 14 Feb 2003 09:41:39 +0000
Message-ID: <3E4CABAA.EB496387@metrowerks.com>
Date: Fri, 14 Feb 2003 08:41:14 +0000
From: Stuart Hughes <shughes@metrowerks.com>
Organization: MetroWerks
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sseeger@stellartec.com
CC: 'Jun Sun' <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: NEC VR4181A
References: <02c101c2d362$f9e2eed0$3501a8c0@wssseeger>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <shughes@metrowerks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shughes@metrowerks.com
Precedence: bulk
X-list: linux-mips

Steven Seeger wrote:
> 
> >Osprey uses Vr4181, which is a different chip from vr4181a.
> 
[snip]
> >Interesting.  I was trying to get RT-Linux working at one time
> >but aborted that effort in the middle.
> 
> Getting RTAI working wasn't easy. Took over a week and it was supposedly
> already "ported." One of these days I really must find the time to check in
> my changes to that project. It works very well and is quite stable. I think
> 46 us worst-case interrupt response off one of the VR4181's interrupts from
> an external source is very good.
> 

Hi Steve,

Can you send what you have (or a patch) to Paolo at the rtai mailing
list, then he can merge this in with the existing mips stuff that's in
there.

Regards, Stuart
