Received:  by oss.sgi.com id <S42219AbQGWX3q>;
	Sun, 23 Jul 2000 16:29:46 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25692 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42207AbQGWX3T>; Sun, 23 Jul 2000 16:29:19 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA04238
	for <linux-mips@oss.sgi.com>; Sun, 23 Jul 2000 16:34:40 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA48814
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Jul 2000 16:28:36 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-46.karlsruhe.ipdial.viaginterkom.de (u-46.karlsruhe.ipdial.viaginterkom.de [62.180.18.46]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03390
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Jul 2000 16:28:34 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639669AbQGWX2W>;
        Mon, 24 Jul 2000 01:28:22 +0200
Date:   Mon, 24 Jul 2000 01:28:22 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: kmem_alloc: NULL ptr (name=unknown) - is it a serious problem?
Message-ID: <20000724012822.C2678@bacchus.dhis.org>
References: <3979096E.2E11AFA6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3979096E.2E11AFA6@mvista.com>; from jsun@mvista.com on Fri, Jul 21, 2000 at 07:39:42PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jul 21, 2000 at 07:39:42PM -0700, Jun Sun wrote:

> I found a couple of these annoying messages at the beginning of kernel
> startup.  It seems that some subsystems are requesting regions
> (request_region()) before kernel even initialize its memory.
> 
> It appears to me this reservation is just for mutual exclusive access to
> some memory region.  Since I have a static system (no PnP and hot swap
> etc), so I can safely ignore them. 
> 
> Does that make sense?

Not really.  The kernel initializes all devices long after memory
managment, see init/main.c:start_kernel().  So the simple suggestion
would be to delay initialization.

  Ralf
