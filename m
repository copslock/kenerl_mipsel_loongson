Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 04:07:43 +0200 (CEST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:44697 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8126581AbWEZCHd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 04:07:33 +0200
Received: (qmail 1590 invoked by uid 101); 26 May 2006 02:07:15 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 26 May 2006 02:07:15 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k4Q27EtG020346;
	Thu, 25 May 2006 19:07:15 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF6MZJ2>; Thu, 25 May 2006 19:07:14 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF80DE0F2@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	Roman Mashak <mrv@corecom.co.kr>, linux-mips@linux-mips.org
Subject: RE: booting with NFS root
Date:	Thu, 25 May 2006 19:07:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C68069.1A1B3943"
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C68069.1A1B3943
Content-Type: text/plain

Roman,
  You have an older version of the linux kernel. I can send you latest snapshot.
There was a software bug. I don't know your source version to send patch but I am
attaching the source titan_ge.c

Regards,
Kiran

-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Roman Mashak
Sent: Thursday, May 25, 2006 5:50 PM
To: linux-mips@linux-mips.org
Subject: booting with NFS root

Hello!

I have evaluation board from PMC-sierra, their CPU is using E9000 core. 
Kernel (2.4.26), root FS are provided by them. I set up NFS and TFTP servers on my linux box, kernel loads into board but fails to boot woth the following message (I skipped some lines of kernel):

=====================
PMC-Sierra TITAN 10/100/1000 Ethernet Driver Device Id : 206014,  Version : 0
eth0: port 0 with MAC address 30:30:3a:31:31:3a Rx NAPI supported, Tx Coalescing ON
eth1: port 1 with MAC address 30:30:3a:31:31:3b Rx NAPI supported, Tx Coalescing ON
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
IP-Config: Entered.
ipconfig.c 1194
dev.c 1998
dev.c 2013
dev.c 750
irq.c 539
irq.c 571
irq.c 840
irq.c 879
handler->startup 80259d14
irq.c 892
irq.c 576
Assigned IRQ 6 to port 0
titan_ge.c 2256
titan_ge.c 2278
titan_ge.c 2316
titan_ge.c 2359
titan_ge.c 1614
titan_ge.c 1659
titan_ge.c 1698
titan_ge.c 1717
titan_ge.c 1837
titan_ge.c 2025
titan_ge.c 2118
titan_ge.c 2177
dev_addr=       1, reg_addr=      11
val=    4111
val=       1
titan_ge.c 2184
titan_ge.c 2397
dev_addr=       1, reg_addr=      11
val=    4112
val=       1
dev.c 788
dev.c 2034
dev.c 2043
dev.c 2059
IP-Config: eth0 UP (able=1, xid=57c63687) dev.c 1998 dev.c 2013 dev.c 750 irq.c 539 irq.c 571 irq.c 840 irq.c 879 irq.c 892 irq.c 576 Assigned IRQ 6 to port 1 titan_ge.c 2256 titan_ge.c 2278 titan_ge.c 2316 titan_ge.c 2359 titan_ge.c 1659 titan_ge.c 1698 titan_ge.c 1717 titan_ge.c 1837 titan_ge.c 2025 titan_ge.c 2118 titan_ge.c 2177
dev_addr=       2, reg_addr=      11
val=    4111
val=       1
titan_ge.c 2184
titan_ge.c 2397
dev_addr=       2, reg_addr=      11
val=    4212
val=       1
eth1: Error opening interface
dev.c 788
dev.c 2034
dev.c 2043
dev.c 2059
IP-Config: Failed to open eth1
ipconfig.c 1199
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.11.42, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.11.42, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.11.43, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.11.43 Looking up port of RPC 100005/1 on 192.168.11.43
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 104k freed do_cpu invoked from kernel context! in traps.c::do_cpu, line 676:
$0 : 00000000 9004a000 2ab03fe0 2ab03fe0 2ab01560 00000000 00000ae0 00000ae0
$8 : 00000020 2ab01fe0 2ab01520 00001000 00000019 00000080 811d7b18 00000c62
$16: 2ab010c0 811d7c58 87f8cfe0 00000003 00000080 2ab01520 87f841a0 00000001
$24: 00000000 00000080                   811d6000 811d7ba0 2aaa8000 8015f414
Hi : 00000000
Lo : 00000000
epc   : 80256e14    Not tainted
Status: 9004a003
Cause : 1000002c
PrId  : 000034c1
Process init (pid: 1, stackpage=811d6000)
Stack:    8015f8a8 8015f9a8 87f71180 8012b2fc 00000000 80135330 00002012
 00000019 87f8cf60 2ab019e4 00000004 00002012 000590c0 2ab01000 10000000
 811d7d88 87ff5740 00000000 811d7ef8 81164e80 00000000 00000002 87f841a0
 8015ffd8 811d7c20 811d6000 811d7cbc 801975a4 00006012 0000000a 811d7c18
 811d7c18 7f454c46 01020100 00000000 00000000 00020008 00000001 00401980
 00000034 ...
Call Trace:   [<8015f8a8>] [<8015f9a8>] [<8012b2fc>] [<80135330>] 
[<8015ffd8>]
 [<801975a4>] [<8015fbc0>] [<801493ac>] [<801007b8>] [<8014889c>] [<801495bc>]  [<801495a8>] [<801007b8>] [<80108f80>] [<801007b8>] [<8014fcc4>] [<801095c0>]  [<8025ad30>] [<801007b8>] [<8025ad30>] [<8014af50>] [<801007b8>] [<80117888>]  [<801194a0>] [<80100884>] [<801007b8>] [<8010079c>] [<8025de14>] [<80104320>]  [<80117aec>] [<8026b7a8>] [<801b2054>] [<80104310>]

Code: 30c8003c  01244821  24840040 <ac85ffc0> ac85ffc4  ac85ffc8  ac85ffcc ac85ffd0  ac85ffd4 Kernel panic: Attempted to kill init!
=====================

I load kernel with the following parameters:
tftp://192.168.11.43/vmlinux ip=192.168.11.42 root=/dev/nfs nfsroot=192.168.11.43:/export/linux/mips-fs-be

What may be the problem here?

Thanks in advance!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 




------_=_NextPart_000_01C68069.1A1B3943
Content-Type: application/octet-stream;
	name="titan_ge.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="titan_ge.c"

/*=0A=
 * drivers/net/titan_ge.c - Driver for Titan ethernet ports=0A=
 *=0A=
 * Copyright (C) 2004 PMC-Sierra Inc.=0A=
 * Author : Manish Lachwani (lachwani@pmc-sierra.com)=0A=
 * Changes for RM9150: Raj Palani (palanira@pmc-sierra.com)=0A=
 *=0A=
 * This program is free software; you can redistribute it and/or=0A=
 * modify it under the terms of the GNU General Public License=0A=
 * as published by the Free Software Foundation; either version 2=0A=
 * of the License, or (at your option) any later version.=0A=
 *=0A=
 * This program is distributed in the hope that it will be useful,=0A=
 * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the=0A=
 * GNU General Public License for more details.=0A=
 *=0A=
 * You should have received a copy of the GNU General Public License=0A=
 * along with this program; if not, write to the Free Software=0A=
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  =
02111-1307, USA.=0A=
 */=0A=
=0A=
/*=0A=
 * The MAC unit of the Titan consists of the following:=0A=
 *=0A=
 * -> XDMA Engine to move data to from the memory to the MAC packet =
FIFO=0A=
 * -> FIFO is where the incoming and outgoing data is placed=0A=
 * -> TRTG is the unit that pulls the data from the FIFO for Tx and =
pushes=0A=
 *    the data into the FIFO for Rx=0A=
 * -> TMAC is the outgoing MAC interface and RMAC is the incoming. =0A=
 * -> AFX is the address filtering block=0A=
 * -> GMII block to communicate with the PHY=0A=
 *=0A=
 * Rx will look like the following:=0A=
 * GMII --> RMAC --> AFX --> TRTG --> Rx FIFO --> XDMA --> CPU =
memory=0A=
 *=0A=
 * Tx will look like the following:=0A=
 * CPU memory --> XDMA --> Tx FIFO --> TRTG --> TMAC --> GMII=0A=
 *=0A=
 * The Titan driver has support for the following performance =
features:=0A=
 * -> Rx side checksumming =0A=
 * -> Jumbo Frames=0A=
 * -> Interrupt Coalscing=0A=
 * -> Rx NAPI =0A=
 * -> SKB Recycling=0A=
 * -> Transmit/Receive descriptors in SRAM=0A=
 * -> Fast routing for IP forwarding=0A=
 *=0A=
 * Modified aggresively for IP forwarding. pktgen provides 750 kpps=0A=
 * for Tx path and 64 byte packets. Using Smartbits, we get abt 408 =
Kpps=0A=
 *=0A=
 * SKB Recycling introduced : Pretty good IP forwarding improvement. =
=0A=
 * Currently, we are getting 565 Kpps using Smartbits.=0A=
 *=0A=
 * Moved the Rx descriptors into the SRAM. Improved IP forwarding =0A=
 * throughput to 765 Kpps=0A=
 *=0A=
 * Renice the priority of ksoftirqd to -19. =0A=
 *=0A=
 * Reduce the data touching in the IP forwarding path and set the=0A=
 * Writeback Enable for the XDMA off. Improved performance for IP=0A=
 * forwarding to 933 Kpps. On 1.2 Ghz board, packet forwarding has=0A=
 * improved to 1.04 Mpps=0A=
 *=0A=
 * Turn on Direct Deposit for the receive side packets. Packets put=0A=
 * directly into the L2 cache of the CPU. Prefetching changes also=0A=
 * incorporated. Improves fastpath forwarding throughput to 1.059 =
Mpps=0A=
 * =0A=
 * Slow path forwarding is now about 415 Kpps. This includes the fix =
=0A=
 * for the IP header alignment.=0A=
 *=0A=
 * Rx side NAPI support finally in. Gives about 500-512 Kpps =
forwarding. =0A=
 * However, still needs work.=0A=
 *=0A=
 * Bug fix for NAPI. Was not properly incrementing the workload done =
for=0A=
 * the receive. Now, we get about 565 Kpps on the slow path. =0A=
 *=0A=
 * Introduce the Tx and Rx thresholds for the descriptor recycling. =
Improves=0A=
 * NAPI throughput to 578 Kpps.=0A=
 *=0A=
 * Made changes specific to the Uniprocessor kernel. No need to use =
LLSC on=0A=
 * UP. Just disable and enable interrupts. Saves some CPU cycles and =
improves=0A=
 * performance to 588 Kpps=0A=
 *=0A=
 * Disable rp_filter since it is broken and it gives us a couple of =
Kpps=0A=
 * more. Performance for slow path improves to 591 Kpps=0A=
 *=0A=
 * Do we need Tx side interrupts at all? Increased the coalescing to =
a=0A=
 * very large value, like 1000. Now, Tx interrupt comes after a very =
long=0A=
 * time. This is good and gets the forwarding throughput to 600 Kpps=0A=
 *=0A=
 * At this point in time, Tx and Rx interrupts have been disabled =
completely=0A=
 * and the poll routine handles everything. It clean the tx queue and =
also=0A=
 * the Rx allocation. Performance now is 605 Kpps=0A=
 *=0A=
 * Make sure FASTROUTE and NAPI are not enabled at the same time. =0A=
 *=0A=
 * Changed the Tx Queue Size (Tx Ring Size) to 64. This improved the =
fast=0A=
 * path routing from 1068 Kpps to about 1201 Kpps.=0A=
 *=0A=
 * If GCC 2.9.6 is used to compile the kernel, then it will align the =
IP=0A=
 * header before presenting it to the network stack. Although, we =
avoid=0A=
 * an extra copy in this case, we do not get any improvement in =
performance=0A=
 *=0A=
 * In Titan 1.2 chip, one of the fixes was to align the IP header. So, =
we=0A=
 * dont need an extra copy for the incoming SKB if the board has a 1.2 =
chip=0A=
 *=0A=
 * Configure the port #3 to send the interrupts to the CPU.=0A=
 *=0A=
 * IO coherency flawed in case of SMP. The Data Wr coherency has to be =
turned=0A=
 * off leading to two cache invalidates in the Rx side of the driver=0A=
 */=0A=
=0A=
=0A=
#include <linux/config.h>=0A=
#include <linux/version.h>=0A=
#include <linux/module.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/config.h>=0A=
#include <linux/sched.h>=0A=
#include <linux/ptrace.h>=0A=
#include <linux/fcntl.h>=0A=
#include <linux/ioport.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/string.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/ip.h>=0A=
#include <linux/init.h>=0A=
#include <linux/in.h>=0A=
#include <linux/pci.h>=0A=
=0A=
#include <linux/netdevice.h>=0A=
#include <linux/etherdevice.h>=0A=
#include <linux/skbuff.h>=0A=
#include <linux/mii.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/skbuff.h>=0A=
=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
#include <linux/prefetch.h>=0A=
#endif=0A=
=0A=
/* For MII specifc registers, titan_mdio.h should be included */=0A=
#include <net/ip.h>=0A=
=0A=
#include <asm/bitops.h>=0A=
#include <asm/io.h>=0A=
#include <asm/types.h>=0A=
#include <asm/pgtable.h>=0A=
#include <asm/system.h>=0A=
=0A=
#include "titan_ge.h"=0A=
#include "titan_mdio.h"=0A=
=0A=
/* Static Function Declarations	 */=0A=
static int titan_ge_eth_open(struct net_device *);=0A=
static int titan_ge_eth_stop(struct net_device *);=0A=
static int titan_ge_change_mtu(struct net_device *, int);=0A=
static struct net_device_stats *titan_ge_get_stats(struct net_device =
*);=0A=
static int titan_ge_init_rx_desc_ring(titan_ge_port_info *, int, =
int,=0A=
				      unsigned long, unsigned long,=0A=
				      unsigned long);=0A=
static int titan_ge_init_tx_desc_ring(titan_ge_port_info *, int,=0A=
				      unsigned long, unsigned long);=0A=
=0A=
static int titan_ge_open(struct net_device *);=0A=
static int titan_ge_start_xmit(struct sk_buff *, struct net_device =
*);=0A=
static int titan_ge_stop(struct net_device *);=0A=
static void titan_ge_int_handler(int, void *, struct pt_regs *);=0A=
static int titan_ge_set_mac_address(struct net_device *, void *);=0A=
=0A=
static unsigned long titan_ge_tx_coal(unsigned long, int);=0A=
static unsigned long titan_ge_rx_coal(unsigned long, int);=0A=
=0A=
static void titan_ge_port_reset(unsigned int);=0A=
static int titan_ge_free_tx_queue(titan_ge_port_info *);=0A=
static int titan_ge_rx_task(struct net_device *, titan_ge_port_info =
*);=0A=
static int titan_ge_port_start(struct net_device *, titan_ge_port_info =
*);=0A=
=0A=
static int titan_ge_init(int);=0A=
static int titan_ge_return_tx_desc(titan_ge_port_info *, int);=0A=
=0A=
#ifdef CONFIG_CPU_HAS_PREFETCH=0A=
=0A=
#define	Pref_Load	0=0A=
=0A=
static inline void rm9000_prefetch(const void *addr)=0A=
{=0A=
	__asm__ __volatile__(=0A=
	"	.set	mips4		\n"=0A=
	"	pref	%0, (%1)	\n"=0A=
	"	.set	mips0		\n"=0A=
	:=0A=
	: "i" (Pref_Load), "r" (addr));=0A=
}=0A=
=0A=
#endif=0A=
=0A=
=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
/*=0A=
 * Not a part of the Linux tree as yet. Works well=0A=
 * in the Uniprocessor mode =0A=
 */=0A=
#define RC_QUEUE_PER_DEV 300;=0A=
=0A=
/* =0A=
 * For the future, add the stats for the recycler=0A=
 */=0A=
struct titan_ge_rc_data {=0A=
	struct sk_buff_head  list  ____cacheline_aligned;=0A=
	struct sk_buff_head  list_tmp[1]  ____cacheline_aligned;=0A=
	int qlen;=0A=
	atomic_t cnt;=0A=
};=0A=
=0A=
struct titan_ge_rc_data titan_ge_rc[1] ____cacheline_aligned;=0A=
=0A=
static void titan_ge_recycle_init(void);=0A=
static void titan_ge_recycle_remove(void);=0A=
=0A=
/*=0A=
 * Initialize the recycler=0A=
 */=0A=
static void titan_ge_recycle_init(void)=0A=
{=0A=
	int cpu, cpu1;=0A=
=0A=
	for (cpu=3D0; cpu < 1; cpu++) {=0A=
		atomic_set(&titan_ge_rc[cpu].cnt, 0);=0A=
		skb_queue_head_init(&titan_ge_rc[cpu].list);=0A=
		for (cpu1=3D0; cpu1 < 1; cpu1++) {=0A=
			skb_queue_head_init(&titan_ge_rc[cpu].list_tmp[cpu1]);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
static void titan_ge_remove_tmp_queues(int cpu)=0A=
{=0A=
	int cpu1;=0A=
	=0A=
	for (cpu1=3D0; cpu1 < 1; cpu1++) {=0A=
		struct sk_buff_head *list;=0A=
		struct sk_buff *skb;=0A=
=0A=
		list =3D &titan_ge_rc[cpu].list_tmp[cpu1];=0A=
		while ((skb=3Dskb_dequeue(list))!=3DNULL) {=0A=
			__kfree_skb_recycled(skb);=0A=
			atomic_dec(&titan_ge_rc[cpu].cnt);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
/*=0A=
 * remove the recycler=0A=
 */=0A=
static void titan_ge_recycle_remove(void)=0A=
{=0A=
	int cpu;=0A=
	for(cpu=3D0; cpu < 1; cpu++) {=0A=
		while(atomic_read(&titan_ge_rc[cpu].cnt)) {=0A=
			struct sk_buff *skb;=0A=
			struct sk_buff_head *list =3D &titan_ge_rc[cpu].list;=0A=
		=0A=
			current->state =3D TASK_INTERRUPTIBLE;=0A=
			schedule_timeout(10);=0A=
=0A=
			titan_ge_remove_tmp_queues(cpu);=0A=
	=0A=
			while ((skb=3Dskb_dequeue(list))!=3DNULL) {=0A=
				__kfree_skb_recycled(skb);=0A=
				atomic_dec(&titan_ge_rc[cpu].cnt);=0A=
			}=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
static inline int __skb_prepend_list(struct sk_buff_head *l1, struct =
sk_buff_head *l2)=0A=
{=0A=
	struct sk_buff *t1, *t2;=0A=
	int len =3D 0;=0A=
=0A=
	if(l2->qlen =3D=3D 0) =0A=
		return 0;=0A=
=0A=
	len =3D l2->qlen;=0A=
	t1 =3D l1->next;=0A=
	t2 =3D l2->prev;=0A=
	l1->next =3D l2->next;=0A=
	t2->next =3D t1;=0A=
	=0A=
	l1->next->prev =3D (struct sk_buff *) l1;=0A=
	t1->prev =3D t2;=0A=
=0A=
	l1->qlen +=3D len;=0A=
	l2->qlen =3D 0;=0A=
=0A=
	l2->next =3D l2->prev =3D (struct sk_buff *)l2;=0A=
	return len;=0A=
}=0A=
=0A=
static inline int skb_prepend_list(struct sk_buff_head *l1, struct =
sk_buff_head *l2)=0A=
{=0A=
	int i;=0A=
	unsigned long flags;=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_lock_irqsave(&l1->lock, flags);=0A=
#else=0A=
	local_irq_save(flags);=0A=
#endif=0A=
=0A=
	spin_lock(&l2->lock);=0A=
=0A=
	i =3D __skb_prepend_list(l1, l2);=0A=
=0A=
	spin_unlock(&l2->lock);=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_unlock_irqrestore(&l1->lock, flags);=0A=
#else=0A=
	local_irq_restore(flags);=0A=
#endif=0A=
=0A=
	return i;=0A=
}=0A=
=0A=
/*=0A=
 * Main recycling function=0A=
 */=0A=
static int titan_ge_recycle(struct sk_buff *skb)=0A=
{=0A=
	struct sk_buff_head *list =3D &titan_ge_rc[smp_processor_id()].=0A=
					list_tmp[skb->cpu];=0A=
=0A=
	if (skb_queue_len(list) <=3D titan_ge_rc[skb->cpu].qlen/4 ) { =0A=
		if(skb->cpu =3D=3D smp_processor_id()) {=0A=
			struct sk_buff_head *list2;=0A=
			list2 =3D &titan_ge_rc[smp_processor_id()].list;=0A=
=0A=
			__skb_queue_head(list2, skb);=0A=
			return 1;=0A=
		}=0A=
		else {=0A=
			__skb_queue_head(list, skb);=0A=
			if(skb_queue_len(list) > 32 ){=0A=
				struct sk_buff_head *list3;=0A=
				list3 =3D &titan_ge_rc[skb->cpu].list_tmp[skb->cpu];=0A=
				skb_prepend_list(list3, list);=0A=
			}=0A=
			return 1;=0A=
		}=0A=
	}=0A=
	atomic_dec(&titan_ge_rc[skb->cpu].cnt);=0A=
	=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Reclaim the memory =0A=
 */=0A=
static void titan_ge_mem_reclaim(struct net_device *dev)=0A=
{=0A=
	titan_ge_recycle_remove();=0A=
}=0A=
=0A=
/* =0A=
 * Main function to get the skb from the recycle pool=0A=
 */=0A=
static inline struct sk_buff *get_recycle(titan_ge_port_info =
*titan_ge_eth)=0A=
{=0A=
	struct sk_buff_head *list =3D =
&titan_ge_rc[smp_processor_id()].list;=0A=
	struct sk_buff *skb, *l;=0A=
=0A=
	l =3D (struct sk_buff *)list;=0A=
#ifdef CONFIG_CPU_HAS_PREFETCH=0A=
	rm9000_prefetch(l->next->next);=0A=
#endif=0A=
=0A=
	skb =3D __skb_dequeue(list);=0A=
	if(!skb) {=0A=
		struct sk_buff_head *list2;=0A=
		list2 =3D =
&titan_ge_rc[smp_processor_id()].list_tmp[smp_processor_id()];=0A=
=0A=
		while ( skb_queue_len(list2)) {=0A=
			skb_prepend_list(list, list2);=0A=
		}=0A=
		skb =3D __skb_dequeue(list);=0A=
	}=0A=
=0A=
	if(skb) {=0A=
		u8 *data  =3D skb->head;=0A=
		unsigned int size =3D skb->truesize - sizeof(struct sk_buff);=0A=
=0A=
		l =3D (struct sk_buff *)list;=0A=
=0A=
		skb_headerinit(skb, data, size);  /* clean state */=0A=
=0A=
		skb->data =3D skb->head;=0A=
		skb->tail =3D skb->head;=0A=
		skb->len =3D 0; =0A=
		skb->end  =3D data + size;=0A=
	}=0A=
=0A=
	return skb;=0A=
}=0A=
=0A=
#endif=0A=
		=0A=
/*=0A=
 * Some configuration for the FIFO and the XDMA channel needs=0A=
 * to be done only once for all the ports. This flag controls=0A=
 * that=0A=
 */=0A=
unsigned long config_done =3D 0;=0A=
=0A=
/*=0A=
 * One time out of memory flag=0A=
 */=0A=
unsigned int oom_flag =3D 0;=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
static int titan_ge_poll(struct net_device *netdev, int *budget);=0A=
#endif=0A=
=0A=
int titan_ge_receive_queue(struct net_device *, unsigned int);=0A=
=0A=
/* MAC Address */=0A=
extern unsigned char titan_ge_mac_addr_base[6];=0A=
=0A=
/* =0A=
 * The Titan GE has two alignment requirements:=0A=
 * -> skb->data to be cacheline aligned (32 byte)=0A=
 * -> IP header alignment to 16 bytes=0A=
 *=0A=
 * The latter is not implemented. So, that results in an extra copy =
on=0A=
 * the Rx. This is a big performance hog. For the former case, the =0A=
 * dev_alloc_skb() has been replaced with titan_ge_alloc_skb(). The =
size=0A=
 * requested is calculated:=0A=
 * =0A=
 * Ethernet Frame Size : 1518=0A=
 * Ethernet Header     : 14=0A=
 * Future Titan change for IP header alignment : 2=0A=
 *=0A=
 * Hence, we allocate (1518 + 14 + 2+ 64) =3D 1580 bytes. For the =
future =0A=
 * revisions of the chip that do support IP header alignment, we will =
use=0A=
 * skb_reserve().=0A=
 */=0A=
=0A=
#define ALIGNED_RX_SKB_ADDR(addr) \=0A=
        ((((unsigned long)(addr) + (64UL - 1UL)) \=0A=
	& ~(64UL - 1UL)) - (unsigned long)(addr))=0A=
=0A=
#define titan_ge_alloc_skb(__length, __gfp_flags) \=0A=
({      struct sk_buff *__skb; \=0A=
        __skb =3D alloc_skb((__length) + 64, (__gfp_flags)); \=0A=
        if(__skb) { \=0A=
                int __offset =3D (int) =
ALIGNED_RX_SKB_ADDR(__skb->data); \=0A=
                if(__offset) \=0A=
                        skb_reserve(__skb, __offset); \=0A=
        } \=0A=
        __skb; \=0A=
})=0A=
=0A=
/*=0A=
 * Reset the Marvel PHY=0A=
 */=0A=
static void titan_ge_reset_phy(void)=0A=
{=0A=
	int err =3D 0;=0A=
	unsigned int reg_data;=0A=
=0A=
	/* Reset the PHY for the above values to take effect */=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID, MII_BMCR,=0A=
			       &reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY control register 0 \n");=0A=
		return TITAN_GE_ERROR;=0A=
	}=0A=
=0A=
	reg_data |=3D 0x8000;=0A=
	err =3D=0A=
	    titan_ge_mdio_write(TITAN_GE_MARVEL_PHY_ID, MII_BMCR,=0A=
				reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not write to PHY control register 0 \n");=0A=
		return TITAN_GE_ERROR;=0A=
	}=0A=
}=0A=
=0A=
/*=0A=
 * Wait for sometime to check if Auto-Neg has completed=0A=
 */=0A=
static int titan_ge_wait_autoneg(void)=0A=
{=0A=
	int err =3D 0, i =3D 0;=0A=
	unsigned long reg_data;=0A=
=0A=
	for (i =3D 0; i < PHY_ANEG_TIME_WAIT; i++) {=0A=
		err =3D=0A=
		    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID, MII_BMSR,=0A=
				       &reg_data);=0A=
		if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
			printk(KERN_ERR=0A=
			       "Could not read PHY status register 0x1 \n");=0A=
			return TITAN_GE_MDIO_ERROR;=0A=
		}=0A=
=0A=
		if (reg_data & 0x8)=0A=
			return TITAN_GE_MDIO_GOOD;=0A=
=0A=
		msec_delay(100);=0A=
	}=0A=
=0A=
	if (!(reg_data & 0x8)) {=0A=
		printk(KERN_ERR=0A=
		       "Auto-Negotiation did not complete successfully \n");=0A=
		return TITAN_GE_MDIO_ERROR;=0A=
	}=0A=
=0A=
	return TITAN_GE_MDIO_GOOD;=0A=
}=0A=
=0A=
/*=0A=
 * Get the speed/duplex from the PHY and =0A=
 * put it into the main Titan structure=0A=
 */=0A=
static int titan_ge_get_speed(titan_ge_port_info * titan_ge_eth)=0A=
{=0A=
	int err =3D 0;=0A=
	unsigned int reg_data =3D 0;=0A=
=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID,=0A=
			       TITAN_GE_MDIO_MII_EXTENDED, &reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY status register 0x0f \n");=0A=
		return TITAN_GE_MDIO_ERROR;=0A=
	}=0A=
=0A=
	/* Check for 1000 Mbps first */=0A=
	if (reg_data & 0x1010) {=0A=
		titan_ge_eth->duplex =3D TITAN_GE_FULL_DUPLEX;=0A=
		titan_ge_eth->speed =3D TITAN_GE_SPEED_1000;=0A=
		return TITAN_GE_MDIO_GOOD;=0A=
	}=0A=
=0A=
	if (reg_data & 0x0101) {=0A=
		titan_ge_eth->duplex =3D TITAN_GE_HALF_DUPLEX;=0A=
		titan_ge_eth->speed =3D TITAN_GE_SPEED_1000;=0A=
		return TITAN_GE_MDIO_GOOD;=0A=
	}=0A=
=0A=
	/* Check for 100 Mbps next */=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID, MII_BMSR,=0A=
			       &reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY status register 0x01 \n");=0A=
		return TITAN_GE_MDIO_ERROR;=0A=
	}=0A=
=0A=
	if (reg_data & 0x4000) {=0A=
		titan_ge_eth->duplex =3D TITAN_GE_FULL_DUPLEX;=0A=
		titan_ge_eth->speed =3D TITAN_GE_SPEED_100;=0A=
		return TITAN_GE_MDIO_GOOD;=0A=
	}=0A=
=0A=
	if (reg_data & 0x2000) {=0A=
		titan_ge_eth->duplex =3D TITAN_GE_HALF_DUPLEX;=0A=
		titan_ge_eth->speed =3D TITAN_GE_SPEED_100;=0A=
		return TITAN_GE_MDIO_GOOD;=0A=
	}=0A=
=0A=
	/* Check for 10 Mbps */=0A=
	if (reg_data & 0x1000) {=0A=
		titan_ge_eth->duplex =3D TITAN_GE_FULL_DUPLEX;=0A=
		titan_ge_eth->speed =3D TITAN_GE_SPEED_10;=0A=
		return TITAN_GE_MDIO_GOOD;=0A=
	}=0A=
=0A=
	if (reg_data & 0x0800) {=0A=
		titan_ge_eth->duplex =3D TITAN_GE_HALF_DUPLEX;=0A=
		titan_ge_eth->speed =3D TITAN_GE_SPEED_10;=0A=
		return TITAN_GE_MDIO_GOOD;=0A=
	}=0A=
=0A=
	return TITAN_GE_MDIO_ERROR;=0A=
}=0A=
=0A=
/*=0A=
 * Configures flow control=0A=
 */=0A=
static int titan_ge_fc_config(titan_ge_port_info * titan_ge_eth)=0A=
{=0A=
	int err =3D 0;=0A=
	unsigned int adv_reg_data, lp_reg_data;=0A=
=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID,=0A=
			       TITAN_PHY_AUTONEG_ADV, &adv_reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY control register 0x4 \n");=0A=
		return TITAN_GE_MDIO_ERROR;=0A=
	}=0A=
=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID,=0A=
			       TITAN_PHY_LP_ABILITY, &lp_reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY control register 0x4 \n");=0A=
		return TITAN_GE_MDIO_ERROR;=0A=
	}=0A=
=0A=
	/*=0A=
	 * Check if both the PAUSE bits are set to 1. =0A=
	 * If that is the case, then we have Symmetric =0A=
	 * Flow Control enabled at both the ends. For the =0A=
	 * Marvel PHY, the bits 8 and 7 in the TITAN_PHY_AUTONEG_ADV =0A=
	 * register need to be checked here. For the LP, =0A=
	 * the bits 11 and 10 of the TITAN_PHY_LP_ABILITY =0A=
	 * register need to be checked here=0A=
	 */=0A=
	if ((adv_reg_data & 0x0180) && (lp_reg_data & 0x0400)) {=0A=
		printk("Symmetric Flow Control \n");=0A=
		titan_ge_eth->fc =3D TITAN_GE_FC_FULL;=0A=
	}=0A=
	else=0A=
		/* For the Transmit Pause Frames only */=0A=
	if (!(adv_reg_data & 0x0080) && (adv_reg_data & 0x0100) &&=0A=
		    (lp_reg_data & 0x0800) && (lp_reg_data & 0x0400)) {=0A=
		printk("Transmit FC  \n");=0A=
		titan_ge_eth->fc =3D TITAN_GE_FC_TX_PAUSE;=0A=
	}=0A=
	else=0A=
		/* For the Receive Pause Frames only */=0A=
	if ((adv_reg_data & 0x0180) && !(lp_reg_data & 0x0800) &&=0A=
		    (lp_reg_data & 0x0400)) {=0A=
		printk("Rx Pause only \n");=0A=
		titan_ge_eth->fc =3D TITAN_GE_FC_RX_PAUSE;=0A=
	}=0A=
	else {=0A=
		printk("No FC \n");=0A=
		/* No Flow Control */=0A=
		titan_ge_eth->fc =3D TITAN_GE_FC_NONE;=0A=
	}=0A=
=0A=
	return TITAN_GE_MDIO_GOOD;=0A=
}=0A=
=0A=
/*=0A=
 * Configure the GMII block of the Titan based =0A=
 * on what the PHY tells us=0A=
 */=0A=
static void titan_ge_gmii_config(int port_num)=0A=
{=0A=
	volatile unsigned int reg_data =3D 0, phy_reg;=0A=
	int err;=0A=
=0A=
	err =3D titan_ge_mdio_read(port_num,=0A=
                               TITAN_GE_MDIO_PHY_STATUS, &phy_reg);=0A=
=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
                printk(KERN_ERR=0A=
                       "Could not read PHY control register 0x11 =
\n");=0A=
		printk(KERN_ERR=0A=
			"Setting speed to 1000 Mbps and Duplex to Full \n");=0A=
=0A=
		return TITAN_ERROR;=0A=
        }=0A=
=0A=
	err =3D titan_ge_mdio_write(port_num,=0A=
			TITAN_GE_MDIO_PHY_IE, 0);=0A=
=0A=
	if (phy_reg & 0x8000) {=0A=
		if (phy_reg & 0x2000) {=0A=
			/* Full Duplex and 1000 Mbps */=0A=
			TITAN_GE_WRITE((TITAN_GE_GMII_CONFIG_MODE + =0A=
					(port_num << 12)), 0x201);=0A=
		}  else {=0A=
			/* Half Duplex and 1000 Mbps */=0A=
			TITAN_GE_WRITE((TITAN_GE_GMII_CONFIG_MODE +=0A=
					(port_num << 12)), 0x2201);=0A=
			}=0A=
	}=0A=
	if (phy_reg & 0x4000) {=0A=
		if (phy_reg & 0x2000) {=0A=
			/* Full Duplex and 100 Mbps */=0A=
			TITAN_GE_WRITE((TITAN_GE_GMII_CONFIG_MODE +=0A=
					(port_num << 12)), 0x100);=0A=
		} else {=0A=
			/* Half Duplex and 100 Mbps */=0A=
			TITAN_GE_WRITE((TITAN_GE_GMII_CONFIG_MODE +=0A=
					(port_num << 12)), 0x2100);=0A=
		}=0A=
	}=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_GMII_CONFIG_GENERAL +=0A=
				(port_num << 12));=0A=
	reg_data |=3D 0x3;=0A=
	TITAN_GE_WRITE((TITAN_GE_GMII_CONFIG_GENERAL +=0A=
			(port_num << 12)), reg_data);=0A=
}=0A=
=0A=
/*=0A=
 * Configure the PHY. No support for TBI (10 Bit Interface) as yet. =0A=
 * Hence, we need to make use of MDIO for communication with the =0A=
 * external PHY. The PHY uses GMII=0A=
 */=0A=
static int titan_phy_setup(titan_ge_port_info * titan_ge_eth)=0A=
{=0A=
	unsigned int reg_data;=0A=
	int err =3D 0;=0A=
	titan_ge_mdio_config *titan_ge_mdio =3D =0A=
		kmalloc(sizeof(titan_ge_mdio_config), GFP_KERNEL);=0A=
=0A=
	titan_ge_mdio->clka =3D 0x301f;		/* Clock */=0A=
	titan_ge_mdio->mdio_spre =3D 0x0000;	/* Generate 32-bit Preamble */=0A=
	titan_ge_mdio->mdio_mode =3D 0x4000;	/* Direct mode */=0A=
	titan_ge_mdio_setup(titan_ge_mdio);	/* Setup the SCMB and the MDIO =
*/=0A=
=0A=
	/* Now read the PHY status register */=0A=
	err =3D titan_ge_wait_autoneg();=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR)=0A=
		return TITAN_ERROR;=0A=
=0A=
	/* Now read the Model of the PHY */=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID, MII_PHYSID2,=0A=
			       &reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY status register 0x3 \n");=0A=
		return TITAN_ERROR;=0A=
	}=0A=
=0A=
	printk("Marvel PHY Model Number : %x  \n", reg_data);=0A=
=0A=
	/* Interrupt Enable Registers for the PHY */=0A=
	err =3D=0A=
	    titan_ge_mdio_read(TITAN_GE_MARVEL_PHY_ID,=0A=
			       TITAN_GE_MDIO_PHY_IE, &reg_data);=0A=
=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY control register 0x11 \n");=0A=
		return TITAN_ERROR;=0A=
	}=0A=
=0A=
	/*=0A=
	 * Description:=0A=
	 *=0A=
	 * Speed Change interrupt Enable=0A=
	 * Duplex Change interrupt Enable=0A=
	 * Link status change interrupt enable=0A=
	 */=0A=
	reg_data |=3D 0x34;=0A=
=0A=
	err =3D=0A=
	    titan_ge_mdio_write(TITAN_GE_MARVEL_PHY_ID, MII_BMCR,=0A=
				reg_data);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not write to PHY control register 0x9 \n");=0A=
		return TITAN_ERROR;=0A=
	}=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Enable the TMAC if it is not=0A=
 */=0A=
