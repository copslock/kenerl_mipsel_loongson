Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72HI9Rw009407
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 10:18:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72HI9DS009406
	for linux-mips-outgoing; Fri, 2 Aug 2002 10:18:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hermod.qsicorp.com (mail.qsicorp.com [216.190.147.34])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72HI1Rw009394
	for <linux-mips@oss.sgi.com>; Fri, 2 Aug 2002 10:18:02 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hermod.qsicorp.com (Postfix) with ESMTP
	id A974B17086; Fri,  2 Aug 2002 11:19:41 -0600 (MDT)
Received: from hermod.qsicorp.com ([127.0.0.1]) by localhost (hermod.qsicorp.com [127.0.0.1]) (amavisd-new) with ESMTP id 08180-02; Fri, 2 Aug 2002 11:19:39 -0000 (MDT)
Received: from qsicorp.com (computer195.qsicorp.com [216.190.147.195])
	by hermod.qsicorp.com (Postfix) with ESMTP
	id BC2EA1708B; Fri,  2 Aug 2002 11:19:39 -0600 (MDT)
Message-ID: <3D4ACD9D.AB3FC45C@qsicorp.com>
Date: Fri, 02 Aug 2002 11:21:17 -0700
From: Ryan Martindale <ryan@qsicorp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Today's OSS doesn't work on Malta
References: <20020802100714.A4669@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new amavisd-new-20020630
X-Razor-id: f0502936caa018079f35f3e1a07b67ea3f4a8052
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H. J. Lu" wrote:
> 
> The 2.4 kernel from today's OSS doesn't work on Malta. I got
> 
> hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, (U)DMA
> Partition check:
>  hda:<1>Unable to handle kernel paging request at virtual address 611c2000,
> epc4
> Oops in fault.c::do_page_fault, line 206:
> $0 : 00000000 1000fc00 00000001 00001000 00001000 00001000 81191000 00000001
> $8 : 811c0000 81199000 00000001 00008000 00010000 802d1358 00000000 00000080
> $16: 611c2000 00000001 802d1338 00000000 00000000 00000008 00000000 00000000
> $24: 0000000a 811ddd91                   8027a000 8027bd10 8009e0d0 801eaa24
> Hi : 0000004f
> Lo : df328000
> epc  : 801eaa98    Not tainted
> Status: 1000fc03
> Cause : 0080000c
> Process swapper (pid: 0, stackpage=8027a000)
> Stack: 8027bd08 8027bd08 802b5c20 00000000 00001240 802d12c8 802d1338 801eb170
>        0000000e 00000001 b8000000 802d1338 81198320 802d1338 81198320 802d12c8
>        0000000e 00000001 801efc14 1000fc00 811dde48 802d1338 811dddd0 802d12c8
>        0000000e 00000001 801e3ca8 802d12c8 8027bd88 1000fc00 8027bde0 1000fc00
>        00000000 802d1338 81198320 801e406c 1000fc00 802d12c8 801e93e4 00000000
>        00000003 ...
> Call Trace: [<801eb170>] [<801efc14>] [<801e3ca8>] [<801e406c>] [<801e93e4>]
> [<]
>  [<801db1b4>] [<801e44ec>] [<801e3008>] [<8012ea04>] [<801e9290>] [<801e4be8>]
>  [<80109690>] [<80109970>] [<8010ae3c>] [<80254554>] [<80254d10>] [<80254860>]
>  [<801089a4>] [<80102e40>] [<80102e9c>] [<80102e44>] [<8010042c>] [<80255800>]
> 
> Code: 54e00001  00a02021  3083ffff <ae060000> 00a42823  14600008  26100004  263
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

Looks like what I was dealing with - check process.c patch I submitted a
couple of days ago (gp doesn't get set to the appropriate type of
structure).

Ryan
