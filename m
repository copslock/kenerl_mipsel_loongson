Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f82IqF707095
	for linux-mips-outgoing; Sun, 2 Sep 2001 11:52:15 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f82IqCd07091
	for <linux-mips@oss.sgi.com>; Sun, 2 Sep 2001 11:52:12 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7EE52849; Sun,  2 Sep 2001 20:52:07 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E4A2C4637; Sun,  2 Sep 2001 20:29:17 +0200 (CEST)
Date: Sun, 2 Sep 2001 20:29:17 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: George Gensure <werkt@csh.rit.edu>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: xdm bus errors
Message-ID: <20010902202917.B14288@paradigm.rfc822.org>
References: <3B913DF7.6040007@csh.rit.edu> <22645.999376352@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22645.999376352@ocs3.ocs-net>
User-Agent: Mutt/1.3.20i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 02, 2001 at 06:32:32AM +1000, Keith Owens wrote:
> On Sat, 01 Sep 2001 15:58:47 -0400, 
> George Gensure <werkt@csh.rit.edu> wrote:
> >I got this lovely bit of alphanumericism whilst trying to run xdm. 
> > Anyone have any idea how to fix this bus error?
> 
> The first thing to do is run it through ksymoops to decode the numbers
> to symbols.

As its an R5000 (from guessing) this is the random oops of the day 
due to the cacheing issues.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