static void titan_ge_enable_tx(unsigned int port_num)=0A=
{=0A=
	unsigned long reg_data;=0A=
=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 +=0A=
				(port_num << 12));=0A=
	if (!(reg_data & 0x8000)) {=0A=
		printk("TMAC disabled for port %d!! \n", port_num);=0A=
=0A=
		reg_data |=3D 0x0001;	/* Enable TMAC */=0A=
		reg_data |=3D 0x4000;	/* CRC Check Enable */=0A=
		reg_data |=3D 0x2000;	/* Padding enable */=0A=
		reg_data |=3D 0x0800;	/* CRC Add enable */=0A=
		reg_data |=3D 0x0080;	/* PAUSE frame */=0A=
=0A=
		TITAN_GE_WRITE((TITAN_GE_TMAC_CONFIG_1 +=0A=
				(port_num << 12)), reg_data);=0A=
	}=0A=
}=0A=
=0A=
/*=0A=
 * Tx Timeout function=0A=
 */=0A=
static void titan_ge_tx_timeout(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth =3D netdev->priv;=0A=
=0A=
	printk(KERN_INFO "%s: TX timeout  ", netdev->name);=0A=
	printk(KERN_INFO "Resetting card \n");=0A=
=0A=
	/* Do the reset outside of interrupt context */=0A=
	schedule_task(&titan_ge_eth->tx_timeout_task);=0A=
}=0A=
=0A=
/*=0A=
 * Update the AFX tables for UC and MC for slice 0 only=0A=
 */=0A=
