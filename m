Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2003 18:49:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:62964 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225234AbTFXRt4>;
	Tue, 24 Jun 2003 18:49:56 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA28001;
	Tue, 24 Jun 2003 10:49:53 -0700
Subject: Re: CVS Update@-mips.org: linux
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030624093157.GA25367@linux-mips.org>
References: <20030624033916Z8224827-1272+2821@linux-mips.org>
	 <20030624093157.GA25367@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1056477065.10455.225.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 10:51:05 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-06-24 at 02:31, Ralf Baechle wrote:
> On Tue, Jun 24, 2003 at 04:39:11AM +0100, ppopov@linux-mips.org wrote:
> 
> > CVSROOT:	/home/cvs
> > Module name:	linux
> > Changes by:	ppopov@ftp.linux-mips.org	03/06/24 04:39:11
> > 
> > Modified files:
> > 	drivers/char   : Tag: linux_2_4 Makefile 
> > 
> > Log message:
> > 	Added au1x00-serial.o to the exports list.
> 
> There doesn't seem to be a good reason to.  Only the register_serial and
> unregister_serial are exported and they don't seem to be called from
> anywhere outside.

Strange, the kernel wouldn't compile without this. I'll try locally to
build it again and see what the problem is and if we can fix it without
modifying the Makefile.

Pete
