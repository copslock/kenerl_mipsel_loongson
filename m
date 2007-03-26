Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 23:39:11 +0100 (BST)
Received: from mail.hcrest.com ([12.173.51.131]:33073 "EHLO mail.hcrest.com")
	by ftp.linux-mips.org with ESMTP id S20022763AbXCZWjJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 23:39:09 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flush_anon_page for MIPS
Date:	Mon, 26 Mar 2007 18:38:42 -0400
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF6CD4AA@MAILSERV.hcrest.com>
In-Reply-To: <20070326140542.GA14354@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: flush_anon_page for MIPS
Thread-Index: Acdvr+MldaVjQjb1Q5S/w84d7Qm9/QARk21g
From:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"David Daney" <ddaney@avtrex.com>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, <miklos@szeredi.hu>,
	<linux-mips@linux-mips.org>
Return-Path: <Ravi.Pratap@hillcrestlabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ravi.Pratap@hillcrestlabs.com
Precedence: bulk
X-list: linux-mips

> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Monday, March 26, 2007 10:06 AM
> To: Ravi Pratap
> Cc: David Daney; Atsushi Nemoto; miklos@szeredi.hu; 
> linux-mips@linux-mips.org
> Subject: Re: flush_anon_page for MIPS
> 
> On Mon, Mar 26, 2007 at 09:33:10AM -0400, Ravi Pratap wrote:
> 
> > 
> > Yes, but isn't it a lot of work considering the lack of a 
> > flush_anon_page in 2.6.15?
> 
> David wrote about forward porting the patches in your vendor 
> kernel to a more modern kernel.  That would require some work but the
> flush_anon_page() thing would be the least of your worries.
> 
> Otherwise, you'd need to backport the about following 
> changesets into your kernel to get flush_anon_page:
> 
> 03beb07664d768db97bf454ae5c9581cd4737bb4
> df7c814ea6385fea8ccf54c80ec78326f78b743e
> f036773e8760a79ad9fdeea6665f86d3493d40d1
> 4c40981a5c0fe1ee5c755a55a4a8e5e3527f0bca
> 

Thanks for the info. I think I'm going to go with backporting these
changesets for now while still talking to the vendors about upgrading
their kernel. The problem is that these guys are just notoriously slow
and we have work to get done :-)


Ravi.