static void titan_ge_update_afx(titan_ge_port_info * titan_ge_eth)=0A=
{=0A=
	unsigned int i;=0A=
	volatile unsigned long reg_data =3D 0;=0A=
	u8 p_addr[6];=0A=
	int port =3D titan_ge_eth->port_num;=0A=
=0A=
	memcpy(p_addr, titan_ge_eth->port_mac_addr, 6);=0A=
=0A=
	/* Set the MAC address here for TMAC and RMAC */=0A=
        TITAN_GE_WRITE((TITAN_GE_TMAC_STATION_HI + (port << 12)),=0A=
                       ((p_addr[5] << 8) | p_addr[4]));=0A=
        TITAN_GE_WRITE((TITAN_GE_TMAC_STATION_MID + (port << 12)),=0A=
                       ((p_addr[3] << 8) | p_addr[2]));=0A=
        TITAN_GE_WRITE((TITAN_GE_TMAC_STATION_LOW + (port << 12)), =0A=
                       ((p_addr[1] << 8) | p_addr[0]));=0A=
=0A=
        TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_HI + (port << 12)),=0A=
                       ((p_addr[5] << 8) | p_addr[4]));=0A=
        TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_MID + (port << 12)),=0A=
                       ((p_addr[3] << 8) | p_addr[2]));=0A=
        TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_LOW + (port << 12)),=0A=
                       ((p_addr[1] << 8) | p_addr[0]));=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	TITAN_GE_WRITE((0x1164 | (port << 12)), 0x1);=0A=
#else=0A=
	TITAN_GE_WRITE((0x112c | (port << 12)), 0x1);=0A=
#endif=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Configure the sixteen address filters */=0A=
        for (i =3D 0; i < 16; i++) {=0A=
                /* Select each of the sixteen filters */=0A=
                TITAN_GE_WRITE((TITAN_GE_AFX_ADDRS_FILTER_CTRL_2 +=0A=
                                (port << 12)), i);=0A=
=0A=
                /* Configure the match */=0A=
                reg_data =3D 0x9; /* Forward Enable Bit */=0A=
                TITAN_GE_WRITE((TITAN_GE_AFX_ADDRS_FILTER_CTRL_0 +=0A=
                                (port << 12)), reg_data);=0A=
=0A=
                /* Finally, AFX Exact Match Address Registers */=0A=
                TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_LOW + (port << =
12)),=0A=
                               ((p_addr[1] << 8) | p_addr[0]));=0A=
                TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_MID + (port << =
12)),=0A=
                               ((p_addr[3] << 8) | p_addr[2]));=0A=
                TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_HIGH + (port =
<< 12)),=0A=
                               ((p_addr[5] << 8) | p_addr[4]));=0A=
=0A=
		/* VLAN id set to 0 */=0A=
                TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_VID +=0A=
                                (port << 12)), 0);=0A=
        }=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Configure the eight address filters */=0A=
	for (i =3D 0; i < 8; i++) {=0A=
		/* Select each of the eight filters */=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_ADDRS_FILTER_CTRL_2 +=0A=
				(port << 12)), i);=0A=
=0A=
		/* Configure the match */=0A=
		reg_data =3D 0x9;	/* Forward Enable Bit */=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_ADDRS_FILTER_CTRL_0 +=0A=
				(port << 12)), reg_data);=0A=
=0A=
		/* Finally, AFX Exact Match Address Registers */=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_LOW + (port << 12)),=0A=
			       ((p_addr[1] << 8) | p_addr[0]));=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_MID + (port << 12)),=0A=
			       ((p_addr[3] << 8) | p_addr[2]));=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_HIGH + (port << 12)),=0A=
			       ((p_addr[5] << 8) | p_addr[4]));=0A=
=0A=
		/* VLAN id set to 0 */=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_EXACT_MATCH_VID + =0A=
				(port << 12)), 0);=0A=
	}=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
}=0A=
=0A=
/*=0A=
 * Actual Routine to reset the adapter when the timeout occurred=0A=
 */=0A=
static void titan_ge_tx_timeout_task(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth =3D netdev->priv;=0A=
	int port =3D titan_ge_eth->port_num;=0A=
=0A=
	printk("Titan GE: Transmit timed out. Resetting ... \n");=0A=
=0A=
	/* Dump debug info */=0A=
	printk(KERN_ERR "TRTG cause : %x \n",=0A=
			(unsigned long)TITAN_GE_READ(0x100c + (port << 12)));=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	/* Fix this for the other ports */=0A=
	printk(KERN_ERR "FIFO cause : %x \n",=0A=
			(unsigned long)TITAN_GE_READ(0x282c));=0A=
	printk(KERN_ERR "IE cause : %x \n",=0A=
                        (unsigned long)TITAN_GE_READ(0x0024));=0A=
	printk(KERN_ERR "XDMA GDI ERROR : %x \n",=0A=
                        (unsigned long)TITAN_GE_READ(0x3008 + (port << =
9)));=0A=
	printk(KERN_ERR "CHANNEL ERROR: %x \n",=0A=
                        (unsigned =
long)TITAN_GE_READ(TITAN_GE_CHANNEL0_INTERRUPT=0A=
                                                + (port << 9)));=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Fix this for the other ports */=0A=
        printk(KERN_ERR "FIFO cause : %x \n",=0A=
                        (unsigned long)TITAN_GE_READ(0x482c));=0A=
	printk(KERN_ERR "IE cause : %x \n",=0A=
			(unsigned long)TITAN_GE_READ(0x0040));=0A=
	printk(KERN_ERR "XDMA GDI ERROR : %x \n",=0A=
			(unsigned long)TITAN_GE_READ(0x5008 + (port << 8)));=0A=
	printk(KERN_ERR "CHANNEL ERROR: %x \n",=0A=
			(unsigned long)TITAN_GE_READ(TITAN_GE_CHANNEL0_INTERRUPT=0A=
						+ (port << 8)));	=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	netif_device_detach(netdev);=0A=
	titan_ge_port_reset(titan_ge_eth->port_num);=0A=
	titan_ge_port_start(netdev, titan_ge_eth);=0A=
	netif_device_attach(netdev);=0A=
}=0A=
=0A=
/*=0A=
 * Change the MTU of the Ethernet Device=0A=
 */=0A=
static int titan_ge_change_mtu(struct net_device *netdev, int =
new_mtu)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num;=0A=
	unsigned long flags;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	spin_lock_irqsave(&titan_ge_eth->lock, flags);=0A=
=0A=
	if ((new_mtu > 9500) || (new_mtu < 64)) {=0A=
		spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
		return -EINVAL;=0A=
	}=0A=
=0A=
	netdev->mtu =3D new_mtu;=0A=
=0A=
	/* Now we have to reopen the interface so that SKBs with the new=0A=
	 * size will be allocated */=0A=
=0A=
	if (netif_running(netdev)) {=0A=
		if (titan_ge_eth_stop(netdev) !=3D TITAN_OK) {=0A=
			printk(KERN_ERR=0A=
			       "%s: Fatal error on stopping device\n",=0A=
			       netdev->name);=0A=
			spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
			return -1;=0A=
		}=0A=
=0A=
		if (titan_ge_eth_open(netdev) !=3D TITAN_OK) {=0A=
			printk(KERN_ERR=0A=
			       "%s: Fatal error on opening device\n",=0A=
			       netdev->name);=0A=
			spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
			return -1;=0A=
		}=0A=
	}=0A=
=0A=
	spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Reset the XDMA unit due to errors=0A=
 */=0A=
static void titan_ge_xdma_reset(void)=0A=
{=0A=
       unsigned long   reg_data;=0A=
=0A=
       reg_data =3D TITAN_GE_READ(TITAN_GE_XDMA_CONFIG);=0A=
       reg_data |=3D 0x80000000;=0A=
       TITAN_GE_WRITE(TITAN_GE_XDMA_CONFIG, reg_data);=0A=
=0A=
       mdelay(2);=0A=
=0A=
       reg_data =3D TITAN_GE_READ(TITAN_GE_XDMA_CONFIG);=0A=
       reg_data &=3D ~(0x80000000);=0A=
       TITAN_GE_WRITE(TITAN_GE_XDMA_CONFIG, reg_data);=0A=
}=0A=
=0A=
/*=0A=
 * Titan Gbe Interrupt Handler. All the three ports=0A=
 * send interrupt to one line only. Once an interrupt=0A=
 * is triggered, figure out the port and then check=0A=
 * the channel.=0A=
 */=0A=
static void titan_ge_int_handler(int irq, void *dev_id,=0A=
				 struct pt_regs *regs)=0A=
{=0A=
	struct net_device *netdev =3D (struct net_device *) dev_id;=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num, reg_data;=0A=
	unsigned long eth_int_cause_error =3D 0, is, temp;=0A=
	unsigned long eth_int_cause1;=0A=
	int err =3D 0;=0A=
	unsigned int count;=0A=
#ifdef CONFIG_SMP=0A=
	unsigned long eth_int_cause2;=0A=
#endif=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Ack the CPU interrupt */=0A=
=0A=
/* If we have separate interrupts for all the channels something=0A=
   different has to be done=0A=
*/=0A=
=0A=
#ifdef CONFIG_MIPS64 =0A=
		is =3D *(volatile u_int32_t *)(0xffffffff00000000=0A=
			 | RM9150_GCIC_INT3_STATUS);=0A=
		temp =3D 0xffffffff00000000 | RM9150_GCIC_INT3_CLEAR;=0A=
		*(volatile u_int32_t *)(temp) =3D is;=0A=
#else		=0A=
                is =3D *(volatile u_int32_t =
*)(RM9150_GCIC_INT3_STATUS);=0A=
=0A=
		*(volatile u_int32_t *)(RM9150_GCIC_INT3_CLEAR) =3D is;=0A=
=0A=
#endif=0A=
=0A=
        eth_int_cause1 =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_CORE_A);=0A=
=0A=
	if (eth_int_cause1 =3D=3D 0) {=0A=
                eth_int_cause_error =3D =
TITAN_GE_READ(TITAN_GE_CHANNEL0_INTERRUPT =0A=
						+ (port_num << 9));=0A=
=0A=
                if (eth_int_cause_error =3D=3D 0)=0A=
                        return;=0A=
        }=0A=
	/* Handle Tx first. No need to ack interrupts */=0A=
=0A=
	if (eth_int_cause1 & 0x20002) =0A=
		titan_ge_free_tx_queue(titan_ge_eth);=0A=
		=0A=
#ifdef TITAN_RX_NAPI=0A=
	/* Handle the Rx next */=0A=
=0A=
	if (eth_int_cause1 & 0x10001) {=0A=
=0A=
		if (netif_rx_schedule_prep(netdev)) {=0A=
			unsigned int ack;=0A=
	=0A=
			ack =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_IE);=0A=
			/* Disable Tx and Rx both */=0A=
			if (port_num =3D=3D 0) =0A=
				ack &=3D ~(0x3);=0A=
			if (port_num =3D=3D 1) =0A=
				ack &=3D ~(0x30000);=0A=
=0A=
			/* Interrupts have been disabled */=0A=
			TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, ack);=0A=
=0A=
			__netif_rx_schedule(netdev);=0A=
		}=0A=
	}=0A=
#else=0A=
	titan_ge_free_tx_queue(titan_ge_eth);=0A=
	count =3D titan_ge_receive_queue(netdev, 0);=0A=
=0A=
#endif=0A=
	/* Handle error interrupts */=0A=
        if (eth_int_cause_error && =0A=
		(eth_int_cause_error !=3D 0x2)) {=0A=
/*=0A=
	  TITAN_GE_READ(TITAN_GE_GXIS);=0A=
*/=0A=
		printk(KERN_ERR=0A=
			"XDMA Channel Error : %x  on port %d\n",=0A=
			eth_int_cause_error, port_num);=0A=
=0A=
		printk(KERN_ERR=0A=
			"XDMA GDI Hardware error : %x  on port %d\n",=0A=
			TITAN_GE_READ(0x3008 + (port_num << 9)), port_num);=0A=
=0A=
		printk(KERN_ERR=0A=
			"XDMA currently has %d Rx descriptors \n",=0A=
			TITAN_GE_READ(0x3048 + (port_num << 9)));=0A=
=0A=
		printk(KERN_ERR=0A=
			"XDMA currently has prefetcted %d Rx descriptors \n",=0A=
			TITAN_GE_READ(0x305c + (port_num << 9)));=0A=
	=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_INTERRUPT +=0A=
                               (port_num << 9)), =
eth_int_cause_error);=0A=
        }=0A=
=0A=
	/*=0A=
	 * PHY interrupt to inform abt the changes. Reading the =0A=
	 * PHY Status register will clear the interrupt=0A=
	 */=0A=
	if ((!(eth_int_cause1 & 0x30003)) && =0A=
		(eth_int_cause_error =3D=3D 0)) {=0A=
		err =3D=0A=
		    titan_ge_mdio_read(port_num,=0A=
			       TITAN_GE_MDIO_PHY_IS, &reg_data);=0A=
=0A=
		if (reg_data & 0x0400) {=0A=
			/* Link status change */=0A=
			titan_ge_mdio_read(port_num,=0A=
				   TITAN_GE_MDIO_PHY_STATUS, &reg_data);=0A=
			if (!(reg_data & 0x0400)) {=0A=
				/* Link is down */=0A=
				netif_carrier_off(netdev);=0A=
				netif_stop_queue(netdev);=0A=
			} else {=0A=
				/* Link is up */=0A=
				netif_carrier_on(netdev);=0A=
				netif_wake_queue(netdev);=0A=
=0A=
				/* Enable the queue */=0A=
				titan_ge_enable_tx(port_num);=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Ack the CPU interrupt */=0A=
        if (port_num =3D=3D 1) {=0A=
#ifdef CONFIG_MIPS64=0A=
                is =3D *(volatile u_int32_t *)(0xfffffffffb001b00);=0A=
                *(volatile u_int32_t *)(0xfffffffffb001b0c) =3D is;=0A=
#else=0A=
                is =3D *(volatile u_int32_t *)(0xfb001b00);=0A=
                *(volatile u_int32_t *)(0xfb001b0c) =3D is;=0A=
#endif=0A=
                                                                        =
          =0A=
#ifdef CONFIG_SMP=0A=
                is =3D *(volatile u_int32_t *)(0xfb002b00);=0A=
                *(volatile u_int32_t *)(0xfb002b0c) =3D is;=0A=
#endif=0A=
        }=0A=
                                                                        =
          =0A=
        if (port_num =3D=3D 0) {=0A=
#ifdef CONFIG_MIPS64=0A=
                is =3D *(volatile u_int32_t *)(0xfffffffffb001b10); =0A=
                *(volatile u_int32_t *)(0xfffffffffb001b1c) =3D is;=0A=
#else=0A=
                is =3D *(volatile u_int32_t *)(0xfb001b10);=0A=
                *(volatile u_int32_t *)(0xfb001b1c) =3D is;=0A=
#endif=0A=
                                                                        =
          =0A=
#ifdef CONFIG_SMP=0A=
                is =3D *(volatile u_int32_t *)(0xfb002b10);=0A=
                *(volatile u_int32_t *)(0xfb002b1c) =3D is;=0A=
#endif=0A=
        }		=0A=
=0A=
#ifdef TITAN_GE_12=0A=
	if (port_num =3D=3D 2) {=0A=
#ifdef CONFIG_MIPS64=0A=
		is =3D *(volatile u_int32_t *)(0xfffffffffb001b40);=0A=
		*(volatile u_int32_t *)(0xfffffffffb001b4c) =3D is;=0A=
#else=0A=
		is =3D *(volatile u_int32_t *)(0xfb001b40);=0A=
		*(volatile u_int32_t *)(0xfb001b4c) =3D is;=0A=
#endif=0A=
=0A=
#ifdef CONFIG_SMP=0A=
		is =3D *(volatile u_int32_t *)(0xfb002b40);=0A=
		*(volatile u_int32_t *)(0xfb002b4c) =3D is;=0A=
#endif=0A=
	}=0A=
#endif	=0A=
=0A=
	eth_int_cause1 =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_CORE_A);=0A=
#ifdef CONFIG_SMP=0A=
	eth_int_cause2 =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_CORE_B);=0A=
#endif=0A=
=0A=
	/* Spurious interrupt */=0A=
#ifdef CONFIG_SMP=0A=
	if ( (eth_int_cause1 =3D=3D 0) && (eth_int_cause2 =3D=3D 0)) {=0A=
#else=0A=
	if (eth_int_cause1 =3D=3D 0) {=0A=
#endif=0A=
		eth_int_cause_error =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_INTERRUPT =
+=0A=
					(port_num << 8));=0A=
=0A=
		if (eth_int_cause_error =3D=3D 0)=0A=
			return;=0A=
	}=0A=
=0A=
	/* Handle Tx first. No need to ack interrupts */=0A=
#ifdef CONFIG_SMP=0A=
	if ( (eth_int_cause1 & 0x20202) || =0A=
		(eth_int_cause2 & 0x20202) )=0A=
#else=0A=
	if (eth_int_cause1 & 0x20202) =0A=
#endif=0A=
		titan_ge_free_tx_queue(titan_ge_eth);=0A=
		=0A=
#ifdef TITAN_RX_NAPI=0A=
	/* Handle the Rx next */=0A=
#ifdef CONFIG_SMP=0A=
	if ( (eth_int_cause1 & 0x10101) ||=0A=
		(eth_int_cause2 & 0x10101)) {=0A=
#else=0A=
	if (eth_int_cause1 & 0x10101) {=0A=
#endif=0A=
		if (netif_rx_schedule_prep(netdev)) {=0A=
			unsigned int ack;=0A=
	=0A=
			ack =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_IE);=0A=
			/* Disable Tx and Rx both */=0A=
			if (port_num =3D=3D 0) =0A=
				ack &=3D ~(0x3);=0A=
			if (port_num =3D=3D 1) =0A=
				ack &=3D ~(0x300);=0A=
			if (port_num =3D=3D 2) =0A=
				ack &=3D ~(0x30000);=0A=
=0A=
			/* Interrupts have been disabled */=0A=
			TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, ack);=0A=
=0A=
			__netif_rx_schedule(netdev);=0A=
		}=0A=
	}=0A=
