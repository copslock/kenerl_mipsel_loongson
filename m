Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 01:00:51 +0100 (BST)
Received: from sirius.livecd.pl ([IPv6:::ffff:83.243.111.250]:58636 "EHLO
	sirius.livecd.pl") by linux-mips.org with ESMTP id <S8225209AbUGTAAh> convert rfc822-to-8bit;
	Tue, 20 Jul 2004 01:00:37 +0100
Received: from localhost ([127.0.0.1] ident=havner)
	by sirius.livecd.pl with esmtp (Exim 4.32)
	id 1Bmi5A-0006cQ-SP
	for linux-mips@linux-mips.org; Tue, 20 Jul 2004 02:02:08 +0200
From: havner <havner@pld-linux.org>
To: linux-mips@linux-mips.org
Subject: Re: DECstation 5000/20
Date: Tue, 20 Jul 2004 02:02:07 +0200
User-Agent: KMail/1.6.2
References: <200407192102.15261.havner@pld-linux.org> <20040719232449.GA965@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040719232449.GA965@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407200202.08636.havner@pld-linux.org>
Return-Path: <havner@pld-linux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: havner@pld-linux.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 20 July 2004 01:24, Thiemo Seufer wrote:
> > Unfortunately both of them freezes system (RH7.1/RH7.3) f.e. when trying
> > to cat /proc/cpuinfo. No oops, no message on serial, just hard freeze.
>
> Fixed in newer 2.4 kernels from linux-mips.org.
I've already found, but it doesn't build (my previous post)

> linux-mips.org CVS, -r linux_2_4, should work for serial console. Debian
> has a r3k-kn02 kernel package for mipsel which is supposed to work as
> well.
The only debian image I've managed to find was 2.4.17 and it freezes the same
way like 2.4.18 quoted previously :-(


- -- 
Regards       Havner                          http://livecd.pld-linux.org
GG: 2846839                             jid,mail: havner(at)pld-linux.org
          "We live as we dream, alone"   - Joseph Conrad
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/GD/gvS01FGjsR8RAiisAJ4sqiDVvk703yRN8FYOZ418UxLqvgCeO0Vp
/jcXaWeh+AW1GtPZffrFC/I=
=3kAl
-----END PGP SIGNATURE-----
