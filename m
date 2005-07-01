Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 23:44:35 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:41869
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226180AbVGAWoP>; Fri, 1 Jul 2005 23:44:15 +0100
Received: (qmail 78788 invoked from network); 1 Jul 2005 22:44:07 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 1 Jul 2005 22:44:07 -0000
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b72050701153566c83bb6@mail.gmail.com>
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 01 Jul 2005 15:44:11 -0700
Message-Id: <1120257851.5987.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-07-01 at 15:35 -0700, rolf liu wrote:
> thanks, Pete.
> I applied the patch, it can mount the root now. Such a delicate patch.
> 
> Have you made the HPT371N working for 2.6 tree? 

One and off, yes. There was a timing issue I remember ... I had a 2.4
patch in my oss directory that worked fine for 2.4. I don't remember if
the same patch worked ok in 2.6. I didn't have much time to debug it,
but I remember when I put a few debug prints in the hpt init routine,
the problem went away, indicating an initialization timing issue.

Pete

>  When I want to
> compile in the hpt366.c, the kernel will hang up right after it found
> the disk drive:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> HPT371: IDE controller at PCI slot 0000:00:0b.0
> PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> HPT371: chipset revision 2
> HPT37X: using 33MHz PCI clock
> HPT371: 100% native mode on irq 5
>    ide2: BM-DMA at 0x1000-0x1007, BIOS settings: hde:pio, hdf:pio
>    ide3: BM-DMA at 0x1008-0x100f, BIOS settings: hdg:pio, hdh:pio
> hdg: IBM-DTTA-350840, ATA DISK drive
> 
> hang up ................ :(
> 
> 
> On 7/1/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> > 
> > <snip>
> > 
> > The problem below is caused by a .mips3 directive in xchg_u32. I talked
> > to Ralf and Maciel about the problem; Ralf sent a patch but I don't see
> > it applied in the tree yet.  Try this:
> > 
> > Index: include/asm-mips/system.h
> > ===================================================================
> > RCS file: /home/cvs/linux/include/asm-mips/system.h,v
> > retrieving revision 1.85
> > diff -u -r1.85 system.h
> > --- include/asm-mips/system.h   23 Jun 2005 15:57:18 -0000      1.85
> > +++ include/asm-mips/system.h   29 Jun 2005 12:01:54 -0000
> > @@ -178,7 +178,9 @@
> >                __asm__ __volatile__(
> >                "       .set    mips3                                   \n"
> >                "1:     ll      %0, %3                  #
> > xchg_u32      \n"
> > +               "       .set    mips0                                   \n"
> >                "       move    %2, %
> > z4                                 \n"
> > +               "       .set    mips3                                   \n"
> >                "       sc      %2, %
> > 1                                  \n"
> >                "       beqzl   %2,
> > 1b                                  \n"
> >                ROT_IN_PIECES
> > @@ -195,7 +197,9 @@
> >                __asm__ __volatile__(
> >                "       .set    mips3                                   \n"
> >                "1:     ll      %0, %3                  #
> > xchg_u32      \n"
> > +               "       .set    mips0                                   \n"
> >                "       move    %2, %
> > z4                                 \n"
> > +               "       .set    mips3                                   \n"
> >                "       sc      %2, %
> > 1                                  \n"
> >                "       beqz    %2,
> > 1b                                  \n"
> >  #ifdef CONFIG_SMP
> > 
> > 
> > 
> > Pete
> > 
> > > eth1: link up
> > > ., OK
> > > IP-Config: Got DHCP answer from 255.255.255.255, my address is 10.200.1.54
> > > IP-Config: Complete:
> > >       device=eth0, addr=10.200.1.54, mask=255.255.0.0, gw=10.200.0.1,
> > >      host=10.200.1.54, domain=sel, nis-domain=(none),
> > >      bootserver=255.255.255.255, rootserver=10.200.0.198, rootpath=
> > > Looking up port of RPC 100003/2 on 10.200.0.198
> > > Reserved instruction in kernel code in
> > > arch/mips/kernel/traps.c::do_ri, line 706[#1]:
> > > Cpu 0
> > > $ 0   : 00000000 1000fc00 00010000 00000000
> > > $ 4   : 812b8e40 00000093 00000000 811df97c
> > > $ 8   : 00000040 812b9e40 00000000 812a4e10
> > > $12   : 0000ffff 00200200 00100100 812a3ef4
> > > $16   : 812b8e40 00000000 812b8e40 00000060
> > > $20   : 8042a6e0 00010000 811df90c 80144b20
> > > $24   : 00000000 00000001
> > > $28   : 811de000 811df8f0 8042a6e0 802facd0
> > > Hi    : 00000000
> > > Lo    : 00000780
> > > epc   : 802ca258 sock_alloc_send_skb+0x74/0x5c8     Not tainted
> > > ra    : 802facd0 ip_append_data+0x7c8/0xa34
> > > Status: 1000fc03    KERNEL EXL IE
> > > Cause : 00800028
> > > PrId  : 03030200
> > > Modules linked in:
> > > Process swapper (pid: 1, threadinfo=811de000, task=80456bf0)
> > > Stack : c600c80a 3601c80a 00000000 00000000 00000000 00000000 00000000 00000000
> > >         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > >         00000074 00000000 812b8e40 00000060 812b8e40 812b9e40 00000060 00000008
> > >         812b8e98 802facd0 00000000 00000093 00000000 811df97c 00000000 00000000
> > >         00000000 00000000 812b9e40 00000000 00000010 00000000 000005dc 00000000
> > >         ...
> > > Call Trace:
> > >  [<802facd0>] ip_append_data+0x7c8/0xa34
> > >  [<8031e3c4>] udp_sendmsg+0x224/0xa08
> > >  [<802fa44c>] ip_generic_getfrag+0x0/0xbc
> > >  [<802c6558>] sock_sendmsg+0xac/0xf0
> > >  [<80334890>] fn_hash_lookup+0x100/0x150
> > >  [<80334890>] fn_hash_lookup+0x100/0x150
> > >  [<80144b20>] autoremove_wake_function+0x0/0x44
> > >  [<802c65c0>] kernel_sendmsg+0x24/0x38
> > >  [<80362f48>] xdr_sendpages+0x1dc/0x29c
> > >  [<80355284>] xprt_transmit+0xec/0x5f4
> > >  [<80144b20>] autoremove_wake_function+0x0/0x44
> > >  [<803529c4>] call_transmit+0x1f4/0x2d4
> > >  [<80356674>] rpc_delete_timer+0xdc/0x108
> > >  [<80357cb4>] __rpc_execute+0xa8/0x54c
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80144b20>] autoremove_wake_function+0x0/0x44
> > >  [<8035976c>] rpcauth_bindcred+0xac/0x248
> > >  [<80144b20>] autoremove_wake_function+0x0/0x44
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80351d28>] rpc_call_sync+0x8c/0xd8
> > >  [<80351d14>] rpc_call_sync+0x78/0xd8
> > >  [<80361fdc>] pmap_create+0x74/0xc0
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<803622e8>] rpc_getport_external+0x11c/0x180
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<8041b854>] root_nfs_getport+0x8c/0xa8
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80254000>] snprintf+0x14/0x20
> > >  [<8041bb94>] nfs_root_data+0x324/0x3a8
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80128f24>] printk+0x1c/0x28
> > >  [<80144b20>] autoremove_wake_function+0x0/0x44
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<8013e444>] flush_workqueue+0x28/0x34
> > >  [<80197f58>] path_lookup+0xe0/0x3d0
> > >  [<80194c78>] getname+0x28/0xf8
> > >  [<80198644>] __user_walk+0x78/0x94
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80409cb0>] mount_root+0xac/0x1c4
> > >  [<80144b20>] autoremove_wake_function+0x0/0x44
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80420000>] init_mtdchar+0x20/0x60
> > >  [<80409e10>] prepare_namespace+0x48/0x148
> > >  [<8013e444>] flush_workqueue+0x28/0x34
> > >  [<8010065c>] init+0x200/0x264
> > >  [<80100574>] init+0x118/0x264
> > >  [<80105e20>] kernel_thread_helper+0x10/0x18
> > >  [<80105e10>] kernel_thread_helper+0x0/0x18
> > >
> > >
> > > Code: 10400091  0280f021  c20300a0 <0000102d> e20200a0  1040fffc
> > > 00000000  00032823  14a0009f
> > > Kernel panic - not syncing: Attempted to kill init!
> > >
> > >
> > >
> > >
> > > Also, I tried to run 2.4.31 on db1550, but got no luck to get the hard
> > > drive working, which also crashes during the probing process:
> > > probing for hda: present=0, media=32, probetype=ATA
> > > probing for hda: present=0, media=32, probetype=ATAPI
> > > probing for hdb: present=0, media=32, probetype=ATA
> > > probing for hdb: present=0, media=32, probetype=ATAPI
> > > probing for hdc: present=0, media=32, probetype=ATA
> > > probing for hdc: present=0, media=32, probetype=ATAPI
> > > probing for hdd: present=0, media=32, probetype=ATA
> > > probing for hdd: present=0, media=32, probetype=ATAPI
> > > probing for hde: present=0, media=32, probetype=ATA
> > > probing for hde: present=0, media=32, probetype=ATAPI
> > > probing for hdf: present=0, media=32, probetype=ATA
> > > probing for hdf: present=0, media=32, probetype=ATAPI
> > > probing for hdg: present=0, media=32, probetype=ATA
> > > hdg: IBM-DTTA-350840, ATA DISK drive
> > > probing for hdh: present=0, media=32, probetype=ATA
> > > probing for hdh: present=0, media=32, probetype=ATAPI
> > > Unable to handle kernel paging request at virtual address 00000000,
> > > epc == 801e77f0, ra == 801e7b48
> > > Oops in fault.c::do_page_fault, line 206:
> > >
> > 
> >
> 