#else=0A=
	titan_ge_free_tx_queue(titan_ge_eth);=0A=
	count =3D titan_ge_receive_queue(netdev, 0);=0A=
=0A=
#endif=0A=
	/* Handle error interrupts */=0A=
        if (eth_int_cause_error && =0A=
		(eth_int_cause_error !=3D 0x2)) {=0A=
		printk(KERN_ERR=0A=
			"XDMA Channel Error : %x  on port %d\n",=0A=
			eth_int_cause_error, port_num);=0A=
=0A=
		printk(KERN_ERR=0A=
			"XDMA GDI Hardware error : %x  on port %d\n",=0A=
			TITAN_GE_READ(0x5008 + (port_num << 8)), port_num);=0A=
=0A=
		printk(KERN_ERR=0A=
			"XDMA currently has %d Rx descriptors \n",=0A=
			TITAN_GE_READ(0x5048 + (port_num << 8)));=0A=
=0A=
		printk(KERN_ERR=0A=
			"XDMA currently has prefetcted %d Rx descriptors \n",=0A=
			TITAN_GE_READ(0x505c + (port_num << 8)));=0A=
	=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_INTERRUPT +=0A=
                               (port_num << 8)), =
eth_int_cause_error);=0A=
        }=0A=
=0A=
	/*=0A=
	 * PHY interrupt to inform abt the changes. Reading the =0A=
	 * PHY Status register will clear the interrupt=0A=
	 */=0A=
	if ((!(eth_int_cause1 & 0x30303)) && =0A=
		(eth_int_cause_error =3D=3D 0)) {=0A=
		err =3D=0A=
		    titan_ge_mdio_read(port_num,=0A=
			       TITAN_GE_MDIO_PHY_IS, &reg_data);=0A=
=0A=
		if (reg_data & 0x0400) {=0A=
			/* Link status change */=0A=
			titan_ge_mdio_read(port_num,=0A=
				   TITAN_GE_MDIO_PHY_STATUS, &reg_data);=0A=
			if (!(reg_data & 0x0400)) {=0A=
				/* Link is down */=0A=
				netif_carrier_off(netdev);=0A=
				netif_stop_queue(netdev);=0A=
			} else {=0A=
				/* Link is up */=0A=
				netif_carrier_on(netdev);=0A=
				netif_wake_queue(netdev);=0A=
=0A=
				/* Enable the queue */=0A=
				titan_ge_enable_tx(port_num);=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
}=0A=
=0A=
/*=0A=
 * Multicast and Promiscuous mode set. The =0A=
 * set_multi entry point is called whenever the =0A=
 * multicast address list or the network interface =0A=
 * flags are updated.=0A=
 */=0A=
static void titan_ge_set_multi(struct net_device *netdev)=0A=
{=0A=
	unsigned long reg_data;=0A=
	struct dev_mc_list *mc_ptr;=0A=
	unsigned int port_num;=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_AFX_ADDRS_FILTER_CTRL_1 + =0A=
				(port_num << 12));=0A=
=0A=
	if (netdev->flags & IFF_PROMISC) {=0A=
		reg_data |=3D 0x2;=0A=
	}=0A=
	else if (netdev->flags & IFF_ALLMULTI) {=0A=
		reg_data |=3D 0x01;=0A=
		reg_data |=3D 0x400; /* Use the 64-bit Multicast Hash bin */=0A=
	}=0A=
	else {=0A=
		reg_data =3D 0x2;=0A=
	}=0A=
=0A=
	TITAN_GE_WRITE((TITAN_GE_AFX_ADDRS_FILTER_CTRL_1 + =0A=
			(port_num << 12)), reg_data);=0A=
	if (reg_data & 0x01) {=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_MULTICAST_HASH_LOW +=0A=
				(port_num << 12)), 0xffff);=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_MULTICAST_HASH_MIDLOW +=0A=
				(port_num << 12)), 0xffff);=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_MULTICAST_HASH_MIDHI +=0A=
				(port_num << 12)), 0xffff);=0A=
		TITAN_GE_WRITE((TITAN_GE_AFX_MULTICAST_HASH_HI +=0A=
				(port_num << 12)), 0xffff);=0A=
	}=0A=
}=0A=
=0A=
/*=0A=
 * Open the network device=0A=
 */=0A=
static int titan_ge_open(struct net_device *netdev)=0A=
{=0A=
	int retval;=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	retval =3D request_irq(6, titan_ge_int_handler,=0A=
                        SA_SHIRQ | SA_SAMPLE_RANDOM , netdev->name, =
netdev);=0A=
=0A=
	if (retval !=3D 0) {=0A=
                printk(KERN_ERR "Cannot assign IRQ number to TITAN GE =
\n");=0A=
                return -1;=0A=
        } else {=0A=
                   netdev->irq =3D 6;=0A=
                   printk(KERN_INFO "Assigned IRQ %d to port %d\n",=0A=
                                netdev->irq, port_num);=0A=
        }=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	if (port_num =3D=3D 2)=0A=
		retval =3D request_irq(7, titan_ge_int_handler,=0A=
			SA_SHIRQ | SA_SAMPLE_RANDOM , netdev->name, netdev);=0A=
	else=0A=
		retval =3D request_irq(TITAN_ETH_PORT_IRQ - port_num, =0A=
			titan_ge_int_handler, SA_SHIRQ | SA_SAMPLE_RANDOM , =0A=
			netdev->name, netdev);=0A=
=0A=
	if (retval !=3D 0) {=0A=
		printk(KERN_ERR "Cannot assign IRQ number to TITAN GE \n");=0A=
		return -1;=0A=
	} else {=0A=
		if (port_num =3D=3D 2)=0A=
			netdev->irq =3D 7;=0A=
		else=0A=
			netdev->irq =3D TITAN_ETH_PORT_IRQ - port_num;=0A=
=0A=
=0A=
		printk(KERN_INFO "Assigned IRQ %d to port %d\n", =0A=
				netdev->irq, port_num);=0A=
	}=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	spin_lock_irq(&(titan_ge_eth->lock));=0A=
=0A=
=0A=
	if (titan_ge_eth_open(netdev) !=3D TITAN_OK) {=0A=
		printk("%s: Error opening interface \n", netdev->name);=0A=
		spin_unlock_irq(&(titan_ge_eth->lock));=0A=
		free_irq(netdev->irq, netdev);=0A=
		return -EBUSY;=0A=
	}=0A=
=0A=
	SET_MODULE_OWNER(netdev);=0A=
	spin_unlock_irq(&(titan_ge_eth->lock));=0A=
=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Return the Rx buffer back to the Rx ring=0A=
 */=0A=
static int titan_ge_rx_return_buff(titan_ge_port_info * =
titan_ge_port,=0A=
					struct sk_buff *skb)=0A=
{=0A=
	int rx_used_desc;=0A=
	volatile titan_ge_rx_desc *rx_desc;=0A=
=0A=
	rx_used_desc =3D titan_ge_port->rx_used_desc_q;=0A=
	rx_desc =3D &(titan_ge_port->rx_desc_area[rx_used_desc]);=0A=
=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
	rx_desc->buffer_addr =3D=0A=
               pci_map_single(0, skb->data, TITAN_GE_JUMBO_BUFSIZE - =
2,=0A=
                                            PCI_DMA_FROMDEVICE);=0A=
#else=0A=
	rx_desc->buffer_addr =3D =0A=
                pci_map_single(0, skb->data, TITAN_GE_STD_BUFSIZE - =
2,=0A=
                                            PCI_DMA_FROMDEVICE);=0A=
#endif=0A=
=0A=
	titan_ge_port->rx_skb[rx_used_desc] =3D skb;=0A=
	rx_desc->cmd_sts =3D TITAN_GE_RX_BUFFER_OWNED;=0A=
=0A=
	titan_ge_port->rx_used_desc_q =3D=0A=
    	(rx_used_desc + 1) % TITAN_GE_RX_QUEUE;=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Allocate the SKBs for the Rx ring. Also used =0A=
 * for refilling the queue=0A=
 */=0A=
static int titan_ge_rx_task(struct net_device *netdev, =0A=
				titan_ge_port_info *titan_ge_eth)=0A=
{=0A=
	struct sk_buff *skb;=0A=
	int count =3D 0;=0A=
=0A=
	while (titan_ge_eth->rx_ring_skbs < titan_ge_eth->rx_ring_size) {=0A=
=0A=
	/* First try to get the skb from the recycler */=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
=0A=
		skb =3D get_recycle(titan_ge_eth);=0A=
=0A=
		if (!skb) {=0A=
#endif=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
			skb =3D titan_ge_alloc_skb(TITAN_GE_JUMBO_BUFSIZE, GFP_ATOMIC);=0A=
#else	=0A=
			skb =3D titan_ge_alloc_skb(TITAN_GE_STD_BUFSIZE, GFP_ATOMIC);=0A=
#endif=0A=
			if (!skb) {	=0A=
				/* OOM, set the flag */=0A=
				printk("OOM \n");=0A=
				oom_flag =3D 1;=0A=
				break;=0A=
			}=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
			skb->cpu =3D smp_processor_id();=0A=
			atomic_inc(&titan_ge_rc[smp_processor_id()].cnt);=0A=
		}=0A=
		skb->skb_recycle =3D titan_ge_recycle;=0A=
#endif=0A=
		count++;=0A=
		skb->dev =3D netdev;=0A=
		=0A=
		titan_ge_eth->rx_ring_skbs++;=0A=
=0A=
		if (titan_ge_rx_return_buff(titan_ge_eth, skb) !=3D=0A=
		    TITAN_OK) {=0A=
			printk(KERN_ERR "%s: Error allocating RX Ring\n",=0A=
			       netdev->name);=0A=
			break;=0A=
		}=0A=
	}=0A=
=0A=
	return count;=0A=
}=0A=
=0A=
/*=0A=
 * Actual init of the Tital GE port. There is one register for =0A=
 * the channel configuration=0A=
 */=0A=
static void titan_port_init(struct net_device *netdev,=0A=
			    titan_ge_port_info * titan_ge_eth)=0A=
{=0A=
	unsigned long reg_data;=0A=
	int port_num;=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
        for (port_num =3D 0; port_num < 2; port_num++) {=0A=
=0A=
		titan_ge_port_reset(port_num);=0A=
=0A=
                /* First reset the TMAC */=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 9));=0A=
                reg_data |=3D 0x80000000;=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
9)), reg_data);=0A=
=0A=
                udelay(30);=0A=
=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 9));=0A=
                reg_data &=3D ~(0xc0000000);=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
9)), reg_data);=0A=
=0A=
                /* Now reset the RMAC */=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 9));=0A=
                reg_data |=3D 0x0010000;=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
9)), reg_data);=0A=
=0A=
                udelay(30);=0A=
=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 9));=0A=
                reg_data &=3D ~(0x00180000);=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
9)), reg_data);=0A=
        }=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	for (port_num =3D 0; port_num < 3; port_num++) {=0A=
=0A=
		titan_ge_port_reset(port_num);=0A=
=0A=
                /* First reset the TMAC */=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 8));=0A=
                reg_data |=3D 0x80000000;=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
8)), reg_data);=0A=
=0A=
                udelay(30);=0A=
=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 8));=0A=
                reg_data &=3D ~(0xc0000000);=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
8)), reg_data);=0A=
=0A=
                /* Now reset the RMAC */=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 8));=0A=
                reg_data |=3D 0x00080000;=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
8)), reg_data);=0A=
=0A=
                udelay(30);=0A=
=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =
(port_num << 8));=0A=
                reg_data &=3D ~(0x000c0000);=0A=
                TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << =
8)), reg_data);=0A=
        }=0A=
=0A=
#endif=0A=
}=0A=
=0A=
/*=0A=
 * Start the port. All the hardware specific configuration=0A=
 * for the XDMA, Tx FIFO, Rx FIFO, TMAC, RMAC, TRTG and AFX=0A=
 * go here=0A=
 */=0A=
static int titan_ge_port_start(struct net_device *netdev,=0A=
				titan_ge_port_info * titan_port)=0A=
{=0A=
	volatile unsigned long reg_data, reg_data1, reg_data_1;=0A=
	int count =3D 0;=0A=
	int port_num =3D titan_port->port_num;=0A=
=0A=
	if (config_done =3D=3D 0) {=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
		reg_data =3D TITAN_GE_READ(0x0008);=0A=
		reg_data |=3D 0x100;=0A=
		TITAN_GE_WRITE(0x0008, reg_data);=0A=
=0A=
		reg_data &=3D ~(0x100);=0A=
		TITAN_GE_WRITE(0x0008, reg_data);=0A=
=0A=
		/* Turn on GMII/MII mode and turn off TBI mode */=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_CPIF2_GU0);=0A=
		reg_data &=3D ~(0x0000000C);=0A=
		TITAN_GE_WRITE(TITAN_GE_CPIF2_GU0, reg_data); =0A=
=0A=
#else=0A=
=0A=
		reg_data =3D TITAN_GE_READ(0x0004);=0A=
                reg_data |=3D 0x100;=0A=
                TITAN_GE_WRITE(0x0004, reg_data);=0A=
                                                                        =
          =0A=
                reg_data &=3D ~(0x100);=0A=
                TITAN_GE_WRITE(0x0004, reg_data);=0A=
=0A=
		/* Turn on GMII/MII mode and turn off TBI mode */=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_TSB_CTRL_1);=0A=
        	reg_data |=3D 0x00000700;=0A=
		reg_data &=3D ~(0x00800000); /* Fencing */=0A=
#ifdef TITAN_RX_NAPI=0A=
		TITAN_GE_WRITE(0x000c, 0x00001100);=0A=
#else=0A=
		TITAN_GE_WRITE(0x000c, 0x00000100); /* No WCIMODE */=0A=
#endif=0A=
	        TITAN_GE_WRITE(TITAN_GE_TSB_CTRL_1, reg_data);=0A=
=0A=
		/* Set the CPU Resource Limit register */=0A=
		TITAN_GE_WRITE(0x00f8, 0x8); =0A=
=0A=
		/* Be conservative when using the BIU buffers */=0A=
		TITAN_GE_WRITE(0x0068, 0x4);=0A=
=0A=
#endif // CONFIG_PMC_SEQUOIA=0A=
	}=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
	titan_port->tx_threshold =3D 0;=0A=
	titan_port->rx_threshold =3D 0;=0A=
#endif=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* We need to write the descriptors for Tx and Rx */=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_TX_DESC + (port_num << =
9)),=0A=
                       (unsigned long) titan_port->tx_dma);=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_RX_DESC + (port_num << =
9)),=0A=
                       (unsigned long) titan_port->rx_dma);=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* We need to write the descriptors for Tx and Rx */=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_TX_DESC + (port_num << =
8)),=0A=
                       (unsigned long) titan_port->tx_dma);=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_RX_DESC + (port_num << =
8)),=0A=
                       (unsigned long) titan_port->rx_dma);=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	if (config_done =3D=3D 0) {=0A=
		/* Step 1:  XDMA config	*/=0A=
	        reg_data =3D TITAN_GE_READ(TITAN_GE_XDMA_CONFIG);=0A=
		reg_data &=3D ~(0x80000000);      /* clear reset */=0A=
       		reg_data |=3D 0x1 << 29;	/* sparse tx descriptor spacing */=0A=
		reg_data |=3D 0x1 << 28;	/* sparse rx descriptor spacing */=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
		/* No support for coherency.  Has to be cleared */=0A=
		reg_data &=3D ~(0x1E00000);=0A=
=0A=
#else //CONFIG_PMC_SEUQOIA=0A=
=0A=
		reg_data |=3D (0x1 << 23) | (0x1 << 24);  /* Descriptor Rd and Wr =
Coherency */ =0A=
		reg_data |=3D (0x1 << 21) | (0x1 << 22);  /* Data Rd and Wr Coherency =
*/	=0A=
#endif //CONFIG_PMC_SEQUOIA		=0A=
		TITAN_GE_WRITE(TITAN_GE_XDMA_CONFIG, reg_data);=0A=
	}=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* IR register for the XDMA */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_GDI_INTERRUPT_ENABLE + =
(port_num << 9)=0A=
);=0A=
        reg_data |=3D 0xF006C000; /* No Rx_OOD */=0A=
        TITAN_GE_WRITE((TITAN_GE_GDI_INTERRUPT_ENABLE + (port_num << =
9)), reg_data);=0A=
=0A=
#else // CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* IR register for the XDMA */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_GDI_INTERRUPT_ENABLE + (port_num =
<< 8));=0A=
       	reg_data |=3D 0x80068000; /* No Rx_OOD */=0A=
       	TITAN_GE_WRITE((TITAN_GE_GDI_INTERRUPT_ENABLE + (port_num << =
8)), reg_data);=0A=
=0A=
#endif // CONFIG_PMC_SEQUOIA=0A=
=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Start the Tx and Rx XDMA controller */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + (port_num << =
9));=0A=
	reg_data &=3D 0x5fffffff;     /* Clear tx reset */=0A=
	reg_data &=3D 0xffebffff;     /* Clear rx reset */=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
	reg_data |=3D 0xa0;=0A=
	reg_data &=3D ~(0x38070000);=0A=
