Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OKwg904689
	for linux-mips-outgoing; Wed, 24 Oct 2001 13:58:42 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OKwcD04685
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 13:58:38 -0700
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9OL0YB13623;
	Wed, 24 Oct 2001 14:00:34 -0700
Subject: Re: I am looking for a mips machine
From: Pete Popov <ppopov@mvista.com>
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
In-reply-to: <20011024121944.B6520@lucon.org>
X-Authentication-warning: oss.sgi.com: mail owned process doing -bs
In-Reply-To: 
	<Pine.SGI.4.33.0110241637200.11721-100000@thor.tetracon-eng.net>
References: <Pine.SGI.4.33.0110241637200.11721-100000@thor.tetracon-eng.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.09.08.08 (Preview Release)
Date: 24 Oct 2001 14:00:15 -0700
Message-Id: <1003957215.26240.29.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2001-10-24 at 13:42, J. Scott Kasten wrote:
> 
> My general impression is that your looking for a "FAST" board, and a
> little endian board make for mutually exclusive requirements.  Not that
> little endian couldn't be fast, but just about every piece of hardware
> I've seen running little endian has used one of the lesser mips chips in
> it where they've cut corners multiplexing address and data over the same
> pins and so forth.  Someone correct me if I'm wrong, but of all the ones
> I've looked at, the little endian boards had the less capable hardware to
> boot.  I think that's because the market was being driven by these little
> Win CE things, and CE only supports little endian.

Well, not quite. Linux supports LE too but the choice of LE mips desktop
systems is limited.

The fastest LE cpu/board I've worked with is the Alchemy Au1000 part
running at 396MHz. The board doesn't have and IDE or SCSI controller
though. However, it has pcmcia and we've added support for their pcmcia
controller, so I was able to use a Hitachi 2GB pcmcia ata card (looks
like the IBM Microdrive).  That might be one option for reasonably fast
native compiles.

Pete

> 
> On Wed, 24 Oct 2001, H . J . Lu wrote:
> 
> > On Wed, Oct 24, 2001 at 11:19:27AM -0700, James Simmons wrote:
> > >
> > > I use a Cobalt Qube for alot of my developement. It works fine. I know it
> > > is not in Ralph's tree yet but I plan to send him my work soon.
> >
> > I think Cobalt Qube is slow and is hard to expand the memory. I need at
> > least 128MB RAM. Also the current mips kernel doesn't support it.
> >
> >
> > H.J.
> >
> 
