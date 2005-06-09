Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 11:11:01 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:5917 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225601AbVFMKKq>; Mon, 13 Jun 2005 11:10:46 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5DA84Ob011259;
	Mon, 13 Jun 2005 11:08:04 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j59M1lv1004830;
	Thu, 9 Jun 2005 23:01:47 +0100
Date:	Thu, 9 Jun 2005 23:01:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ton Truong <ttruong@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Member sc_sigset gone in latest 2.6.12-rc5 breaks strace.
Message-ID: <20050609220147.GA4802@linux-mips.org>
References: <20050606121640.GB6651@linux-mips.org> <200506091737.KAA22310@mon-irva-10.broadcom.com> <20050609204937.GK4927@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609204937.GK4927@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 09, 2005 at 09:49:37PM +0100, Ralf Baechle wrote:

> > I see that in the rc5 update, MIPS codes have now dropped 
> > sc_sigset[4] from struct sigcontext, defined in asm-mips/sigcontext.h.  I'd
> > appreciate it if someone provide a brief summary of what needs to be changed
> > for strace to compile or where I can find an strace port that work with the
> > new MIPS codes?
> 
> sc_sigset and the other members that were changed have been unused by the
> kernel since a very, very long time so whatever strace may have done with
> that field was probably bogus.
> 
> Thanks for reporting, something I'm going to look at tomorrow.

Ok, it was just too trivial.  Here's an untested patch.

  Ralf

 signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: strace-cvs/signal.c
===================================================================
--- strace-cvs.orig/signal.c	2005-06-09 22:56:14.000000000 +0100
+++ strace-cvs/signal.c	2005-06-09 22:56:27.000000000 +0100
@@ -1420,7 +1420,7 @@
 		if (umove(tcp, sp, &sc) < 0)
 		  	return 0;
 		tcp->u_arg[0] = 1;
-		tcp->u_arg[1] = sc.sc_sigset;
+		tcp->u_arg[1] = &sc + 1;
 	} else {
 	  	tcp->u_rval = tcp->u_error = 0;
 		if(tcp->u_arg[0] == 0)
