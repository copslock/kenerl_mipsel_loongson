Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 19:59:58 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:43845
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225303AbUBBT76>; Mon, 2 Feb 2004 19:59:58 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12Jxcex025465;
	Mon, 2 Feb 2004 20:59:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12Jxbsp025464;
	Mon, 2 Feb 2004 20:59:37 +0100
Date: Mon, 2 Feb 2004 20:59:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
Message-ID: <20040202195937.GB24843@linux-mips.org>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org> <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org> <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be> <20040202194622.GA25095@linux-mips.org> <Pine.GSO.4.58.0402022049140.19699@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402022049140.19699@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 08:50:38PM +0100, Geert Uytterhoeven wrote:

> > That would be possible - but would still leave all the other limitations
> > of the original firmware such as not supporting netboots.  Peter Horten
> > seem to have worked on something better.
> 
> Unles the second stage booter supports netboots. I don't know anything about
> the Cobalt firmware, but just using it to load something like uBoot should be
> possible, right?

Oh, it boots everything as long as it's a compress ELF executable named
/vmlinux.gz on a PC-style partitioned disk with an ext2 filesystem
(must be revision 0!) on it's first partition or it uploaded with cu(1)'s
send file command at 115200bps, 8N1.  No luxury, whistles or bells at
all.

  Ralf
