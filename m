Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 19:55:39 +0000 (GMT)
Received: from [85.21.88.2] ([85.21.88.2]:48013 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8135576AbVKGTzV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2005 19:55:21 +0000
Received: (qmail 6304 invoked from network); 7 Nov 2005 19:56:30 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 7 Nov 2005 19:56:30 -0000
Message-ID: <436FB1DE.6010405@ru.mvista.com>
Date:	Mon, 07 Nov 2005 22:58:22 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS Development <linux-mips@linux-mips.org>
CC:	alsa-devel@lists.sourceforge.net, dan@embeddededge.com,
	Pete Popov <ppopov@embeddedalley.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [Alsa-devel] Au1550 OSS driver issues
References: <43452054.2090305@ru.mvista.com>
In-Reply-To: <43452054.2090305@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050909010902020204030508"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050909010902020204030508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I wrote:

>     We have found some issues with Au1550 AC'97 OSS driver in 2.6
> (sound/oss/au1550_ac97.c), though it also should concern 2.4 driver
> (drivers/sound/au1550_psc.c).
>     First, we don't think that using readl() calls instead of au_readl() is
> correct -- readl() is subject to byte-swapping etc., so may not work in
> BE mode anymore and au_readl() is intended for embedded Au1550 devices for 
   > which the byte swapping issue is resolved automagically, and BTW the same
> PSC_AC97STAT register is read "both ways" in the driver.

         ... for no apparent reason?

> That's what the first patch is about.

>     Second, start_dac() grabs a spinlock already held by its caller, 
> au1550_write(). This doesn't show up with the standard UP spinlock 
> impelmentation but when the different one (mutex based) is in use, a 
> lockup happens. The second patch demonstates a possible solution but 
> here's a question: why there's no "symmetric" spinlock logic in 
> start_adc(), may be here exits another potential issue?

         After having a look at sound/oss/au1000.c, here's an updated patch 
that deals with "nested" spinlocks the same way that driver does, and adds 
spinlock to start_adc() as well.

WBR, Sergei


--------------050909010902020204030508
Content-Type: text/plain;
 name="au1550_ac97_readl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1550_ac97_readl.patch"

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: linux/sound/oss/au1550_ac97.c
===================================================================
--- linux.orig/sound/oss/au1550_ac97.c
+++ linux/sound/oss/au1550_ac97.c
@@ -463,7 +463,7 @@ stop_dac(struct au1550_state *s)
 	/* Wait for Transmit Busy to show disabled.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_TB) != 0);
 
@@ -492,7 +492,7 @@ stop_adc(struct au1550_state *s)
 	/* Wait for Receive Busy to show disabled.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_RB) != 0);
 
@@ -542,7 +542,7 @@ set_xmit_slots(int num_channels)
 	/* Wait for Device ready.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
@@ -574,7 +574,7 @@ set_recv_slots(int num_channels)
 	/* Wait for Device ready.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
@@ -1989,7 +1989,7 @@ au1550_probe(void)
 	/* Wait for PSC ready.
 	*/
 	do {
-		val = readl((void *)PSC_AC97STAT);
+		val = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((val & PSC_AC97STAT_SR) == 0);
 
@@ -2012,7 +2012,7 @@ au1550_probe(void)
 	/* Wait for Device ready.
 	*/
 	do {
-		val = readl((void *)PSC_AC97STAT);
+		val = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((val & PSC_AC97STAT_DR) == 0);
 






--------------050909010902020204030508
Content-Type: text/plain;
 name="au1550_ac7-spinlocks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1550_ac7-spinlocks.patch"

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: sound/oss/au1550_ac97.c
===================================================================
--- sound/oss/au1550_ac97.c~	10 Jul 2005 10:29:03 -0000
+++ sound/oss/au1550_ac97.c	7 Nov 2005 18:14:59 -0000
@@ -607,11 +607,14 @@ static void
 start_adc(struct au1550_state *s)
 {
 	struct dmabuf  *db = &s->dma_adc;
+	unsigned long   flags;
 	int	i;
 
 	if (!db->stopped)
 		return;
 
+	spin_lock_irqsave(&s->lock, flags);
+
 	/* Put two buffers on the ring to get things started.
 	*/
 	for (i=0; i<2; i++) {
@@ -630,6 +633,8 @@ start_adc(struct au1550_state *s)
 	au_sync();
 
 	db->stopped = 0;
+
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static int
@@ -1181,8 +1186,11 @@ au1550_write(struct file *file, const ch
 			if (db->nextOut >= db->rawbuf + db->dmasize)
 				db->nextOut -= db->dmasize;
 			db->total_bytes += db->dma_fragsize;
-			if (db->dma_qcount == 0)
+			if (db->dma_qcount == 0) {
+				spin_unlock(&s->lock);
 				start_dac(s);
+				spin_lock(&s->lock);
+			}
 			db->dma_qcount++;
 		}
 		spin_unlock_irqrestore(&s->lock, flags);





--------------050909010902020204030508--
