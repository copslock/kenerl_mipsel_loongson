Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2003 04:50:08 +0100 (BST)
Received: from [IPv6:::ffff:211.154.175.2] ([IPv6:::ffff:211.154.175.2]:34308
	"EHLO mail.netpower.com.cn") by linux-mips.org with ESMTP
	id <S8225200AbTE2DuF>; Thu, 29 May 2003 04:50:05 +0100
Received: from netpower.com.cn [192.168.0.196] by mail.netpower.com.cn with ESMTP
  (SMTPD32-7.07) id A2634370048; Thu, 29 May 2003 11:45:39 +0800
Message-ID: <3ED586BE.9050906@netpower.com.cn>
Date: Thu, 29 May 2003 12:04:14 +0800
From: Zhang Haitao <zhanght@netpower.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Hi, this is my patch for broadcom sb1250-mac.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <zhanght@netpower.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhanght@netpower.com.cn
Precedence: bulk
X-list: linux-mips

Hi, i've got sb1250-mac.c from broadcom directly,
but find the original driver are not working stable when
delivering 64bytes framesize packets under gigabits circumstance.
This patch have been ported a part of NAPI (added an sbmac_poll 
function,dev->quota = 80 )
and modified some parameters to enhance the packets processing performance
eg. tx&rx dma discriptor numbers and dual TX channel configuration.
at the same, in order to let may driver working in Gigafiber circumstance,
i also added some codes for fiber mode controll.

After using my pacth, my board can process 140Mbps 64bytes packets under 
linux.

but there are still some problem exsit in my driver :
seems that bug will be trigger when running into fiber mode
and i also use klogd to collect some oops message, hope someone can told me
what's happend to make my kernel crashed.... :-(

i'm very glad to let all of you to review this patch
or give me some advice from the oops message!

Thanks in advance !
 
yours
Zhang Haitao

here i post my most part of this patch  and oops message get from klogd

----------------------------------------
< static int int_pktcnt = 32;
< static int int_timeout = 1024;
---
 > #ifdef CONFIG_SBMAC_COALESCE
 > static int int_pktcnt = 0;
 > static int int_timeout = 0;
 > #endif
94,95d95
< #define CONFIG_SB1250_NAPI
< #define NAPI_LOP_MAX 10
156,159c154,155
< #define SBMAC_MAX_TXDESCR     128
< #define SBMAC_MAX_RXDESCR     128
---
 > #define SBMAC_MAX_TXDESCR     32
 > #define SBMAC_MAX_RXDESCR     32
270,272d263
<
<       int              sbm_fibermode;
<       int              sbm_phy_oldsignaldetect;
293a285
 > static void sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d);
300d291
< /*static void sbmac_init_and_start(struct sbmac_softc *sc);*/
304,310d294
< #ifdef CONFIG_SB1250_NAPI
< static int sbmac_poll(struct net_device *dev_instance, int *budget);
< static inline void sbmac_irq_disable(struct sbmac_softc *s);
< static inline void sbmac_irq_enable(struct sbmac_softc *s);
< #else
< static void sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d);
< #endif
312c296
< static int sbmac_init(struct net_device *dev);
---
 > static int sbmac_init(struct net_device *dev, int idx);
