Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25E7hh25685
	for linux-mips-outgoing; Tue, 5 Mar 2002 06:07:43 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25E7W925681
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 06:07:32 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16iEep-0006ZY-00; Tue, 05 Mar 2002 14:07:07 +0100
Date: Tue, 5 Mar 2002 14:07:07 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Andrea Venturi <a.venturi@cineca.it>
cc: linux-mips@oss.sgi.com
Subject: Re: device support on indy WS !?
In-Reply-To: <3C84B611.5050103@cineca.it>
Message-ID: <Pine.LNX.4.21.0203051355360.24029-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Mar 2002, Andrea Venturi wrote:

[snip]
> 1. audio hal2: i saw in the cvs.sgi.com kernel the OSS hal2.* files; 
> what about the guenther alsa0.9 port? is it finished? what about iec958 
> spdif support?

I can't say anything about ALSA 0.9 port. I decided for OSS driver,
because I wanded to listen music and there was no driver. OSS is much
better documented interface than ALSA.

Sometimes you get HAL2 timeout when closing /dev/dsp. It is my fault and
I'm sorry for it. Following patch solves it.

Index: linux/drivers/sound/hal2.c
===================================================================
RCS file: /cvs/linux/drivers/sound/hal2.c,v
retrieving revision 1.3.2.5
diff -u -r1.3.2.5 hal2.c
--- linux/drivers/sound/hal2.c	2002/02/15 02:14:40	1.3.2.5
+++ linux/drivers/sound/hal2.c	2002/03/04 12:33:53
@@ -691,32 +691,25 @@
 	DECLARE_WAITQUEUE(wait, current);
 	hal2_codec_t *dac = &hal2->dac;
 	int ret = 0;
-	signed long timeout = 1 + 1000 * H2_BUFFER_SIZE * 2 * dac->voices *
+	signed long timeout = 1000 * H2_BUFFER_SIZE * 2 * dac->voices *
 			      HZ / dac->sample_rate / 900;
 
 	down(&dac->sem);
 	
-	while (dac->tail->info.cnt > 0 && ret == 0) {
+	while (dac->pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_ISACT) {
 		add_wait_queue(&dac->dma_wait, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!schedule_timeout(timeout))
 			/* We may get bogus timeout when system is 
 			 * heavily loaded */
 			if (dac->tail->info.cnt) {
 				printk("HAL2: timeout...\n");
-				ret = -ETIME;
+				hal2_stop_dac(hal2);
+				hal2_reset_dac_pointer(hal2);
 			}
-		if (signal_pending(current))
-			ret = -ERESTARTSYS;
 		remove_wait_queue(&dac->dma_wait, &wait);
 	}
 
-	/* Make sure that DMA is stopped */
-	if (dac->pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_ISACT) {
-		hal2_stop_dac(hal2);
-		hal2_reset_dac_pointer(hal2);
-	}
-	
 	up(&dac->sem);
 	
 	return ret;
@@ -1108,7 +1101,7 @@
 	} else {
 		do {
 			/* ~10% longer */
-			signed long timeout = 1 + 1000 * H2_BUFFER_SIZE *
+			signed long timeout = 1000 * H2_BUFFER_SIZE *
 				2 * adc->voices * HZ / adc->sample_rate / 900;
 			DECLARE_WAITQUEUE(wait, current);
 			ssize_t cnt = 0;
@@ -1169,7 +1162,7 @@
 	} else {
 		do {
 			/* ~10% longer */
-			signed long timeout = 1 + 1000 * H2_BUFFER_SIZE *
+			signed long timeout = 1000 * H2_BUFFER_SIZE *
 				2 * dac->voices * HZ / dac->sample_rate / 900;
 			DECLARE_WAITQUEUE(wait, current);
 			ssize_t cnt = 0;

recording doesn't work and will not work until someone provide better
documentation.

btw, what is iec958 spdig?

> 2. isdn: there is a siemens isac-s chip (BTW i didn't see the hscx 
> twin): is it supported now? it should be not to difficult to leverage 
> the ia32-isdn hisax (passive) isac driver _if_ the hpc3 delivers the 
> irq? what do you think about it?

there is currenty no support. any documentation available?
