Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 16:32:02 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:47959
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225196AbVAVQb6>; Sat, 22 Jan 2005 16:31:58 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CsOB4-0001Q1-00
	for <linux-mips@linux-mips.org>; Sat, 22 Jan 2005 17:31:58 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CsOB3-0003fs-00
	for <linux-mips@linux-mips.org>; Sat, 22 Jan 2005 17:31:57 +0100
Date:	Sat, 22 Jan 2005 17:31:57 +0100
To:	linux-mips@linux-mips.org
Subject: Re: O2 and 128Mb
Message-ID: <20050122163157.GI15265@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.4.61.0501220920460.21833@waterleaf.sonytel.be> <200501221147.j0MBlBfW023297@arbas.nms.ulrich-teichert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501221147.j0MBlBfW023297@arbas.nms.ulrich-teichert.org>
User-Agent: Mutt/1.5.6+20040907i
From:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ulrich Teichert wrote:
[snip]
> >> dial program.  If it's not on your system, you'll have to install it via
> >> whatever means your working distro provides, then do this:
> >> 
> >> xc -l/dev/ttyS0
> >
> >Or you can try `cu' (`apt-get install cu'). 
> 
> Or kermit, my personal favourite. "set line /dev/ttyS0" in your .kermrc,
> or `kermit -l /dev/ttyS0`.

Just for completeness:

screen /dev/ttyS0


Thiemo