460,468d442
< /* Added for Fiber mode detection
< just read Signal Detect alternation */
<
< #define MII_AUXCTL      0x18   /* Auxiliary Control Register */
<
< #define MII_SGMIISR     0x0C    /* SGMII/100-X Status Register */
<
< #define SGMIISR_FIBERSDS      0x2000
<
480,490d453
< #ifdef CONFIG_SB1250_NAPI
< static inline void sbmac_irq_disable(struct sbmac_softc *s){
<          SBMAC_WRITECSR(s->sbm_imr,
<                      ((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << 
S_MAC_TX_CH0));
< }
< static inline void sbmac_irq_enable(struct sbmac_softc *s){
<       SBMAC_WRITECSR(s->sbm_imr,
<                      ((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << 
S_MAC_TX_CH0) |
<                      ((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << 
S_MAC_RX_CH0));
< }
< #endif
1075,1082c1040,1042
<       phys = KVTOPHYS(sb->data);
<       ncb = NUMCACHEBLKS(length+(phys & (CACHELINESIZE-1)));
< #ifdef CONFIG_SBMAC_COALESCE
<       /* do not interript per DMA transfer*/
<       dsc->dscr_a = phys |
<               V_DMA_DSCRA_A_SIZE(ncb) |
<               M_DMA_ETHTX_SOP;
< #else
---
 >       phys = virt_to_phys(sb->data);
 >       ncb = NUMCACHEBLKS(length+(phys & (SMP_CACHE_BYTES - 1)));
 >
1084a1045
 > #ifndef CONFIG_SBMAC_COALESCE
1085a1047
 > #endif
1166c1129
< #ifndef CONFIG_SB1250_NAPI
---
 >
1213,1221c1176,1177
<               if (curidx == hwidx) break;
<               /*{
<                       int i;
<                       for (i=0;;i++) {
<                       if ((dsc->dscr_a & M_DMA_ETHRX_SOP) != 0)
<                               break;
<                       if (i >= NAPI_LOP_MAX) goto ret;
<                       }
<               }*/
---
 >               if (curidx == hwidx)
 >                       break;
1392d1355
<               //__kfree_skb(sb); //try free fast
1433,1434c1396
<
<       int auxctl;
---
1455,1456d1416
<
<       s->sbm_phy_oldsignaldetect =0;
1478,1481d1438
<
<       /*
<        * Fiber/Copper Mode AutoDetection
<        */
1483,1489d1439
<       sbmac_mii_write(s,1,MII_AUXCTL,0x2007);
<       auxctl = sbmac_mii_read(s,1,MII_AUXCTL);
<       if(auxctl)
<               {
<                       s->sbm_fibermode=1;
<               }
<       else s->sbm_fibermode=0;
1686,1687d1635
<                      M_MAC_RXDMA_EN1 |
<                      M_MAC_TXDMA_EN1 |
2182c2107
<                * Receives on channel 0,1
---
 >                * Receives on channel 0
2198,2206c2123,2128
<        * (EOP_SEEN is part of M_MAC_INT_CHANNEL << S_MAC_RX_CH0)
<        */
<
<
<       if (isr & (M_MAC_INT_CHANNEL << S_MAC_RX_CH0)) {
< #ifdef CONFIG_SB1250_NAPI
<               if (netif_rx_schedule_prep(dev)) {
<                       sbmac_irq_disable(sc);
<                       __netif_rx_schedule(dev);
---
 >                * (EOP_SEEN is part of M_MAC_INT_CHANNEL << S_MAC_RX_CH0)
 >                */
 >
 >
 >               if (isr & (M_MAC_INT_CHANNEL << S_MAC_RX_CH0)) {
 >                       sbdma_rx_process(sc,&(sc->sbm_rxdma));
2208,2210d2129
< #else
<               sbdma_rx_process(sc,&(sc->sbm_rxdma));
< #endif
2213d2131
< }
2251,2268d2172
< #ifdef CONFIG_SB1250_NAPI
< //#define NAPI_POL_MAX 100
< static int sbmac_poll(struct net_device *dev_instance, int *budget) {
<       struct net_device *dev = (struct net_device *) dev_instance;
<     struct sbmac_softc *sc = (struct sbmac_softc *) (dev_instance->priv);
<     sbmacdma_t *d = &(sc->sbm_rxdma);
<     int rx_work_limit = *budget;
<       unsigned long flags;
<       long int receive=0;
<       int curidx;
<       int hwidx;
<
<       sbdmadscr_t *dsc;
<       struct sk_buff *sb;
<       int len;
<
<     if(rx_work_limit > dev->quota)
<           rx_work_limit = dev->quota;
2270,2382d2173
<     for (;;) {
<               if(--rx_work_limit < 0) goto not_done;
<               curidx = d->sbdma_remptr - d->sbdma_dscrtable;
<               hwidx = (int) (((SBMAC_READCSR(d->sbdma_curdscr) & 
M_DMA_CURDSCR_ADDR) -
<                               d->sbdma_dscrtable_phys) / 
sizeof(sbdmadscr_t));
<               if (curidx == hwidx) break;
<
<               dsc = &(d->sbdma_dscrtable[curidx]);
<               sb = d->sbdma_ctxtable[curidx];
<               d->sbdma_ctxtable[curidx] = NULL;
<
<               len = (int)G_DMA_DSCRB_PKT_SIZE(dsc->dscr_b) - 4;
<               if (!(dsc->dscr_a & M_DMA_ETHRX_BAD)) {
<
<
<                       if (sbdma_add_rcvbuffer(d,NULL) == -ENOBUFS) {
<                           sc->sbm_stats.rx_dropped++;
<                           sbdma_add_rcvbuffer(d,sb);  /* re-add old 
buffer */
<                           }
<                       else {
<                           /*
<                            * Set length into the packet
<                            */
<                           skb_put(sb,len);
<
<                           /*
<                            * Buffer has been replaced on the receive ring.
<                            * Pass the buffer to the kernel
<                            */
<                           sc->sbm_stats.rx_bytes += len;
<                           sc->sbm_stats.rx_packets++;receive++;
<                           sb->protocol = 
eth_type_trans(sb,d->sbdma_eth->sbm_dev);
<                             if (sc->rx_hw_checksum == ENABLE) {
<                           /* if the ip checksum is good indicate in skb.
<                               else set CHECKSUM_NONE as device failed to
<                                       checksum the packet */
<
<                              if (((dsc->dscr_b) |M_DMA_ETHRX_BADTCPCS) ||
<                                 ((dsc->dscr_a)| M_DMA_ETHRX_BADIP4CS)){
<                                 sb->ip_summed = CHECKSUM_NONE;
<                              } else {
<                                printk(KERN_DEBUG "hw checksum fail .\n");
<                                sb->ip_summed = CHECKSUM_UNNECESSARY;
<                              }
<                           } /*rx_hw_checksum */
<                             netif_receive_skb(sb);
<                           }
<               }
<               else {
<                       /*
<                        * Packet was mangled somehow.  Just drop it and
<                        * put it back on the receive ring.
<                        */
<                       sc->sbm_stats.rx_errors++;
<                       sbdma_add_rcvbuffer(d,sb);
<               }
<
<               d->sbdma_remptr = SBDMA_NEXTBUF(d,sbdma_remptr);
<
<       }
<       if (!receive) receive = 1;
<       dev->quota -= receive;
<       *budget -= receive;
<
<       spin_lock_irqsave(&sc->sbm_lock,flags);
<       netif_rx_complete(dev);
<         sbmac_irq_enable(sc);
<       spin_unlock_irqrestore(&sc->sbm_lock,flags);
<       return 0;
< not_done:
<       dev->quota -= receive;
<       *budget -= receive;
<       return 1;
< }
< #endif
2639,2642d2437
< #ifdef CONFIG_SB1250_NAPI
<         dev->poll       = sbmac_poll;
<         dev->weight     =dev->quota = 80;
< #endif
2646,2652c2441,2442
<       if (soc_pass >= K_SYS_REVISION_PASS3) {
<               /* In pass3 we do dumb checksum in TX */
<               dev->features |= NETIF_F_IP_CSUM;
<       }
<
<         /* This is needed for PASS2 for Rx H/W checksum feature */
<       sbmac_set_iphdr_offset( sc);
---
 >       /* This is needed for PASS2 for Rx H/W checksum feature */
 >       sbmac_set_iphdr_offset(sc);
2720,2723d2508
<       int signaldetect;
<
<       if(s->sbm_fibermode == 0)
<               {
< #ifdef CONFIG_NET_SB1250_MAC_QUIET
<     noisy = 0;
< #endif
2818,2852d2601
<    }
<    else
<       { //fiber mode
<
<       chg=0;
<       printk("sbm_phy_oldsignaldetect:%d\n",s->sbm_phy_oldsignaldetect);
<
<       signaldetect = (SGMIISR_FIBERSDS & 
sbmac_mii_read(s,s->sbm_phys[0],MII_SGMIISR));
<
<     printk("current signaldetect:%d\n",signaldetect);
<
<       if (signaldetect == 0)
<               {
<               printk("link state is DOWN!\n");
<               s->sbm_phy_oldsignaldetect = 0;
<               return 0;
<               }
<       else
<               {
<               if(s->sbm_phy_oldsignaldetect != signaldetect)
<               {
<               s->sbm_phy_oldsignaldetect = signaldetect;
<               chg = 1;
<               printk("link state has been changed\n");
<               }
<               }
<       if (chg==0) return 0;
<               printk("Link is up\n");
<               s->sbm_speed = sbmac_speed_1000;
<               s->sbm_duplex = sbmac_duplex_full;
<               s->sbm_fc = sbmac_fc_frame;
<               s->sbm_state = sbmac_state_on;
<       noisy =0;
<        printk("fiber mode.\t");
<       }
2865d2611
<       int signaldetect;
2868,2870c2614
<
<     if(sc->sbm_fibermode == 0)
<     {
2883,2899d2626
<     }
<     else
<     {
<       signaldetect = (SGMIISR_FIBERSDS & 
sbmac_mii_read(sc,sc->sbm_phys[0],MII_SGMIISR));
<               if(sc->sbm_phy_oldsignaldetect != signaldetect)
<               {
<                 sc->sbm_phy_oldsignaldetect = signaldetect;
<               if (signaldetect) {
<                  printk("netif_carrier_on. \n");
<                netif_carrier_on(dev);
<               }
<               else {
<                netif_carrier_off(dev);
<               }
<                 printk("link state has been changed\n");
<               }
<     }
2905,2915c2632,2642
<       if (sbmac_mii_poll(sc,1)) {
<           if (sc->sbm_state != sbmac_state_off) {
<               /*
<                * something changed, restart the channel
<                */
<               if (debug > 1) {
<                   printk("%s: restarting channel because speed changed\n",
<                          sc->sbm_dev->name);
<                   }
<               sbmac_channel_stop(sc);
<               sbmac_channel_start(sc);
---
 >       if (sbmac_mii_poll(sc,noisy_mii)) {
 >               if (sc->sbm_state != sbmac_state_off) {
 >                       /*
 >                        * something changed, restart the channel
 >                        */
 >                       if (debug > 1) {
 >                               printk("%s: restarting channel because 
speed changed\n",
 >                                      sc->sbm_dev->name);
 >                       }
 >                       sbmac_channel_stop(sc);
 >                       sbmac_channel_start(sc);
3163c2893
<               sbmac_init(dev);
---
 >               sbmac_init(dev, macidx);

----------------------------------------------------
and blow is the oops messages
----------------------------------------------------
May 28 14:16:04 netpower kernel: napi mac_irq disable.
May 28 14:16:04 netpower kernel: skput:over: 801dce38:2498 put:2498 
dev:eth2kern
el BUG at skbuff.c:92!
May 28 14:16:04 netpower kernel: Unable to handle kernel paging request 
at virtu
al address 00000000, epc == 801f1a5c, ra == 801dce4c
May 28 14:16:04 netpower kernel: Oops in fault.c::do_page_fault, line 219:
May 28 14:16:04 netpower kernel: $0 : 00000000 10001f00 0000001b 
00000000 000000
01 80cbe000 00000001 00000000
May 28 14:16:04 netpower kernel: $8 : 007d351a 00000000 00008001 
00000000 802f63
79 fffffffa 0000000a 802afc79
May 28 14:16:04 netpower kernel: $16: 8fe1b980 000009c2 8fe16a74 
8fe16960 8fe140
00 0000004f 00000000 8fe16800
May 28 14:16:04 netpower kernel: $24: ffffffff 
00000002                   802ae0
00 802afdb8 8fe16800 801dce4c
May 28 14:16:04 netpower kernel: Hi : 00000003
May 28 14:16:04 netpower kernel: Lo : 33333334
May 28 14:16:04 netpower kernel: epc  : 801f1a5c    Not tainted
May 28 14:16:04 netpower kernel: Status: 10001f03
May 28 14:16:04 netpower kernel: Cause : 1080000c
May 28 14:16:04 netpower kernel: Process swapper (pid: 0, 
stackpage=802ae000)
May 28 14:16:04 netpower kernel: Stack:    802993c0 802993d8 0000005c 
00000001 8
fe16800 8fe16960 801dce4c
May 28 14:16:04 netpower kernel:  80115490 00000000 2ac58da0 80296972 
8fe16968 8
fe168c0 8fe16800 00000001
May 28 14:16:04 netpower kernel:  802c11dc 802c11dc 802c11c0 00000000 
00016424 8
ffae460 801f7874 00000000
May 28 14:16:04 netpower kernel:  802afe20 8029695c 00000001 0000012c 
ffffffff 00000000 802c0c90 fffffffb
May 28 14:16:04 netpower kernel:  00000000 10001f00 802afea8 8ffd1208 
8fed1cb0 8011ae44 801037d4 8010bb34
May 28 14:16:04 netpower kernel:  00000037 ...
May 28 14:16:04 netpower kernel: Call Trace:   
[dm_head_vals.0+1568/4944] [dm_head_vals.0+1592/4944] 
[sbmac_poll+524/1240] [printk+608/688] [twist_table.0+3010/3712]
May 28 14:16:04 netpower kernel:  [net_rx_action+356/704] 
[twist_table.0+2988/3712] [do_softirq+228/440] 
[handle_IRQ_event+144/304] [local_timer_interrupt+152/164] [do_IRQ+316/372]
May 28 14:16:04 netpower kernel:  [sb1250_timer_interrupt+248/252] 
[sb1250_time_init+8/588] [cpu_idle+60/112] [cpu_idle+92/112] 
[init+0/468] [std_ide_release_region+204/2360]
May 28 14:16:04 netpower kernel:  [std_ide_release_region+268/2360]
May 28 14:16:04 netpower kernel:
May 28 14:16:04 netpower kernel: Code: 0c04548c  2406005c  8fbf0018 
<ac000000> 03e00008  27bd0020  3c02802a  244293e4  0807c68e
May 28 14:16:04 netpower kernel: Kernel panic: Aiee, killing interrupt 
handler!


 
