Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 02:22:49 +0000 (GMT)
Received: from colo.lackof.org ([198.49.126.79]:8085 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S8133529AbWAQCWb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 02:22:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 3D242360012;
	Mon, 16 Jan 2006 19:35:19 -0700 (MST)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22407-05; Mon, 16 Jan 2006 19:35:15 -0700 (MST)
Received: by colo.lackof.org (Postfix, from userid 27253)
	id D7E24360001; Mon, 16 Jan 2006 19:35:15 -0700 (MST)
Date:	Mon, 16 Jan 2006 19:35:15 -0700
From:	Grant Grundler <grundler@parisc-linux.org>
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
	linux-mips@linux-mips.org, grundler@parisc-linux.org
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-ID: <20060117023515.GB20607@colo.lackof.org>
References: <4393CD9F.3090305@jg555.com> <20051205114456.GA2728@linux-mips.org> <20060116160355.GB28383@deprecation.cyrius.com> <43CBC97E.3090800@jg555.com> <20060116165825.GG5798@deprecation.cyrius.com> <20060116172320.1e6d3cfd.akpm@osdl.org> <43CC4A37.9050502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CC4A37.9050502@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <grundler@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@parisc-linux.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 16, 2006 at 08:36:55PM -0500, Jeff Garzik wrote:
> >Jeff, can you please suggest how this patch should be altered to make it
> >acceptable?
> 
> Answer hasn't changed since this was last discussed:  sleep, rather than 
> delay for an extra-long time.  That's the only hurdle for the tulip 
> patches you keep resending.
> 
> Francois Romieu even had an untested patch that attempted this, somewhere.

Yes, he implemented a workqueue to invoke tulip_select_media().
	http://lkml.org/lkml/2005/5/21/69

His patch didn't deal with the same issue in tulip_restart_rxtx()
as noted here:
	http://lkml.org/lkml/2005/5/22/6

Otherwise, it was mostly ok - just some other nits.
Last reply on that thread was Oct 2005: "an updated version is cooking".

hth,
grant
