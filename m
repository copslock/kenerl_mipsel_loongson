Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0C6maW11229
	for linux-mips-outgoing; Fri, 11 Jan 2002 22:48:36 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0C6mXg11223
	for <linux-mips@oss.sgi.com>; Fri, 11 Jan 2002 22:48:33 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0C5mV105092;
	Fri, 11 Jan 2002 21:48:31 -0800
Date: Fri, 11 Jan 2002 21:48:31 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Adrian.Hulse@taec.toshiba.com, linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020111214831.A5081@dea.linux-mips.net>
References: <OFBDC20C8C.A135D7FF-ON88256B3E.006DCF0C@taec.com> <20020111120806.A28902@lucon.org> <20020111212620.A4809@dea.linux-mips.net> <20020111214234.A5294@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020111214234.A5294@lucon.org>; from hjl@lucon.org on Fri, Jan 11, 2002 at 09:42:34PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 11, 2002 at 09:42:34PM -0800, H . J . Lu wrote:

> > This bug may result in libraries not getting linked against certain other
> > libraries thus DT_NEEDED entries missing.  Frequently that's harmless but
> > it breaks a few packages.  I remember fixing this in a large number of
> > RH 7.0 packages.
> > 
> > Bug are rarely harmless just their consequences are subtle.
> 
> Ok. Please try
> 
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/libtool-1.3.5-8.3.src.rpm
> 
> You have to rebuild it on your Linux/mips system with
> 
> # su
> # rpm --rebuild libtool-1.3.5-8.3.src.rpm
> 
> Let me know if it works for you.

I'll not be able to test this for several more days as I'm currently in
Sunnyvale.

  Ralf
