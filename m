Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 00:24:59 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:59707
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225192AbUGSXYx>; Tue, 20 Jul 2004 00:24:53 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BmhV4-0008TH-00; Tue, 20 Jul 2004 01:24:50 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BmhV3-0002pL-00; Tue, 20 Jul 2004 01:24:49 +0200
Date: Tue, 20 Jul 2004 01:24:49 +0200
To: havner <havner@pld-linux.org>
Cc: linux-mips@linux-mips.org
Subject: Re: DECstation 5000/20
Message-ID: <20040719232449.GA965@rembrandt.csv.ica.uni-stuttgart.de>
References: <200407192102.15261.havner@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407192102.15261.havner@pld-linux.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

havner wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> What's the recommended kernel for this machine?
> I've only managed to boot 2.4.17 from debian and 2.4.18
> http://www.xs4all.nl/~vhouten/mipsel/vmlinux-2.4.18-decR3k.ecoff.tgz

This is very old.

> Unfortunately both of them freezes system (RH7.1/RH7.3) f.e. when trying to 
> cat /proc/cpuinfo. No oops, no message on serial, just hard freeze.

Fixed in newer 2.4 kernels from linux-mips.org.

> using rpm also likes to freeze this machine. I've tried co cross compile 
> kernel from cvs at linux-mips.org, but it stop at boot time just after 
> setting high precission timer. vanila kernel (2.6.7) ends with kernel panic.

linux-mips.org CVS, -r linux_2_4, should work for serial console. Debian
has a r3k-kn02 kernel package for mipsel which is supposed to work as
well.


Thiemo
