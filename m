Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 16:36:11 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.207]:64845 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465580AbVI3Pfz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 16:35:55 +0100
Received: by zproxy.gmail.com with SMTP id j2so487476nzf
        for <linux-mips@linux-mips.org>; Fri, 30 Sep 2005 08:35:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AekFcibA/x90ZiSqF2tFxyvKqaaQZ/DuLaeruJ1CmVwRKa/X2lELl0JWhbBhadQOzI7t4sBAye8HBnTnF6jrCJWsjpACixz0yVEIhL6YY4vQ9jR9o2GV+4rqIsgQXd5qXvwOaFfrRPGKTFyOl45jfEBhGCPZ2RakZIZ9kZ6Dyeg=
Received: by 10.37.22.45 with SMTP id z45mr3772750nzi;
        Fri, 30 Sep 2005 08:35:48 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Fri, 30 Sep 2005 08:35:48 -0700 (PDT)
Message-ID: <cda58cb80509300835x5f5ede9fg@mail.gmail.com>
Date:	Fri, 30 Sep 2005 17:35:48 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: DISCONTIGMEM suuport on 32 bits MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050930134900.GB3083@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80509260216591eb96b@mail.gmail.com>
	 <20050926122114.GC3175@linux-mips.org>
	 <cda58cb80509260546a6f4118@mail.gmail.com>
	 <20050929235025.GC3983@linux-mips.org>
	 <cda58cb80509300540i7a419fb8u@mail.gmail.com>
	 <20050930134900.GB3083@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/9/30, Ralf Baechle <ralf@linux-mips.org>:
> On Fri, Sep 30, 2005 at 02:40:31PM +0200, Franck wrote:
>
> > > > > IP27 currently the only system that absolutely needs discontiguous
> > > > > memory in order to work at all.  A few other systems could make use of
> > > > > discontiguous memory to reduce the waste of memory - the family of
> > > > > Broadcom SB1 based systems comes to mind.
> > > >
> > > > Isn't discontiguous memory common for embedded system as well ? I
> > > > thought so...Anyways can we make discontiguous memory thing move into
> > > > generic MIPS code so every future needs for that will profit ? I
> > > > looked at other arch, and they seem to implement it that way (in
> > > > arch/xxx/mm/discontig.c).
> > >
> > > Yes, that would be a good thing.  There are several platforms that could
> > > make good use of discontiguous memory support such as Broadcom's Sibyte
> > > SoCs with their insanely large hole in the memory map but also others.
> > >
> >
> > Ok I'll try to do that soon (maybe in 1 or 2 weeks). I looked at the
> > ARM's code and I should be able to do the same on MIPS. Should I keep
> > IP27 data structure and code although ARM's ones seem to be easier to
> > understand ?
>
> The IP27 code is a little obscure which partly is explained by it's age;
> it's been the first NUMA system to be supported in Linux.  After a
> quick look the ARM code seems a little to simple to deal with such a
> system, so I suggest you take a look at arch/ia64/mm/discontig.c instead.
>

Ok, I'll do that.

Thanks
--
               Franck
