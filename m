Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR7JtJ08561
	for linux-mips-outgoing; Mon, 26 Nov 2001 23:19:55 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAR7Jqo08558
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 23:19:52 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAR6JoL31409;
	Tue, 27 Nov 2001 17:19:50 +1100
Date: Tue, 27 Nov 2001 17:19:50 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011127171950.B29424@dea.linux-mips.net>
References: <20011126204509.A10341@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126204509.A10341@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Nov 26, 2001 at 08:45:09PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 08:45:09PM +0100, Florian Lohoff wrote:

> i guess the RM200 parts are untested for at least a year (possibly
> even more). Does anyone work on this or does know a working
> checkout date ?

I'm only maintaining in the sense of making sure the default configuration
still compiles.  The last kernel I know is working is 2.1.73 which needs
some patches that are not in the standard CVS.  Even if the RM200C is
broken, it's a relativly sane system and so fixing should be fairly easy.

  Ralf
