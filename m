Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7KhnZ22511
	for linux-mips-outgoing; Fri, 7 Dec 2001 12:43:49 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7Khko22508
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 12:43:46 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fB7Jhh504444;
	Fri, 7 Dec 2001 14:43:43 -0500
Date: Fri, 7 Dec 2001 14:43:43 -0500
From: Jim Paris <jim@jtan.com>
To: Justin Carlson <justinca@ri.cmu.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Message-ID: <20011207144343.A4417@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011207121416.A9583@dev1.ltc.com> <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be> <20011207123833.A23784@nevyn.them.org> <20011207160636.B23798@dea.linux-mips.net> <20011207131521.A3942@neurosis.mit.edu> <1007753789.1680.1.camel@GLOVEBOX.AHS.RI.CMU.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1007753789.1680.1.camel@GLOVEBOX.AHS.RI.CMU.EDU>; from justinca@ri.cmu.edu on Fri, Dec 07, 2001 at 02:36:28PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Maybe I missed this, but is there any reason for the patch, other then 
> a personal preference of how to do macros that look like functions? 
> I've seen gcc do strange non-optimal things with functions declared
> inlines, but I've never seen it generate bad code WRT to do{}while(0)
> constructs.
> 
> Unless I'm missing something, this patch looks like a solution in search
> of a problem...

In the case of set_io_port_base, I see no real reason.  But for the
out[b,w,l] functions, having the do/while can prevent constructs that
might otherwise make sense, like

	for(i=0;i<10;i++,outb(i,port)) {
           ...
        }

Okay, so it's a bad example, but.. :)  Maybe Brad has a better one.

-jim
