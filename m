Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0D7RSX30900
	for linux-mips-outgoing; Sat, 12 Jan 2002 23:27:28 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0D7RQg30897
	for <linux-mips@oss.sgi.com>; Sat, 12 Jan 2002 23:27:26 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 51F4E125CB; Sat, 12 Jan 2002 22:27:21 -0800 (PST)
Date: Sat, 12 Jan 2002 22:27:21 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Robin Humble <rjh@groucho.maths.monash.edu.au>
Cc: linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020112222721.B26661@lucon.org>
References: <20020112092217.A15384@lucon.org> <200201130404.EAA27646@groucho.maths.monash.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201130404.EAA27646@groucho.maths.monash.edu.au>; from rjh@groucho.maths.monash.edu.au on Sun, Jan 13, 2002 at 03:04:35PM +1100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jan 13, 2002 at 03:04:35PM +1100, Robin Humble wrote:
> 
> H.J. writes:
> >On Sun, Jan 13, 2002 at 12:36:21AM +1100, Robin Humble wrote:
> >> >Ok. Please try
> >> >ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/libtool-1.3.5-8.3.src.rpm
> >> unfortunately this doesn't work. Same output as the orig 7.1 rpm or a
> >> stock newer libtool :-/
> >Please tell me how to reproduce it.
> 
> try --rebuild on these for example: imlib, gconf, gnome-python, mozilla.

Do you have something which doesn't use X? I don't have X on my machine.
I need a simple testcase.


H.J.
