Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7D50GS29299
	for linux-mips-outgoing; Sun, 12 Aug 2001 22:00:16 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7D50Fj29295
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 22:00:15 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 226513E90; Sun, 12 Aug 2001 21:48:05 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 1877513FD0; Sun, 12 Aug 2001 21:54:43 -0700 (PDT)
Date: Sun, 12 Aug 2001 21:54:42 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Ilya Volynets <ilya@theIlya.com>
Cc: Mark Nellemann <mark@nellemann.nu>,
   linux-mips mail list <linux-mips@oss.sgi.com>
Subject: Re: Is it possible to boot linux on an O2 r5k ?
Message-ID: <20010812215442.C24560@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01081009105200.07543@gateway>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 09:10:52AM -0700, Ilya Volynets wrote:

> Both. The kernel sources for O2 live in cvs.foobazco.org. Also,
> there are LOTS of problems. You will need some extra ethernet
> adapter, for example, since MACE ethernet is not suported. (I am
> working on it at the moment, but don't hold your breath).  NICs that
> are knownw to work: some tulip-based.  NICs that are known not to
> work: 3c905B-TX...

Also eepro100 has worked for me in the past.  Someone should
investigate why the 3c doesn't work; probably the driver is doing
something forbidden.  While we're at it, someone should sync that tree
with oss again.  It doesn't appear likely that I'll be working on it
for some time, if ever.

> Also, things only work uncached.

Well, even then I can't really claim that it "works" for any standard
meaning of the word.  Frankly, I'd rather people start running cached
so that those problems can get fixed, especially since running cached
isn't really *that* much worse anyway.

> As you now understand, O2+Linux is kernel-hacker only toy at the moment.

Isn't that the rule?  Completeness of Linux support is directly
proportional to the degree of obsolescence of the hardware.  You want
full support, just run Irix... it's not like it's windows or anything.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
 	"There is no such song as 'Acid Acid Acid' by 'The Acid Heads'
	 but there might as well be." --jwz
