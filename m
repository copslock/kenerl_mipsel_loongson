Received:  by oss.sgi.com id <S42298AbQFSUXQ>;
	Mon, 19 Jun 2000 13:23:16 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:62470 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42186AbQFSUXE>;
	Mon, 19 Jun 2000 13:23:04 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id NAA27178;
	Mon, 19 Jun 2000 13:22:51 -0700
Date:   Mon, 19 Jun 2000 13:22:51 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Paul Jakma <paul@clubi.ie>
Cc:     Florian Lohoff <flo@rfc822.org>,
        Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: linux/mips on cd?
Message-ID: <20000619132251.D22137@chem.unr.edu>
References: <20000619113148.B691@paradigm.rfc822.org> <Pine.LNX.4.21.0006192034060.8536-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0006192034060.8536-100000@fogarty.jakma.org>; from paul@clubi.ie on Mon, Jun 19, 2000 at 08:39:16PM +0100
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jun 19, 2000 at 08:39:16PM +0100, Paul Jakma wrote:

> i know, i know.. I've read parts of the archive, and have lurked on
> the list for a few months. However, it seems to me the Indy (little
> endian linux/mips, right?) does at least boot and run some userspace
> stuff.

SGI is bigendian. It does boot and there is a userland. I personally
have even seen X working.

> incidentally, i tried booting the 2.2.13 kernel from the website. It
> appeared to work as the PROM downloaded it and didn't complain, but
> it produced absolutely no output. and when i pressed a key it booted
> back to PROM.
> 
> do these kernels require serial console?

I was able to boot those. Hmmm. You can also try the indy kernel at
ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/kernels/ which
should definitely work and support the graphics console, if you have
XL graphics. If you have XZ you are in trouble at the moment.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
