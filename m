Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA04087 for <linux-archive@neteng.engr.sgi.com>; Tue, 19 Jan 1999 19:03:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA77097
	for linux-list;
	Tue, 19 Jan 1999 19:02:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA10703;
	Tue, 19 Jan 1999 19:01:56 -0800 (PST)
	mail_from (job@piquin.uchicago.edu)
Received: from piquin.uchicago.edu (piquin.uchicago.edu [128.135.132.47]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA07073; Tue, 19 Jan 1999 19:01:54 -0800 (PST)
	mail_from (job@piquin.uchicago.edu)
Received: from piquin.uchicago.edu (localhost [127.0.0.1]) by piquin.uchicago.edu (8.9.1b+Sun/8.8.3) with ESMTP id VAA14922; Tue, 19 Jan 1999 21:01:49 -0600 (CST)
Message-Id: <199901200301.VAA14922@piquin.uchicago.edu>
To: offer@morgaine.engr.sgi.com (Richard Offer)
cc: linux@cthulhu.engr.sgi.com, ellidz@eridu.uchicago.edu
Subject: Re: [Fwd: linus.linux.sgi.com] 
In-Reply-To: Message from offer@morgaine.engr.sgi.com (Richard Offer) 
   of "Tue, 19 Jan 1999 18:28:50 PST." <9901191828.ZM20761@morgaine.engr.sgi.com> 
Date: Tue, 19 Jan 1999 21:01:49 -0600
From: job bogan <job@piquin.uchicago.edu>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Your message dated: Tue, 19 Jan 1999 18:28:50 PST

>Well, I couldn't see anything faster than 60ns on Kingstons store.
>http://www.ec.kingston.com/ecom/kepler/specs.asp

100MHz is the bus speed.  to meet that, you need ~5-6ns access times.
Kingston does list 100MHz memory.

>I'd guess that their 10ns is a misprint as its cheap and listed in the PC-66
>section.

look in the PC100 section.  that's the Lintel world acronym for 100MHz
capable ram.  And, yes, it's cheap.  That's the point. =)  If you are
using ECC, the worst i'll see is a hung machine.  and judging by
previous SGI prices, i can buy twice as much 3rd party ram as SGI ram.  

>Isn't 100Mhz and 50ns a measure of two different things ? This is meant as a
>serious question, as I don't know.  But, I'd guess that one is the refresh and
>one the time to access ?

nope.  see the stuff above.  If you want more info, bug me off the list.

>* I might buy some if they are competitive w/ plain old white Linux boxes.
>
>How do you measure 'competitive' ? For me, they aren't; for my next-cubicle
>neighbour they would be. Luckily we don't live in a one size
>(hardware/software) fits all world.

I know, it's a tough question.

Competative, in my realm, is floating point performance based.
Specificly, Big (100's of MB) matrix manipulations.  Lately, generic PCs
and sun E450's have won our $.  Both well outperform SGIs for the
cost. (both O2000 or O200 based.  we have some of each around...)

NT as the only OS for the SGI 540/320 means they are not competitive.
We cannot dedicate, and waste, that much CPU to one person's desktop.
If NT had a good remote user (ssh, telnet, hell a remote queuing system)
interface, we might look at them.  The lack of true multi-user and
non-console interfaces in NT just takes these SGIs off the chart until
linux runs on them.

And once it's there, i see no reason to buy them unless i can get the
Video Performance out of them.  (unless, perhaps, they clean up on raw
cpu due to a cleaned up system bus.)

i've never been the world's biggest SGI/Irix fan. But - for my env., and
most of the Academic world, i just don't see these as viable machines
until Linux or Irix runs on them.  egh...  you may be able to get the
CAD/CAM market back,  but i don't see us buying more SGIs soon.

Anyhow, this is offtopic now.

job

--
John Bogan
Director of Computing					773-702-2588
James Franck Institute				5640 South Ellis Ave
University of Chicago				   Chicago, Il 60637
