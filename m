Received:  by oss.sgi.com id <S554029AbQLBAwD>;
	Fri, 1 Dec 2000 16:52:03 -0800
Received: from u-183-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.183]:57609
        "EHLO u-183-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S554026AbQLBAwA>; Fri, 1 Dec 2000 16:52:00 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869503AbQLBAul>;
	Sat, 2 Dec 2000 01:50:41 +0100
Date:	Sat, 2 Dec 2000 01:50:41 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Calvine Chew <calvine@sgi.com>
Cc:	'linux-mips' <linux-mips@oss.sgi.com>
Subject: Re: Xwindows/XFree86 in HardHat?
Message-ID: <20001202015041.E3211@bacchus.dhis.org>
References: <43FECA7CDC4CD411A4A3009027999112267CB3@sgp-apsa001e--n.singapore.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267CB3@sgp-apsa001e--n.singapore.sgi.com>; from calvine@sgi.com on Fri, Dec 01, 2000 at 02:54:19PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 01, 2000 at 02:54:19PM +0800, Calvine Chew wrote:

> Does HardHat include some form of Xwindows?

Yes; it's X clients plus the virtual servers Xvfb and Xnest.

> There are some xwindows files in the distribution, but I can't fire up
> xwindows (some files seem to be missing). I did notice that HardHat
> included only one XF86 server (XF68_FBDev) but if I used that, startx
> reports a X11TransSocketUNIXConnect errno 146.

The framebuffer server is only used for certain simple framebuffer hardware.
Which the Indy doesn't have.

> Do I need to install the latest XFree86 distribution (4.0.1), or is there
> some other things I can fiddle with in the config files?

Checkout the archives of this list at
http://oss.sgi.com/projects/linux-mips/archive/, there should be a pointer
to the necessary patches for XFree 4.

  Ralf