#else=0A=
	reg_data |=3D 0x40;=0A=
	reg_data &=3D ~(0x38070000);=0A=
#endif=0A=
=0A=
	TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << 9)), =
reg_data);=0A=
=0A=
	/* Rx desc count */=0A=
        count =3D titan_ge_rx_task(netdev, titan_port);=0A=
        TITAN_GE_WRITE((0x3048 + (port_num << 9)), count);=0A=
        count =3D TITAN_GE_READ(0x3048 + (port_num << 9));=0A=
=0A=
#else // CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Start the Tx and Rx XDMA controller */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + (port_num =
<< 8));=0A=
        reg_data &=3D 0x4fffffff;     /* Clear tx reset */=0A=
        reg_data &=3D 0xfff4ffff;     /* Clear rx reset */=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
        reg_data |=3D 0xa0 | 0x30030000;=0A=
#else=0A=
        reg_data |=3D 0x40 | 0x30030000;=0A=
#endif=0A=
=0A=
=0A=
=0A=
#ifndef CONFIG_SMP=0A=
	if (port_num =3D=3D 1) {=0A=
		reg_data &=3D ~(0x10);=0A=
		reg_data |=3D 0x0f; /* All of the packet */=0A=
	}=0A=
#endif=0A=
=0A=
=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG + (port_num << 8)), =
reg_data);=0A=
=0A=
	/* Rx desc count */=0A=
	count =3D titan_ge_rx_task(netdev, titan_port);=0A=
	TITAN_GE_WRITE((0x5048 + (port_num << 8)), count);=0A=
	count =3D TITAN_GE_READ(0x5048 + (port_num << 8));=0A=
=0A=
#endif // CONFIG_PMC_SEQUOIA=0A=
=0A=
	udelay(30);=0A=
=0A=
	/* =0A=
	 * Step 2:  Configure the SDQPF, i.e. FIFO =0A=
	 */=0A=
	if (config_done =3D=3D 0) {=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_RXFIFO_CTL);=0A=
		reg_data =3D 0x1;=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_CTL, reg_data);=0A=
		reg_data &=3D ~(0x1);=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_CTL, reg_data);=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_RXFIFO_CTL);=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_CTL, reg_data);=0A=
=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_TXFIFO_CTL);=0A=
		reg_data =3D 0x1;=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_CTL, reg_data);=0A=
		reg_data &=3D ~(0x1);=0A=
        	TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_CTL, reg_data);=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_TXFIFO_CTL);=0A=
        	TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_CTL, reg_data);=0A=
	}=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* =0A=
	 * Enable RX FIFO 0 and 8 =0A=
	 */=0A=
	if (port_num =3D=3D 0) {=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_RXFIFO_0);=0A=
	=0A=
		reg_data |=3D 0x100000;=0A=
		reg_data |=3D (0xff << 10);=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_0, reg_data);=0A=
		/* =0A=
		 * BAV2,BAV and DAV settings for the Rx FIFO =0A=
		 */=0A=
        	reg_data1 =3D TITAN_GE_READ(0x2844);=0A=
	       	reg_data1 |=3D ( (0x10 << 20) | (0x10 << 10) | 0x1);=0A=
        	TITAN_GE_WRITE(0x2844, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_0, reg_data);=0A=
=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_TXFIFO_0);=0A=
		reg_data |=3D 0x100000;=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_0, reg_data);=0A=
=0A=
		reg_data |=3D (0xff << 10);=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_0, reg_data);=0A=
	=0A=
		/* =0A=
		 * BAV2, BAV and DAV settings for the Tx FIFO =0A=
		 */=0A=
	        reg_data1 =3D TITAN_GE_READ(0x2910);=0A=
		reg_data1 =3D ( (0x1 << 20) | (0x1 << 10) | 0x10);=0A=
=0A=
	        TITAN_GE_WRITE(0x2910, reg_data1);=0A=
	=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_0, reg_data);=0A=
=0A=
	}=0A=
=0A=
	if (port_num =3D=3D 1) {=0A=
		reg_data =3D TITAN_GE_READ(0x28A0);=0A=
=0A=
		reg_data |=3D 0x100000;=0A=
		reg_data |=3D (0xff << 10) | (0xff + 1);=0A=
=0A=
		TITAN_GE_WRITE(0x28A0, reg_data);=0A=
		/*=0A=
		 * BAV2,BAV and DAV settings for the Rx FIFO=0A=
		 */=0A=
		reg_data1 =3D TITAN_GE_READ(0x28A4);=0A=
		reg_data1 |=3D ( (0x10 << 20) | (0x10 << 10) | 0x1);=0A=
		TITAN_GE_WRITE(0x28A4, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(0x28A0, reg_data);=0A=
=0A=
		reg_data =3D TITAN_GE_READ(0x2918);=0A=
		reg_data |=3D 0x100000;=0A=
=0A=
		TITAN_GE_WRITE(0x2918, reg_data);=0A=
		reg_data |=3D (0xff << 10) | (0xff + 1);=0A=
		TITAN_GE_WRITE(0x2918, reg_data);=0A=
=0A=
		/*=0A=
		 * BAV2, BAV and DAV settings for the Tx FIFO=0A=
		 */=0A=
		reg_data1 =3D TITAN_GE_READ(0x291C);=0A=
		reg_data1 =3D ( (0x1 << 20) | (0x1 << 10) | 0x10);=0A=
=0A=
		TITAN_GE_WRITE(0x291C, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(0x2918, reg_data);=0A=
	}=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* =0A=
	 * Enable RX FIFO 0, 4 and 8 =0A=
	 */=0A=
	if (port_num =3D=3D 0) {=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_RXFIFO_0);=0A=
	=0A=
		reg_data |=3D 0x100000;=0A=
		reg_data |=3D (0xff << 10);=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_0, reg_data);=0A=
		/* =0A=
		 * BAV2,BAV and DAV settings for the Rx FIFO =0A=
		 */=0A=
        	reg_data1 =3D TITAN_GE_READ(0x4844);=0A=
	       	reg_data1 |=3D ( (0x10 << 20) | (0x10 << 10) | 0x1);=0A=
        	TITAN_GE_WRITE(0x4844, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_RXFIFO_0, reg_data);=0A=
=0A=
		reg_data =3D TITAN_GE_READ(TITAN_GE_SDQPF_TXFIFO_0);=0A=
		reg_data |=3D 0x100000;=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_0, reg_data);=0A=
=0A=
		reg_data |=3D (0xff << 10);=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_0, reg_data);=0A=
	=0A=
		/* =0A=
		 * BAV2, BAV and DAV settings for the Tx FIFO =0A=
		 */=0A=
	        reg_data1 =3D TITAN_GE_READ(0x4944);=0A=
		reg_data1 =3D ( (0x1 << 20) | (0x1 << 10) | 0x10);=0A=
=0A=
	        TITAN_GE_WRITE(0x4944, reg_data1);=0A=
	=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_SDQPF_TXFIFO_0, reg_data);=0A=
=0A=
	}=0A=
=0A=
	if (port_num =3D=3D 1) {=0A=
		reg_data =3D TITAN_GE_READ(0x4870);=0A=
=0A=
		reg_data |=3D 0x100000;=0A=
		reg_data |=3D (0xff << 10) | (0xff + 1);=0A=
=0A=
		TITAN_GE_WRITE(0x4870, reg_data);=0A=
		/*=0A=
		 * BAV2,BAV and DAV settings for the Rx FIFO=0A=
		 */=0A=
		reg_data1 =3D TITAN_GE_READ(0x4874);=0A=
		reg_data1 |=3D ( (0x10 << 20) | (0x10 << 10) | 0x1);=0A=
		TITAN_GE_WRITE(0x4874, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(0x4870, reg_data);=0A=
=0A=
		reg_data =3D TITAN_GE_READ(0x494c);=0A=
		reg_data |=3D 0x100000;=0A=
=0A=
		TITAN_GE_WRITE(0x494c, reg_data);=0A=
		reg_data |=3D (0xff << 10) | (0xff + 1);=0A=
		TITAN_GE_WRITE(0x494c, reg_data);=0A=
=0A=
		/*=0A=
		 * BAV2, BAV and DAV settings for the Tx FIFO=0A=
		 */=0A=
		reg_data1 =3D TITAN_GE_READ(0x4950);=0A=
		reg_data1 =3D ( (0x1 << 20) | (0x1 << 10) | 0x10);=0A=
=0A=
		TITAN_GE_WRITE(0x4950, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(0x494c, reg_data);=0A=
	}=0A=
=0A=
	if (port_num =3D=3D 2) {=0A=
		reg_data =3D TITAN_GE_READ(0x48a0);=0A=
=0A=
		reg_data |=3D 0x100000;=0A=
		reg_data |=3D (0xff << 10) | (2*(0xff + 1));=0A=
=0A=
		TITAN_GE_WRITE(0x48a0, reg_data);=0A=
		/*=0A=
		 * BAV2,BAV and DAV settings for the Rx FIFO=0A=
		 */=0A=
		reg_data1 =3D TITAN_GE_READ(0x48a4);=0A=
		reg_data1 |=3D ( (0x10 << 20) | (0x10 << 10) | 0x1);=0A=
		TITAN_GE_WRITE(0x48a4, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(0x48a0, reg_data);=0A=
=0A=
		reg_data =3D TITAN_GE_READ(0x4958);=0A=
		reg_data |=3D 0x100000;=0A=
=0A=
		TITAN_GE_WRITE(0x4958, reg_data);=0A=
		reg_data |=3D (0xff << 10) | (2*(0xff + 1));=0A=
		TITAN_GE_WRITE(0x4958, reg_data);=0A=
=0A=
		/*=0A=
		 * BAV2, BAV and DAV settings for the Tx FIFO=0A=
		 */=0A=
		reg_data1 =3D TITAN_GE_READ(0x495c);=0A=
		reg_data1 =3D ( (0x1 << 20) | (0x1 << 10) | 0x10);=0A=
=0A=
		TITAN_GE_WRITE(0x495c, reg_data1);=0A=
=0A=
		reg_data &=3D ~(0x00100000);=0A=
		reg_data |=3D 0x200000;=0A=
=0A=
		TITAN_GE_WRITE(0x4958, reg_data);=0A=
	}=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* =0A=
	 * Step 3:  TRTG block enable =0A=
	 */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_TRTG_CONFIG + (port_num << =
12));=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	reg_data_1 =3D TITAN_GE_READ(0x103c + (port_num << 12));	=0A=
=0A=
	reg_data_1 |=3D 0x02020202;=0A=
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);=0A=
	TITAN_GE_WRITE((0x1040 + (port_num << 12)), reg_data_1);=0A=
=0A=
	mdelay(5);=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
#ifdef TITAN_GE_12=0A=
	/*=0A=
	 * This is the 1.2 revision of the chip. It has fix for the =0A=
	 * IP header alignment. Now, the IP header begins at an =0A=
	 * aligned address and this wont need an extra copy in the =0A=
	 * driver. This performance drawback existed in the previous=0A=
	 * versions of the silicon=0A=
	 */=0A=
	reg_data_1 =3D TITAN_GE_READ(0x103c + (port_num << 12));=0A=
	reg_data_1 |=3D 0x40000000;=0A=
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);=0A=
=0A=
	reg_data_1 |=3D 0x04000000;=0A=
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);=0A=
=0A=
	mdelay(5);=0A=
=0A=
	reg_data_1 &=3D ~(0x04000000);=0A=
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);=0A=
=0A=
	mdelay(5);=0A=
=0A=
#endif=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	reg_data |=3D 0x0001; =0A=
	TITAN_GE_WRITE((TITAN_GE_TRTG_CONFIG + (port_num << 12)), =
reg_data);=0A=
=0A=
=0A=
	/* =0A=
	 * Step 4:  Start the Tx activity =0A=
	 */=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_CONFIG_2 + (port_num << 12)), =
0xe197);=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
	TITAN_GE_WRITE((0x1258 + (port_num << 12)), 0x4000);=0A=
#endif=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 + (port_num << =
12));=0A=
	reg_data |=3D 0x0001;	/* Enable TMAC */=0A=
	reg_data |=3D 0x6c70;	/* PAUSE also set */=0A=
=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_CONFIG_1 + (port_num << 12)), =
reg_data);=0A=
=0A=
	udelay(30);=0A=
=0A=
	/* Destination Address drop bit */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_2 + (port_num =
<< 12));=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	reg_data |=3D 0x108;        /* DA_DROP bit and pause */=0A=
#else=0A=
        reg_data |=3D 0x218;        /* DA_DROP bit and pause */=0A=
#endif=0A=
        TITAN_GE_WRITE((TITAN_GE_RMAC_CONFIG_2 + (port_num << 12)), =
reg_data);=0A=
=0A=
	TITAN_GE_WRITE((0x1218 + (port_num << 12)), 0x3);=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
	TITAN_GE_WRITE((0x1208 + (port_num << 12)), 0x4000);=0A=
#endif=0A=
	/* Start the Rx activity */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 + (port_num << =
12));=0A=
	reg_data |=3D 0x0001;	/* RMAC Enable */=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* CRC Check enable */=0A=
	/* Min Frame check enable */=0A=
	/* Max Frame check enable */=0A=
=0A=
	reg_data |=3D 0x4CAA;=0A=
=0A=
#else=0A=
=0A=
	reg_data |=3D 0x0010;	/* CRC Check enable */=0A=
	reg_data |=3D 0x0040;	/* Min Frame check enable */=0A=
	reg_data |=3D 0x4400;	/* Max Frame check enable */=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	TITAN_GE_WRITE((TITAN_GE_RMAC_CONFIG_1 + (port_num << 12)), =
reg_data);=0A=
=0A=
	udelay(30);=0A=
=0A=
	/* =0A=
	 * Enable the Interrupts for Tx and Rx =0A=
	 */=0A=
	reg_data1 =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_IE);=0A=
=0A=
	if (port_num =3D=3D 0) {=0A=
		reg_data1 |=3D 0x3;=0A=
	}=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	if (port_num =3D=3D 1) {=0A=
		reg_data1 |=3D 0x30000;=0A=
	}=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
	if (port_num =3D=3D 1) {=0A=
		reg_data1 |=3D 0x300;=0A=
	}=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	if (port_num =3D=3D 2) {=0A=
		reg_data1 |=3D 0x30000;=0A=
	}=0A=
=0A=
	TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, reg_data1);=0A=
=0A=
	if (config_done =3D=3D 0) {=0A=
#ifndef CONFIG_PMC_SEQUOIA=0A=
		TITAN_GE_WRITE(0x0038, 0x00303);=0A=
		TITAN_GE_WRITE(0x003c, 0x00300);=0A=
#endif=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
// XD_OOD_INTSMSG =3D 0x61, XD_INTSMSG =3D 0x62, =0A=
// XD_RX_INTSMSG =3D XD_TX_INTSMSG =3D 0x60=0A=
		TITAN_GE_WRITE(0x0060, RM9150_GCIC_INTMSG  >> 4);=0A=
=0A=
                reg_data =3D 0x61626060;=0A=
		TITAN_GE_WRITE(0x0044, reg_data);=0A=
		reg_data =3D TITAN_GE_READ(0x0080);=0A=
		reg_data |=3D 0x1;		=0A=
		TITAN_GE_WRITE(0x0080, reg_data);=0A=
=0A=
#else=0A=
#ifdef TITAN_GE_12=0A=
		TITAN_GE_WRITE(0x0024, 0x04844424);=0A=
#else=0A=
		TITAN_GE_WRITE(0x0024, 0x04000024);	/* IRQ vector */=0A=
#endif=0A=
		TITAN_GE_WRITE(0x0020, 0x000fb000);	/* INTMSG base */=0A=
#endif // CONFIG_PMC_SEQUOIA=0A=
	}=0A=
=0A=
	/* Priority */=0A=
	reg_data =3D TITAN_GE_READ(0x1038 + (port_num << 12));=0A=
	reg_data &=3D ~(0x00f00000);=0A=
	TITAN_GE_WRITE((0x1038 + (port_num << 12)), reg_data);=0A=
=0A=
	/* Step 5:  GMII config */=0A=
	titan_ge_gmii_config(port_num);=0A=
=0A=
=0A=
	if (config_done =3D=3D 0) {=0A=
#ifndef CONFIG_PMC_SEQUOIA	  =0A=
		TITAN_GE_WRITE(0x1a80, 0);=0A=
#endif=0A=
		config_done =3D 1;=0A=
	}=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Function to queue the packet for the Ethernet device=0A=
 */=0A=
static void titan_ge_tx_queue(titan_ge_port_info * titan_ge_eth,=0A=
				struct sk_buff * skb)=0A=
{=0A=
	volatile titan_ge_tx_desc *tx_curr;=0A=
	int port_num =3D titan_ge_eth->port_num;=0A=
	unsigned int curr_desc =3D=0A=
			titan_ge_eth->tx_curr_desc_q;=0A=
=0A=
	tx_curr =3D &(titan_ge_eth->tx_desc_area[curr_desc]);=0A=
	tx_curr->buffer_addr =3D =0A=
		pci_map_single(0, skb->data, skb->len - skb->data_len,=0A=
					PCI_DMA_TODEVICE);=0A=
=0A=
	titan_ge_eth->tx_skb[curr_desc] =3D (struct sk_buff *) skb;=0A=
	tx_curr->buffer_len =3D skb->len - skb->data_len;=0A=
=0A=
	/* Last descriptor enables interrupt and changes ownership */=0A=
	tx_curr->cmd_sts =3D 0x1 | (1 << 15) | (1 << 5);=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Kick the XDMA to start the transfer from memory to the FIFO */=0A=
        TITAN_GE_WRITE((0x3044 + (port_num << 9)), 0x1);=0A=
#else=0A=
=0A=
	/* Kick the XDMA to start the transfer from memory to the FIFO */=0A=
        TITAN_GE_WRITE((0x5044 + (port_num << 8)), 0x1);=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Current descriptor updated */=0A=
	titan_ge_eth->tx_curr_desc_q =3D (curr_desc + 1) % =
TITAN_GE_TX_QUEUE;=0A=
=0A=
	/* Prefetch the next descriptor */=0A=
=0A=
#ifdef CONFIG_CPU_HAS_PREFETCH=0A=
	if (port_num =3D=3D 1) =0A=
		rm9000_prefetch(&(titan_ge_eth->tx_desc_area[=0A=
					titan_ge_eth->tx_curr_desc_q]));=0A=
#endif=0A=
=0A=
=0A=
}=0A=
=0A=
/*=0A=
 * Actually does the open of the Ethernet device=0A=
 */=0A=
