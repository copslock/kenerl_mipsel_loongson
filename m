Received:  by oss.sgi.com id <S553682AbRAHWDJ>;
	Mon, 8 Jan 2001 14:03:09 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:4596 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553672AbRAHWDA>; Mon, 8 Jan 2001 14:03:00 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870731AbRAHVxC>; Mon, 8 Jan 2001 19:53:02 -0200
Date:	Mon, 8 Jan 2001 19:53:02 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:	Karsten Merker <karsten@excalibur.cologne.de>,
        linux-mips@oss.sgi.com
Subject: Re: Current CVS kernel no-go on R4k Decstation
Message-ID: <20010108195302.B9198@bacchus.dhis.org>
References: <20010108193010.B887@excalibur.cologne.de> <XFMail.791030042838.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.791030042838.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Tue, Oct 30, 1979 at 04:28:38AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 30, 1979 at 04:28:38AM +0100, Harald Koerfgen wrote:

> > Similar effect for me (DS5000/150, Checkout @ Sat Jan 6 ~22:30 CET),
> > except that I do not get the "illigal instruction" lines. Harald has the
> > same problem on his /260. It looks like sometime in December 2000
> > something has gone broken in the R4K-support, or are we perhaps
> > triggering a compiler bug in egcs 1.1.2?
> 
> I don't think so. This hang appeared in the middle of December and may or may
> not be related to the MIPS32 patches which were commited then. Unfortunately I
> haven't had the time to track this down.
> 
> Anyway, is anybody else with a R4X00 machines seeing this?

I can tell you that this patch provoked other alergic reactions, for example
with the R7000.

  Ralf
