Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0S3dMK30640
	for linux-mips-outgoing; Sun, 27 Jan 2002 19:39:22 -0800
Received: from cast-ext.ab.videon.ca (cast-ext.ab.videon.ca [206.75.216.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0S3dKP30637
	for <linux-mips@oss.sgi.com>; Sun, 27 Jan 2002 19:39:20 -0800
Received: (qmail 7234 invoked from network); 28 Jan 2002 02:39:19 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by cast-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <mdharm@momenco.com>; 28 Jan 2002 02:39:19 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16V1hV-0006rN-00; Sun, 27 Jan 2002 19:39:17 -0700
Date: Sun, 27 Jan 2002 19:39:17 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: Matthew Dharm <mdharm@momenco.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Help with OOPSes, anyone?
In-Reply-To: <20020127142657.C18041@momenco.com>
Message-ID: <Pine.LNX.3.96.1020127163608.6344C-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Sun, 27 Jan 2002, Matthew Dharm wrote:

> Interesting... did you try the 2.4.17 that's in the SGI CVS?  That's what
> I'm using....

Hmm. Woops. Wrong CVS tag.

Right, 2.4.17 out of CVS w/ my patch set is working OK, at least it
compiles ncftp, and runs my usual gamut of things.

I'll send you my modified cache code..

Jason
