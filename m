Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6TDH7821844
	for linux-mips-outgoing; Sun, 29 Jul 2001 06:17:07 -0700
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6TDH3V21825
	for <linux-mips@oss.sgi.com>; Sun, 29 Jul 2001 06:17:03 -0700
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id A00462B303; Sun, 29 Jul 2001 14:16:56 +0100 (IST)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 07886A8A5; Sun, 29 Jul 2001 14:16:37 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id EA587A8A4; Sun, 29 Jul 2001 14:16:37 +0100 (IST)
Date: Sun, 29 Jul 2001 14:16:37 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, <engel@unix-ag.org>
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010728214114.C27316@lug-owl.de>
Message-ID: <Pine.LNX.4.32.0107291413510.11630-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


You really should read around before hacking :-)

http://www.skynet.ie/~airlied/mips/declance_2_3_48.c

is the declance driver for the DS5000/200, I'm not sure it still works but
it did the last time I looked at it .. the declance.c in the same dir is
for 2.2 kernel.. I must rename them someday..

Dave.


On Sat, 28 Jul 2001, Jan-Benedict Glaw wrote:

> Hi!
>
> I'm tryin' to get a DS5000/200 to work. Currently, I see that declance.c
> wasn't complete wrt. this system. Problem: ring buffer pointers not
> initialized, Oops. I've copied that part from {PMAX_LANCE,ASIC_LANCE},
> but that seems not to be enough. So now, the kernel loops infinitive
> when trying to send a bootp packet.
>
> Here's what I did:
>
> static int __init dec_lance_init(struct net_device *dev, const int type)
> {
> [...]
> 	switch (type) {
> [...]
> 	case PMAD_LANCE:
> 		slot = search_tc_card("PMAD-AA");
> 		claim_tc_card(slot);
>
> 		dev->mem_start = get_tc_base_addr(slot);
> 		dev->base_addr = dev->mem_start + 0x100000;
> 		dev->irq = get_tc_irq_nr(slot);
> 		esar_base = dev->mem_start + 0x1c0002;
> 		/*
> 		 * setup the pointer arrays, this sucks [tm] :-(
> 		 */
> 		for (i = 0; i < RX_RING_SIZE; i++) {
> 			lp->rx_buf_ptr_cpu[i] = (char *) (dev->mem_start + BUF_OFFSET_CPU
> 						 + 2 * i * RX_BUFF_SIZE);
> 			printk("lp->rx_buf_ptr_cpu[%d]=%p\n",
> 					i, lp->rx_buf_ptr_cpu[i]
> 			);
> 			lp->rx_buf_ptr_lnc[i] = (char *) (BUF_OFFSET_LNC
> 						     + i * RX_BUFF_SIZE);
> 			printk("lp->rx_buf_ptr_lnc[%d]=%p\n",
> 					i, lp->rx_buf_ptr_lnc[i]
> 			);
> 		}
> 		for (i = 0; i < TX_RING_SIZE; i++) {
> 			lp->tx_buf_ptr_cpu[i] = (char *) (dev->mem_start + BUF_OFFSET_CPU
> 					+ 2 * RX_RING_SIZE * RX_BUFF_SIZE
> 						 + 2 * i * TX_BUFF_SIZE);
> 			printk("lp->tx_buf_ptr_cpu[%d]=%p\n",
> 					i, lp->tx_buf_ptr_cpu[i]
> 			);
> 			lp->tx_buf_ptr_lnc[i] = (char *) (BUF_OFFSET_LNC
> 					    + RX_RING_SIZE * RX_BUFF_SIZE
> 						     + i * TX_BUFF_SIZE);
> 			printk("lp->tx_buf_ptr_lnc[%d]=%p\n",
> 					i, lp->tx_buf_ptr_lnc[i]
> 			);
> 		}
>
> 		break;
> [...]
> }
>
> However, the chip actually does not transmit the frame. Please look
> at it because I don't have a clue about the lance chip. Especially,
> I see there problems:
> 	- lp->tx_buf_ptr_lnc[i] and lp->rx_buf_ptr_lnc[i] are
> 	  quite low addresses. Is this correct? Are they relative
> 	  to some other address (TC slot address?)
> 	- while kernel's bootp tries to send the packet, only
> 	  buffers [0] to [5] are used. Why are not all 16 buffers
> 	  used?
>
> It would be *very* nice if the people who originally wrote this
> driver could help me...
>
> Here's the serial console's output:
>
> >>boot 6/tftp console=ttyS3 root=/dev/nfs ip=bootp rw
> 1630208+139264+146848
> This DECstation is a DS5000/200
> Loading R[23]000 MMU routines.
> [...]
> TURBOchannel rev. 1 at 25.0 MHz (without parity)
>     slot 5: DEC      PMAZ-AA  V5.3b
>     slot 6: DEC      PMAD-AA  V5.3a
> [...]
> declance.c: v0.008 by Linux Mips DECstation task force
> lp->rx_buf_ptr_cpu[0]=bf800240
> lp->rx_buf_ptr_lnc[0]=00000120
> lp->rx_buf_ptr_cpu[1]=bf800e40
> lp->rx_buf_ptr_lnc[1]=00000720
> lp->rx_buf_ptr_cpu[2]=bf801a40
> lp->rx_buf_ptr_lnc[2]=00000d20
> lp->rx_buf_ptr_cpu[3]=bf802640
> lp->rx_buf_ptr_lnc[3]=00001320
> lp->rx_buf_ptr_cpu[4]=bf803240
> lp->rx_buf_ptr_lnc[4]=00001920
> lp->rx_buf_ptr_cpu[5]=bf803e40
> lp->rx_buf_ptr_lnc[5]=00001f20
> lp->rx_buf_ptr_cpu[6]=bf804a40
> lp->rx_buf_ptr_lnc[6]=00002520
> lp->rx_buf_ptr_cpu[7]=bf805640
> lp->rx_buf_ptr_lnc[7]=00002b20
> lp->rx_buf_ptr_cpu[8]=bf806240
> lp->rx_buf_ptr_lnc[8]=00003120
> lp->rx_buf_ptr_cpu[9]=bf806e40
> lp->rx_buf_ptr_lnc[9]=00003720
> lp->rx_buf_ptr_cpu[10]=bf807a40
> lp->rx_buf_ptr_lnc[10]=00003d20
> lp->rx_buf_ptr_cpu[11]=bf808640
> lp->rx_buf_ptr_lnc[11]=00004320
> lp->rx_buf_ptr_cpu[12]=bf809240
> lp->rx_buf_ptr_lnc[12]=00004920
> lp->rx_buf_ptr_cpu[13]=bf809e40
> lp->rx_buf_ptr_lnc[13]=00004f20
> lp->rx_buf_ptr_cpu[14]=bf80aa40
> lp->rx_buf_ptr_lnc[14]=00005520
> lp->rx_buf_ptr_cpu[15]=bf80b640
> lp->rx_buf_ptr_lnc[15]=00005b20
> lp->tx_buf_ptr_cpu[0]=bf80c240
> lp->tx_buf_ptr_lnc[0]=00006120
> lp->tx_buf_ptr_cpu[1]=bf80ce40
> lp->tx_buf_ptr_lnc[1]=00006720
> lp->tx_buf_ptr_cpu[2]=bf80da40
> lp->tx_buf_ptr_lnc[2]=00006d20
> lp->tx_buf_ptr_cpu[3]=bf80e640
> lp->tx_buf_ptr_lnc[3]=00007320
> lp->tx_buf_ptr_cpu[4]=bf80f240
> lp->tx_buf_ptr_lnc[4]=00007920
> lp->tx_buf_ptr_cpu[5]=bf80fe40
> lp->tx_buf_ptr_lnc[5]=00007f20
> lp->tx_buf_ptr_cpu[6]=bf810a40
> lp->tx_buf_ptr_lnc[6]=00008520
> lp->tx_buf_ptr_cpu[7]=bf811640
> lp->tx_buf_ptr_lnc[7]=00008b20
> lp->tx_buf_ptr_cpu[8]=bf812240
> lp->tx_buf_ptr_lnc[8]=00009120
> lp->tx_buf_ptr_cpu[9]=bf812e40
> lp->tx_buf_ptr_lnc[9]=00009720
> lp->tx_buf_ptr_cpu[10]=bf813a40
> lp->tx_buf_ptr_lnc[10]=00009d20
> lp->tx_buf_ptr_cpu[11]=bf814640
> lp->tx_buf_ptr_lnc[11]=0000a320
> lp->tx_buf_ptr_cpu[12]=bf815240
> lp->tx_buf_ptr_lnc[12]=0000a920
> lp->tx_buf_ptr_cpu[13]=bf815e40
> lp->tx_buf_ptr_lnc[13]=0000af20
> lp->tx_buf_ptr_cpu[14]=bf816a40
> lp->tx_buf_ptr_lnc[14]=0000b520
> lp->tx_buf_ptr_cpu[15]=bf817640
> lp->tx_buf_ptr_lnc[15]=0000bb20
> eth0: PMAD-AA, addr = 08:00:2b:1c:44:ee, irq = 3
> [...]
> Sending BOOTP requests .lance_start_xmit:882: entry=0
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[0]=bf80c240, skb->data=8022c402, skblen=590)
> .lance_start_xmit:882: entry=1
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[1]=bf80ce40, skb->data=8022c402, skblen=590)
> .lance_start_xmit:882: entry=2
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[2]=bf80da40, skb->data=8022c402, skblen=590)
> .lance_start_xmit:882: entry=3
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[3]=bf80e640, skb->data=8022c402, skblen=590)
> .lance_start_xmit:882: entry=4
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[4]=bf80f240, skb->data=8022c402, skblen=590)
> .lance_start_xmit:882: entry=5
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[5]=bf80fe40, skb->data=8022c402, skblen=590)
>  timed out!
> IP-Config: Retrying forever (NFS root)...
> Sending BOOTP requests .lance_start_xmit:882: entry=0
> lance_start_xmit:884: calling cp_to_buf((char *) lp->tx_buf_ptr_cpu[0]=bf80c240, skb->data=8022c402, skblen=590)
> .lance_start_xmit:882: entry=1
> [...]
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
