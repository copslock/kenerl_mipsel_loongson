Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA20608; Thu, 1 Aug 1996 20:38:22 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA23655 for linux-list; Fri, 2 Aug 1996 03:38:15 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA23648 for <linux@cthulhu.engr.sgi.com>; Thu, 1 Aug 1996 20:38:14 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA12032 for <linux@yon.engr.sgi.com>; Thu, 1 Aug 1996 20:36:30 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	 id PAA04878; Fri, 2 Aug 1996 15:37:39 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id PAA16834; Fri, 2 Aug 1996 15:37:38 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9608021537.ZM16832@windy.wellington.sgi.com>
Date: Fri, 2 Aug 1996 15:37:37 +0000
In-Reply-To: ariel@yon.engr.sgi.com (Ariel Faigon)
        "Linux: the next step" (Aug  1, 12:51pm)
References: <199608010048.RAA10293@yon.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: Linux: the next step
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Aug 1, 12:51pm, Ariel Faigon wrote:
> Subject: Linux: the next step
> Hi Linuxies,
>
> So soon the port will be "over".
>
> What's next?
>
> Can we turn this from a neat hacker's adventure into
> something really beneficial to SGI?
>
> Thanks to Larry and David, I started collecting some
> thoughts in:
>
> 	http://info.engr/linux/next-step.html
>

My 2c...maybe it isn't even worth that much!  I know that there is a lot
of politics here, so some of this may be just dreaming....

I'll break it into the same sections as Ariel has:

We need more contributors to keep momentum:

1. We will HAVE to seed machines to people as I'm guessing most people have
   ~$0 budget for hardware.

2. We need to make sure the basic tools (gcc/glibc) make it as seamless
   as possilble to port things (ie, just configure/make and it happens).
   I think David is doing a great job here, but we are probably going to
   need an ongoing effort from a real good libc hacker who can get any
   compatability/conflict type problems sorted intelligently.  What is
   David's commitment when he leaves...or are we going to let him leave??

3. We need to get some of the neat Indy features supported.  We need
   an SGI graphics wizard to make X fly, then things like ISDN and audio.
   These are the sorts of things that will make people want to use Indy's
   as their primary dev environments.  Fast and great functionality.

4. We need to have some people who are able to commit to help contributors
   who need to find out things.  It needs to be easy for people to find out
   information they need.  This is a tricky area as sometimes people really
   will need to know confidential info...how can we handle this.  I know
   Ralph has found it real difficult at times to find things out...we need
   to make this easier so as not to slow things down.

We should start thinking marketing

1. I believe RedHat would be the best candidate for distribution.  I would
   like to see it 'launched' at some high profile conference (Linux related),
   have it on a CD that has 'awesome' artwork (the old WebForce CD's are a
   good example) and becomes a great collectors item afterwards, and is
   packaged with a real cool T-Shirt for the first X copies.  This stuff
   should be firmly Linux relevant from the design point (penguins??) but
   at the same time be SGI through and through.  SGI should probably
   contribute this part.

2. Don't let marketing name it or we'll get Cosmo Linux....just kidding :-)
   I think we need to emphasis that SGI has put real dollars into this and
   is committed to make it work, rather than the 'faster' bandwagon.  To
   emphasis this point I feel we need to have it run on any new platforms
   at first shipment, and support the neat features.  Nothing will kill it
   quicker than if people get this feeling that this is second tier and
   nobody cares.  We need a number of us to commit to give quality help to
   people on mailing lists/newgroups.  Shucks...maybe if we even had 5% of
   the budget IRIX has...

3. Sponsor Linux events etc....give away Indy's etc...and other things like
   apparel and mugs.  These should all have professional art work that is to
   die for....this stuff works when people really want it.  It should really
   put SGI in front of people.  My feeling is that we can really get in front
   of the technical people in a lot of places and get them on our side.
   While they might not be the decision makers, it sure helps sales people
   if the techo's in the organisation are on side rather than fighting
   against you!

4. A Web/FTP server is a great idea.  Let's get some real great design on the
   Web server though so that the quality is similar to Silicon Surf.  Again,
   it gets the message across that we are serious, committed etc.  We also
   want people accessing as many things with .sgi.com in them!!

5. If we can't get people to come to sgi, how about we sponsor good net
   connections for them that are in a domain linux.sgi.com.  Subtle, but it
   does get sgi associated with them on the net....and we do have a backbone
   to most parts of the world.

>
> P.S. I also talked to some people who oppose all this
> so I made their voices heard in:
>
> 	http://info.engr/linux/skeptic.html
>

One comment I would make here is that people really need to work out whether
we are a hardware or software company.  I realise that this is probably
contentious (sp?), but my feeling is that we are a company who make hardware,
and the software is really a means to an end...selling more hardware.  If this
is true, then people need to look at where we are going to get the greatest
number of hardware sales from....Irix or Linux.  We need both I think to hit
different markets, and maybe we even need NT (don't want to get into that
argument!).  Maybe we should be getting agreement from management for funding
based on sales, and I'll bet we can get a lot more mileage from the funding
than Irix will :-)

> I hope you'll find these two mildly interesting.

It's great having someone pull it all together, thanks.

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
