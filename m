Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2003 16:42:00 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:38267
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225310AbTKGQl2>; Fri, 7 Nov 2003 16:41:28 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AI9f9-0005XZ-00; Fri, 07 Nov 2003 17:40:43 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AI9f9-0008Iz-00; Fri, 07 Nov 2003 17:40:43 +0100
Date: Fri, 7 Nov 2003 17:40:43 +0100
To: Eric Christopher <echristo@redhat.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
Message-ID: <20031107164043.GA24269@rembrandt.csv.ica.uni-stuttgart.de>
References: <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com> <20031104.142111.41626869.nemoto@toshiba-tops.co.jp> <1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com> <20031104.200222.70226623.nemoto@toshiba-tops.co.jp> <1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Eric Christopher wrote:
[snip]
> > Yes.  mips-linux and mipsel-linux target (host is i386).  Both target
> > generate broken binary for my test program.
> > 
> > eric> And where would I find the sources?
> > 
> > I'm using plain binutils 2.14 and gcc 3.3.2 from gnu.org FTP site,
> > binutils 2.14.90.0.7 from
> > http://www.kernel.org/pub/linux/devel/binutils/.
> 
> I'm using mainline gcc, but I meant the python-qt sources you were
> compiling.

It was python-qt-3.8 from debian unstable, compiled with
"gcc (GCC) 3.3.2 (Debian)" and binutils
"2.14.90.0.7 20031029 Debian GNU/Linux"

An attempt to link with CVS ld shows the same BFD assertion.


Thiemo
