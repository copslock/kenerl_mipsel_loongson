Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BJY8Rw020950
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 12:34:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BJY8OD020949
	for linux-mips-outgoing; Thu, 11 Jul 2002 12:34:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from snog.front.onramp.ca (snog.front.onramp.ca [198.163.180.7])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BJY2Rw020937
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 12:34:03 -0700
Received: (qmail 15217 invoked from network); 11 Jul 2002 19:38:37 -0000
Received: from gateway.hgeng.com (HELO shadowfax.hgeng.com) (199.246.74.82)
  by 0 with SMTP; 11 Jul 2002 19:38:37 -0000
Received: from dilbert.hgeng.com (dilbert.hgeng.com [192.168.1.6])
	by shadowfax.hgeng.com (8.12.1/8.12.1/Debian -3) with ESMTP id g6BJcagO008515
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 15:38:36 -0400
Subject: Re: X server blanking out virtual consoles?
From: Michael Hill <mikehill@hgeng.com>
To: linux-mips@oss.sgi.com
In-Reply-To: <1025794188.10696.205.camel@dilbert>
References: <1025794188.10696.205.camel@dilbert>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1026416316.1138.59.camel@dilbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 11 Jul 2002 15:38:36 -0400
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-07-04 at 10:49, I wrote:

> On Tue, 2002-06-11 at 03:55, Guido Guenther wrote: 

> > Known issue that I really have to debug someday. Until then try the
> > patch by Dominik Behr at:
> >  http://honk.physik.uni-konstanz.de/linux-mips/x/x.html#bugs
> 
> Works brilliantly for me with one small side effect.

Xserver from CVS using Dominik's patch mostly fixes a Window Maker
colour issue with the server from 4.2.0 (similarly patched) on my 8-bit
Indy.  Virtual consoles are visible, wmaker complains like this:

/usr/bin/WindowMaker warning: could not allocate color "rgb:93/0d/29"
/usr/bin/WindowMaker warning: could not get color for key
"CClipTitleColor"
/usr/bin/WindowMaker warning: using default "#454045" instead
/usr/bin/WindowMaker warning: could not allocate color "#454045"
/usr/bin/WindowMaker warning: could not get color for key
"CClipTitleColor"
/usr/bin/WindowMaker warning: could not allocate color "#73091d"
/usr/bin/WindowMaker warning: could not get color for key
"IconTitleBack"
/usr/bin/WindowMaker warning: using default "black" instead

A few of the adornments are indeed black but it's much brighter, and
it's more tolerable than having everything black (Sawfish looks the
same, but it was okay before).  Thanks Guido (and Florian).

Mike
