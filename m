Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NG2sn13148
	for linux-mips-outgoing; Wed, 23 May 2001 09:02:54 -0700
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NG2rF13145
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 09:02:53 -0700
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id MAA10467;
	Wed, 23 May 2001 12:03:43 -0400
Date: Wed, 23 May 2001 12:03:43 -0400 (EDT)
From: <nick@snowman.net>
X-Sender: nick@ns
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: joshua@babbage.millersv.edu, linux-mips@oss.sgi.com
Subject: Re: wrt irc
In-Reply-To: <20010523085742.B10516@foobazco.org>
Message-ID: <Pine.LNX.4.21.0105231201170.10190-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I agree that the IRIX kernel is horribly obfuscated, however it still
contains valuable information, and in theory can be decoded.  I strongly
suspect this is where harold got much of his information, and if one is
demented enough, and has enough time much can be learned from
it.  Curiousity, what is your goal in asking this?  There is no magic
answer, and it will probably take you months to years if you want to port
something useing just the irix headers.
	Nick

On Wed, 23 May 2001, Keith M Wesolowski wrote:

> On Wed, May 23, 2001 at 11:55:29AM -0400, nick@snowman.net wrote:
> 
> > Most of the important addresses are listed in the irix headers.  With
> > enough hardware and knowledge you can infer how those addresses are used,
> > and I belive he also decompiled the o2's irix kernel.
> 
> Yes, I did; it was a great way to waste a few hours.  Nothing of
> interest came of that.  IRIX seems to have many layers of indirection
> before you actually find the code you want.  Not recommended.
> 
> -- 
> Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
> ------(( Project Foobazco Coordinator and Network Administrator ))------
> 	"Nothing motivates a man more than to see his boss put
> 	 in an honest day's work." -- The fortune file
> 
