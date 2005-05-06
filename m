Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 18:09:38 +0100 (BST)
Received: from rwcrmhc14.comcast.net ([IPv6:::ffff:216.148.227.89]:56298 "EHLO
	rwcrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8226019AbVEFRJX>; Fri, 6 May 2005 18:09:23 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc14) with SMTP
          id <2005050617091401400881mhe>; Fri, 6 May 2005 17:09:15 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Geert Uytterhoeven'" <geert@linux-m68k.org>
Cc:	"'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: ATA devices attached to arbitary busses
Date:	Fri, 6 May 2005 13:09:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVSW1kVhIWtjtPyQ66P7vSJUfe3NQAAEGqQ
In-Reply-To: <Pine.LNX.4.62.0505061846170.5272@numbat.sonytel.be>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050506170923Z8226019-1340+6651@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips


> This is not the direct `memory map' of the IDE drive's registers! It's an
> indirect map, cfr. e.g.
>
>   #define IDE_DATA_REG            (HWIF(drive)->io_ports[IDE_DATA_OFFSET])
>
> So the actual register is found by looking up offset IDE_DATA_OFFSET in
> the array HWIF(drive)->io_ports[].

Yes, I understand.  This is starting to make more sense.  Here is what I
have figured out:  The first 8 offsets are normally 0-7, just like their
array indexes.  Index 8 and 9, IDE_CONTROLL_OFFSET and IDE_IRQ_OFFSET, were
confusing me because I was expecting them to be the actual offset 8 and 9 --
and I could not find any IDE adapter data sheets that showed them located as
such.  Now that I take a second look at ide_std_init_ports(), I see that the
CONTROL register is treated as a special case, i.e. it is not expected to
follow the STATUS register in address space.  This jives with what I have
seen in data sheets.  

It looks like the example that Alan contributed does not update
HWIF(drive)->io_ports[IDE_IRQ_OFFSET].  Or at least I cant figure out where.
I am having trouble identifying this register in IDE data sheets.  Is it one
of the "not used" or obsolete registers?  Do I need to be conserned with it?
Thanks again.

Bryan
