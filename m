Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 22:08:14 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:40241
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225313AbUK2WIJ>; Mon, 29 Nov 2004 22:08:09 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CYtgl-0004ZD-00; Mon, 29 Nov 2004 23:08:07 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CYtgk-0005nd-00; Mon, 29 Nov 2004 23:08:06 +0100
Date: Mon, 29 Nov 2004 23:08:06 +0100
To: "Eric Y. Theriault" <eric@eyt.ca>
Cc: linux-mips@linux-mips.org
Subject: Re: dvhtool support for variable block factor...
Message-ID: <20041129220806.GT6804@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.61.0411291004110.14874@ingress.local.fxdevelopment.com> <20041129172020.GP6804@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.61.0411291403190.20405@ingress.local.fxdevelopment.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411291403190.20405@ingress.local.fxdevelopment.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Eric Y. Theriault wrote:
[snip]
> >A testcase which always "worked" for me on IP22: create a DVH with
> >parted, and then try to read/change it with fdisk. Apparently
> >parted poisons the DVH for fdisk. :-)
> 
> Could you provide me a link/contact to linux-util to submit such a patch? 

I meant util-linux. The debian package says:

It was downloaded from
ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/util-linux/

Upstream maintainers include:
Maintainer: Andries Brouwer <aeb@cwi.nl>
Maintainer address: util-linux@math.uio.no
Maintainer of getopt: Frodo Looijaard <frodol@dds.nl>
Maintainer of simpleinit: Richard Gooch <rgooch@atnf.csiro.au>


Thiemo