static int titan_ge_eth_open(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num, size, phy_reg;=0A=
	unsigned long reg_data;=0A=
	int err =3D 0;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	/* Stop the Rx activity */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 +=0A=
				(port_num << 12));=0A=
	reg_data &=3D ~(0x00000001);=0A=
	TITAN_GE_WRITE((TITAN_GE_RMAC_CONFIG_1 +=0A=
			(port_num << 12)), reg_data);=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Clear the port interrupts */=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_INTERRUPT +=0A=
                        (port_num << 9)), 0x0);=0A=
=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Clear the port interrupts */=0A=
	TITAN_GE_WRITE((TITAN_GE_CHANNEL0_INTERRUPT +=0A=
			(port_num << 8)), 0x0);=0A=
=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	if (config_done =3D=3D 0) {=0A=
		TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_CORE_A, 0);=0A=
#ifndef CONFIG_PMC_SEQUOIA=0A=
		TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_CORE_B, 0);=0A=
#endif=0A=
	}=0A=
=0A=
	/* Set the MAC Address */=0A=
	memcpy(titan_ge_eth->port_mac_addr, netdev->dev_addr, 6);=0A=
=0A=
	if (config_done =3D=3D 0)=0A=
		titan_port_init(netdev, titan_ge_eth);=0A=
=0A=
	titan_ge_update_afx(titan_ge_eth);=0A=
=0A=
	/* Allocate the Tx ring now */=0A=
	titan_ge_eth->tx_ring_skbs =3D 0;=0A=
	titan_ge_eth->tx_ring_size =3D TITAN_GE_TX_QUEUE;=0A=
	size =3D titan_ge_eth->tx_ring_size * sizeof(titan_ge_tx_desc);=0A=
=0A=
	/* Allocate space in the SRAM for the descriptors */=0A=
        if (port_num =3D=3D 1) {=0A=
=0A=
                titan_ge_eth->tx_desc_area =3D=0A=
                    (titan_ge_tx_desc *) =
(TITAN_GE_SRAM_BASE_VIRTUAL);=0A=
                                                                        =
        =0A=
                titan_ge_eth->tx_dma =3D =
(TITAN_GE_SRAM_BASE_PHYSICAL);=0A=
=0A=
        } else {=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
		titan_ge_eth->tx_desc_area =3D=0A=
                    (titan_ge_tx_desc *) (TITAN_GE_SRAM_BASE_VIRTUAL + =
0x2000);=0A=
                                                                        =
                  =0A=
                titan_ge_eth->tx_dma =3D (TITAN_GE_SRAM_BASE_PHYSICAL + =
0x2000);=0A=
#else	=0A=
		titan_ge_eth->tx_desc_area =3D=0A=
			(titan_ge_tx_desc *) pci_alloc_consistent(NULL, size,=0A=
					&titan_ge_eth->tx_dma);=0A=
#endif=0A=
	}=0A=
=0A=
	if (!titan_ge_eth->tx_desc_area) {=0A=
		printk(KERN_ERR=0A=
		       "%s: Cannot allocate Tx Ring (size %d bytes)\n",=0A=
		       netdev->name, size);=0A=
		return -ENOMEM;=0A=
	}=0A=
=0A=
	memset((void *) titan_ge_eth->tx_desc_area, 0,=0A=
	       titan_ge_eth->tx_desc_area_size);=0A=
=0A=
	/* Now initialize the Tx descriptor ring */=0A=
	titan_ge_init_tx_desc_ring(titan_ge_eth,=0A=
				   titan_ge_eth->tx_ring_size,=0A=
				   (unsigned long) titan_ge_eth->=0A=
				   tx_desc_area,=0A=
				   (unsigned long) titan_ge_eth->tx_dma);=0A=
=0A=
	/* Allocate the Rx ring now */=0A=
	titan_ge_eth->rx_ring_size =3D TITAN_GE_RX_QUEUE;=0A=
	titan_ge_eth->rx_ring_skbs =3D 0;=0A=
	size =3D titan_ge_eth->rx_ring_size * sizeof(titan_ge_rx_desc);=0A=
=0A=
=0A=
	if (port_num =3D=3D 1) {=0A=
=0A=
                titan_ge_eth->rx_desc_area =3D=0A=
                        (titan_ge_rx_desc *)(TITAN_GE_SRAM_BASE_VIRTUAL =
+ 0x1000);=0A=
                                                                        =
        =0A=
                titan_ge_eth->rx_dma =3D (TITAN_GE_SRAM_BASE_PHYSICAL + =
0x1000);=0A=
=0A=
        }=0A=
        else {=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
		titan_ge_eth->rx_desc_area =3D=0A=
                        (titan_ge_rx_desc *)(TITAN_GE_SRAM_BASE_VIRTUAL =
+ 0x3000);=0A=
                                                                        =
                  =0A=
                titan_ge_eth->rx_dma =3D (TITAN_GE_SRAM_BASE_PHYSICAL + =
0x3000);=0A=
#else=0A=
		titan_ge_eth->rx_desc_area =3D=0A=
		   (titan_ge_rx_desc *) pci_alloc_consistent(NULL, size,=0A=
					      &titan_ge_eth->rx_dma);=0A=
#endif=0A=
	}=0A=
=0A=
	if (!titan_ge_eth->rx_desc_area) {=0A=
		printk(KERN_ERR=0A=
		       "%s: Cannot allocate Rx Ring (size %d bytes)\n",=0A=
		       netdev->name, size);=0A=
=0A=
		printk(KERN_ERR=0A=
		       "%s: Freeing previously allocated TX queues...",=0A=
		       netdev->name);=0A=
=0A=
		pci_free_consistent(0, titan_ge_eth->tx_desc_area_size,=0A=
				    (void *) titan_ge_eth->tx_desc_area,=0A=
				    titan_ge_eth->tx_dma);=0A=
=0A=
		return -ENOMEM;=0A=
	}=0A=
=0A=
	memset((void *) titan_ge_eth->rx_desc_area, 0,=0A=
	       titan_ge_eth->tx_desc_area_size);=0A=
=0A=
	/* Now initialize the Rx ring */=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
	if ((titan_ge_init_rx_desc_ring=0A=
	    (titan_ge_eth, titan_ge_eth->rx_ring_size, =
TITAN_GE_JUMBO_BUFSIZE,=0A=
	     (unsigned long) titan_ge_eth->rx_desc_area, 0,=0A=
	      (unsigned long) titan_ge_eth->rx_dma)) =3D=3D 0)=0A=
#else=0A=
	if ((titan_ge_init_rx_desc_ring=0A=
	     (titan_ge_eth, titan_ge_eth->rx_ring_size, =
TITAN_GE_STD_BUFSIZE,=0A=
	      (unsigned long) titan_ge_eth->rx_desc_area, 0,=0A=
	      (unsigned long) titan_ge_eth->rx_dma)) =3D=3D 0)=0A=
#endif=0A=
		panic("%s: Error initializing RX Ring\n", netdev->name);=0A=
=0A=
	/* Fill the Rx ring with the SKBs */=0A=
	titan_ge_port_start(netdev, titan_ge_eth);=0A=
=0A=
	/* =0A=
	 * Check if Interrupt Coalscing needs to be turned on. The=0A=
	 * values specified in the register is multiplied by =0A=
	 * (8 x 64 nanoseconds) to determine when an interrupt should=0A=
	 * be sent to the CPU. =0A=
	 */=0A=
#ifndef TITAN_RX_NAPI=0A=
	/* =0A=
	 * If NAPI is turned on, we disable Rx interrupts=0A=
	 * completely. So, we dont need coalescing then. Tx side=0A=
	 * coalescing set to very high value. Maybe, disable=0A=
	 * Tx side interrupts completely=0A=
	 */=0A=
	if (TITAN_GE_RX_COAL) {=0A=
		titan_ge_eth->rx_int_coal =3D=0A=
		    titan_ge_rx_coal(TITAN_GE_RX_COAL, port_num);=0A=
	} =0A=
=0A=
#endif=0A=
	if (TITAN_GE_TX_COAL) {=0A=
		titan_ge_eth->tx_int_coal =3D=0A=
		    titan_ge_tx_coal(TITAN_GE_TX_COAL, port_num);=0A=
	}=0A=
=0A=
	err =3D=0A=
	    titan_ge_mdio_read(port_num,=0A=
			       TITAN_GE_MDIO_PHY_STATUS, &phy_reg);=0A=
	if (err =3D=3D TITAN_GE_MDIO_ERROR) {=0A=
		printk(KERN_ERR=0A=
		       "Could not read PHY control register 0x11 \n");=0A=
		return TITAN_ERROR;=0A=
	}=0A=
	if (!(phy_reg & 0x0400)) {=0A=
		netif_carrier_off(netdev);=0A=
		netif_stop_queue(netdev);=0A=
		return TITAN_ERROR;=0A=
	} else {=0A=
		netif_carrier_on(netdev);=0A=
		netif_start_queue(netdev);=0A=
	}=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Queue the packet for Tx. Currently no support for zero copy, =0A=
 * checksum offload and Scatter Gather. The chip does support =0A=
 * Scatter Gather only. But, that wont help here since zero copy =0A=
 * requires support for Tx checksumming also. =0A=
 */=0A=
int titan_ge_start_xmit(struct sk_buff *skb, struct net_device =
*netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned long flags;=0A=
=0A=
=0A=
#ifdef EXTRA_STATS=0A=
	struct net_device_stats *stats;=0A=
#endif=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
=0A=
#ifdef EXTRA_STATS=0A=
	stats =3D &titan_ge_eth->stats;=0A=
#endif=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_lock_irqsave(&titan_ge_eth->lock, flags);=0A=
#else=0A=
	local_irq_save(flags);=0A=
#endif=0A=
=0A=
	if ((TITAN_GE_TX_QUEUE - titan_ge_eth->tx_ring_skbs) <=3D=0A=
	    (skb_shinfo(skb)->nr_frags + 1)) {=0A=
		netif_stop_queue(netdev);=0A=
#ifdef CONFIG_SMP=0A=
		spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
#else=0A=
		local_irq_restore(flags);=0A=
#endif=0A=
		printk(KERN_ERR "Tx OOD \n");=0A=
		return 1;=0A=
	}=0A=
=0A=
	titan_ge_tx_queue(titan_ge_eth, skb);=0A=
=0A=
	titan_ge_eth->tx_ring_skbs++;=0A=
=0A=
	if (TITAN_GE_TX_QUEUE <=3D (titan_ge_eth->tx_ring_skbs + 4)) {=0A=
#ifdef CONFIG_SMP=0A=
		spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
#else=0A=
		local_irq_restore(flags);=0A=
#endif=0A=
		titan_ge_free_tx_queue(titan_ge_eth);=0A=
#ifdef CONFIG_SMP=0A=
		spin_lock_irqsave(&titan_ge_eth->lock, flags);=0A=
#else=0A=
		local_irq_save(flags);=0A=
#endif=0A=
	}=0A=
=0A=
#ifdef EXTRA_STATS=0A=
	stats->tx_bytes +=3D skb->len;=0A=
	stats->tx_packets++;=0A=
#endif=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
#else=0A=
	local_irq_restore(flags);=0A=
#endif=0A=
=0A=
	netdev->trans_start =3D jiffies;=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
#ifdef CONFIG_NET_FASTROUTE=0A=
/*=0A=
 * Fast forward function for the fast routing. Helps=0A=
 * in IP forwarding. No semi fast forward since we=0A=
 * have to do that extra copy on the Rx for the IP=0A=
 * header alignment=0A=
 */=0A=
static int titan_ge_fast_forward(struct net_device *dev, =0A=
			struct sk_buff *skb, int len)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth =3D =0A=
			(titan_ge_port_info *)dev->priv;=0A=
	struct ethhdr *eth =3D (void*)skb->data;=0A=
=0A=
	if (eth->h_proto =3D=3D __constant_htons(ETH_P_IP)) {=0A=
		struct rtable *rt;=0A=
		struct iphdr *iph;=0A=
		unsigned h;=0A=
=0A=
		iph =3D (struct iphdr*)(skb->data + ETH_HLEN);=0A=
		h=3D(*(u8*)&iph->daddr^*(u8*)&iph->saddr)&NETDEV_FASTROUTE_HMASK;=0A=
		rt =3D (struct rtable*)(dev->fastpath[h]);=0A=
		if (rt &&=0A=
			((u16*)&iph->daddr)[0] =3D=3D ((u16*)&rt->key.dst)[0] &&=0A=
			((u16*)&iph->daddr)[1] =3D=3D ((u16*)&rt->key.dst)[1] &&=0A=
			((u16*)&iph->saddr)[0] =3D=3D ((u16*)&rt->key.src)[0] &&=0A=
			((u16*)&iph->saddr)[1] =3D=3D ((u16*)&rt->key.src)[1] &&=0A=
			rt->u.dst.obsolete =3D=3D 0) {=0A=
				struct net_device *odev =3D rt->u.dst.dev;=0A=
=0A=
				if (*(u8*)iph !=3D 0x45 ||=0A=
					(eth->h_dest[0]&1) ||=0A=
					!neigh_is_valid(rt->u.dst.neighbour) ||=0A=
					iph->ttl <=3D 1) {=0A=
						return 1;		=0A=
				}=0A=
				ip_decrease_ttl(iph);=0A=
				skb_put(skb, len);=0A=
=0A=
				memcpy(eth->h_source, odev->dev_addr, 6);=0A=
				memcpy(eth->h_dest, rt->u.dst.neighbour->ha, 6);=0A=
				skb->dev =3D odev;=0A=
				skb->pkt_type =3D PACKET_FASTROUTE;=0A=
=0A=
				if (netif_running(odev) &&=0A=
				   (spin_trylock(&odev->xmit_lock))) {=0A=
					if(odev->xmit_lock_owner !=3D 0) {=0A=
						odev->xmit_lock_owner=3D0;=0A=
					}=0A=
					if (odev->hard_start_xmit(skb,odev) =3D=3D 0) {=0A=
						odev->xmit_lock_owner=3D-1;=0A=
						spin_unlock(&odev->xmit_lock);=0A=
						return 0;=0A=
					} =0A=
				}=0A=
				skb->nh.raw =3D skb->data + ETH_HLEN;=0A=
				skb->protocol =3D __constant_htons(ETH_P_IP);=0A=
				return 1;=0A=
			}=0A=
	}=0A=
	return 1;=0A=
}=0A=
=0A=
#endif=0A=
=0A=
/*=0A=
 * Actually does the Rx. Rx side checksumming supported.=0A=
 */=0A=
