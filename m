Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f419v6015640
	for linux-mips-outgoing; Tue, 1 May 2001 02:57:06 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65] (may be forged))
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f419v5M15637
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 02:57:05 -0700
Received: from scotty.mgnet.de (pD957B425.dip.t-dialin.net [217.87.180.37])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id LAA29019
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 11:57:03 +0200 (MET DST)
Received: (qmail 21348 invoked from network); 1 May 2001 09:57:02 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 1 May 2001 09:57:02 -0000
Date: Tue, 1 May 2001 11:57:02 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Carsten Langgaard <carstenl@mips.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Login problem on a serial console
In-Reply-To: <3AEE84F8.6BC907A7@mips.com>
Message-ID: <Pine.LNX.4.21.0105011155170.12400-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 1 May 2001, Carsten Langgaard wrote:

> I have just upgraded my kernel sources from 2.4.1 to the latest 2.4.3
> sources, but after doing that I can't login on my serial console. It get
> all the way up to the login prompt, but nothing happens when I try to
> press a key.  So I figure that the serial line worked one way.
> I have tried using a single shell (booted with "init=/bin/sh") and that
> seemed to work fine, so I guess the serial driver works fine.
> 
> I'm running on both an Atlas and a Malta board, both seem to have the
> same problem.
> Has anyone any ideas ?

I think this has something to do with the fixes Bachus commited
lately. I think he changed something which made some getty's
not work anymore. Can you try an other getty ?

		Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
