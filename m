Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f490jVK05799
	for linux-mips-outgoing; Tue, 8 May 2001 17:45:31 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f490jUF05796
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 17:45:30 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f490hDt12538;
	Tue, 8 May 2001 21:43:13 -0300
Date: Tue, 8 May 2001 21:43:13 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010508214313.A12528@bacchus.dhis.org>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010508202518.A13476@paradigm.rfc822.org>; from flo@rfc822.org on Tue, May 08, 2001 at 08:25:18PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 08, 2001 at 08:25:18PM +0200, Florian Lohoff wrote:

> > > compatibility. I read the whole thread on linux-mips but i didnt get the point
> > > why this has to happen - If we are repairing a real bug for it.
> > > 
> > > Could someone please elaborate on whats going on as i feel i missed ~200 mails
> > > discussion and i dont want to purge the whole debian archive until i know
> > > what for we actually drop the compatibility.
> > 
> > We don't.
> 
> Could you explain a bit more - I'd like to understand the whole issue.

The whole point was to switch from our IRIX ELF flavoured binaries to
standard ABI ELF.  These two variants are close but not identical which
for example made modutils missbehave.

  Ralf
