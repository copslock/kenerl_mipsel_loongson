Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA09296 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Mar 1999 07:53:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA44780
	for linux-list;
	Tue, 30 Mar 1999 07:52:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA36799;
	Tue, 30 Mar 1999 07:52:35 -0800 (PST)
	mail_from (neuroinc@unidial.com)
Received: from mail.unidial.com (unidial.com [206.112.0.9]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA01076; Tue, 30 Mar 1999 07:52:33 -0800 (PST)
	mail_from (neuroinc@unidial.com)
Received: from unidial.com (root@pool-209-138-15-39.ipls.grid.net [209.138.15.39])
	by mail.unidial.com (8.8.7/ntr.net 3.0.0) with ESMTP id PAA11443;
	Tue, 30 Mar 1999 15:52:15 GMT
Message-ID: <3700EDC0.29E677A4@unidial.com>
Date: Tue, 30 Mar 1999 15:29:04 +0000
From: Alan Hoyt <neuroinc@unidial.com>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        "linux@engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: Port to R3000 Indigo
References: <199903300853.AAA52093@oz.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon wrote:

> I believe this was referred to by Bill Earl in an earlier post.
> Clearly, this needs further explanation.
>
> Since the interfaces with SGI proprietary hardware were never meant
> to be public, the only documentation you can really rely on to be
> accurate and reliable is the (working) IRIX source code.  We would really
> like to avoid publishing material that's incomplete, outdated, and
> turns out to be more confusing than it is worth.
>
> Now, if it were entirely in my hands, I would have gladly published
> some source code.  The problem is much more complex than that.  The
> IRIX source code includes licensed code from many external commercial
> sources, AT&T SVR4, Sun, Xerox, etc. each surrounded by its own complex
> licensing terms, so the lawyers need to look into this lest SGI
> becomes liable by just making some "innocent goodwill" happen.
>
> I know it sounds lame, and I as much as anyone, hate this, but
> this is reality, and it isn't simple as it may appear to some.
> It requires a lot of legal (inspection and clearance) + engineering
> (sanitize and clean up code) time which I'm not sure we can afford
> on a global scale.
>
> The good news is that SGI is clearly putting much more emphasis
> these days on developing hardware that is much more standard
> and opening more and more source code (after legal has looked into
> it and approved it).  Everything we have been doing in the past
> year on the Linux front makes this clear that this is where we're
> going.  I would like to request a bit of patience and support...
> You are preaching to the choir here.
>
> --
> Peace, Ariel

One last question:

I have an old Indigo and Indigo 2 - I am very interested and very serious about
porting Linux to one of these systems.  However, without detailed hardware specs.
a very difficult job becomes much much harder.  Can you throw a dog a bone?  Are
there any hardware specs. (NOT source code) that you are willing and/or capable
of providing at this time to get the ball rolling- without further delays
perpetrated by your legal department?

Thanks

 - Alan Hoyt -
