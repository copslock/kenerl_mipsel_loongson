Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 02:26:19 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.4]:3716 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8133529AbWAQC0B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 02:26:01 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0H2TUDZ029481
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Jan 2006 18:29:31 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k0H2TSLG020912;
	Mon, 16 Jan 2006 18:29:29 -0800
Date:	Mon, 16 Jan 2006 18:29:11 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	Grant Grundler <grundler@parisc-linux.org>
Cc:	jgarzik@pobox.com, tbm@cyrius.com, linux-mips@linux-mips.org,
	grundler@parisc-linux.org, Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-Id: <20060116182911.20bae624.akpm@osdl.org>
In-Reply-To: <20060117023515.GB20607@colo.lackof.org>
References: <4393CD9F.3090305@jg555.com>
	<20051205114456.GA2728@linux-mips.org>
	<20060116160355.GB28383@deprecation.cyrius.com>
	<43CBC97E.3090800@jg555.com>
	<20060116165825.GG5798@deprecation.cyrius.com>
	<20060116172320.1e6d3cfd.akpm@osdl.org>
	<43CC4A37.9050502@pobox.com>
	<20060117023515.GB20607@colo.lackof.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Grant Grundler <grundler@parisc-linux.org> wrote:
>
> On Mon, Jan 16, 2006 at 08:36:55PM -0500, Jeff Garzik wrote:
> > >Jeff, can you please suggest how this patch should be altered to make it
> > >acceptable?
> > 
> > Answer hasn't changed since this was last discussed:  sleep, rather than 
> > delay for an extra-long time.  That's the only hurdle for the tulip 
> > patches you keep resending.
> > 
> > Francois Romieu even had an untested patch that attempted this, somewhere.
> 
> Yes, he implemented a workqueue to invoke tulip_select_media().
> 	http://lkml.org/lkml/2005/5/21/69
> 
> His patch didn't deal with the same issue in tulip_restart_rxtx()
> as noted here:
> 	http://lkml.org/lkml/2005/5/22/6
> 
> Otherwise, it was mostly ok - just some other nits.
> Last reply on that thread was Oct 2005: "an updated version is cooking".
> 

Might help to cc him.

Look, we really don't care who writes the patch.
