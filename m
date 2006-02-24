Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 20:37:17 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:13580 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133758AbWBXUhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2006 20:37:08 +0000
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Fri, 24 Feb 2006 12:44:27 -0800
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 3DDE32AF; Fri, 24 Feb 2006 12:44:10 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 14FB82AE; Fri, 24 Feb
 2006 12:44:10 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CZL16025; Fri, 24 Feb 2006 12:44:05 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 7176D20501; Fri, 24 Feb 2006 12:44:05 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC] SMP initialization order fixes.
Date:	Fri, 24 Feb 2006 12:44:05 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D077D619E@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: [RFC] SMP initialization order fixes.
Thread-Index: AcY5fVm0Dk3bCIjHQ8yfwk2j4utBkQABUodg
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Stuart Anderson" <anderson@netsweng.com>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022406; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230332E34334646364645442E303037452D412D;
 ENG=IBF; TS=20060224204430; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022406_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FE1AFA10QO18560-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Yep, that's the problem we're run into as well.  We're working on a NAPI
patch for the sb1250-mac.c driver which fixes this - but that's not
quite ready for release yet.

In the meantime, adding the following line manually to net/core/dev.c
(in netif_rx(), right after the enqueue label) appears to suppress the
problem with no ill effects...  Note: this is *NOT* a fix, it's a hack.
Please let me know if it works for you.

Thx,
Mark

        if (queue->input_pkt_queue.qlen <= netdev_max_backlog) {
                if (queue->input_pkt_queue.qlen) {
enqueue:
+                       netif_rx_schedule(&queue->backlog_dev);
                        dev_hold(skb->dev);
                        __skb_queue_tail(&queue->input_pkt_queue, skb);
                        local_irq_restore(flags);
                        return NET_RX_SUCCESS;
                }

                netif_rx_schedule(&queue->backlog_dev);
                goto enqueue;
        }


> -----Original Message-----
> From: Stuart Anderson [mailto:anderson@netsweng.com] 
> Sent: Friday, February 24, 2006 12:03 PM
> To: Mark E Mason
> Cc: linux-mips@linux-mips.org
> Subject: RE: [RFC] SMP initialization order fixes.
> 
> On Fri, 24 Feb 2006, Mark E Mason wrote:
> 
> > Hello Stuart,
> >
> > Um - define "hung"...
> 
> Networking stops happening. At this point, processes are still active.
> Because I am using NFS root, any process that touches the 
> filesystem will then hang. It doesn't take too long for 
> enough processes to touch the FS for the system to be 
> useless. As a test, I put a tmpfs on /tmp, and ran sash from 
> there. That shell would remain responsive after the rest of 
> the system was hung waiting on NFS.
> 
>                                   Stuart
> 
> Stuart R. Anderson                               anderson@netsweng.com
> Network & Software Engineering                   
> http://www.netsweng.com/
> 1024D/37A79149:                                  0791 D3B8 
> 9A4C 2CDC A31F
>                                                    BD03 0A62 
> E534 37A7 9149
> 
> 