static int titan_ge_rx(struct net_device *netdev, int port_num,=0A=
			titan_ge_port_info * titan_ge_port,=0A=
		       titan_ge_packet * packet)=0A=
{=0A=
	int rx_curr_desc, rx_used_desc;=0A=
	volatile titan_ge_rx_desc *rx_desc;=0A=
=0A=
	rx_curr_desc =3D titan_ge_port->rx_curr_desc_q;=0A=
	rx_used_desc =3D titan_ge_port->rx_used_desc_q;=0A=
=0A=
	if (((rx_curr_desc + 1) % TITAN_GE_RX_QUEUE) =3D=3D rx_used_desc) =0A=
		return TITAN_ERROR;=0A=
=0A=
	rx_desc =3D &(titan_ge_port->rx_desc_area[rx_curr_desc]);=0A=
=0A=
	if (rx_desc->cmd_sts & TITAN_GE_RX_BUFFER_OWNED) =0A=
		return TITAN_ERROR;=0A=
=0A=
	packet->skb =3D titan_ge_port->rx_skb[rx_curr_desc];=0A=
	packet->len =3D (rx_desc->cmd_sts & 0x7fff);=0A=
=0A=
=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
               pci_unmap_single(0, rx_desc->buffer_addr, =
TITAN_GE_JUMBO_BUFSIZE - 2,=0A=
                                            PCI_DMA_FROMDEVICE);=0A=
#else=0A=
                pci_unmap_single(0, rx_desc->buffer_addr, =
TITAN_GE_STD_BUFSIZE - 2,=0A=
                                            PCI_DMA_FROMDEVICE);=0A=
#endif=0A=
=0A=
	/* =0A=
	 * At this point, we dont know if the checksumming =0A=
	 * actually helps relieve CPU. So, keep it for =0A=
	 * port 0 only=0A=
	 */=0A=
	if (port_num =3D=3D 0)=0A=
		packet->checksum =3D ntohs((rx_desc->buffer & 0xffff0000) >> 16);=0A=
=0A=
	titan_ge_port->rx_curr_desc_q =3D=0A=
	    (rx_curr_desc + 1) % TITAN_GE_RX_QUEUE;=0A=
	=0A=
	/* Prefetch the next descriptor */=0A=
#ifdef CONFIG_CPU_HAS_PREFETCH=0A=
	if (port_num =3D=3D 1)=0A=
		rm9000_prefetch(&(titan_ge_port->rx_desc_area[=0A=
					titan_ge_port->rx_curr_desc_q + 1]));=0A=
#endif=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Free the Tx queue of the used SKBs=0A=
 */=0A=
static int titan_ge_free_tx_queue(titan_ge_port_info *titan_ge_eth)=0A=
{=0A=
	unsigned long flags;=0A=
=0A=
	/* Take the lock */=0A=
#ifdef CONFIG_SMP=0A=
	spin_lock_irqsave(&(titan_ge_eth->lock), flags);=0A=
#else=0A=
	local_irq_save(flags);=0A=
#endif=0A=
=0A=
	while (titan_ge_return_tx_desc(titan_ge_eth, titan_ge_eth->port_num) =
=3D=3D 0) =0A=
		if (titan_ge_eth->tx_ring_skbs > 0)=0A=
			titan_ge_eth->tx_ring_skbs--;=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
#else=0A=
	local_irq_restore(flags);=0A=
#endif=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Do the slowpath route. This route is kicked off=0A=
 * when the IP header is misaligned. Grrr ..=0A=
 */=0A=
static int titan_ge_slowpath(struct sk_buff *skb,=0A=
				titan_ge_packet *packet,=0A=
				struct net_device *netdev)=0A=
{=0A=
	struct sk_buff *copy_skb;=0A=
=0A=
	copy_skb =3D dev_alloc_skb(packet->len + 2);=0A=
=0A=
	if (!copy_skb) {=0A=
		dev_kfree_skb_any(packet->skb);=0A=
		return -1;=0A=
	}=0A=
=0A=
	copy_skb->dev =3D netdev;=0A=
	skb_reserve(copy_skb, 2);=0A=
	skb_put(copy_skb, packet->len);=0A=
=0A=
	memcpy(copy_skb->data, skb->data, packet->len);=0A=
=0A=
	/* Titan supports Rx checksum offload */=0A=
	copy_skb->ip_summed =3D CHECKSUM_HW;=0A=
	copy_skb->csum =3D packet->checksum;=0A=
=0A=
	copy_skb->protocol =3D eth_type_trans(copy_skb, netdev);=0A=
=0A=
	__kfree_skb(packet->skb);=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
	netif_receive_skb(copy_skb);=0A=
#else=0A=
	netif_rx(copy_skb);=0A=
#endif=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Threshold beyond which we do the cleaning of=0A=
 * Tx queue and new allocation for the Rx =0A=
 * queue=0A=
 */=0A=
#define	TX_THRESHOLD	4=0A=
#define	RX_THRESHOLD	10=0A=
=0A=
/*=0A=
 * Receive the packets and send it to the kernel. =0A=
 */=0A=
int titan_ge_receive_queue(struct net_device *netdev, unsigned int =
max)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num;=0A=
	titan_ge_packet packet;=0A=
#ifdef EXTRA_STATS=0A=
	struct net_device_stats *stats;=0A=
#endif=0A=
	struct sk_buff *skb;=0A=
	unsigned long received_packets =3D 0;=0A=
	unsigned int ack;=0A=
	int i =3D 0;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
#ifdef EXTRA_STATS=0A=
	stats =3D &titan_ge_eth->stats;=0A=
#endif=0A=
=0A=
	while ((--max)=0A=
	       && (titan_ge_rx(netdev, port_num, titan_ge_eth, &packet) =3D=3D =
TITAN_OK)) {=0A=
=0A=
		titan_ge_eth->rx_ring_skbs--;=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
		if (--titan_ge_eth->rx_work_limit < 0)=0A=
			break;=0A=
		received_packets++;=0A=
#endif=0A=
=0A=
#ifdef EXTRA_STATS=0A=
		stats->rx_packets++;=0A=
		stats->rx_bytes +=3D packet.len;=0A=
#endif=0A=
		/* =0A=
		 * Either support fast path or slow path. Decision=0A=
		 * making can really slow down the performance. The=0A=
		 * idea is to cut down the number of checks and improve=0A=
		 * the fastpath.=0A=
		 */=0A=
#if (defined(CONFIG_NET_FASTROUTE) && !defined(TITAN_RX_NAPI))=0A=
		if (port_num =3D=3D 1) {=0A=
			switch (titan_ge_fast_forward(netdev, =0A=
					packet.skb, packet.len)) {=0A=
				case 0:=0A=
					goto gone;=0A=
				case 1:=0A=
					break;=0A=
			}=0A=
		}=0A=
#endif=0A=
		skb =3D (struct sk_buff *) packet.skb;=0A=
		/*=0A=
		 * This chip is wierd. Does not have a byte level offset=0A=
		 * to fix the IP header alignment issue. Now, do an extra=0A=
		 * copy only if the custom pattern is not present=0A=
		 */=0A=
#ifdef TITAN_GE_12=0A=
		skb_put(skb, packet.len - 2);=0A=
#else=0A=
		skb_put(skb, packet.len);=0A=
#endif=0A=
=0A=
#ifdef TITAN_GE_12=0A=
		/*=0A=
		 * Increment data pointer by two since thats where=0A=
		 * the MAC starts=0A=
		 */=0A=
		skb_reserve(skb, 2);=0A=
#endif=0A=
=0A=
#if (defined(TITAN_GE_10) || defined(TITAN_GE_11))=0A=
		/* =0A=
		 * This is where Titan 1.0 and Titan 1.1 have a performance=0A=
		 * drawback. Since the IP header is misaligned, the driver has=0A=
		 * to perform an extra copy. However, we can send custom packets=0A=
		 * from Smartbits to avoid this copy. This __hack__ was used to =0A=
		 * determine the max IP forwarding throughput Titan 1.2 can =
deliver=0A=
		 * Check to make sure this is the custom packet =0A=
		 */=0A=
		if (*(skb->data) =3D=3D 0x0) {=0A=
			skb_reserve(skb, 2);=0A=
#endif=0A=
=0A=
			skb->protocol =3D eth_type_trans(skb, netdev);=0A=
=0A=
			netif_receive_skb(skb);=0A=
=0A=
#if (defined(TITAN_GE_10) || defined(TITAN_GE_11))=0A=
		}=0A=
		else =0A=
			if (titan_ge_slowpath(skb, &packet, netdev) < 0) =0A=
				goto out_next;=0A=
#endif=0A=
=0A=
gone:=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
		if (titan_ge_eth->rx_threshold > RX_THRESHOLD) {=0A=
			ack =3D titan_ge_rx_task(netdev, titan_ge_eth);=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
        	        TITAN_GE_WRITE((0x3048 + (port_num << 9)), ack);=0A=
#else=0A=
			TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);=0A=
#endif=0A=
			titan_ge_eth->rx_threshold =3D 0;=0A=
		} else=0A=
			titan_ge_eth->rx_threshold++;=0A=
#else=0A=
		ack =3D titan_ge_rx_task(netdev, titan_ge_eth);=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
		TITAN_GE_WRITE((0x3048 + (port_num << 9)), ack);=0A=
#else=0A=
		TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);=0A=
#endif=0A=
=0A=
#endif=0A=
=0A=
out_next:=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
		if (titan_ge_eth->tx_threshold > TX_THRESHOLD) {=0A=
			titan_ge_eth->tx_threshold =3D 0;=0A=
			titan_ge_free_tx_queue(titan_ge_eth);=0A=
		}=0A=
		else=0A=
			titan_ge_eth->tx_threshold++;=0A=
#endif=0A=
=0A=
	}=0A=
=0A=
	return received_packets;=0A=
}=0A=
=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
=0A=
/*=0A=
 * Enable the Rx side interrupts =0A=
 */=0A=
static void titan_ge_enable_int(unsigned int port_num,=0A=
			titan_ge_port_info *titan_ge_eth,=0A=
			struct net_device *netdev)=0A=
{=0A=
	unsigned long reg_data =3D =0A=
		TITAN_GE_READ(TITAN_GE_INTR_XDMA_IE);=0A=
=0A=
	if (port_num =3D=3D 0)=0A=
		reg_data |=3D 0x3;=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	if (port_num =3D=3D 1)=0A=
		reg_data |=3D 0x30000;=0A=
#else=0A=
	if (port_num =3D=3D 1)=0A=
                reg_data |=3D 0x300;=0A=
#endif=0A=
	if (port_num =3D=3D 2)=0A=
		reg_data |=3D 0x30000;=0A=
=0A=
	/* Re-enable interrupts */=0A=
	TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, reg_data);=0A=
}=0A=
=0A=
/*=0A=
 * Main function to handle the polling for Rx side NAPI.=0A=
 * Receive interrupts have been disabled at this point. =0A=
 * The poll schedules the transmit followed by receive.=0A=
 */	=0A=
static int titan_ge_poll(struct net_device *netdev, int *budget)=0A=
{=0A=
        titan_ge_port_info *titan_ge_eth =3D netdev->priv;=0A=
        int port_num =3D titan_ge_eth->port_num; =0A=
	int work_done =3D 0; =0A=
	unsigned long flags, status;=0A=
=0A=
	titan_ge_eth->rx_work_limit =3D *budget;=0A=
        if (titan_ge_eth->rx_work_limit > netdev->quota)=0A=
                titan_ge_eth->rx_work_limit =3D netdev->quota;=0A=
=0A=
	if (port_num =3D=3D 0) {=0A=
		/* Do the transmit cleaning work here */=0A=
		titan_ge_free_tx_queue(titan_ge_eth);=0A=
=0A=
		TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_CORE_A, 0x3);=0A=
		work_done +=3D titan_ge_receive_queue(netdev, 0);=0A=
		goto done;=0A=
	}=0A=
=0A=
	do {=0A=
		/* Do the transmit cleaning work here */=0A=
		titan_ge_free_tx_queue(titan_ge_eth);=0A=
=0A=
		/* Ack the Rx interrupts */=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
                if (port_num =3D=3D 1)=0A=
                        TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_CORE_A, =
0x30000);=0A=
#else=0A=
		if (port_num =3D=3D 1)=0A=
                        TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_CORE_A, =
0x300);=0A=
#endif=0A=
                if (port_num =3D=3D 2)=0A=
                        TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_CORE_A, =
0x30000);=0A=
=0A=
	        work_done +=3D titan_ge_receive_queue(netdev, 0);=0A=
=0A=
		/* Out of quota and there is work to be done */	=0A=
		if (titan_ge_eth->rx_work_limit < 0)=0A=
			goto not_done;			=0A=
=0A=
		/* Receive alloc_skb could lead to OOM */	=0A=
		if (oom_flag =3D=3D 1) {=0A=
			oom_flag =3D 0;=0A=
			goto oom;=0A=
		}=0A=
=0A=
		status =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_CORE_A);=0A=
	}=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	while (status & 0x30000);=0A=
#else=0A=
	 while (status & 0x30300);=0A=
#endif=0A=
	/* If we are here, then no more interrupts to process */=0A=
	goto done;=0A=
=0A=
not_done:=0A=
	*budget -=3D work_done;=0A=
	netdev->quota -=3D work_done;=0A=
	return 1;=0A=
=0A=
oom:=0A=
	printk(KERN_ERR "OOM \n");=0A=
	netif_rx_complete(netdev);=0A=
	return 0;=0A=
=0A=
done:=0A=
	/*=0A=
	 * No more packets on the poll list. Turn the interrupts =0A=
	 * back on and we should be able to catch the new=0A=
	 * packets in the interrupt handler=0A=
	 */=0A=
	if (!work_done)=0A=
		work_done =3D 1;=0A=
=0A=
	*budget -=3D work_done;=0A=
        netdev->quota -=3D work_done;=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_lock_irqsave(&titan_ge_eth->lock, flags);=0A=
#else=0A=
	local_irq_save(flags);=0A=
#endif=0A=
=0A=
	/* Remove us from the poll list */=0A=
	netif_rx_complete(netdev);=0A=
=0A=
	/* Re-enable interrupts */=0A=
	titan_ge_enable_int(port_num, titan_ge_eth, netdev);=0A=
=0A=
#ifdef CONFIG_SMP=0A=
	spin_unlock_irqrestore(&titan_ge_eth->lock, flags);=0A=
#else=0A=
	local_irq_restore(flags);=0A=
#endif=0A=
=0A=
	return 0;=0A=
}=0A=
#endif=0A=
=0A=
/*=0A=
 * Close the network device=0A=
 */=0A=
int titan_ge_stop(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	spin_lock_irq(&(titan_ge_eth->lock));=0A=
	titan_ge_eth_stop(netdev);=0A=
	free_irq(netdev->irq, netdev);=0A=
	MOD_DEC_USE_COUNT;=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
	titan_ge_recycle_remove();=0A=
#endif=0A=
	spin_unlock_irq(&titan_ge_eth->lock);=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Free the Tx ring=0A=
 */=0A=
static void titan_ge_free_tx_rings(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num, curr;=0A=
	unsigned long reg_data;=0A=
	volatile titan_ge_tx_desc *tx_curr;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	/* Stop the Tx DMA */=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG +=0A=
				(port_num << 9));=0A=
#else=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG +=0A=
                                (port_num << 8));=0A=
#endif=0A=
	reg_data |=3D 0xc0000000;=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG +=0A=
			(port_num << 9)), reg_data);=0A=
#else=0A=
	TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG +=0A=
                        (port_num << 8)), reg_data);=0A=
#endif=0A=
=0A=
	/* Disable the TMAC */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 +=0A=
				(port_num << 12));=0A=
	reg_data &=3D ~(0x00000001);=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_CONFIG_1 +=0A=
			(port_num << 12)), reg_data);=0A=
=0A=
	/* Going in the order: disable Tx XDMA -> disable TMAC  */=0A=
        /* -> disable RMAC -> disable Rx XDMA.                  */=0A=
        /* Wait till TMAC is brought down. */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        while (reg_data & 0x8000) {=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        }	=0A=
=0A=
	for (curr =3D 0;=0A=
	     (titan_ge_eth->tx_ring_skbs) && (curr < TITAN_GE_TX_QUEUE);=0A=
	     curr++) {=0A=
		if (titan_ge_eth->tx_skb[curr]) {=0A=
		        tx_curr =3D &(titan_ge_eth->tx_desc_area[curr]);=0A=
			pci_unmap_single(0, tx_curr->buffer_addr, tx_curr->buffer_len, =
PCI_DMA_TODEVICE);=0A=
			dev_kfree_skb(titan_ge_eth->tx_skb[curr]);=0A=
			titan_ge_eth->tx_ring_skbs--;=0A=
		}=0A=
	}=0A=
=0A=
	if (titan_ge_eth->tx_ring_skbs !=3D 0)=0A=
		printk=0A=
		    ("%s: Error on Tx descriptor free - could not free %d"=0A=
		     " descriptors\n", netdev->name,=0A=
		     titan_ge_eth->tx_ring_skbs);=0A=
=0A=
	pci_free_consistent(0, titan_ge_eth->tx_desc_area_size,=0A=
			    (void *) titan_ge_eth->tx_desc_area,=0A=
			    titan_ge_eth->tx_dma);=0A=
}=0A=
=0A=
/*=0A=
 * Free the Rx ring=0A=
 */=0A=
static void titan_ge_free_rx_rings(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num, curr;=0A=
	unsigned long reg_data;=0A=
	volatile titan_ge_rx_desc *rx_desc;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
=0A=
	/* Going in the order: disable Tx XDMA -> disable TMAC  */=0A=
        /* -> disable RMAC -> disable Rx XDMA.                  */=0A=
        /* Disable the RMAC */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        reg_data &=3D ~(0x00000001);=0A=
        TITAN_GE_WRITE((TITAN_GE_RMAC_CONFIG_1 +=0A=
                        (port_num << 12)), reg_data);=0A=
=0A=
        /* Wait till all packets received and RMAC brought down. */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        while (reg_data & 0x8000) {=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        }=0A=
=0A=
        udelay(60);=0A=
=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
=0A=
	/* Stop the Rx DMA */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG +=0A=
                                (port_num << 9));=0A=
        reg_data |=3D 0x00180000;=0A=
        TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG +=0A=
                        (port_num << 9)), reg_data);=0A=
=0A=
#else=0A=
=0A=
	/* Stop the Rx DMA */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_CHANNEL0_CONFIG + =0A=
				(port_num << 8));=0A=
	reg_data |=3D 0x000c0000;=0A=
	TITAN_GE_WRITE((TITAN_GE_CHANNEL0_CONFIG +=0A=
			(port_num << 8)), reg_data);=0A=
=0A=
#endif=0A=
=0A=
=0A=
	for (curr =3D 0;=0A=
	     titan_ge_eth->rx_ring_skbs && (curr < TITAN_GE_RX_QUEUE);=0A=
	     curr++) {=0A=
		if (titan_ge_eth->rx_skb[curr]) {=0A=
	rx_desc =3D &(titan_ge_eth->rx_desc_area[curr]);=0A=
=0A=
#ifdef TITAN_GE_JUMBO_FRAMES=0A=
		        pci_unmap_single(0, rx_desc->buffer_addr, =
TITAN_GE_JUMBO_BUFSIZE - 2,=0A=
                    PCI_DMA_FROMDEVICE);=0A=
#else=0A=
		        pci_unmap_single(0, rx_desc->buffer_addr, =
TITAN_GE_STD_BUFSIZE - 2,=0A=
                    PCI_DMA_FROMDEVICE);=0A=
#endif=0A=
=0A=
			/* The garbage collection code removes child    */=0A=
                        /* nodes without removing parents causing Linux =
*/=0A=
                        /* to crash. Either (i) don't call this at all  =
*/=0A=
                        /* - in this case, few Rx descriptors remain    =
*/=0A=
                        /* alive and would cause memory leak without    =
*/=0A=
                        /* any functional error; or, (ii) do it right   =
*/=0A=
                        /* so that Linux does not crash.                =
*/=0A=
=0A=
			/* If it is on a list, first remove the buffer  */=0A=
                        /* from the list ...                            =
*/=0A=
=0A=
                        if (titan_ge_eth->rx_skb[curr]->list)=0A=
                                =
skb_unlink(titan_ge_eth->rx_skb[curr]);=0A=
                        /* And then remove it.                          =
*/=0A=
			titan_ge_eth->rx_ring_skbs--;=0A=
		}=0A=
	}=0A=
=0A=
	if (titan_ge_eth->rx_ring_skbs !=3D 0)=0A=
		printk(KERN_ERR=0A=
		       "%s: Error in freeing Rx Ring. %d skb's still"=0A=
		       " stuck in RX Ring - ignoring them\n", netdev->name,=0A=
		       titan_ge_eth->rx_ring_skbs);=0A=
=0A=
	pci_free_consistent(0, titan_ge_eth->rx_desc_area_size,=0A=
			    (void *) titan_ge_eth->rx_desc_area,=0A=
			    titan_ge_eth->rx_dma);=0A=
}=0A=
=0A=
static void titan_ge_eth_disable_int(struct net_device *netdev)=0A=
{=0A=
       titan_ge_port_info *titan_ge_eth =3D netdev->priv;=0A=
       int port_num =3D titan_ge_eth->port_num;=0A=
       int channel =3D port_num<<2;=0A=
       unsigned int r;=0A=
=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
       channel =3D channel << 1;=0A=
#endif=0A=
=0A=
       r =3D TITAN_GE_READ(TITAN_GE_INTR_XDMA_IE);=0A=
       r &=3D ~(0x1<<(channel<<1));=0A=
       TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, r);=0A=
}=0A=
=0A=
=0A=
/*=0A=
 * Actually does the stop of the Ethernet device=0A=
 */=0A=
