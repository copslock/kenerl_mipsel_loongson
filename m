Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 10:36:56 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225473AbTIXJgy>; Wed, 24 Sep 2003 10:36:54 +0100
Date: Wed, 24 Sep 2003 10:36:54 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-mips@linux-mips.org
Cc: Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>
Subject: Re: [BUG?][linux_2_4] Oops in ip22-berr.c
Message-ID: <20030924103654.A15492@linux-mips.org>
References: <20030924092828.GB21504@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030924092828.GB21504@icm.edu.pl>; from rathann@icm.edu.pl on Wed, Sep 24, 2003 at 11:28:28AM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 24, 2003 at 11:28:28AM +0200, Dominik 'Rathann' Mierzejewski wrote:
> Hello.
> 
> I've succesfully compiled the 2.4 kernel from linux-mips CVS,
> but it oopses at boot time. I'll try to copy and paste by hand
> from the console:
> [...]
> SCSI subsystem driver Revision: 1.00
> wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
>            setup_args=,,,,,,,,,
> 	   Version 1.25 09/Jul/1997, compiled Sep 19 2003 at 15:37:47
> scsi0: SGI WD93
>   sending SDTR 010301410csync_xfer=3c<3>MC Bus Error
> GIO Error 0x400:<TIME > @ 0x08292e3000
> Instruction bus error, epc == 880d1184, ra == 880d1168
> Oops in ip22-berr.c::ip22_be_interrupt, line 98:
> $0 : 00000000 1000cc00 00000000 00000002 00000008 bfbc4007 00000100 88155cc8
> $8 : 09219e98 892c8200 8921ac7c 89219d98 00000100 00000000 881a7e58 89212480
> $16: 1000cc01 00000001 00000019 88155ea8 881788a4 887fe5b4 00000031 9fc4b080
> $24: ffffffff 00000000                   88154000 88155e28 00000001 880d1168
> Hi : 00000000
> Lo : 00000100
> epc  : 880d1184    Not tainted
> Status: 1000cc03
> Cause : 00004000
> Process swapper (pid:0, stackpage: 88154000)
> Stack:    00000100 00000000 88003048 8880e554 881ad480 88003060 00000001
>  881690a0 fffffffe 1000cc00 88168320 00000019 881ad480 fffffffb 88155ea8
>  88003334 00000031 9fc4b080 881788a4 8880e554 00000400 8880e554 887fe5b4
>  00000000 887fe8bc 880a3e0c 00010f00 00000000 88155f40 1000cc01 880a4014
>  880a3ffc 00000000 00000622 00000001 88154000 00010f00 00000000 00000000
>  881b0000 ...
> Call Trace:   [<88003048>] [<88003060>] [<88003334>] [<880a3e0c>] [<880a4014>]
>  [<880a3ffc>] [<88002db0>] [<88003f2c>] [<88002db4>] [<8812972c>] [<8800278c>]
>  [<88129708>]
> 
> Code: 02018025  40906000  00000040 <00000040> 00000040  8fbf0014  8fb00010  03e00008  27bd0018
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> That's about it. The hardware is SGI Indy IP22 R4600@133MHz 64MB RAM
> with the standard built-in graphics and sound. Kernel compiled with
> Debian 3.0's gcc-2.95.4. I've since then upgraded Woody to
> testing/Sarge. Debian distro kernel-2.4.19 from Sarge boots fine.
> If there's any more info you need, let me know.

nice to see bus error handler working :-)
please apply following patch:
ftp://ftp.linux-mips.org/pub/linux/mips/people/ladis/sgiwd93.diff

	ladis
