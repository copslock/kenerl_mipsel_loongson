Received:  by oss.sgi.com id <S305221AbQCaIv6>;
	Fri, 31 Mar 2000 00:51:58 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:6732 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305168AbQCaIvs>;
	Fri, 31 Mar 2000 00:51:48 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA07404; Fri, 31 Mar 2000 00:47:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA34865
	for linux-list;
	Fri, 31 Mar 2000 00:39:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA35342
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 00:39:30 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA09369
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 00:39:28 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id F092F7F3; Fri, 31 Mar 2000 10:39:23 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 420DC8FC3; Fri, 31 Mar 2000 10:29:52 +0200 (CEST)
Date:   Fri, 31 Mar 2000 10:29:52 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: resources.h patch / RLIM_INFINITY __KERNEL__ depend ?
Message-ID: <20000331102952.B273@paradigm.rfc822.org>
References: <20000330142705.B3530@paradigm.rfc822.org> <20000330184715.A1600@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000330184715.A1600@uni-koblenz.de>; from Ralf Baechle on Thu, Mar 30, 2000 at 06:47:15PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Mar 30, 2000 at 06:47:15PM +0200, Ralf Baechle wrote:
> On Thu, Mar 30, 2000 at 02:27:05PM +0200, Florian Lohoff wrote:
> 
> > again - short patch - RLIM_INFINITY - This is also defined in
> > both glibc 2.0 and glibc 2.1 headers so it should be __KERNEL__
> > dependend - Shouldnt it ?
> 
> Glibc 2.1 doesn't include <asm/resource.h>, and 2.0 shouldn't do as well
> as per convention.  So the fix is to copy the necessary definitions from
> kernel headers into glibc headers.
> 
> Thanks for reporting this.  I'm just cooking  a new glibc release ...

My glibc does include asm/resource.h - This is default hardhat (little endian)

resourcebits.h:#include <asm/resource.h>

This is what caused a lot of userspace builts to fail.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
