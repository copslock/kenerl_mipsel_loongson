Received:  by oss.sgi.com id <S42247AbQGYXkK>;
	Tue, 25 Jul 2000 16:40:10 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:42029 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42210AbQGYXja>;
	Tue, 25 Jul 2000 16:39:30 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA25012
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 16:31:31 -0700 (PDT)
	mail_from (markp@nmrf.org.au)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA38907
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Jul 2000 16:38:39 -0700 (PDT)
	mail_from (markp@nmrf.org.au)
Received: from gw.cs.nsw.gov.au (gw1.cs.nsw.gov.au [152.76.0.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03746
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jul 2000 16:38:37 -0700 (PDT)
	mail_from (markp@nmrf.org.au)
Received: from funnelweb.cs.nsw.gov.au ([152.76.2.177]) by gw1.gw.cs.nsw.gov.au with ESMTP id <115227>; Wed, 26 Jul 2000 09:43:28 +1000
Received: from nuc130.crg.cs.nsw.gov.au ([152.76.224.253])
          by funnelweb.cs.nsw.gov.au (Post.Office MTA v3.5.1 release 219
          ID# 0-0U10L2S100) with ESMTP id au;
          Wed, 26 Jul 2000 09:38:18 +1000
Received: from nmrf.org.au (really [152.76.85.139]) by nucmed.crg.cs.nsw.gov.au
	via smail with esmtp (ident markp using rfc1413)
	id <m13HFbx-0004JEC@nuc130.crg.cs.nsw.gov.au> (Debian Smail3.2.0.101)
	for <michael.j.lewis@db.com>; Wed, 26 Jul 2000 11:03:49 +1000 (EST) 
Message-ID: <397E28D8.37D77A9A@nmrf.org.au>
From:   Mark Pearson <markp@nmrf.org.au>
Organization: Nuclear Medicine Research Foundation
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     michael.j.lewis@db.com, linux@cthulhu.engr.sgi.com
Subject: Re: SGI-Linux VisualWorkstations
References: <85256927.0048395E.00@nysmtp4001.svc.btco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Jul 2000 09:43:28 +1000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The howto page on the sgi site has moved to
http://oss.sgi.com/www.linux.sgi.com/intel/visws
I use a debian distribution with kernel 2.2.10 on a 320 with 256Mb ram and
the flat panel display.
Xfree 3.3.6 seems to work best and will provide 8 or 16 bit depth. The
main problem I have found (at least under kde and xfree 3.x and 4.x) is
that the mouse focus will not always pass to the window under the cursor,
and some processes have to be killed to release the focus.
The other problem is that every few days the ethernet controller stops
transmitting and must be restarted.

michael.j.lewis@db.com wrote:

> Has anyone managed to get Linux (any distribution) onto the Visual
> Workstation? Personally, had a no. of problems
> with the Visual Workstation and my last gasp effort to use the machine
> (apart from as a dust magnet) is to run Linux on
> them .... any info. pls. let me know. (linux.sgi.com ... used to have a
> couple of pages as I recall, but dont think they are there now....)
>
> rgds & thnks,
>
> Michael L

--
Mark Pearson BSc (Computing) -- Technical and Computer Support
Department of Nuclear Medicine, Concord Hospital
Hospital Road, Concord, NSW  2137, Australia
PH: 61-2-9767 7450 or 61-2-9767 6339  FAX: 61-2-9767 7451
