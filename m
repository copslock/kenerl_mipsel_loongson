Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 20:07:48 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:37221
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225303AbUBBUHr>; Mon, 2 Feb 2004 20:07:47 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AnkMB-0002BE-00; Mon, 02 Feb 2004 21:07:43 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AnkMA-0007TL-00; Mon, 02 Feb 2004 21:07:42 +0100
Date: Mon, 2 Feb 2004 21:07:42 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
Message-ID: <20040202200742.GG1458@rembrandt.csv.ica.uni-stuttgart.de>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org> <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org> <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be> <20040202194622.GA25095@linux-mips.org> <Pine.GSO.4.58.0402022049140.19699@waterleaf.sonytel.be> <20040202195937.GB24843@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202195937.GB24843@linux-mips.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Feb 02, 2004 at 08:50:38PM +0100, Geert Uytterhoeven wrote:
> 
> > > That would be possible - but would still leave all the other limitations
> > > of the original firmware such as not supporting netboots.  Peter Horten
> > > seem to have worked on something better.
> > 
> > Unles the second stage booter supports netboots. I don't know anything about
> > the Cobalt firmware, but just using it to load something like uBoot should be
> > possible, right?
> 
> Oh, it boots everything as long as it's a compress ELF executable named
> /vmlinux.gz

AFAIK it also boots such a kernel from a NFS(!) export.

> on a PC-style partitioned disk with an ext2 filesystem
> (must be revision 0!) on it's first partition or it uploaded with cu(1)'s
> send file command at 115200bps, 8N1.  No luxury, whistles or bells at
> all.


Thiemo
