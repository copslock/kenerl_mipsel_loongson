Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 14:53:01 +0100 (CET)
Received: from mail-pf0-x231.google.com ([IPv6:2607:f8b0:400e:c00::231]:32977
        "EHLO mail-pf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdLHNwyZPJRZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 14:52:54 +0100
Received: by mail-pf0-x231.google.com with SMTP id y89so7342223pfk.0
        for <linux-mips@linux-mips.org>; Fri, 08 Dec 2017 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBJniWlbydZY/Ul6eI2tSZUtEhBsYGVzQ/vBt1k2Va4=;
        b=plDNWWVuHERsoxC2LWZveovYzvB89k6MDv7ZUuWVElXsGd2jsmsd8s3B8obt5oXoH0
         jLTcUvG4Fs0DhTDCL55jxuVlmXf64sZCuuX1rg1smrzbsq2oHDhyYp6hNl1O8J9ImAi6
         S5UdrYnVSM1FPsTbmMl/0eULo8Uw+PSsEmH0RtMAgo3HYhOHpmlPzunsDKnW8Hk1A/YX
         TyZAHzuKT8b/ffUC1TEC5yodaULW/uEsigoKQjtciK7VT62qAlLc2iTTvnfS1LZtpqdY
         LaRUafYNDEuCQ44ahcYN45OULVJBrvVxL5HNb6enqF5NAIGkYkHvJSVn32Tuqp4/rROu
         sKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBJniWlbydZY/Ul6eI2tSZUtEhBsYGVzQ/vBt1k2Va4=;
        b=UPK0jcwKfupM/TXXDi5PyKXXyEvXLxNUxperyfSB44rDC48tAvxfpBIxzK7EKDHg3h
         oQISf3/5ZDQkjbxSu5OFkQWNHfm6VsomtTYYzVssDWynFemF9VSOh3q7nOpr9lZCBmUm
         0ohA0R1oNZTmUQ+g3kjGlD7YOWmWwaIdNLx+cOejyWmZx+4UlYuLrI9oL0fkm8SoCUd2
         c9oAt+NWdQ2c9fUL7M33sYuDfRKKjztruDkV0pRYKDCOqILhirhtd7YI4giDB7ibhKly
         /4jGvGR3JDdk0hNKH8gz37wDeFZbMFkj2FtMkGMRg37OxZe9HEr6ksYqjoNrZoV12nka
         pFVw==
X-Gm-Message-State: AJaThX50gdvDWSqStB+9BFez4xKYvVpqOW44uep8kePxRSg/NdEU5En1
        fKIJFyYt2iEvRLmvrxw77KY=
X-Google-Smtp-Source: AGs4zMZSs5EgZL4rpJLW49HhL2cBFXekE+kJgjsBMlGxVdqntgKbT++2fQBXikWAEDQzphmccfQhTA==
X-Received: by 10.99.167.6 with SMTP id d6mr29390322pgf.100.1512741167777;
        Fri, 08 Dec 2017 05:52:47 -0800 (PST)
Received: from edumazet-glaptop3.lan (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.googlemail.com with ESMTPSA id m87sm15572068pfi.88.2017.12.08.05.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 05:52:46 -0800 (PST)
Message-ID: <1512741164.25033.28.camel@gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Eric Dumazet <edumazet@google.com>,
        Matt Turner <mattst88@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Date:   Fri, 08 Dec 2017 05:52:44 -0800
In-Reply-To: <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
         <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
         <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
         <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 2017-12-08 at 05:42 -0800, Eric Dumazet wrote:
> On Thu, Dec 7, 2017 at 11:54 PM, Matt Turner <mattst88@gmail.com>
> wrote:
> > On Thu, Dec 7, 2017 at 11:00 PM, Matt Turner <mattst88@gmail.com>
> > wrote:
> > > On Sun, Mar 12, 2017 at 6:43 PM, Matt Turner <mattst88@gmail.com>
> > > wrote:
> > > > On a Broadcom BCM91250a MIPS system I can reliably trigger NFS
> > > > corruption on the first file read.
> > > > 
> > > > To demonstrate, I downloaded five identical copies of the gcc-
> > > > 5.4.0
> > > > source tarball. On the NFS server, they hash to the same value:
> > > > 
> > > > server distfiles # md5sum gcc-5.4.0.tar.bz2*
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
> > > > 
> > > > On the MIPS system (the NFS client):
> > > > 
> > > > bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2.2
> > > > 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
> > > > bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
> > > > 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
> > > > 
> > > > The first file read will contain some corruption, and it is
> > > > persistent until...
> > > > 
> > > > bcm91250a-le distfiles # echo 1 > /proc/sys/vm/drop_caches
> > > > bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
> > > > 
> > > > the caches are dropped, at which point it reads back properly.
> > > > 
> > > > Note that the corruption is different across reboots, both in
> > > > the size
> > > > of the corruption and the location. I saw 1900~ and 1400~ byte
> > > > sequences corrupted on separate occasions, which don't
> > > > correspond to
> > > > the system's 16kB page size.
> > > > 
> > > > I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
> > > > today). All exhibit this behavior with differing frequencies.
> > > > Earlier
> > > > kernels seem to reproduce the issue less often, while more
> > > > recent
> > > > kernels reliably exhibit the problem every boot.
> > > > 
> > > > How can I further debug this?
> > > 
> > > I think I was wrong about the statement about kernels v3.19 to
> > > 4.11-rc1+. I found out I couldn't reproduce with 4.7-rc1 and then
> > > bisected to 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq:
> > > Let
> > > ksoftirqd do its job"). Still reproduces with current tip of
> > > Linus'
> > > tree.
> > > 
> > > Any ideas? The board's ethernet is an uncommon device supported
> > > by
> > > CONFIG_SB1250_MAC. Something about the ethernet driver maybe?
> > 
> > With the patch reverted on master (reverts cleanly), NFS corruption
> > no
> > longer happens.
> 
> Hi Matt.
> 
> Thanks for bisecting.
> 
> Patch simply exposes an existing bug more often by changing the way
> driver functions are scheduled.
> 
> Which is probably a good thing.
> 
> sbmac_intr() looks extremely suspicious to me.
> 
> A NAPI driver hard interrupt should simply schedule NAPI.
> 
> Apparently, if sbmac_intr() can not grab NAPIF_STATE_SCHED bit, it
> directly calls sbdma_rx_process() from
> hard interrupt context.
> 
> Insane really.

Please try this fix (not compiled on my x86 laptop, and I had no coffee
yet, so it might have some trivial errors)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index ecdef42f0ae63641419a603f0b4eec2fc213c334..3ddd9ca469b280e70509b22fd7d3f449c81fbedc 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -287,8 +287,6 @@ static int sbdma_add_rcvbuffer(struct sbmac_softc *sc, struct sbmacdma *d,
 static int sbdma_add_txbuffer(struct sbmacdma *d, struct sk_buff *m);
 static void sbdma_emptyring(struct sbmacdma *d);
 static void sbdma_fillring(struct sbmac_softc *sc, struct sbmacdma *d);
-static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
-			    int work_to_do, int poll);
 static void sbdma_tx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 			     int poll);
 static int sbmac_initctx(struct sbmac_softc *s);
