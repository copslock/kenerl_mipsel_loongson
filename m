Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CFnKRw007172
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 08:49:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CFnK6K007171
	for linux-mips-outgoing; Fri, 12 Jul 2002 08:49:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from snog.front.onramp.ca (snog.front.onramp.ca [198.163.180.7])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CFnFRw007159
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 08:49:15 -0700
Received: (qmail 21547 invoked from network); 12 Jul 2002 15:53:52 -0000
Received: from gateway.hgeng.com (HELO shadowfax.hgeng.com) (199.246.74.82)
  by 0 with SMTP; 12 Jul 2002 15:53:52 -0000
Received: from dilbert.hgeng.com (dilbert.hgeng.com [192.168.1.6])
	by shadowfax.hgeng.com (8.12.1/8.12.1/Debian -3) with ESMTP id g6CFidgO011142
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 11:44:39 -0400
Subject: Re: X server blanking out virtual consoles?
From: Michael Hill <mikehill@hgeng.com>
To: linux-mips@oss.sgi.com
In-Reply-To: <20020712075549.GA1569@bogon.ms20.nix>
References: <20020712075549.GA1569@bogon.ms20.nix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1026488672.7814.115.camel@dilbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 12 Jul 2002 11:44:33 -0400
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2002-07-12 at 03:55, Guido Guenther wrote:

> On Thu, Jul 11, 2002 at 03:38:36PM -0400, Michael Hill wrote:
> > /usr/bin/WindowMaker warning: could not allocate color "rgb:93/0d/29"
> > etc

> This is possibly as close as one can get with 8bpp.

I spoke too quickly:  even these go away when wmaker is launched from
the display manager, rather than from sawfish.  CVS Xserver + Dominik's
patch = works as expected.

Mike
