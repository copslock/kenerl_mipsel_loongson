Received:  by oss.sgi.com id <S554209AbRASLE3>;
	Fri, 19 Jan 2001 03:04:29 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:20743 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554204AbRASLEN>;
	Fri, 19 Jan 2001 03:04:13 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0A5CB7F4; Fri, 19 Jan 2001 12:04:10 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 00372F59A; Fri, 19 Jan 2001 11:58:05 +0100 (CET)
Date:   Fri, 19 Jan 2001 11:58:05 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     K.H.C.vanHouten@kpn.com
Cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>,
        Rasmus Andersen <rasmus@jaquet.dk>,
        K.H.C.vanHouten@research.kpn.com
Subject: Re: [PATCH] make drivers/scsi/dec_esp.c check request_irq return code (240p3) (fwd)
Message-ID: <20010119115805.I29515@paradigm.rfc822.org>
References: <Pine.LNX.4.05.10101190931310.27117-100000@callisto.of.borg> <200101190840.JAA13979@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101190840.JAA13979@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Fri, Jan 19, 2001 at 09:40:44AM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 19, 2001 at 09:40:44AM +0100, Houten K.H.C. van (Karel) wrote:
> Hi all,
> 
> Would this be the cause of the problem I have in my 5000/260
> that I can only use the on-board SCSI interface, and not
> the TC scsi card (which should use the same driver)?
> 
> I hope to be able to test this patch this weekend!

I dont think so - The addtional cards have been broken since early
2.4.0 and i tried once to fix it and clean up the spaghetti stuff
but i think i failed horribly and made it worse in the cvs.

I'll have a look at it soon(tm).

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
