Received:  by oss.sgi.com id <S553884AbQLQAgt>;
	Sat, 16 Dec 2000 16:36:49 -0800
Received: from pop3.web.de ([212.227.116.81]:7439 "HELO smtp.web.de")
	by oss.sgi.com with SMTP id <S553880AbQLQAgc>;
	Sat, 16 Dec 2000 16:36:32 -0800
Received: from web.de by smtp.web.de with smtp
	(freemail 4.2.1.0 #3) id m147RoM-005D7uC; Sun, 17 Dec 2000 01:36 +0100
Message-ID: <3A3C0ACE.8A13EA97@web.de>
Date:   Sun, 17 Dec 2000 01:37:34 +0100
From:   Olaf Zaplinski <olaf.zaplinski@web.de>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Re: FAQ/
References: <3A36AFFE.51C9F2B@web.de> <20001213135723.B3060@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Where do I find it? I saw the debian-mipsel dist on ftp.rfc822.org, but as
there is no doc at all, this dist is unusuable... perhaps I am lucky with
that, I strongly dislike the Debian dist.

Olaf

Florian Lohoff wrote:
> 
> On Wed, Dec 13, 2000 at 12:08:46AM +0100, Olaf Zaplinski wrote:
> > Hi all,
> >
> > can someone please point me to a Howto/FAQ? I'd like to put Linux on my SNI
> > RM200 machine (R4600, 64MB). Can I use the Hardhat distribution, or does it
> > run on SGIs only?
> 
> The RM200 was supported only in little endian mode with the Windows NT
> firmware - Nobody knows (chance is little) if the tree will still work.
> 
> You will need the decstation root not the hardhat tarball as that
> is strictly big endian.
> 
> Flo
> --
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
