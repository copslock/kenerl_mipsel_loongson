Received:  by oss.sgi.com id <S553898AbQLQBaU>;
	Sat, 16 Dec 2000 17:30:20 -0800
Received: from haliga.physik.TU-Cottbus.De ([141.43.75.9]:42768 "HELO
        haliga.physik.tu-cottbus.de") by oss.sgi.com with SMTP
	id <S553895AbQLQBaE>; Sat, 16 Dec 2000 17:30:04 -0800
Received: by haliga.physik.tu-cottbus.de (Postfix, from userid 7215)
	id 1B2908D8F; Sun, 17 Dec 2000 02:29:56 +0100 (CET)
Date:   Sun, 17 Dec 2000 02:29:55 +0100
To:     linux-mips@oss.sgi.com
Subject: Re: FAQ/
Message-ID: <20001217022955.A10064@physik.tu-cottbus.de>
References: <3A36AFFE.51C9F2B@web.de> <20001213135723.B3060@paradigm.rfc822.org> <3A3C0ACE.8A13EA97@web.de> <20001217020043.B29250@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217020043.B29250@lug-owl.de>; from jbglaw@lug-owl.de on Sun, Dec 17, 2000 at 02:00:43AM +0100
From:   heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Dec 17, 2000 at 02:00:43AM +0100, Jan-Benedict Glaw wrote:
> On Sun, Dec 17, 2000 at 01:37:34AM +0100, Olaf Zaplinski wrote:
> > Where do I find it? I saw the debian-mipsel dist on ftp.rfc822.org, but as
> > there is no doc at all, this dist is unusuable... perhaps I am lucky with
> > that, I strongly dislike the Debian dist.
> 
> Btw, what kind of doc do you expect? The MIPS port is, well, everything
> but a "customer linux" right now. It's more-or-less working for
> people who know what they do. There's no installer comparable to
> a regular PC installation (insert boot CDROM, press enter sometimes,
> ready). Everything you can expect is a tarball, which can be
> mounted via nfsroot. There you can find a kernel inside which you
> can boot over bootp/tftp (or via mop, if you have not so much luck).
> Then, you can locally fdisk/mkfs/mount your HDDs and copy everything
> by hand. That's the installation.
> 
> Anything else still needs to be written. I've started an approach
> of a clean debian root filesystem (ftp.lug-owl.de) you may want
> to try. However, Debian is currently the only distribution supporting
> those machines at all. The declinux image is heavily outdated and
> ships a totally broken libc with it... It's no fun!
> 
> MfG, JB"Nur die Harten komm'n in'n Garten, alle Weichen geh'n in Teich!"G
> PS: http://oss.sgi.com/mips/mips-howto.html
> 

Hm I am still working on the boot floppies for debian, when I have the time.
for mipsel they should work, but I only build them for mips.
the problem on mips was the sgi disklabel, but that isnt used on dec. 


-- 


Henning Heinold
