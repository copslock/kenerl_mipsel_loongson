Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARNCvT01940
	for linux-mips-outgoing; Tue, 27 Nov 2001 15:12:57 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fARNCto01937
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 15:12:55 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fARMCmS24215;
	Wed, 28 Nov 2001 09:12:48 +1100
Date: Wed, 28 Nov 2001 09:12:48 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011128091248.A24032@dea.linux-mips.net>
References: <20011126204509.A10341@paradigm.rfc822.org> <20011127171950.B29424@dea.linux-mips.net> <20011127173947.B11918@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127173947.B11918@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Nov 27, 2001 at 05:39:47PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 05:39:47PM +0100, Florian Lohoff wrote:

> On Tue, Nov 27, 2001 at 05:19:50PM +1100, Ralf Baechle wrote:
> > I'm only maintaining in the sense of making sure the default configuration
> > still compiles.  The last kernel I know is working is 2.1.73 which needs
> > some patches that are not in the standard CVS.  Even if the RM200C is
> > broken, it's a relativly sane system and so fixing should be fairly easy.
> 
> BTW: Do you still have those patches ?

Yes, on a machine that is on the other side of the globe ...  As I remember
those patches were mostly stuff like endianess fixes to the NCR driver
which is looking very different today.  Nothing that would still apply
these days.

  Ralf