static int titan_ge_eth_stop(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	netif_stop_queue(netdev);=0A=
=0A=
	/* Going in the order: disable Tx XDMA -> disable TMAC  */=0A=
        /* -> disable RMAC -> disable Rx XDMA.                  */=0A=
=0A=
	titan_ge_free_tx_rings(netdev);=0A=
=0A=
	titan_ge_port_reset(titan_ge_eth->port_num);=0A=
=0A=
	titan_ge_free_rx_rings(netdev);=0A=
=0A=
	/* Disable the Tx and Rx Interrupts for the specified port */=0A=
	titan_ge_eth_disable_int(netdev);=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Update the MAC address. Note that we have to write the =0A=
 * address in three station registers, 16 bits each. And this =0A=
 * has to be done for TMAC and RMAC=0A=
 */=0A=
static void titan_ge_update_mac_address(struct net_device *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth =3D netdev->priv;=0A=
	unsigned int port_num =3D titan_ge_eth->port_num;=0A=
	u8 p_addr[6];=0A=
=0A=
	memcpy(titan_ge_eth->port_mac_addr, netdev->dev_addr, 6);=0A=
	memcpy(p_addr, netdev->dev_addr, 6);=0A=
=0A=
	/* Update the Address Filtering Match tables */=0A=
	titan_ge_update_afx(titan_ge_eth);=0A=
=0A=
	printk("Station MAC : %d %d %d %d %d %d  \n", =0A=
		p_addr[5], p_addr[4], p_addr[3], =0A=
		p_addr[2], p_addr[1], p_addr[0]);=0A=
=0A=
	/* Set the MAC address here for TMAC and RMAC */=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_STATION_HI + (port_num << 12)),=0A=
		       ((p_addr[5] << 8) | p_addr[4]));=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_STATION_MID + (port_num << 12)),=0A=
		       ((p_addr[3] << 8) | p_addr[2]));=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_STATION_LOW + (port_num << 12)),=0A=
		       ((p_addr[1] << 8) | p_addr[0]));=0A=
=0A=
	TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_HI + (port_num << 12)),=0A=
		       ((p_addr[5] << 8) | p_addr[4]));=0A=
	TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_MID + (port_num << 12)),=0A=
		       ((p_addr[3] << 8) | p_addr[2]));=0A=
	TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_LOW + (port_num << 12)),=0A=
		       ((p_addr[1] << 8) | p_addr[0]));=0A=
=0A=
	return;=0A=
}=0A=
=0A=
/*=0A=
 * Set the MAC address of the Ethernet device=0A=
 */=0A=
int titan_ge_set_mac_address(struct net_device *netdev, void *addr)=0A=
{=0A=
	int i;=0A=
=0A=
	for (i =3D 0; i < 6; i++)=0A=
		netdev->dev_addr[i] =3D ((unsigned char *) addr)[i + 2];=0A=
=0A=
	titan_ge_update_mac_address(netdev);=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Get the Ethernet device stats=0A=
 */=0A=
static struct net_device_stats *titan_ge_get_stats(struct net_device=0A=
						   *netdev)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	unsigned int port_num;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	port_num =3D titan_ge_eth->port_num;=0A=
=0A=
	return &titan_ge_eth->stats;=0A=
}=0A=
=0A=
/*=0A=
 * Register the Titan GE with the kernel=0A=
 */=0A=
static int __init titan_ge_init_module(void)=0A=
{=0A=
	unsigned long version, device;=0A=
=0A=
	printk(KERN_NOTICE=0A=
	       "PMC-Sierra TITAN 10/100/1000 Ethernet Driver \n");=0A=
	device =3D TITAN_GE_READ(TITAN_GE_DEVICE_ID);=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	version =3D (device & 0x0f000000) >> 16;=0A=
	device &=3D 0x00ffffff;=0A=
#else=0A=
	version =3D (device & 0x000f0000) >> 16;=0A=
	device &=3D 0x0000ffff;=0A=
#endif=0A=
=0A=
	printk(KERN_NOTICE "Device Id : %x,  Version : %x \n", device,=0A=
	       version);=0A=
=0A=
	/* Register only one port */ =0A=
	if (titan_ge_init(0)) =0A=
		printk(KERN_ERR=0A=
		       "Error registering the TITAN Ethernet driver"=0A=
			"for port 0 \n");=0A=
=0A=
	=0A=
	if (titan_ge_init(1)) =0A=
		printk(KERN_ERR "Error registering the TITAN Ethernet" =0A=
				"driver for port 1\n");=0A=
=0A=
=0A=
#ifndef CONFIG_PMC_SEQUOIA=0A=
=0A=
#ifdef TITAN_GE_12=0A=
	if (titan_ge_init(2)) =0A=
		printk(KERN_ERR "Error registering the TITAN Ethernet" =0A=
				"driver for port 2 \n"); =0A=
#endif=0A=
=0A=
#endif // CONFIG_PMC_SEQUOIA=0A=
=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
        titan_ge_recycle_init();=0A=
#endif=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Unregister the Titan GE from the kernel=0A=
 */=0A=
static void __init titan_ge_cleanup_module(void)=0A=
{=0A=
	/* Nothing to do here */=0A=
}=0A=
=0A=
module_init(titan_ge_init_module);=0A=
module_exit(titan_ge_cleanup_module);=0A=
=0A=
/*=0A=
 * Initialize the Rx descriptor ring for the Titan Ge=0A=
 */=0A=
static int titan_ge_init_rx_desc_ring(titan_ge_port_info * =
titan_eth_port,=0A=
				      int rx_desc_num,=0A=
				      int rx_buff_size,=0A=
				      unsigned long rx_desc_base_addr,=0A=
				      unsigned long rx_buff_base_addr,=0A=
				      unsigned long rx_dma)=0A=
{=0A=
	volatile titan_ge_rx_desc *rx_desc;=0A=
	unsigned long buffer_addr;=0A=
	int index;=0A=
	unsigned long titan_ge_rx_desc_bus =3D rx_dma;=0A=
	volatile unsigned long reg_data;=0A=
=0A=
	buffer_addr =3D rx_buff_base_addr;=0A=
	rx_desc =3D (titan_ge_rx_desc *) rx_desc_base_addr;=0A=
=0A=
	/* Check alignment */=0A=
	if (rx_buff_base_addr & 0xF)=0A=
		return 0;=0A=
=0A=
	/* Check Rx buffer size */=0A=
	if ((rx_buff_size < 8) || (rx_buff_size > TITAN_GE_MAX_RX_BUFFER))=0A=
		return 0;=0A=
=0A=
	/* 64-bit alignment =0A=
	if ((rx_buff_base_addr + rx_buff_size) & 0x7)=0A=
		return 0; */=0A=
=0A=
	/* Initialize the Rx desc ring */=0A=
	for (index =3D 0; index < rx_desc_num; index++) {=0A=
		titan_ge_rx_desc_bus +=3D sizeof(titan_ge_rx_desc);=0A=
		rx_desc[index].cmd_sts =3D 0;=0A=
		rx_desc[index].buffer_addr =3D buffer_addr;=0A=
		titan_eth_port->rx_skb[index] =3D NULL;=0A=
		buffer_addr +=3D rx_buff_size;=0A=
	}=0A=
=0A=
	titan_eth_port->rx_curr_desc_q =3D 0;=0A=
	titan_eth_port->rx_used_desc_q =3D 0;=0A=
=0A=
	titan_eth_port->rx_desc_area =3D=0A=
	    (titan_ge_rx_desc *) rx_desc_base_addr;=0A=
	titan_eth_port->rx_desc_area_size =3D=0A=
	    rx_desc_num * sizeof(titan_ge_rx_desc);=0A=
	=0A=
	titan_eth_port->rx_dma =3D rx_dma;=0A=
=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Initialize the Tx descriptor ring. Descriptors in the SRAM=0A=
 */=0A=
static int titan_ge_init_tx_desc_ring(titan_ge_port_info * =
titan_ge_port,=0A=
				      int tx_desc_num,=0A=
				      unsigned long tx_desc_base_addr,=0A=
				      unsigned long tx_dma)=0A=
{=0A=
	titan_ge_tx_desc *tx_desc;=0A=
	int index;=0A=
	unsigned long titan_ge_tx_desc_bus =3D tx_dma;=0A=
=0A=
	if (tx_desc_base_addr & 0xF)=0A=
		return 0;=0A=
=0A=
	tx_desc =3D (titan_ge_tx_desc *) tx_desc_base_addr;=0A=
=0A=
	for (index =3D 0; index < tx_desc_num; index++) {=0A=
		titan_ge_port->tx_dma_array[index] =3D=0A=
		    (dma_addr_t) titan_ge_tx_desc_bus;=0A=
		titan_ge_tx_desc_bus +=3D sizeof(titan_ge_tx_desc);=0A=
		tx_desc[index].cmd_sts =3D 0x0000;=0A=
		tx_desc[index].buffer_len =3D 0;=0A=
		tx_desc[index].buffer_addr =3D 0x00000000;=0A=
		titan_ge_port->tx_skb[index] =3D NULL;=0A=
	}=0A=
=0A=
	titan_ge_port->tx_curr_desc_q =3D 0;=0A=
	titan_ge_port->tx_used_desc_q =3D 0;=0A=
=0A=
	titan_ge_port->tx_desc_area =3D=0A=
	    (titan_ge_tx_desc *) tx_desc_base_addr;=0A=
	titan_ge_port->tx_desc_area_size =3D=0A=
	    tx_desc_num * sizeof(titan_ge_tx_desc);=0A=
=0A=
	titan_ge_port->tx_dma =3D tx_dma;=0A=
	return TITAN_OK;=0A=
}=0A=
=0A=
/*=0A=
 * Initialize the device as an Ethernet device=0A=
 */=0A=
static int titan_ge_init(int port)=0A=
{=0A=
	titan_ge_port_info *titan_ge_eth;=0A=
	struct net_device *netdev;=0A=
	int err;=0A=
	int i;=0A=
=0A=
	netdev =3D alloc_etherdev(sizeof(titan_ge_port_info));=0A=
	if (!netdev) {=0A=
		err =3D -ENODEV;=0A=
		goto out;=0A=
	}=0A=
=0A=
	netdev->open =3D titan_ge_open;=0A=
	netdev->stop =3D titan_ge_stop;=0A=
	netdev->hard_start_xmit =3D titan_ge_start_xmit;=0A=
	netdev->get_stats =3D titan_ge_get_stats;=0A=
	netdev->set_multicast_list =3D titan_ge_set_multi;=0A=
	netdev->set_mac_address =3D titan_ge_set_mac_address;=0A=
=0A=
	/* Tx timeout */=0A=
	netdev->tx_timeout =3D titan_ge_tx_timeout;=0A=
	netdev->watchdog_timeo =3D 2 * HZ;=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
	/* Set these to very high values */=0A=
	netdev->poll =3D titan_ge_poll;=0A=
	netdev->weight =3D 64;=0A=
#endif=0A=
	netdev->tx_queue_len =3D TITAN_GE_TX_QUEUE;=0A=
	netif_carrier_off(netdev);=0A=
	netdev->base_addr =3D 0;=0A=
=0A=
#ifdef CONFIG_NET_FASTROUTE=0A=
	netdev->accept_fastpath =3D titan_accept_fastpath;=0A=
#endif=0A=
=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
	netdev->mem_reclaim =3D titan_ge_mem_reclaim;=0A=
#endif=0A=
=0A=
	netdev->change_mtu =3D titan_ge_change_mtu;=0A=
=0A=
	titan_ge_eth =3D netdev->priv;=0A=
	/* Allocation of memory for the driver structures */=0A=
=0A=
	titan_ge_eth->port_num =3D port;=0A=
=0A=
	memset(&titan_ge_eth->stats, 0, sizeof(struct net_device_stats));=0A=
=0A=
	/* Configure the Tx timeout handler */=0A=
	INIT_TQUEUE(&titan_ge_eth->tx_timeout_task,=0A=
		    (void (*)(void *)) titan_ge_tx_timeout_task, netdev);=0A=
=0A=
	spin_lock_init(&titan_ge_eth->lock);=0A=
=0A=
	/* set MAC addresses */=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	memcpy(netdev->dev_addr, titan_ge_mac_addr_base, 6);=0A=
	netdev->dev_addr[5] +=3D port;=0A=
#else //CONFIG_PMC_SEQUOIA=0A=
	netdev->dev_addr[0] =3D (unsigned char)=0A=
                TITAN_GE_READ(TITAN_GE_RMAC_STATION_LOW + (port << =
12));=0A=
        netdev->dev_addr[1] =3D (unsigned char)=0A=
                (TITAN_GE_READ(TITAN_GE_RMAC_STATION_LOW + (port << =
12)) >> 8);=0A=
        netdev->dev_addr[2] =3D (unsigned char)=0A=
                TITAN_GE_READ(TITAN_GE_RMAC_STATION_MID + (port << =
12));=0A=
        netdev->dev_addr[3] =3D (unsigned char)=0A=
                (TITAN_GE_READ(TITAN_GE_RMAC_STATION_MID + (port << =
12)) >> 8);=0A=
        netdev->dev_addr[4] =3D (unsigned char)=0A=
                TITAN_GE_READ(TITAN_GE_RMAC_STATION_HI + (port << =
12));=0A=
        netdev->dev_addr[5] =3D (unsigned char)=0A=
                (TITAN_GE_READ(TITAN_GE_RMAC_STATION_HI + (port << 12)) =
>> 8);=0A=
#endif //CONFIG_PMC_SEQUOIA=0A=
=0A=
	err =3D register_netdev(netdev);=0A=
=0A=
        if (err)=0A=
                goto out_free_private;=0A=
=0A=
	printk(KERN_NOTICE=0A=
	       "%s: port %d with MAC address =
%02x:%02x:%02x:%02x:%02x:%02x\n",=0A=
	       netdev->name, port, netdev->dev_addr[0],=0A=
	       netdev->dev_addr[1], netdev->dev_addr[2],=0A=
	       netdev->dev_addr[3], netdev->dev_addr[4],=0A=
	       netdev->dev_addr[5]);=0A=
=0A=
#ifdef TITAN_RX_NAPI=0A=
	printk(KERN_NOTICE "Rx NAPI supported, Tx Coalescing ON \n");=0A=
#else=0A=
	printk(KERN_NOTICE "Rx and Tx Coalescing ON \n");=0A=
#endif=0A=
=0A=
#ifdef CONFIG_NET_FASTROUTE=0A=
	printk(KERN_NOTICE "Fastpath Routing turned ON \n");=0A=
#endif=0A=
=0A=
#ifdef CONFIG_NET_SKB_RECYCLING=0A=
	for(i=3D0; i < 1; i++) {=0A=
		titan_ge_rc[i].qlen +=3D RC_QUEUE_PER_DEV;=0A=
	}=0A=
#endif=0A=
=0A=
	return 0;=0A=
=0A=
out_free_private:=0A=
=0A=
out_free_netdev:=0A=
	// free_netdev(netdev);=0A=
=0A=
out:=0A=
	return err;=0A=
}=0A=
=0A=
/*=0A=
 * Reset the Ethernet port=0A=
 */=0A=
static void titan_ge_port_reset(unsigned int port_num)=0A=
{=0A=
	unsigned int reg_data;=0A=
=0A=
	/* Stop the Tx port activity */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 + =0A=
				(port_num << 12));=0A=
	reg_data &=3D ~(0x0001);=0A=
	TITAN_GE_WRITE((TITAN_GE_TMAC_CONFIG_1 + =0A=
			(port_num << 12)), reg_data);=0A=
=0A=
=0A=
	/* Wait till TMAC is brought down. */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        while (reg_data & 0x8000) {=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_TMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        }=0A=
=0A=
=0A=
	/* Stop the Rx port activity */=0A=
	reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 + =0A=
				(port_num << 12));=0A=
	reg_data &=3D ~(0x0001);=0A=
	TITAN_GE_WRITE((TITAN_GE_RMAC_CONFIG_1 + =0A=
			(port_num << 12)), reg_data);=0A=
=0A=
=0A=
	/* Wait till all packets received and RMAC brought down. */=0A=
        reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        while (reg_data & 0x8000) {=0A=
                reg_data =3D TITAN_GE_READ(TITAN_GE_RMAC_CONFIG_1 +=0A=
                                (port_num << 12));=0A=
        }=0A=
=0A=
=0A=
	return;=0A=
}=0A=
=0A=
/*=0A=
 * Return the Tx desc after use by the XDMA=0A=
 */=0A=
static int titan_ge_return_tx_desc(titan_ge_port_info * titan_ge_eth, =
int port)=0A=
{=0A=
	int tx_desc_used;=0A=
	struct sk_buff *skb;=0A=
	volatile titan_ge_tx_desc *tx_curr;=0A=
=0A=
	tx_desc_used =3D titan_ge_eth->tx_used_desc_q;=0A=
=0A=
	/* return right away */=0A=
	if (tx_desc_used =3D=3D titan_ge_eth->tx_curr_desc_q)=0A=
		return TITAN_ERROR;=0A=
=0A=
	/* Now the critical stuff */=0A=
	skb =3D titan_ge_eth->tx_skb[tx_desc_used];=0A=
=0A=
	tx_curr =3D &(titan_ge_eth->tx_desc_area[tx_desc_used]);=0A=
	pci_unmap_single(0, tx_curr->buffer_addr, tx_curr->buffer_len, =
PCI_DMA_TODEVICE);=0A=
=0A=
#ifdef CONFIG_NET_FASTROUTE=0A=
	if (port =3D=3D 1) =0A=
		__kfree_skb(skb);=0A=
	else=0A=
#endif=0A=
		dev_kfree_skb_any(skb);=0A=
=0A=
	titan_ge_eth->tx_skb[tx_desc_used] =3D NULL;=0A=
	titan_ge_eth->tx_used_desc_q =3D=0A=
	    (tx_desc_used + 1) % TITAN_GE_TX_QUEUE;=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Coalescing for the Rx path=0A=
 */=0A=
static unsigned long titan_ge_rx_coal(unsigned long delay, int port)=0A=
{=0A=
	TITAN_GE_WRITE(TITAN_GE_INT_COALESCING, delay);=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	TITAN_GE_WRITE(0x3034, delay);=0A=
#else=0A=
	TITAN_GE_WRITE(0x5038, delay);=0A=
#endif=0A=
	return delay;=0A=
}=0A=
=0A=
/*=0A=
 * Coalescing for the Tx path=0A=
 */=0A=
static unsigned long titan_ge_tx_coal(unsigned long delay, int port)=0A=
{=0A=
	unsigned long rx_delay;=0A=
=0A=
	rx_delay =3D TITAN_GE_READ(TITAN_GE_INT_COALESCING);=0A=
	delay =3D (delay << 16) | rx_delay;=0A=
=0A=
	TITAN_GE_WRITE(TITAN_GE_INT_COALESCING, delay);=0A=
#ifdef CONFIG_PMC_SEQUOIA=0A=
	TITAN_GE_WRITE(0x3034, delay);=0A=
#else=0A=
	TITAN_GE_WRITE(0x5038, delay);=0A=
#endif=0A=
	return delay;=0A=
}=0A=

------_=_NextPart_000_01C68069.1A1B3943--
