Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KJJWh04443
	for linux-mips-outgoing; Fri, 20 Apr 2001 12:19:32 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KJJSM04439
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 12:19:29 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3KJIKq05664;
	Fri, 20 Apr 2001 16:18:20 -0300
Date: Fri, 20 Apr 2001 16:18:20 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
Message-ID: <20010420161820.B5375@bacchus.dhis.org>
References: <20010311191639.A8587@paradigm.rfc822.org> <20010312122134.B1235@bacchus.dhis.org> <20010312144131.C7715@paradigm.rfc822.org> <3AE0885F.D1A3D26@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE0885F.D1A3D26@mvista.com>; from ppopov@mvista.com on Fri, Apr 20, 2001 at 12:05:03PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 20, 2001 at 12:05:03PM -0700, Pete Popov wrote:

> I'm bringing this up again because none of the related patches on this
> topic have been applied to the latest cvs kernel.  The patch Florian
> refers to above oopses for me as well.  This patch below, from Florian,
> but updated against the latest cvs kernel, works (at least the few
> simple tests I've run do work now).  

This patch is broken for small negative numbers in the memory.

Florian now has a better patch that should be correct.

  Ralf
