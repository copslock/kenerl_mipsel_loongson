Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0EIoZw17344
	for linux-mips-outgoing; Mon, 14 Jan 2002 10:50:35 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0EIoWg17339
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 10:50:32 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2461B125C1; Mon, 14 Jan 2002 09:50:28 -0800 (PST)
Date: Mon, 14 Jan 2002 09:50:28 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Robin Humble <rjh@groucho.maths.monash.edu.au>, linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020114095028.C30946@lucon.org>
References: <20020112222721.B26661@lucon.org> <Pine.GSO.3.96.1020114123630.10091C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020114123630.10091C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 14, 2002 at 12:44:29PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 14, 2002 at 12:44:29PM +0100, Maciej W. Rozycki wrote:
> On Sat, 12 Jan 2002, H . J . Lu wrote:
> 
> > > try --rebuild on these for example: imlib, gconf, gnome-python, mozilla.
> > 
> > Do you have something which doesn't use X? I don't have X on my machine.
> > I need a simple testcase.
> 
>  FYI, I've put mipsel-linux-XFree86-3.3.6-2.src.rpm and
> mipsel-linux-XFree86*-3.3.6-2.i386.rpm cross-compilation packages at my
> site recently.  Standard development libraries take only 6MB of disk space
> with extra 4MB needed for additional static ones. 

I should have made myself clearer. I do have X rpms. In fact, my RedHat
7.1 mips port has XFree86 4.1 rpms. I just don't use them on my machine.
I simply can't afford to put X on it. My mips box is used to track gcc
3.1, which breaks on Linux/mips almost every week, if not everyday. It
takes 2 days for me bootstrap/check gcc 3.1 on that box. I need
something simple to reproduce it.


H.J.
