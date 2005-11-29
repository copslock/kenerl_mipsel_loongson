Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2005 16:52:10 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:22046 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133755AbVK2Qvx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Nov 2005 16:51:53 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jATGpo95023037;
	Tue, 29 Nov 2005 16:51:50 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jATGpmV1023036;
	Tue, 29 Nov 2005 16:51:48 GMT
Date:	Tue, 29 Nov 2005 16:51:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dan Malek <dan@embeddedalley.com>
Cc:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix board type in db1x00
Message-ID: <20051129165148.GA20402@linux-mips.org>
References: <20051122221526.GZ18119@cosmic.amd.com> <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 22, 2005 at 05:31:20PM -0500, Dan Malek wrote:

> On Nov 22, 2005, at 5:15 PM, Jordan Crouse wrote:
> 
> >+	/* Set the platform # */
> >+#if	defined (CONFIG_MIPS_DB1550)
> >+	mips_machtype = MACH_DB1550;
> >+#elif	defined (CONFIG_MIPS_DB1500)
> >+	mips_machtype = MACH_DB1500;
> >+#elif	defined (CONFIG_MIPS_DB1100)
> >+	mips_machtype = MACH_DB1100;
> >+#else
> >+	mips_machtype = MACH_DB1000;
> >+#endif
> 
> Can't we just do something like
> 	#define MACH_ALCHEMY_TYPE  xxxxx
> 
> in the include files and not have this mess in the
> actual code?  Then, all we have to do here is:
> 
> 	mips_machtype = MACH_ALCHEMY_TYPE;

But we don't have a nice space for this in header files either right now.
So I'll apply this one but if you come up with something better I'll
certainly appreciate it.

  Ralf
