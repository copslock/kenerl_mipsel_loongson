Received:  by oss.sgi.com id <S553897AbQLQBia>;
	Sat, 16 Dec 2000 17:38:30 -0800
Received: from pop3.web.de ([212.227.116.81]:30227 "HELO smtp.web.de")
	by oss.sgi.com with SMTP id <S553893AbQLQBiN>;
	Sat, 16 Dec 2000 17:38:13 -0800
Received: from web.de by smtp.web.de with smtp
	(freemail 4.2.1.0 #3) id m147SmB-005CLrC; Sun, 17 Dec 2000 02:38 +0100
Message-ID: <3A3C194B.5E85C4CE@web.de>
Date:   Sun, 17 Dec 2000 02:39:23 +0100
From:   Olaf Zaplinski <olaf.zaplinski@web.de>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Re: FAQ/
References: <3A36AFFE.51C9F2B@web.de> <20001213135723.B3060@paradigm.rfc822.org> <3A3C0ACE.8A13EA97@web.de> <20001217020043.B29250@lug-owl.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Huh, I don't expect comfort. But I expect a x68 Linux users guide to the
world of MIPS systems. Okay, I know my RM 200 quite well, had compiled
several progs under Sinix, put it in LE mode and installes WinNT 4.0. I use
Linux since the 0.something kernel. The problem is that the Debian WWW site
consists of lots of "404" errors. On the ftp site there is no docu at all
that would tell me how to proceed. For Hardhat, I have found this
information.

What I want: a documentation of the form:

- how to prepare your bootp server
- how to boot the kernel via bootp
- how to start some install script *or* boot your mini-dist/root-fs via NFS,
fdisk, cp and enjoy

That would be enough.

Olaf

Jan-Benedict Glaw wrote:
> 
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
> --
> Fehler eingestehen, Größe zeigen: Nehmt die Rechtschreibreform zurück!!!
> /* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
> keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 8399 E1BB
>      "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)
> 
>   ----------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature
