Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4980RK15926
	for linux-mips-outgoing; Wed, 9 May 2001 01:00:27 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4980DF15914;
	Wed, 9 May 2001 01:00:13 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA11116;
	Wed, 9 May 2001 09:59:56 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id JAA08397;
	Wed, 9 May 2001 09:59:56 +0200 (MET DST)
Date: Wed, 9 May 2001 09:59:55 +0200
From: Tom Appermont <tea@sonycom.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010509095955.A8392@sonycom.com>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010508214313.A12528@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, May 08, 2001 at 09:43:13PM -0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 08, 2001 at 09:43:13PM -0300, Ralf Baechle wrote:
> On Tue, May 08, 2001 at 08:25:18PM +0200, Florian Lohoff wrote:
> 
> > > > compatibility. I read the whole thread on linux-mips but i didnt get the point
> > > > why this has to happen - If we are repairing a real bug for it.
> > > > 
> > > > Could someone please elaborate on whats going on as i feel i missed ~200 mails
> > > > discussion and i dont want to purge the whole debian archive until i know
> > > > what for we actually drop the compatibility.
> > > 
> > > We don't.
> > 
> > Could you explain a bit more - I'd like to understand the whole issue.
> 
> The whole point was to switch from our IRIX ELF flavoured binaries to
> standard ABI ELF.  These two variants are close but not identical which
> for example made modutils missbehave.

What is the current status on this? The patches for the tools are already
integrated in their cvs trees (right?). But I don't think everybody was
happy with this in the end, aspecially the people wearing debian hats. 
Is anybody working on a solution, or are we waiting for the debian people 
to rebuild all the packages?

Tom
