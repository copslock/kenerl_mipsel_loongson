Received:  by oss.sgi.com id <S305219AbQC3XvN>;
	Thu, 30 Mar 2000 15:51:13 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:50022 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305168AbQC3Xur>;
	Thu, 30 Mar 2000 15:50:47 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA20499; Thu, 30 Mar 2000 15:46:06 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA97112
	for linux-list;
	Thu, 30 Mar 2000 15:37:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA63308
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 30 Mar 2000 15:37:54 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07780
	for <linux@cthulhu.engr.sgi.com>; Thu, 30 Mar 2000 15:37:37 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA06930;
	Fri, 31 Mar 2000 01:37:28 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407781AbQC3QrP>;
	Thu, 30 Mar 2000 18:47:15 +0200
Date:   Thu, 30 Mar 2000 18:47:15 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: resources.h patch / RLIM_INFINITY __KERNEL__ depend ?
Message-ID: <20000330184715.A1600@uni-koblenz.de>
References: <20000330142705.B3530@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000330142705.B3530@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Mar 30, 2000 at 02:27:05PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Mar 30, 2000 at 02:27:05PM +0200, Florian Lohoff wrote:

> again - short patch - RLIM_INFINITY - This is also defined in
> both glibc 2.0 and glibc 2.1 headers so it should be __KERNEL__
> dependend - Shouldnt it ?

Glibc 2.1 doesn't include <asm/resource.h>, and 2.0 shouldn't do as well
as per convention.  So the fix is to copy the necessary definitions from
kernel headers into glibc headers.

Thanks for reporting this.  I'm just cooking  a new glibc release ...

  Ralf
