Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 20:32:44 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:10310
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225342AbUBBUcn>; Mon, 2 Feb 2004 20:32:43 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12KWbex026153;
	Mon, 2 Feb 2004 21:32:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12KWbvn026152;
	Mon, 2 Feb 2004 21:32:37 +0100
Date: Mon, 2 Feb 2004 21:32:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
Message-ID: <20040202203237.GG24843@linux-mips.org>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org> <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org> <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be> <20040202194622.GA25095@linux-mips.org> <Pine.GSO.4.58.0402022049140.19699@waterleaf.sonytel.be> <20040202195937.GB24843@linux-mips.org> <20040202200742.GG1458@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202200742.GG1458@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 09:07:42PM +0100, Thiemo Seufer wrote:

> > Oh, it boots everything as long as it's a compress ELF executable named
> > /vmlinux.gz
> 
> AFAIK it also boots such a kernel from a NFS(!) export.

Well possible - the firmware contains a Linux kernel of approx 2.0.30
vintage, so that would have been easy to arrange.  When I kernel work for
Cobalt however booting from disk and over serial were the only two
available options.

  Ralf
