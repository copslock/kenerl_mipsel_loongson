Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jun 2004 20:38:45 +0100 (BST)
Received: from p508B7102.dip.t-dialin.net ([IPv6:::ffff:80.139.113.2]:48926
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225624AbUFVTik>; Tue, 22 Jun 2004 20:38:40 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5MJcdlS011804;
	Tue, 22 Jun 2004 21:38:39 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5MJcdDD011803;
	Tue, 22 Jun 2004 21:38:39 +0200
Date: Tue, 22 Jun 2004 21:38:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alexander Voropay <a.voropay@vmb-service.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: Howto run Linux on ACER PICA 61
Message-ID: <20040622193839.GA7082@linux-mips.org>
References: <01d701c45875$5205b460$0200000a@ALEC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d701c45875$5205b460$0200000a@ALEC>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 22, 2004 at 08:23:57PM +0400, Alexander Voropay wrote:

>  I've just got (for free :) an ancient MIPS ACER PICA 61 motherboard.
> 
>  Can anyone help/guide me to run Linux-MIPS on this machine ?
> Is it still possible to run Linux on this architecture ?
> 
>  The motherboard is old (~1993) and it is very difficult to find
> any documentations... AFAIK, this is version of ARC MIPS.
> (mipsel)
> 
> 
>  This is Full-size AT board, AT power supply, 5 ISA slots, 8 SIMM
> slots. The CPU is PACEMIPS R4000-50Mhz (x2=100 internal ???) by
> Performance Semiconductor Corp.. NatSemi Ethernet/AUI onboard.
> No IDE connector. One additional slot is not ISA, but maked as
> IO an contains SCSI/Floppy/Serial/Perallel/Mice card. Another slot
> is like reversed EISA (double) and marked as VIO (locabus video?).
> Unfortunately, the original videocard is lost. :(

Great.  Because that was a S3 968 video card which for it's time was
delivering quite a nice performance.

> However it works fine with old CirrusLogic VGA card in ISA slot (old
> ISA Trident 8900/9000 does not works).

Linux has code for this system but it's suffering from severe bitrot.
I still have the documents here so I could help you a bit if you were
willing to resurrect the kernel - which should be relativly easy, also
due to the system's similarity to another, somewhat better supported
system, the Olivetti M700-10.

  Ralf
