Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 14:45:40 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:16654 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133511AbWEXMpb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 14:45:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 40CFBF5B74;
	Wed, 24 May 2006 14:45:24 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17962-09; Wed, 24 May 2006 14:45:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DC7E3F5B79;
	Wed, 24 May 2006 14:45:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4OCjUMa019857;
	Wed, 24 May 2006 14:45:31 +0200
Date:	Wed, 24 May 2006 13:45:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	art <art@sigrand.ru>, Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: Problem with TLB mcheck!
In-Reply-To: <19691.060524@sigrand.ru>
Message-ID: <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
References: <19691.060524@sigrand.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1479/Wed May 24 07:17:23 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 May 2006, art wrote:

> Hello linux community!
> Please CC to me personaly, because I'am not subsribed yet.
> 
> I am relatively new Linux kernel (just work with some network adapter
> drivers) and my english is poor, so excuse me if something wrong.
> I work with Infineon ADM5120 chip (MIPS32 processor, little endian,
> using tlb), setting embedded Linux on it.
> Almost everything is work now (I port some drivers). But there is big
> problem ( sg16lan is my network driver module):
> 
> [4294714.623000] sg16lan.c: shdsl_interrupt wake up dsl0
> [4294714.627000] sg16lan.c: shdsl_interrupt wake up dsl0
> [4294714.628000] Got mcheck at c0096604
> [4294714.628000] Cpu 0
> [4294714.628000] $ 0   : 00000000 10008400 00000000 00000000
> [4294714.628000] $ 4   : c0098384 c00aa26c 00000001 00000001
> [4294714.628000] $ 8   : 81261fe0 00008400 00000000 80318000
> [4294714.628000] $12   : 0000000c 00 00000078 00000000
> [4294714.628000] $16   : 000000d1 0000aea8 8038a220 8038a000
> [4294714.628000] $20   : 80323420 80030000 00000002 8038a220
> [4294714.628000] $24   : 00000000 802c0000
> [4294714.628000] $28   : 81260000 81261e60 00003fde c0096604
> [4294714.628000] Hi    : 00000280
> [4294714.628000] Lo    : 00000230
> [4294714.628000] epc   : c0096604 store_download+0x424/0x4fc [sg16lan]     Not tainted
> [4294714.628000] ra    : c0096604 store_download+0x424/0x4fc [sg16lan]
> [4294714.628000] Status: 10208403    KERNEL EXL IE
> [4294714.628000] Cause : 00800060
> [4294714.628000] PrId  : 0001800b
> [4294714.628000]
> [4294714.628000] Index:  4 pgmask=4kb va=c0094000 asid=b2
> [4294714.628000]                        [pa=003d4000 c=3 d=1 v=1 g=1]
> [4294714.628000]                        [pa=003d5000 c=3 d=1 v=1 g=1]
> [4294714.628000]
> [4294714.628000] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
> [4294714.628000]
> 
> Panic occures when I work with big memory arrays (about 100Kb), when load firmware in the insmod-ed
> driver. BUT! if driver is staticaly compiled in kernel all is ok.
> I have try loading with two variants:
> 1. request_firmware call (it allocates memory with valloc)
> 2. ioctl call (it allocate memory with kalloc).
> The same thing (if driver insmoded - panic, if staticaly compiled -
> all work correctly).
> 
> IMHO this is Memory Management subsystem problem, because ported
> driver is work fine on x86 processor and can not be reason of the
> problem. But I can be wrong!
> Where can I look and whom ask the questions??
> 
> I woud be thankful for any help.
> Thanks anyway, Artem

 The "linux-mips" mailing list (as cc-ed in this response) is a better 
place to ask such questions.

 You haven't included some important information, such as the version 
number of your Linux kernel and where you got your sources from.  Without 
that bit all I can say is there is something wrong with handling of the 
TLB.

 Ralf, BTW -- shouldn't we report the Index, EntryHi and possibly EntryLo* 
registers in show_regs() if the cause is a machine check?  I think it 
would be useful and these registers shouldn't have been corrupted since 
the triggering tlbw* instruction.  A call to show_code() could be useful 
too, to determine which kind of TLB exception has been taken originally.  

  Maciej
