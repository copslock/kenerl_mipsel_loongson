Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 02:17:59 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61178 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225005AbUKWCRy>; Tue, 23 Nov 2004 02:17:54 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 51EE3185E7; Mon, 22 Nov 2004 18:17:52 -0800 (PST)
Message-ID: <41A29DCF.8030308@mvista.com>
Date: Mon, 22 Nov 2004 18:17:51 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com> <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 22 Nov 2004, Manish Lachwani wrote:
> 
> 
>>I tried out the patch on a MIPS Malta board (24Kc core). Compiled fine 
>>and booted fine as well. On bootup, I see:
>>
>>...
>>Synthesized TLB handler (26 instructions).
>>...
> 
> 
>  This should be 21 instructions -- please get an update from the CVS tree
> for a fix I applied yesterday.  You run with the BCM1250 workaround
> enabled.
> 
>   Maciej

Hello Maciej,

Thanks for the info. I got the latest sources from cvs. Bootlog shows:

...
Synthesized TLB handler (21 instructions).
...

However, the crash still occurs. I dont think your patch was intended to 
fix the problem that I see below (resulting in crash).

I will try to debug this now.

gcc -D__KERNEL__ -I/root/2.4.19/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-DGEMDEBUG_TRACEBUFFER -I /root/2.4.19/include/asm/gcc -G 0 
-mno-abicalls -fno-pic -pipe -mips2 -Wa,--trap   -DKBUILD_BASENAME=main 
-c -o init/main.o init/main.c
Data bus error, epc == 801f83b8, ra == 80323f04
Oops in arch/mips/kernel/traps.c::do_be, line 330[#1]:
Cpu 0
$ 0   : 00000000 80000000 83fffb24 00000000
$ 4   : 83ffff04 80612414 000000dc 00000000
$ 8   : 73696874 6c6f7362 20657475 72707865
$12   : 69737365 81141d60 0000000a 00006e6f
$16   : 80612034 83fffb24 000004dc 0000f45d
$20   : 81136660 00000000 83fffb24 00ff00ff
$24   : 0000001c 00000001
$28   : 8114c000 8114d6c0 00000000 80323f04
Hi    : 10621125
Lo    : f1a9c6d0
epc   : 801f83b8 both_aligned+0x40/0x74     Not tainted
ra    : 80323f04 csum_partial_copy_nocheck+0x44/0x64
Status: 1000fc03    KERNEL EXL IE
Cause : 0080001c
PrId  : 00019360
Modules linked in:
Process rpciod (pid: 12, threadinfo=8114c000, task=810f7060)
Stack : 10008000 80100744 00000000 00000000 000004dc 000004dc 000004dc 
00000000
         802a7464 1000fc00 00000000 80383e34 80383e34 00000003 00000001 
00000000
         0000dcf9 83fff000 000004dc 000004dc 0000106c 00000b90 81136660 
00013fb7
         83fffb24 00ff00ff 00000b24 802a7618 81136660 804f3280 81114600 
802a5b64
         00000000 00000001 00000000 00000000 0000006c 00001000 8114d7e8 
00001000
         ...
Call Trace:
  [<80100744>] mipsIRQ+0x104/0x180
  [<802a7464>] skb_copy_and_csum_bits+0x78/0x2bc
  [<802a7618>] skb_copy_and_csum_bits+0x22c/0x2bc
  [<802a5b64>] kfree_skbmem+0x24/0x34
  [<80312144>] skb_read_and_csum_bits+0x0/0xb4
  [<80312188>] skb_read_and_csum_bits+0x44/0xb4
  [<8010e4b8>] __flush_dcache_page+0x90/0xa4
  [<8031e814>] xdr_partial_copy_from_skb+0x190/0x1dc
  [<8031226c>] csum_partial_copy_to_xdr+0x74/0x134
  [<80312454>] udp_data_ready+0x128/0x230

...

 From the disassembly:

801f8378 <both_aligned>:
801f8378:       00064142        srl     t0,a2,0x5
801f837c:       1100001b        beqz    t0,801f83ec <cleanup_both_aligned>
801f8380:       30d8001f        andi    t8,a2,0x1f
801f8384:       cca00060        pref    0x0,96(a1)
801f8388:       cc810060        pref    0x1,96(a0)
801f838c:       00000000        nop
801f8390:       8ca80000        lw      t0,0(a1)
801f8394:       8ca90004        lw      t1,4(a1)
801f8398:       8caa0008        lw      t2,8(a1)
801f839c:       8cab000c        lw      t3,12(a1)
801f83a0:       24c6ffe0        addiu   a2,a2,-32
801f83a4:       8cac0010        lw      t4,16(a1)
801f83a8:       8caf0014        lw      t7,20(a1)
801f83ac:       ac880000        sw      t0,0(a0)
801f83b0:       ac890004        sw      t1,4(a0)
801f83b4:       8ca80018        lw      t0,24(a1)
801f83b8:       8ca9001c        lw      t1,28(a1)
801f83bc:       24a50020        addiu   a1,a1,32
801f83c0:       24840020        addiu   a0,a0,32
801f83c4:       ac8affe8        sw      t2,-24(a0)
801f83c8:       ac8bffec        sw      t3,-20(a0)
801f83cc:       ac8cfff0        sw      t4,-16(a0)
801f83d0:       ac8ffff4        sw      t7,-12(a0)
801f83d4:       ac88fff8        sw      t0,-8(a0)
801f83d8:       ac89fffc        sw      t1,-4(a0)
801f83dc:       cca00100        pref    0x0,256(a1)
801f83e0:       cc810100        pref    0x1,256(a0)
801f83e4:       14d8ffea        bne     a2,t8,801f8390 <both_aligned+0x18>
801f83e8:       00000000        nop



Thanks
Manish Lachwani
