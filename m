Received:  by oss.sgi.com id <S554045AbRBBJiX>;
	Fri, 2 Feb 2001 01:38:23 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:32519 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554024AbRBBJiO>;
	Fri, 2 Feb 2001 01:38:14 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 95D007F4; Fri,  2 Feb 2001 10:38:01 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3ED40EE9C; Fri,  2 Feb 2001 10:36:07 +0100 (CET)
Date:   Fri, 2 Feb 2001 10:36:07 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Kenneth C Barr <kbarr@MIT.EDU>
Cc:     linux-mips@oss.sgi.com
Subject: Re: netbooting indy
Message-ID: <20010202103607.C18620@paradigm.rfc822.org>
References: <Pine.LNX.4.30.0102010926190.20992-100000@springhead.px.uk.com> <Pine.GSO.4.30L.0102012329020.18202-100000@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30L.0102012329020.18202-100000@biohazard-cafe.mit.edu>; from kbarr@MIT.EDU on Thu, Feb 01, 2001 at 11:39:47PM -0500
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 01, 2001 at 11:39:47PM -0500, Kenneth C Barr wrote:
> 
> 2.  Similar behavior with 3 different ELF kernel images (hardhat,
> vmlinux-indy-2.2.1-990226, and the 2.4.0-test9).  I get the spinning

Ever tried using an ECOFF image ? Some proms cant load elf ..

> 3.  When I specify init=/bin/sh as a parameter, it freezes halfway through
> the kernel download as usual, but on the sniffer, I can see the beginning
> of an NFS conversation.  It looks for /dev/console and then follows
> /bin/sh to bash at which point the SGI starts issuing seemingly malformed
> READ requests.  The NFS server tries to ship it "bash" but the responses
> seemed malformed, too.

This doesnt look like "half way through stop" - This sound like console
setup mismatch - Do you have a Newport GFX Board or something else ? If
something else you have to use Serial Console "console=ttyS0" and
attach a terminal.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
