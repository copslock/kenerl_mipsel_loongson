Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15G6Si21476
	for linux-mips-outgoing; Tue, 5 Feb 2002 08:06:28 -0800
Received: from chmls05.mediaone.net (chmls05.ne.ipsvc.net [24.147.1.143])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15G6MA21451
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 08:06:22 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls05.mediaone.net (8.11.1/8.11.1) with ESMTP id g15G64u29653;
	Tue, 5 Feb 2002 11:06:05 -0500 (EST)
Date: Tue, 5 Feb 2002 11:06:15 -0500
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: linux-mips@oss.sgi.com
To: Jay Carlson <nop@nop.com>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <7E232BAE-1A4A-11D6-927F-0030658AB11E@nop.com>
Message-Id: <48264C88-1A52-11D6-927F-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tuesday, February 5, 2002, at 10:10 AM, Jay Carlson wrote:

> (Quick background for the list: Because there's such a large code size 
> penalty to PIC/abicalls, I resurrected the bad old Linux/SVR3 
> statically linked, dynamically loaded libraries, which are linked at 
> absolute locations.  Shane Nay took this from a cute demo to a working 
> distribution for the Agenda VR3; Brian Webb helped.  Typical code 
> reduction is ~25-40%, eg 391k->272k.)

Oh yes, performance.  Apps on the Agenda VR3 built in the snow ABI are 
dramatically faster/more responsive.  If you don't believe me, go search 
the agenda-dev list and read the testimonials :-)

I don't fully understand why, though.  Here are my speculations; bear in 
mind that the VR3 and some of the other small boxes have 16-bit memory 
interfaces with small i/d caches.

1) Better icache efficiency.

2) Fewer loads (and stalls) to get typical work done.  In PIC, you need 
a load per symbol reference, and that's every function call.

3) Better dcache efficiency.  The GOT no longer needs to be hit for 
those symbol references.

4) Reduced TLB usage.  The GOT pages for each module are quite hot, so 
now that we're no longer touching them, their 4k (ouch) TLB entries can 
point somewhere more useful.

5) No symbol resolution at load time.  For C++ apps, this can help 
startup a lot.  (prelinking fixes this too)

6) Better scheduling from gcc.  egcs seemed to do a better job of 
arranging loads ahead of use when building non-pic; on the TX39, this 
helps even more due to non-blocking loads.

I dunno.

Jay
