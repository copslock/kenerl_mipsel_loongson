Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDF7in06338
	for linux-mips-outgoing; Thu, 13 Dec 2001 07:07:44 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDF7fo06334
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 07:07:41 -0800
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 16EWWR-00049G-00; Thu, 13 Dec 2001 15:07:39 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16EWVD-0003UE-00; Thu, 13 Dec 2001 15:06:23 +0100
Date: Thu, 13 Dec 2001 15:06:22 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: Current CVS on Indigo2 fail
Message-ID: <20011213150622.A13394@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20011213123522.GA32232@paradigm.rfc822.org> <20011213135229.C14699@gandalf.physik.uni-konstanz.de> <20011213134827.GA5630@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213134827.GA5630@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Dec 13, 2001 at 02:48:27PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 02:48:27PM +0100, Florian Lohoff wrote:
> On Thu, Dec 13, 2001 at 01:52:29PM +0100, Guido Guenther wrote:
> > On Thu, Dec 13, 2001 at 01:35:22PM +0100, Florian Lohoff wrote:
> > > 
> > > HI,
> > > i just tried to boot the current cvs as of a couple minutes old
> > > on an Indigo2 - It seemt the stuff crashes before its even able to
> > > print something on the screen.
> > > 
> > Can this be the newport vs. I2 issue? I have (again) sent patches to Ralf
> > to solve this problem...
> 
> Definitly ? Mind sending me (the list) the patches too ?
an old version is at:
 http://honk.physik.uni-konstanz.de/~agx/linux-mips/unsorted-patches/newport-dont-crash-i2-2001-03-25.diff
This currently doesn't apply cleanly due to the arch/mips/kernel/sgi to
arch/mips/sgi-ip22 movement, but that's just a one line change. I'll
update it when back home.
 -- Guido