@@ -1063,7 +1061,7 @@ static void sbmac_netpoll(struct net_device *netdev)
  ********************************************************************* */
 
 static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
-			    int work_to_do, int poll)
+			    int work_to_do)
 {
 	struct net_device *dev = sc->sbm_dev;
 	int curidx;
@@ -1076,7 +1074,6 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 
 	prefetch(d);
 
-again:
 	/* Check if the HW dropped any frames */
 	dev->stats.rx_fifo_errors
 	    += __raw_readq(sc->sbm_rxdma.sbdma_oodpktlost) & 0xffff;
@@ -1169,10 +1166,7 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 				}
 				prefetch(sb->data);
 				prefetch((const void *)(((char *)sb->data)+32));
-				if (poll)
-					dropped = netif_receive_skb(sb);
-				else
-					dropped = netif_rx(sb);
+				dropped = netif_receive_skb(sb);
 
 				if (dropped == NET_RX_DROP) {
 					dev->stats.rx_dropped++;
@@ -1201,10 +1195,6 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 		d->sbdma_remptr = SBDMA_NEXTBUF(d,sbdma_remptr);
 		work_done++;
 	}
-	if (!poll) {
-		work_to_do = 32;
-		goto again; /* collect fifo drop statistics again */
-	}
 done:
 	return work_done;
 }
@@ -2006,11 +1996,6 @@ static irqreturn_t sbmac_intr(int irq,void *dev_instance)
 			__napi_schedule(&sc->napi);
 			/* Depend on the exit from poll to reenable intr */
 		}
-		else {
-			/* may leave some packets behind */
-			sbdma_rx_process(sc,&(sc->sbm_rxdma),
-					 SBMAC_MAX_RXDESCR * 2, 0);
-		}
 	}
 	return IRQ_RETVAL(handled);
 }
@@ -2529,7 +2514,7 @@ static int sbmac_poll(struct napi_struct *napi, int budget)
 	struct sbmac_softc *sc = container_of(napi, struct sbmac_softc, napi);
 	int work_done;
 
-	work_done = sbdma_rx_process(sc, &(sc->sbm_rxdma), budget, 1);
+	work_done = sbdma_rx_process(sc, &(sc->sbm_rxdma), budget);
 	sbdma_tx_process(sc, &(sc->sbm_txdma), 1);
 
 	if (work_done < budget) {
