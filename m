Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 06:01:33 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2549 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225296AbTJVFBa>;
	Wed, 22 Oct 2003 06:01:30 +0100
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id WAA21338;
	Tue, 21 Oct 2003 22:01:27 -0700
Subject: Re: Au1500 kernel?
From: Pete Popov <ppopov@mvista.com>
To: Greg Herlein <gherlein@herlein.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.44.0310211913380.3164-100000@io.herlein.com>
References: <Pine.LNX.4.44.0310211913380.3164-100000@io.herlein.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066798906.28777.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Oct 2003 22:01:46 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-10-21 at 19:16, Greg Herlein wrote:
> > I think I had the same problem, if I remember correctly, so I used the
> > 2.95 compiler on linux-mips.org.
> 
> Unfortunately when I try to install that it fails due to rpm hell 
> (ie, dependencies).  Sigh.  OK, I can go rebuild it all from 
> source.
> 
> > BTW, only serial console, ethernet, and MTD have been updated in 2.6. I
> > haven't had time for anything else yet, including the 36 bit address
> > support.
> 
> OK, I don't need the latest 2.6 stuff - where can I grab some 
> tarballs of older 2.4 kernels with the mips patches applied - 
> does such a thing exist?

Just grab the latest 2.4 branch, which is linux_2_4. The branch is at
2.4.22, so it's up to date with the 2.4 kernels. The patches in
/pub/linux/mips/people/ppopov should apply cleanly (there are 2.4.21 and
2.4.22 versions of some of the patches). Everything should work well.

Pete
