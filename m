Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 13:51:26 +0000 (GMT)
Received: from p508B7561.dip.t-dialin.net ([IPv6:::ffff:80.139.117.97]:44867
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224935AbVAKNvV>; Tue, 11 Jan 2005 13:51:21 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0BDpFPV028191;
	Tue, 11 Jan 2005 14:51:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0BDpECj028190;
	Tue, 11 Jan 2005 14:51:14 +0100
Date: Tue, 11 Jan 2005 14:51:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hdei Nunoe <nunoe@co-nss.co.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: HIGHMEM
Message-ID: <20050111135114.GA28166@linux-mips.org>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE> <20041207095837.GA13264@linux-mips.org> <001701c4e195$24d48260$3ca06096@NUNOE> <20041215141508.GA29222@linux-mips.org> <002801c4f785$fcafd7b0$3ca06096@NUNOE> <20050111103435.GA24198@linux-mips.org> <Pine.GSO.4.61.0501111138050.14328@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0501111138050.14328@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 11, 2005 at 11:38:59AM +0100, Geert Uytterhoeven wrote:

> Time to start using virtually contiguous memory, like m68k does? ;-)
> (no, it's not in mainline)

Won't work for MIPS; there's the KSEG1 address gap.

  Ralf
