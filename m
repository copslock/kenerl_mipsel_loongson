Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2005 16:23:16 +0100 (BST)
Received: from twilight.cs.hut.fi ([IPv6:::ffff:130.233.40.5]:51864 "EHLO
	twilight.cs.hut.fi") by linux-mips.org with ESMTP
	id <S8225988AbVHPPWj>; Tue, 16 Aug 2005 16:22:39 +0100
Received: by twilight.cs.hut.fi (Postfix, from userid 60001)
	id 9F3D62CDD; Tue, 16 Aug 2005 18:27:08 +0300 (EEST)
Received: from kekkonen.cs.hut.fi (kekkonen.cs.hut.fi [130.233.41.50])
	by twilight.cs.hut.fi (Postfix) with ESMTP id 1F5812CD6
	for <linux-mips@linux-mips.org>; Tue, 16 Aug 2005 18:27:06 +0300 (EEST)
Received: (from tmnousia@localhost)
	by kekkonen.cs.hut.fi (8.11.7p1+Sun/8.10.2) id j7GFR5q22548;
	Tue, 16 Aug 2005 18:27:05 +0300 (EEST)
Date:	Tue, 16 Aug 2005 18:27:05 +0300 (EEST)
From:	turja@mbnet.fi
X-X-Sender: tmnousia@kekkonen.cs.hut.fi
Reply-To: turja@mbnet.fi
To:	linux-mips@linux-mips.org
Subject: [PATCH] SGI Indy VINO video driver 0.0.4
Message-ID: <Pine.GSO.4.58.0508161703460.17458@kekkonen.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <tmnousia@twilight.cs.hut.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turja@mbnet.fi
Precedence: bulk
X-list: linux-mips


The patch includes many bugfixes and auto-detection
of video standards has been implemented.

More information: http://www.mbnet.fi/~turja/vino/


Mikael Nousiainen


diff -urN a/drivers/media/video/indycam.c b/drivers/media/video/indycam.c
--- a/drivers/media/video/indycam.c	2005-08-16 16:31:19.000000000 +0300
+++ b/drivers/media/video/indycam.c	2005-08-16 16:32:17.000000000 +0300
@@ -27,15 +27,15 @@

 #include "indycam.h"

-//#define INDYCAM_DEBUG
-
-#define INDYCAM_MODULE_VERSION "0.0.3"
+#define INDYCAM_MODULE_VERSION "0.0.4"

 MODULE_DESCRIPTION("SGI IndyCam driver");
 MODULE_VERSION(INDYCAM_MODULE_VERSION);
 MODULE_AUTHOR("Mikael Nousiainen <tmnousia@cc.hut.fi>");
 MODULE_LICENSE("GPL");

+// #define INDYCAM_DEBUG
+
 #ifdef INDYCAM_DEBUG
 #define dprintk(x...) printk("IndyCam: " x);
 #define indycam_regdump(client) indycam_regdump_debug(client)
@@ -153,8 +153,12 @@
 	ctrl->awb = (ctrl_reg & INDYCAM_CONTROL_AWBCTL)
 		? INDYCAM_VALUE_ENABLED
 		: INDYCAM_VALUE_DISABLED;
+
 	indycam_read_reg(client, INDYCAM_SHUTTER,
 			 (unsigned char *)&ctrl->shutter);
+	ctrl->shutter = (ctrl->shutter == 0x00) ?
+		0xff : (ctrl->shutter - 1);
+
 	indycam_read_reg(client, INDYCAM_GAIN,
 			 (unsigned char *)&ctrl->gain);
 	indycam_read_reg(client, INDYCAM_RED_BALANCE,
@@ -191,8 +195,11 @@
 	}
 	indycam_write_reg(client, INDYCAM_CONTROL, ctrl_reg);

-	if (ctrl->shutter >= 0)
-		indycam_write_reg(client, INDYCAM_SHUTTER, ctrl->shutter);
+	if (ctrl->shutter >= 0) {
+		unsigned char shutter_reg = (ctrl->shutter == 0xff) ?
+			0x00 : (ctrl->shutter + 1);
+		indycam_write_reg(client, INDYCAM_SHUTTER, shutter_reg);
+	}
 	if (ctrl->gain >= 0)
 		indycam_write_reg(client, INDYCAM_GAIN, ctrl->gain);
 	if (ctrl->red_balance >= 0)
@@ -375,11 +382,11 @@
 	}
 	case DECODER_INDYCAM_GET_CONTROLS: {
 		struct indycam_control *ctrl = arg;
-		indycam_get_controls(client, ctrl);
+		return indycam_get_controls(client, ctrl);
 	}
 	case DECODER_INDYCAM_SET_CONTROLS: {
 		struct indycam_control *ctrl = arg;
-		indycam_set_controls(client, ctrl);
+		return indycam_set_controls(client, ctrl);
 	}
 	default:
 		return -EINVAL;
diff -urN a/drivers/media/video/indycam.h b/drivers/media/video/indycam.h
--- a/drivers/media/video/indycam.h	2005-08-16 16:31:19.000000000 +0300
+++ b/drivers/media/video/indycam.h	2005-08-16 16:32:17.000000000 +0300
@@ -101,7 +101,7 @@
 #define INDYCAM_AGC_DEFAULT		INDYCAM_VALUE_ENABLED
 #define INDYCAM_AWB_DEFAULT		INDYCAM_VALUE_ENABLED

-#define INDYCAM_SHUTTER_DEFAULT		INDYCAM_SHUTTER_60
+#define INDYCAM_SHUTTER_DEFAULT		0xff
 #define INDYCAM_GAIN_DEFAULT		0x80
 #define INDYCAM_RED_BALANCE_DEFAULT	0x18
 #define INDYCAM_BLUE_BALANCE_DEFAULT	0xa4
diff -urN a/drivers/media/video/saa7191.c b/drivers/media/video/saa7191.c
--- a/drivers/media/video/saa7191.c	2005-08-16 16:31:19.000000000 +0300
+++ b/drivers/media/video/saa7191.c	2005-08-16 16:32:17.000000000 +0300
@@ -26,14 +26,25 @@

 #include "saa7191.h"

-#define SAA7191_MODULE_VERSION "0.0.3"
+#define SAA7191_MODULE_VERSION	"0.0.4"

 MODULE_DESCRIPTION("Philips SAA7191 video decoder driver");
 MODULE_VERSION(SAA7191_MODULE_VERSION);
 MODULE_AUTHOR("Mikael Nousiainen <tmnousia@cc.hut.fi>");
 MODULE_LICENSE("GPL");

-#define VINO_ADAPTER	(I2C_ALGO_SGI | I2C_HW_SGI_VINO)
+// #define SAA7191_DEBUG
+
+#ifdef SAA7191_DEBUG
+#define dprintk(x...) printk("SAA7191: " x);
+#else
+#define dprintk(x...)
+#endif
+
+#define VINO_ADAPTER		(I2C_ALGO_SGI | I2C_HW_SGI_VINO)
+
+#define SAA7191_SYNC_COUNT	30
+#define SAA7191_SYNC_DELAY	100	/* milliseconds */

 struct saa7191 {
 	struct i2c_client *client;
@@ -42,20 +53,25 @@
 	 * I2C-registers are write-only */
 	unsigned char reg[25];

-	unsigned char norm;
-	unsigned char input;
+	int input;
+	int norm;
 };

 static struct i2c_driver i2c_driver_saa7191;

 static const unsigned char initseq[] = {
 	0,	/* Subaddress */
+
 	0x50,	/* SAA7191_REG_IDEL */
+
+	/* 50hz signal timing */
 	0x30,	/* SAA7191_REG_HSYB */
 	0x00,	/* SAA7191_REG_HSYS */
 	0xe8,	/* SAA7191_REG_HCLB */
 	0xb6,	/* SAA7191_REG_HCLS */
 	0xf4,	/* SAA7191_REG_HPHI */
+
+	/* control */
 	0x01,	/* SAA7191_REG_LUMA - chrominance trap active (CVBS) */
 	0x00,	/* SAA7191_REG_HUEC */
 	0xf8,	/* SAA7191_REG_CKTQ */
@@ -70,6 +86,8 @@
 	0x2c,	/* SAA7191_REG_CHCV */
 	0x00,	/* unused */
 	0x00,	/* unused */
+
+	/* 60hz signal timing */
 	0x34,	/* SAA7191_REG_HS6B */
 	0x0a,	/* SAA7191_REG_HS6S */
 	0xf4,	/* SAA7191_REG_HC6B */
@@ -92,7 +110,7 @@

 	ret = i2c_master_recv(client, value, 1);
 	if (ret < 0) {
-		printk(KERN_ERR "SAA7191: saa7191_read_status(): read failed");
+		printk(KERN_ERR "SAA7191: saa7191_read_status(): read failed\n");
 		return ret;
 	}

@@ -123,7 +141,7 @@
 	ret = i2c_master_send(client, data, length);
 	if (ret < 0) {
 		printk(KERN_ERR "SAA7191: saa7191_write_block(): "
-		       "write failed");
+		       "write failed\n");
 		return ret;
 	}

@@ -134,6 +152,7 @@

 static int saa7191_set_input(struct i2c_client *client, int input)
 {
+	struct saa7191 *decoder = i2c_get_clientdata(client);
 	unsigned char luma = saa7191_read_reg(client, SAA7191_REG_LUMA);
 	unsigned char iock = saa7191_read_reg(client, SAA7191_REG_IOCK);
 	int err;
@@ -161,6 +180,8 @@
 	if (err)
 		return -EIO;

+	decoder->input = input;
+
 	return 0;
 }

@@ -173,20 +194,6 @@
 	int err;

 	switch(norm) {
-	case SAA7191_NORM_AUTO: {
-		unsigned char status;
-
-		// does status depend on current norm ?
-		if (saa7191_read_status(client, &status))
-			return -EIO;
-
-		stdc &= ~SAA7191_STDC_SECS;
-		ctl3 &= ~SAA7191_CTL3_FSEL;
-		ctl3 |= SAA7191_CTL3_AUFD;
-		chcv = (status & SAA7191_STATUS_FIDT)
-			       ? SAA7191_CHCV_NTSC : SAA7191_CHCV_PAL;
-		break;
-	}
 	case SAA7191_NORM_PAL:
 		stdc &= ~SAA7191_STDC_SECS;
 		ctl3 &= ~(SAA7191_CTL3_AUFD | SAA7191_CTL3_FSEL);
@@ -219,9 +226,186 @@

 	decoder->norm = norm;

+	dprintk("ctl3: %02x stdc: %02x chcv: %02x\n", ctl3,
+		stdc, chcv);
+	dprintk("norm: %d\n", norm);
+
 	return 0;
 }

+static int saa7191_wait_for_signal(struct i2c_client *client,
+				   unsigned char *status)
+{
+	int i = 0;
+
+	dprintk("Checking for signal...\n");
+
+	for (i = 0; i < SAA7191_SYNC_COUNT; i++) {
+		if (saa7191_read_status(client, status))
+			return -EIO;
+
+		if (((*status) & SAA7191_STATUS_HLCK) == 0) {
+			dprintk("Signal found\n");
+			return 0;
+		}
+
+		msleep(SAA7191_SYNC_DELAY);
+	}
+
+	dprintk("No signal\n");
+
+	return -EBUSY;
+}
+
+static int saa7191_autodetect_norm_extended(struct i2c_client *client)
+{
+	unsigned char stdc = saa7191_read_reg(client, SAA7191_REG_STDC);
+	unsigned char ctl3 = saa7191_read_reg(client, SAA7191_REG_CTL3);
+	unsigned char status;
+	int err = 0;
+
+	dprintk("SAA7191 extended signal auto-detection...\n");
+
+	stdc &= ~SAA7191_STDC_SECS;
+	ctl3 &= ~(SAA7191_CTL3_FSEL);
+
+	err = saa7191_write_reg(client, SAA7191_REG_STDC, stdc);
+	if (err) {
+		err = -EIO;
+		goto out;
+	}
+	err = saa7191_write_reg(client, SAA7191_REG_CTL3, ctl3);
+	if (err) {
+		err = -EIO;
+		goto out;
+	}
+
+	ctl3 |= SAA7191_CTL3_AUFD;
+	err = saa7191_write_reg(client, SAA7191_REG_CTL3, ctl3);
+	if (err) {
+		err = -EIO;
+		goto out;
+	}
+
+	msleep(SAA7191_SYNC_DELAY);
+
+	err = saa7191_wait_for_signal(client, &status);
+	if (err)
+		goto out;
+
+	if (status & SAA7191_STATUS_FIDT) {
+		/* 60hz signal -> NTSC */
+		dprintk("60hz signal: NTSC\n");
+		return saa7191_set_norm(client, SAA7191_NORM_NTSC);
+	}
+
+	/* 50hz signal */
+	dprintk("50hz signal: Trying PAL...\n");
+
+	/* try PAL first */
+	err = saa7191_set_norm(client, SAA7191_NORM_PAL);
+	if (err)
+		goto out;
+
+	msleep(SAA7191_SYNC_DELAY);
+
+	err = saa7191_wait_for_signal(client, &status);
+	if (err)
+		goto out;
+
+	/* not 50hz ? */
+	if (status & SAA7191_STATUS_FIDT) {
+		dprintk("No 50hz signal\n");
+		err = -EAGAIN;
+		goto out;
+	}
+
+	if (status & SAA7191_STATUS_CODE) {
+		dprintk("PAL\n");
+		return 0;
+	}
+
+	dprintk("No color detected with PAL - Trying SECAM...\n");
+
+	/* no color detected ? -> try SECAM */
+	err = saa7191_set_norm(client,
+			       SAA7191_NORM_SECAM);
+	if (err)
+		goto out;
+
+	msleep(SAA7191_SYNC_DELAY);
+
+	err = saa7191_wait_for_signal(client, &status);
+	if (err)
+		goto out;
+
+	/* not 50hz ? */
+	if (status & SAA7191_STATUS_FIDT) {
+		dprintk("No 50hz signal\n");
+		err = -EAGAIN;
+		goto out;
+	}
+
+	if (status & SAA7191_STATUS_CODE) {
+		/* Color detected -> SECAM */
+		dprintk("SECAM\n");
+		return 0;
+	}
+
+	dprintk("No color detected with SECAM - Going back to PAL.\n");
+
+	/* still no color detected ?
+	 * -> set norm back to PAL */
+	err = saa7191_set_norm(client,
+			       SAA7191_NORM_PAL);
+	if (err)
+		goto out;
+
+out:
+	ctl3 = saa7191_read_reg(client, SAA7191_REG_CTL3);
+	if (ctl3 & SAA7191_CTL3_AUFD) {
+		ctl3 &= ~(SAA7191_CTL3_AUFD);
+		err = saa7191_write_reg(client, SAA7191_REG_CTL3, ctl3);
+		if (err) {
+			err = -EIO;
+		}
+	}
+
+	return err;
+}
+
+static int saa7191_autodetect_norm(struct i2c_client *client)
+{
+	unsigned char status;
+
+	dprintk("SAA7191 signal auto-detection...\n");
+
+	dprintk("Reading status...\n");
+
+	if (saa7191_read_status(client, &status))
+		return -EIO;
+
+	dprintk("Checking for signal...\n");
+
+	/* no signal ? */
+	if (status & SAA7191_STATUS_HLCK) {
+		dprintk("No signal\n");
+		return -EBUSY;
+	}
+
+	dprintk("Signal found\n");
+
+	if (status & SAA7191_STATUS_FIDT) {
+		/* 60hz signal -> NTSC */
+		dprintk("NTSC\n");
+		return saa7191_set_norm(client, SAA7191_NORM_NTSC);
+	} else {
+		/* 50hz signal -> PAL */
+		dprintk("PAL\n");
+		return saa7191_set_norm(client, SAA7191_NORM_PAL);
+	}
+}
+
 static int saa7191_get_controls(struct i2c_client *client,
 				struct saa7191_control *ctrl)
 {
@@ -311,9 +495,6 @@
 	if (err)
 		goto out_free_decoder;

-	decoder->input = SAA7191_INPUT_COMPOSITE;
-	decoder->norm = SAA7191_NORM_AUTO;
-
 	err = saa7191_write_block(client, sizeof(initseq),
 				  (unsigned char *)initseq);
 	if (err) {
@@ -323,6 +504,20 @@

 	printk(KERN_INFO "SAA7191 initialized\n");

+	decoder->input = SAA7191_INPUT_COMPOSITE;
+	decoder->norm = SAA7191_NORM_AUTO;
+
+	err = saa7191_autodetect_norm(client);
+	if (err == -EBUSY) {
+		printk(KERN_INFO "SAA7191: No signal\n");
+	} else if (err) {
+		printk(KERN_ERR "SAA7191: Signal detection failed\n");
+	} else {
+		printk(KERN_INFO "SAA7191: %s signal detected\n",
+		       (decoder->norm == SAA7191_NORM_PAL) ?
+		       "PAL" : "NTSC");
+	}
+
 	return 0;

 out_detach_client:
@@ -406,7 +601,7 @@

 		switch (*iarg) {
 		case VIDEO_MODE_AUTO:
-			return saa7191_set_norm(client, SAA7191_NORM_AUTO);
+			return saa7191_autodetect_norm(client);
 		case VIDEO_MODE_PAL:
 			return saa7191_set_norm(client, SAA7191_NORM_PAL);
 		case VIDEO_MODE_NTSC:
@@ -448,9 +643,11 @@
 		int err;

 		val = (pic->hue >> 8) - 0x80;
+
 		err = saa7191_write_reg(client, SAA7191_REG_HUEC, val);
 		if (err)
 			return -EIO;
+
 		break;
 	}
 	case DECODER_SAA7191_GET_STATUS: {
@@ -459,19 +656,30 @@

 		if (saa7191_read_status(client, &status_reg))
 			return -EIO;
+
 		status->signal = ((status_reg & SAA7191_STATUS_HLCK) == 0)
 			? SAA7191_VALUE_ENABLED : SAA7191_VALUE_DISABLED;
-		status->ntsc = (status_reg & SAA7191_STATUS_FIDT)
+		status->signal_60hz = (status_reg & SAA7191_STATUS_FIDT)
 			? SAA7191_VALUE_ENABLED : SAA7191_VALUE_DISABLED;
 		status->color = (status_reg & SAA7191_STATUS_CODE)
 			? SAA7191_VALUE_ENABLED : SAA7191_VALUE_DISABLED;

 		status->input = decoder->input;
 		status->norm = decoder->norm;
+
+		break;
 	}
 	case DECODER_SAA7191_SET_NORM: {
 		int *norm = arg;
-		return saa7191_set_norm(client, *norm);
+
+		switch (*norm) {
+		case SAA7191_NORM_AUTO:
+			return saa7191_autodetect_norm(client);
+		case SAA7191_NORM_AUTO_EXT:
+			return saa7191_autodetect_norm_extended(client);
+		default:
+			return saa7191_set_norm(client, *norm);
+		}
 	}
 	case DECODER_SAA7191_GET_CONTROLS: {
 		struct saa7191_control *ctrl = arg;
diff -urN a/drivers/media/video/saa7191.h b/drivers/media/video/saa7191.h
--- a/drivers/media/video/saa7191.h	2005-08-16 16:31:19.000000000 +0300
+++ b/drivers/media/video/saa7191.h	2005-08-16 16:32:17.000000000 +0300
@@ -99,16 +99,17 @@
 #define SAA7191_NORM_PAL	1
 #define SAA7191_NORM_NTSC	2
 #define SAA7191_NORM_SECAM	3
+#define SAA7191_NORM_AUTO_EXT	4	/* extended auto-detection */

 #define SAA7191_VALUE_ENABLED		1
 #define SAA7191_VALUE_DISABLED		0
 #define SAA7191_VALUE_UNCHANGED		-1

 struct saa7191_status {
-	/* 0=no signal, 1=signal active*/
+	/* 0=no signal, 1=signal detected */
 	int signal;
 	/* 0=50hz (pal) signal, 1=60hz (ntsc) signal */
-	int ntsc;
+	int signal_60hz;
 	/* 0=no color detected, 1=color detected */
 	int color;

diff -urN a/drivers/media/video/vino.c b/drivers/media/video/vino.c
--- a/drivers/media/video/vino.c	2005-08-16 16:31:20.000000000 +0300
+++ b/drivers/media/video/vino.c	2005-08-16 16:32:17.000000000 +0300
@@ -12,15 +12,11 @@

 /*
  * TODO:
- * - remove "hacks" from memory allocation code and implement nopage()
+ * - remove "mark pages reserved-hacks" from memory allocation code
+ *   and implement nopage()
  * - check decimation, calculating and reporting image size when
  *   using decimation
- * - check vino_acquire_input(), vino_set_input() and channel
- *   ownership handling
- * - report VINO error-interrupts via ioctls ?
- * - implement picture controls (all implemented?)
- * - use macros for boolean values (?)
- * - implement user mode buffers and overlay (?)
+ * - implement read(), user mode buffers and overlay (?)
  */

 #include <linux/init.h>
@@ -59,9 +55,10 @@
  * debug info.
  * Note that the debug output also slows down the driver significantly */
 // #define VINO_DEBUG
+// #define VINO_DEBUG_INT

-#define VINO_MODULE_VERSION "0.0.3"
-#define VINO_VERSION_CODE KERNEL_VERSION(0, 0, 3)
+#define VINO_MODULE_VERSION "0.0.4"
+#define VINO_VERSION_CODE KERNEL_VERSION(0, 0, 4)

 MODULE_DESCRIPTION("SGI VINO Video4Linux2 driver");
 MODULE_VERSION(VINO_MODULE_VERSION);
@@ -90,15 +87,16 @@
 #define VINO_MIN_HEIGHT			32

 #define VINO_CLIPPING_START_ODD_D1	1
-#define VINO_CLIPPING_START_ODD_PAL	1
-#define VINO_CLIPPING_START_ODD_NTSC	1
+#define VINO_CLIPPING_START_ODD_PAL	15
+#define VINO_CLIPPING_START_ODD_NTSC	12

-#define VINO_CLIPPING_START_EVEN_D1	2
-#define VINO_CLIPPING_START_EVEN_PAL	2
-#define VINO_CLIPPING_START_EVEN_NTSC	2
+#define VINO_CLIPPING_START_EVEN_D1	1
+#define VINO_CLIPPING_START_EVEN_PAL	15
+#define VINO_CLIPPING_START_EVEN_NTSC	12

 #define VINO_INPUT_CHANNEL_COUNT	3

+/* the number is the index for vino_inputs */
 #define VINO_INPUT_NONE			-1
 #define VINO_INPUT_COMPOSITE		0
 #define VINO_INPUT_SVIDEO		1
@@ -106,15 +104,13 @@

 #define VINO_PAGE_RATIO			(PAGE_SIZE / VINO_PAGE_SIZE)

-#define VINO_FIFO_THRESHOLD_DEFAULT	512
+#define VINO_FIFO_THRESHOLD_DEFAULT	16

-/*#define VINO_FRAMEBUFFER_SIZE		(VINO_PAL_WIDTH * VINO_PAL_HEIGHT * 4 \
-  + 2 * PAGE_SIZE)*/
 #define VINO_FRAMEBUFFER_SIZE		((VINO_PAL_WIDTH \
 					  * VINO_PAL_HEIGHT * 4 \
 					  + 3 * PAGE_SIZE) & ~(PAGE_SIZE - 1))

-#define VINO_FRAMEBUFFER_MAX_COUNT	8
+#define VINO_FRAMEBUFFER_COUNT_MAX	8

 #define VINO_FRAMEBUFFER_UNUSED		0
 #define VINO_FRAMEBUFFER_IN_USE		1
@@ -130,24 +126,27 @@
 #define VINO_DUMMY_DESC_COUNT		4
 #define VINO_DESC_FETCH_DELAY		5	/* microseconds */

+#define VINO_MAX_FRAME_SKIP_COUNT	128
+
 /* the number is the index for vino_data_formats */
 #define VINO_DATA_FMT_NONE		-1
 #define VINO_DATA_FMT_GREY		0
 #define VINO_DATA_FMT_RGB332		1
 #define VINO_DATA_FMT_RGB32		2
 #define VINO_DATA_FMT_YUV		3
-//#define VINO_DATA_FMT_RGB24		4

 #define VINO_DATA_FMT_COUNT		4

+/* the number is the index for vino_data_norms */
 #define VINO_DATA_NORM_NONE		-1
 #define VINO_DATA_NORM_NTSC		0
 #define VINO_DATA_NORM_PAL		1
 #define VINO_DATA_NORM_SECAM		2
 #define VINO_DATA_NORM_D1		3
-/* The following is a special entry that can be used to
+/* The following are special entries that can be used to
  * autodetect the norm. */
-#define VINO_DATA_NORM_AUTO		0xff
+#define VINO_DATA_NORM_AUTO		0xfe
+#define VINO_DATA_NORM_AUTO_EXT		0xff

 #define VINO_DATA_NORM_COUNT		4

@@ -231,7 +230,7 @@
 	unsigned int head;
 	unsigned int tail;

-	unsigned int data[VINO_FRAMEBUFFER_MAX_COUNT];
+	unsigned int data[VINO_FRAMEBUFFER_COUNT_MAX];
 };

 struct vino_framebuffer_queue {
@@ -245,13 +244,20 @@
 	struct vino_framebuffer_fifo in;
 	struct vino_framebuffer_fifo out;

-	struct vino_framebuffer *buffer[VINO_FRAMEBUFFER_MAX_COUNT];
+	struct vino_framebuffer *buffer[VINO_FRAMEBUFFER_COUNT_MAX];

 	spinlock_t queue_lock;
 	struct semaphore queue_sem;
 	wait_queue_head_t frame_wait_queue;
 };

+struct vino_interrupt_data {
+	struct timeval timestamp;
+	unsigned int frame_counter;
+	unsigned int skip_count;
+	unsigned int skip;
+};
+
 struct vino_channel_settings {
 	unsigned int channel;

@@ -284,6 +290,8 @@

 	unsigned int users;

+	struct vino_interrupt_data int_data;
+
 	/* V4L support */
 	struct video_device *v4l_device;
 };
@@ -314,7 +322,7 @@
 /* Module parameters */

 /*
- * Using vino_pixel_conversion the ARGB32-format pixels supplied
+ * Using vino_pixel_conversion the ABGR32-format pixels supplied
  * by the VINO chip can be converted to more common formats
  * like RGBA32 (or probably RGB24 in the future). This way we
  * can give out data that can be specified correctly with
@@ -328,7 +336,9 @@
  * Use non-zero value to enable conversion.
  */
 static int vino_pixel_conversion = 0;
+
 module_param_named(pixelconv, vino_pixel_conversion, int, 0);
+
 MODULE_PARM_DESC(pixelconv,
 		 "enable pixel conversion (non-zero value enables)");

@@ -344,15 +354,22 @@
 static const char *vino_v4l_device_name_a = "SGI VINO Channel A";
 static const char *vino_v4l_device_name_b = "SGI VINO Channel B";

+static void vino_capture_tasklet(unsigned long channel);
+
+DECLARE_TASKLET(vino_tasklet_a, vino_capture_tasklet, VINO_CHANNEL_A);
+DECLARE_TASKLET(vino_tasklet_b, vino_capture_tasklet, VINO_CHANNEL_B);
+
 static const struct vino_input vino_inputs[] = {
 	{
 		.name		= "Composite",
-		.std		= V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM,
+		.std		= V4L2_STD_NTSC | V4L2_STD_PAL
+		| V4L2_STD_SECAM,
 	},{
 		.name		= "S-Video",
-		.std		= V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM,
+		.std		= V4L2_STD_NTSC | V4L2_STD_PAL
+		| V4L2_STD_SECAM,
 	},{
-		.name		= "D1 (IndyCam)",
+		.name		= "D1/IndyCam",
 		.std		= V4L2_STD_NTSC,
 	}
 };
@@ -375,15 +392,10 @@
 		.colorspace	= V4L2_COLORSPACE_SRGB,
 	},{
 		.description	= "YUV 4:2:2",
-		.bpp		= 4,
+		.bpp		= 2,
 		.pixelformat	= V4L2_PIX_FMT_YUYV, // XXX: swapped?
 		.colorspace	= V4L2_COLORSPACE_SMPTE170M,
-	}/*,{
-		.description	= "24-bit RGB",
-		.bpp		= 3,
-		.pixelformat	= V4L2_PIX_FMT_RGB24,
-		.colorspace	= V4L2_COLORSPACE_SRGB,
-		}*/
+	}
 };

 static const struct vino_data_norm vino_data_norms[] = {
@@ -454,7 +466,7 @@
 			.right 	= VINO_PAL_WIDTH,
 		},
 	},{
-		.description	= "NTSC (D1 input)",
+		.description	= "NTSC/D1",
 		.std		= V4L2_STD_NTSC,
 		.fps_min	= 6,
 		.fps_max	= 30,
@@ -638,9 +650,10 @@
  */
 static int i2c_vino_client_reg(struct i2c_client *client)
 {
+	unsigned long flags;
 	int ret = 0;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
 	switch (client->driver->id) {
 	case I2C_DRIVERID_SAA7191:
 		if (vino_drvdata->decoder.driver)
@@ -657,16 +670,17 @@
 	default:
 		ret = -ENODEV;
 	}
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return ret;
 }

 static int i2c_vino_client_unreg(struct i2c_client *client)
 {
+	unsigned long flags;
 	int ret = 0;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
 	if (client == vino_drvdata->decoder.driver) {
 		if (vino_drvdata->decoder.owner != VINO_NO_CHANNEL)
 			ret = -EBUSY;
@@ -678,7 +692,7 @@
 		else
 			vino_drvdata->camera.driver = NULL;
 	}
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return ret;
 }
@@ -932,7 +946,7 @@

 /* Framebuffer fifo functions (need to be locked externally) */

-static void vino_fifo_init(struct vino_framebuffer_fifo *f,
+static inline void vino_fifo_init(struct vino_framebuffer_fifo *f,
 			   unsigned int length)
 {
 	f->length = 0;
@@ -940,16 +954,18 @@
 	f->head = 0;
 	f->tail = 0;

-	if (length > VINO_FRAMEBUFFER_MAX_COUNT)
-		length = VINO_FRAMEBUFFER_MAX_COUNT;
+	if (length > VINO_FRAMEBUFFER_COUNT_MAX)
+		length = VINO_FRAMEBUFFER_COUNT_MAX;

 	f->length = length;
 }

 /* returns true/false */
-static int vino_fifo_has_id(struct vino_framebuffer_fifo *f, unsigned int id)
+static inline int vino_fifo_has_id(struct vino_framebuffer_fifo *f,
+				   unsigned int id)
 {
 	unsigned int i;
+
 	for (i = f->head; i == (f->tail - 1); i = (i + 1) % f->length) {
 		if (f->data[i] == id)
 			return 1;
@@ -958,13 +974,15 @@
 	return 0;
 }

+#if 0
 /* returns true/false */
-static int vino_fifo_full(struct vino_framebuffer_fifo *f)
+static inline int vino_fifo_full(struct vino_framebuffer_fifo *f)
 {
 	return (f->used == f->length);
 }
+#endif

-static unsigned int vino_fifo_get_used(struct vino_framebuffer_fifo *f)
+static inline unsigned int vino_fifo_get_used(struct vino_framebuffer_fifo *f)
 {
 	return f->used;
 }
@@ -1075,8 +1093,8 @@

 	down(&q->queue_sem);

-	if (*length > VINO_FRAMEBUFFER_MAX_COUNT)
-		*length = VINO_FRAMEBUFFER_MAX_COUNT;
+	if (*length > VINO_FRAMEBUFFER_COUNT_MAX)
+		*length = VINO_FRAMEBUFFER_COUNT_MAX;

 	q->length = 0;

@@ -1312,6 +1330,7 @@
 	return ret;
 }

+#if 0
 static int vino_queue_get_total(struct vino_framebuffer_queue *q,
 				unsigned int *total)
 {
@@ -1337,6 +1356,7 @@

 	return ret;
 }
+#endif

 static struct vino_framebuffer *vino_queue_peek(struct
 						vino_framebuffer_queue *q,
@@ -1470,12 +1490,14 @@

 	dprintk("update_line_size(): before: w = %d, d = %d, "
 		"line_size = %d\n", w, d, vcs->line_size);
+
         /* line size must be multiple of 8 bytes */
 	lsize = (bpp * (w / d)) & ~7;
 	w = (lsize / bpp) * d;

 	vcs->clipping.right = vcs->clipping.left + w;
 	vcs->line_size = lsize;
+
 	dprintk("update_line_size(): after: w = %d, d = %d, "
 		"line_size = %d\n", w, d, vcs->line_size);
 }
@@ -1531,7 +1553,7 @@
 }

 /* execute with input_lock locked */
-static void vino_set_default_clipping(struct vino_channel_settings *vcs)
+static inline void vino_set_default_clipping(struct vino_channel_settings *vcs)
 {
 	vino_set_clipping(vcs, 0, 0, vino_data_norms[vcs->data_norm].width,
 			  vino_data_norms[vcs->data_norm].height);
@@ -1555,8 +1577,7 @@

 	if (d < 1) {
 		d = 1;
-	}
-	if (d > 8) {
+	} else if (d > 8) {
 		d = 8;
 	}

@@ -1569,7 +1590,7 @@
 }

 /* execute with input_lock locked */
-static void vino_reset_scaling(struct vino_channel_settings *vcs)
+static inline void vino_set_default_scaling(struct vino_channel_settings *vcs)
 {
 	vino_set_scaling(vcs, vcs->clipping.right - vcs->clipping.left,
 			 vcs->clipping.bottom - vcs->clipping.top);
@@ -1648,7 +1669,8 @@
 }

 /* execute with input_lock locked */
-static void vino_set_default_framerate(struct vino_channel_settings *vcs)
+static inline void vino_set_default_framerate(struct
+					      vino_channel_settings *vcs)
 {
 	vino_set_framerate(vcs, vino_data_norms[vcs->data_norm].fps_max);
 }
@@ -1686,6 +1708,9 @@
 	 * should be more than enough time */
 	udelay(VINO_DESC_FETCH_DELAY);

+	dprintk("vino_dma_setup(): start desc = %08x, next 4 desc = %08x\n",
+		ch->start_desc_tbl, ch->next_4_desc);
+
 	/* set the alpha register */
 	ch->alpha = vcs->alpha;

@@ -1699,9 +1724,6 @@
 		VINO_CLIP_EVEN(norm->even.top +
 			       vcs->clipping.bottom / 2 - 1) |
 		VINO_CLIP_X(vcs->clipping.right);
-	/* FIXME: end-of-field bug workaround
-		       VINO_CLIP_X(VINO_PAL_WIDTH);
-	 */

 	/* set the size of actual content in the buffer (DECIMATION !) */
 	fb->data_size = ((vcs->clipping.right - vcs->clipping.left) /
@@ -1801,7 +1823,7 @@
 }

 /* (execute only with vino_lock locked) */
-static void vino_dma_start(struct vino_channel_settings *vcs)
+static inline void vino_dma_start(struct vino_channel_settings *vcs)
 {
 	u32 ctrl = vino->control;

@@ -1812,12 +1834,14 @@
 }

 /* (execute only with vino_lock locked) */
-static void vino_dma_stop(struct vino_channel_settings *vcs)
+static inline void vino_dma_stop(struct vino_channel_settings *vcs)
 {
 	u32 ctrl = vino->control;

 	ctrl &= (vcs->channel == VINO_CHANNEL_A) ?
 		~VINO_CTRL_A_DMA_ENBL : ~VINO_CTRL_B_DMA_ENBL;
+	ctrl &= (vcs->channel == VINO_CHANNEL_A) ?
+		~VINO_CTRL_A_INT : ~VINO_CTRL_B_INT;
 	vino->control = ctrl;
 	dprintk("vino_dma_stop():\n");
 }
@@ -1901,7 +1925,7 @@
 	struct vino_framebuffer *fb;
 	unsigned int incoming, id;
 	int err = 0;
-	unsigned long flags, flags2;
+	unsigned long flags;

 	dprintk("vino_capture_next():\n");

@@ -1942,10 +1966,6 @@
 		goto out;
 	}

-	spin_lock_irqsave(&fb->state_lock, flags2);
-	fb->state = VINO_FRAMEBUFFER_UNUSED;
-	spin_unlock_irqrestore(&fb->state_lock, flags2);
-
 	if (start) {
 		vcs->capturing = 1;
 	}
@@ -1963,7 +1983,7 @@
 	return err;
 }

-static int vino_is_capturing(struct vino_channel_settings *vcs)
+static inline int vino_is_capturing(struct vino_channel_settings *vcs)
 {
 	int ret;
 	unsigned long flags;
@@ -2120,6 +2140,7 @@
 	spin_unlock_irqrestore(&vcs->capture_lock, flags);
 }

+#if 0
 static int vino_capture_failed(struct vino_channel_settings *vcs)
 {
 	struct vino_framebuffer *fb;
@@ -2164,9 +2185,31 @@

 	return 0;
 }
+#endif
+
+static void vino_skip_frame(struct vino_channel_settings *vcs)
+{
+	struct vino_framebuffer *fb;
+	unsigned long flags;
+	unsigned int id;
+
+	spin_lock_irqsave(&vcs->capture_lock, flags);
+	fb = vino_queue_peek(&vcs->fb_queue, &id);
+	if (!fb) {
+		spin_unlock_irqrestore(&vcs->capture_lock, flags);
+		dprintk("vino_skip_frame(): vino_queue_peek() failed!\n");
+		return;
+	}
+	spin_unlock_irqrestore(&vcs->capture_lock, flags);
+
+	spin_lock_irqsave(&fb->state_lock, flags);
+	fb->state = VINO_FRAMEBUFFER_UNUSED;
+	spin_unlock_irqrestore(&fb->state_lock, flags);
+
+	vino_capture_next(vcs, 0);
+}

-static void vino_frame_done(struct vino_channel_settings *vcs,
-			    unsigned int fc)
+static void vino_frame_done(struct vino_channel_settings *vcs)
 {
 	struct vino_framebuffer *fb;
 	unsigned long flags;
@@ -2180,8 +2223,9 @@
 	}
 	spin_unlock_irqrestore(&vcs->capture_lock, flags);

-	fb->frame_counter = fc;
-	do_gettimeofday(&fb->timestamp);
+	fb->frame_counter = vcs->int_data.frame_counter;
+	memcpy(&fb->timestamp, &vcs->int_data.timestamp,
+	       sizeof(struct timeval));

 	spin_lock_irqsave(&fb->state_lock, flags);
 	if (fb->state == VINO_FRAMEBUFFER_IN_USE)
@@ -2193,72 +2237,175 @@
 	vino_capture_next(vcs, 0);
 }

+static void vino_capture_tasklet(unsigned long channel) {
+	struct vino_channel_settings *vcs;
+
+	vcs = (channel == VINO_CHANNEL_A)
+		? &vino_drvdata->a : &vino_drvdata->b;
+
+	if (vcs->int_data.skip)
+		vcs->int_data.skip_count++;
+
+	if (vcs->int_data.skip && (vcs->int_data.skip_count
+				   <= VINO_MAX_FRAME_SKIP_COUNT)) {
+		vino_skip_frame(vcs);
+	} else {
+		vcs->int_data.skip_count = 0;
+		vino_frame_done(vcs);
+	}
+}
+
 static irqreturn_t vino_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	u32 intr;
+	u32 ctrl, intr;
 	unsigned int fc_a, fc_b;
-	int done_a = 0;
-	int done_b = 0;
+	int handled_a = 0, skip_a = 0, done_a = 0;
+	int handled_b = 0, skip_b = 0, done_b = 0;

-	spin_lock(&vino_drvdata->vino_lock);
-
-	intr = vino->intr_status;
-	fc_a = vino->a.field_counter / 2;
-	fc_b = vino->b.field_counter / 2;
+#ifdef VINO_DEBUG_INT
+	int loop = 0;
+	unsigned int line_count = vino->a.line_count,
+		page_index = vino->a.page_index,
+		field_counter = vino->a.field_counter,
+		start_desc_tbl = vino->a.start_desc_tbl,
+		next_4_desc = vino->a.next_4_desc;
+	unsigned int line_count_2,
+		page_index_2,
+		field_counter_2,
+		start_desc_tbl_2,
+		next_4_desc_2;
+#endif

-	// TODO: handle error-interrupts in some special way ?
+	spin_lock(&vino_drvdata->vino_lock);

- 	if (intr & VINO_INTSTAT_A) {
-		if (intr & VINO_INTSTAT_A_EOF) {
-			vino_drvdata->a.field++;
-			if (vino_drvdata->a.field > 1) {
+	while ((intr = vino->intr_status)) {
+		fc_a = vino->a.field_counter >> 1;
+		fc_b = vino->b.field_counter >> 1;
+
+		/* handle error-interrupts in some special way ?
+		 * --> skips frames */
+		if (intr & VINO_INTSTAT_A) {
+			if (intr & VINO_INTSTAT_A_EOF) {
+				vino_drvdata->a.field++;
+				if (vino_drvdata->a.field > 1) {
+					vino_dma_stop(&vino_drvdata->a);
+					vino_clear_interrupt(&vino_drvdata->a);
+					vino_drvdata->a.field = 0;
+					done_a = 1;
+				} else {
+					if (vino->a.page_index
+					    != vino_drvdata->a.line_size) {
+						vino->a.line_count = 0;
+						vino->a.page_index =
+							vino_drvdata->
+							a.line_size;
+						vino->a.next_4_desc =
+							vino->a.start_desc_tbl;
+					}
+				}
+				dprintk("channel A end-of-field "
+					"interrupt: %04x\n", intr);
+			} else {
 				vino_dma_stop(&vino_drvdata->a);
 				vino_clear_interrupt(&vino_drvdata->a);
 				vino_drvdata->a.field = 0;
-				done_a = 1;
+				skip_a = 1;
+				dprintk("channel A error interrupt: %04x\n",
+					intr);
 			}
-			dprintk("intr: channel A end-of-field interrupt: "
-				"%04x\n", intr);
-		} else {
-			vino_dma_stop(&vino_drvdata->a);
-			vino_clear_interrupt(&vino_drvdata->a);
-			done_a = 1;
-			dprintk("channel A error interrupt: %04x\n", intr);
+
+#ifdef VINO_DEBUG_INT
+			line_count_2 = vino->a.line_count;
+			page_index_2 = vino->a.page_index;
+			field_counter_2 = vino->a.field_counter;
+			start_desc_tbl_2 = vino->a.start_desc_tbl;
+			next_4_desc_2 = vino->a.next_4_desc;
+
+			printk("intr = %04x, loop = %d, field = %d\n",
+			       intr, loop, vino_drvdata->a.field);
+			printk("1- line count = %04d, page index = %04d, "
+			       "start = %08x, next = %08x\n"
+			       "   fieldc = %d, framec = %d\n",
+			       line_count, page_index, start_desc_tbl,
+			       next_4_desc, field_counter, fc_a);
+			printk("12-line count = %04d, page index = %04d, "
+			       "   start = %08x, next = %08x\n",
+			       line_count_2, page_index_2, start_desc_tbl_2,
+			       next_4_desc_2);
+
+			if (done_a)
+				printk("\n");
+#endif
 		}
-	}
-	if (intr & VINO_INTSTAT_B) {
-		if (intr & VINO_INTSTAT_B_EOF) {
-			vino_drvdata->b.field++;
-			if (vino_drvdata->b.field > 1) {
+
+		if (intr & VINO_INTSTAT_B) {
+			if (intr & VINO_INTSTAT_B_EOF) {
+				vino_drvdata->b.field++;
+				if (vino_drvdata->b.field > 1) {
+					vino_dma_stop(&vino_drvdata->b);
+					vino_clear_interrupt(&vino_drvdata->b);
+					vino_drvdata->b.field = 0;
+					done_b = 1;
+				}
+				dprintk("channel B end-of-field "
+					"interrupt: %04x\n", intr);
+			} else {
 				vino_dma_stop(&vino_drvdata->b);
 				vino_clear_interrupt(&vino_drvdata->b);
 				vino_drvdata->b.field = 0;
-				done_b = 1;
+				skip_b = 1;
+				dprintk("channel B error interrupt: %04x\n",
+					intr);
 			}
-			dprintk("intr: channel B end-of-field interrupt: "
-				"%04x\n", intr);
-		} else {
-			vino_dma_stop(&vino_drvdata->b);
-			vino_clear_interrupt(&vino_drvdata->b);
-			done_b = 1;
-			dprintk("channel B error interrupt: %04x\n", intr);
 		}
-	}

-	/* always remember to clear interrupt status */
-	vino->intr_status = ~intr;
+		/* Always remember to clear interrupt status.
+		 * Disable VINO interrupts while we do this. */
+		ctrl = vino->control;
+		vino->control = ctrl & ~(VINO_CTRL_A_INT | VINO_CTRL_B_INT);
+		vino->intr_status = ~intr;
+		vino->control = ctrl;
+
+		spin_unlock(&vino_drvdata->vino_lock);
+
+		if ((!handled_a) && (done_a || skip_a)) {
+			if (!skip_a) {
+				do_gettimeofday(&vino_drvdata->
+						a.int_data.timestamp);
+				vino_drvdata->a.int_data.frame_counter = fc_a;
+			}
+			vino_drvdata->a.int_data.skip = skip_a;

-	spin_unlock(&vino_drvdata->vino_lock);
+			dprintk("channel A %s, interrupt: %d\n",
+				skip_a ? "skipping frame" : "frame done",
+				intr);
+			tasklet_hi_schedule(&vino_tasklet_a);
+			handled_a = 1;
+		}
+
+		if ((!handled_b) && (done_b || skip_b)) {
+			if (!skip_b) {
+				do_gettimeofday(&vino_drvdata->
+						b.int_data.timestamp);
+				vino_drvdata->b.int_data.frame_counter = fc_b;
+			}
+			vino_drvdata->b.int_data.skip = skip_b;
+
+			dprintk("channel B %s, interrupt: %d\n",
+				skip_b ? "skipping frame" : "frame done",
+				intr);
+			tasklet_hi_schedule(&vino_tasklet_b);
+			handled_b = 1;
+		}

-	if (done_a) {
-		vino_frame_done(&vino_drvdata->a, fc_a);
-		dprintk("channel A frame done, interrupt: %d\n", intr);
-	}
-	if (done_b) {
-		vino_frame_done(&vino_drvdata->b, fc_b);
-		dprintk("channel B frame done, interrupt: %d\n", intr);
+#ifdef VINO_DEBUG_INT
+		loop++;
+#endif
+		spin_lock(&vino_drvdata->vino_lock);
 	}

+	spin_unlock(&vino_drvdata->vino_lock);
+
 	return IRQ_HANDLED;
 }

@@ -2278,11 +2425,13 @@
 	}
 }

-static int vino_get_saa7191_norm(int norm)
+static int vino_get_saa7191_norm(unsigned int data_norm)
 {
-	switch (norm) {
+	switch (data_norm) {
 	case VINO_DATA_NORM_AUTO:
 		return SAA7191_NORM_AUTO;
+	case VINO_DATA_NORM_AUTO_EXT:
+		return SAA7191_NORM_AUTO_EXT;
 	case VINO_DATA_NORM_PAL:
 		return SAA7191_NORM_PAL;
 	case VINO_DATA_NORM_NTSC:
@@ -2296,6 +2445,57 @@
 	}
 }

+static int vino_get_from_saa7191_norm(int saa7191_norm)
+{
+	switch (saa7191_norm) {
+	case SAA7191_NORM_PAL:
+		return VINO_DATA_NORM_PAL;
+	case SAA7191_NORM_NTSC:
+		return VINO_DATA_NORM_NTSC;
+	case SAA7191_NORM_SECAM:
+		return VINO_DATA_NORM_SECAM;
+	default:
+		printk(KERN_ERR "VINO: vino_get_from_saa7191_norm(): "
+		       "invalid norm!\n");
+		return VINO_DATA_NORM_NONE;
+	}
+}
+
+static int vino_saa7191_set_norm(unsigned int *data_norm)
+{
+	int saa7191_norm, new_data_norm;
+	int err = 0;
+
+	saa7191_norm = vino_get_saa7191_norm(*data_norm);
+
+	err = i2c_decoder_command(DECODER_SAA7191_SET_NORM,
+				  &saa7191_norm);
+	if (err)
+		goto out;
+
+	if ((*data_norm == VINO_DATA_NORM_AUTO)
+	    || (*data_norm == VINO_DATA_NORM_AUTO_EXT)) {
+		struct saa7191_status status;
+
+		err = i2c_decoder_command(DECODER_SAA7191_GET_STATUS,
+					  &status);
+		if (err)
+			goto out;
+
+		new_data_norm =
+			vino_get_from_saa7191_norm(status.norm);
+		if (new_data_norm == VINO_DATA_NORM_NONE) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		*data_norm = (unsigned int)new_data_norm;
+	}
+
+out:
+	return err;
+}
+
 /* execute with input_lock locked */
 static int vino_is_input_owner(struct vino_channel_settings *vcs)
 {
@@ -2312,11 +2512,12 @@

 static int vino_acquire_input(struct vino_channel_settings *vcs)
 {
+	unsigned long flags;
 	int ret = 0;

 	dprintk("vino_acquire_input():\n");

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 	/* First try D1 and then SAA7191 */
 	if (vino_drvdata->camera.driver
@@ -2331,23 +2532,48 @@
 		vcs->data_norm = VINO_DATA_NORM_D1;
 	} else if (vino_drvdata->decoder.driver
 		   && (vino_drvdata->decoder.owner == VINO_NO_CHANNEL)) {
+		int input, data_norm;
 		int saa7191_input;
-		int saa7191_norm;

 		if (i2c_use_client(vino_drvdata->decoder.driver)) {
 			ret = -ENODEV;
 			goto out;
 		}

-		vino_drvdata->decoder.owner = vcs->channel;
-		vcs->input = VINO_INPUT_COMPOSITE;
-		vcs->data_norm = VINO_DATA_NORM_PAL;
+		input = VINO_INPUT_COMPOSITE;

-		saa7191_input = vino_get_saa7191_input(vcs->input);
-		i2c_decoder_command(DECODER_SET_INPUT, &saa7191_input);
-
-		saa7191_norm = vino_get_saa7191_norm(vcs->data_norm);
-		i2c_decoder_command(DECODER_SAA7191_SET_NORM, &saa7191_norm);
+		saa7191_input = vino_get_saa7191_input(input);
+		ret = i2c_decoder_command(DECODER_SET_INPUT,
+					  &saa7191_input);
+		if (ret) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
+
+		/* Don't hold spinlocks while auto-detecting norm
+		 * as it may take a while... */
+
+		data_norm = VINO_DATA_NORM_AUTO_EXT;
+
+		ret = vino_saa7191_set_norm(&data_norm);
+		if ((ret == -EBUSY) || (ret == -EAGAIN)) {
+			data_norm = VINO_DATA_NORM_PAL;
+			ret = vino_saa7191_set_norm(&data_norm);
+		}
+
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
+		if (ret) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		vino_drvdata->decoder.owner = vcs->channel;
+
+		vcs->input = input;
+		vcs->data_norm = data_norm;
 	} else {
 		vcs->input = (vcs->channel == VINO_CHANNEL_A) ?
 			vino_drvdata->b.input : vino_drvdata->a.input;
@@ -2362,13 +2588,14 @@

 	if (vino_is_input_owner(vcs)) {
 		vino_set_default_clipping(vcs);
+		vino_set_default_scaling(vcs);
 		vino_set_default_framerate(vcs);
 	}

 	dprintk("vino_acquire_input(): %s\n", vino_inputs[vcs->input].name);

 out:
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return ret;
 }
@@ -2377,16 +2604,17 @@
 {
 	struct vino_channel_settings *vcs2 = (vcs->channel == VINO_CHANNEL_A) ?
 		&vino_drvdata->b : &vino_drvdata->a;
+	unsigned long flags;
 	int ret = 0;

 	dprintk("vino_set_input():\n");

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 	if (vcs->input == input)
 		goto out;

-	switch(input) {
+	switch (input) {
 	case VINO_INPUT_COMPOSITE:
 	case VINO_INPUT_SVIDEO:
 		if (!vino_drvdata->decoder.driver) {
@@ -2403,17 +2631,41 @@
 		}

 		if (vino_drvdata->decoder.owner == vcs->channel) {
+			int data_norm;
 			int saa7191_input;
-			int saa7191_norm;

-			vcs->input = input;
-			vcs->data_norm = VINO_DATA_NORM_PAL;
+			saa7191_input = vino_get_saa7191_input(input);
+			ret = i2c_decoder_command(DECODER_SET_INPUT,
+						  &saa7191_input);
+			if (ret) {
+				vino_drvdata->decoder.owner = VINO_NO_CHANNEL;
+				ret = -EINVAL;
+				goto out;
+			}
+
+			spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
+
+			/* Don't hold spinlocks while auto-detecting norm
+			 * as it may take a while... */
+
+			data_norm = VINO_DATA_NORM_AUTO_EXT;
+
+			ret = vino_saa7191_set_norm(&data_norm);
+			if ((ret  == -EBUSY) || (ret == -EAGAIN)) {
+				data_norm = VINO_DATA_NORM_PAL;
+				ret = vino_saa7191_set_norm(&data_norm);
+			}
+
+			spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
+			if (ret) {
+				vino_drvdata->decoder.owner = VINO_NO_CHANNEL;
+				ret = -EINVAL;
+				goto out;
+			}

-			saa7191_input = vino_get_saa7191_input(vcs->input);
-			i2c_decoder_command(DECODER_SET_INPUT, &saa7191_input);
-			saa7191_norm = vino_get_saa7191_norm(vcs->data_norm);
-			i2c_decoder_command(DECODER_SAA7191_SET_NORM,
-					    &saa7191_norm);
+			vcs->input = input;
+			vcs->data_norm = data_norm;
 		} else {
 			if (vcs2->input != input) {
 				ret = -EBUSY;
@@ -2469,13 +2721,16 @@
 		goto out;
 	}

-	vino_set_default_clipping(vcs);
-	vino_set_default_framerate(vcs);
+	if (vino_is_input_owner(vcs)) {
+		vino_set_default_clipping(vcs);
+		vino_set_default_scaling(vcs);
+		vino_set_default_framerate(vcs);
+	}

 	dprintk("vino_set_input(): %s\n", vino_inputs[vcs->input].name);

 out:
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return ret;
 }
@@ -2484,10 +2739,11 @@
 {
 	struct vino_channel_settings *vcs2 = (vcs->channel == VINO_CHANNEL_A) ?
 		&vino_drvdata->b : &vino_drvdata->a;
+	unsigned long flags;

 	dprintk("vino_release_input():\n");

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 	/* Release ownership of the channel
 	 * and if the other channel takes input from
@@ -2510,34 +2766,61 @@
 	}
 	vcs->input = VINO_INPUT_NONE;

-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
 }

 /* execute with input_lock locked */
 static int vino_set_data_norm(struct vino_channel_settings *vcs,
-			      unsigned int data_norm)
+			      unsigned int data_norm,
+			      unsigned long *flags)
 {
-	int saa7191_norm;
+	int err = 0;
+
+	if (data_norm == vcs->data_norm)
+		return 0;

 	switch (vcs->input) {
 	case VINO_INPUT_D1:
 		/* only one "norm" supported */
-		if (data_norm != VINO_DATA_NORM_D1)
+		if ((data_norm != VINO_DATA_NORM_D1)
+		    && (data_norm != VINO_DATA_NORM_AUTO)
+		    && (data_norm != VINO_DATA_NORM_AUTO_EXT))
 			return -EINVAL;
 		break;
 	case VINO_INPUT_COMPOSITE:
-	case VINO_INPUT_SVIDEO:
+	case VINO_INPUT_SVIDEO: {
+		if ((data_norm != VINO_DATA_NORM_PAL)
+		    && (data_norm != VINO_DATA_NORM_NTSC)
+		    && (data_norm != VINO_DATA_NORM_SECAM)
+		    && (data_norm != VINO_DATA_NORM_AUTO)
+		    && (data_norm != VINO_DATA_NORM_AUTO_EXT))
+			return -EINVAL;
+
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, *flags);
+
+		/* Don't hold spinlocks while setting norm
+		 * as it may take a while... */

-		saa7191_norm = vino_get_saa7191_norm(data_norm);
+		err = vino_saa7191_set_norm(&data_norm);
+
+		spin_lock_irqsave(&vino_drvdata->input_lock, *flags);
+
+		if (err)
+			goto out;

-		i2c_decoder_command(DECODER_SAA7191_SET_NORM, &saa7191_norm);
 		vcs->data_norm = data_norm;
+
+		vino_set_default_clipping(vcs);
+		vino_set_default_scaling(vcs);
+		vino_set_default_framerate(vcs);
 		break;
+	}
 	default:
 		return -EINVAL;
 	}

-	return 0;
+out:
+	return err;
 }

 /* V4L2 helper functions */
@@ -2557,8 +2840,9 @@
 static int vino_enum_data_norm(struct vino_channel_settings *vcs, __u32 index)
 {
 	int data_norm = VINO_DATA_NORM_NONE;
+	unsigned long flags;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
 	switch(vcs->input) {
 	case VINO_INPUT_COMPOSITE:
 	case VINO_INPUT_SVIDEO:
@@ -2576,7 +2860,7 @@
 		}
 		break;
 	}
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return data_norm;
 }
@@ -2584,8 +2868,9 @@
 static int vino_enum_input(struct vino_channel_settings *vcs, __u32 index)
 {
 	int input = VINO_INPUT_NONE;
+	unsigned long flags;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
 	if (vino_drvdata->decoder.driver && vino_drvdata->camera.driver) {
 		switch (index) {
 		case 0:
@@ -2614,7 +2899,7 @@
 			break;
 		}
 	}
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return input;
 }
@@ -2707,11 +2992,12 @@
 {
 	__u32 index;
 	int input;
+	unsigned long flags;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
 	input = vcs->input;
 	index = vino_find_input_index(vcs);
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	dprintk("input = %d\n", input);

@@ -2746,7 +3032,9 @@
 			     struct v4l2_standard *s)
 {
 	int index = s->index;
-	int data_norm = vino_enum_data_norm(vcs, index);
+	int data_norm;
+
+	data_norm = vino_enum_data_norm(vcs, index);
 	dprintk("standard index = %d\n", index);

 	if (data_norm == VINO_DATA_NORM_NONE)
@@ -2770,13 +3058,55 @@
 	return 0;
 }

+static int vino_v4l2_querystd(struct vino_channel_settings *vcs,
+			      v4l2_std_id *std)
+{
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
+	switch (vcs->input) {
+	case VINO_INPUT_D1:
+		*std = vino_inputs[vcs->input].std;
+		break;
+	case VINO_INPUT_COMPOSITE:
+	case VINO_INPUT_SVIDEO: {
+		struct saa7191_status status;
+
+		i2c_decoder_command(DECODER_SAA7191_GET_STATUS, &status);
+
+		if (status.signal) {
+			if (status.signal_60hz) {
+				*std = V4L2_STD_NTSC;
+			} else {
+				*std = V4L2_STD_PAL | V4L2_STD_SECAM;
+			}
+		} else {
+			*std = vino_inputs[vcs->input].std;
+		}
+		break;
+	}
+	default:
+		err = -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
+
+	return err;
+}
+
 static int vino_v4l2_g_std(struct vino_channel_settings *vcs,
 			   v4l2_std_id *std)
 {
-	spin_lock(&vino_drvdata->input_lock);
-	dprintk("current standard = %d\n", vcs->data_norm);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
 	*std = vino_data_norms[vcs->data_norm].std;
-	spin_unlock(&vino_drvdata->input_lock);
+	dprintk("current standard = %d\n", vcs->data_norm);
+
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return 0;
 }
@@ -2784,13 +3114,18 @@
 static int vino_v4l2_s_std(struct vino_channel_settings *vcs,
 			   v4l2_std_id *std)
 {
+	unsigned long flags;
 	int ret = 0;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
+	if (!vino_is_input_owner(vcs)) {
+		ret = -EBUSY;
+		goto out;
+	}

 	/* check if the standard is valid for the current input */
-	if (vino_is_input_owner(vcs)
-	    && (vino_inputs[vcs->input].std & (*std))) {
+	if ((*std) & vino_inputs[vcs->input].std) {
 		dprintk("standard accepted\n");

 		/* change the video norm for SAA7191
@@ -2799,24 +3134,33 @@
 		if (vcs->input == VINO_INPUT_D1)
 			goto out;

-		if ((*std) & V4L2_STD_PAL) {
-			vino_set_data_norm(vcs, VINO_DATA_NORM_PAL);
-			vcs->data_norm = VINO_DATA_NORM_PAL;
+		if (((*std) & V4L2_STD_PAL)
+		    && ((*std) & V4L2_STD_NTSC)
+		    && ((*std) & V4L2_STD_SECAM)) {
+			ret = vino_set_data_norm(vcs, VINO_DATA_NORM_AUTO_EXT,
+						 &flags);
+		} else if ((*std) & V4L2_STD_PAL) {
+			ret = vino_set_data_norm(vcs, VINO_DATA_NORM_PAL,
+						 &flags);
 		} else if ((*std) & V4L2_STD_NTSC) {
-			vino_set_data_norm(vcs, VINO_DATA_NORM_NTSC);
-			vcs->data_norm = VINO_DATA_NORM_NTSC;
+			ret = vino_set_data_norm(vcs, VINO_DATA_NORM_NTSC,
+						 &flags);
 		} else if ((*std) & V4L2_STD_SECAM) {
-			vino_set_data_norm(vcs, VINO_DATA_NORM_SECAM);
-			vcs->data_norm = VINO_DATA_NORM_SECAM;
+			ret = vino_set_data_norm(vcs, VINO_DATA_NORM_SECAM,
+						 &flags);
 		} else {
 			ret = -EINVAL;
 		}
+
+		if (ret) {
+			ret = -EINVAL;
+		}
 	} else {
 		ret = -EINVAL;
 	}

 out:
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return ret;
 }
@@ -2854,6 +3198,7 @@
 			     struct v4l2_format *f)
 {
 	struct vino_channel_settings tempvcs;
+	unsigned long flags;

 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
@@ -2862,9 +3207,9 @@
 		dprintk("requested: w = %d, h = %d\n",
 		       pf->width, pf->height);

-		spin_lock(&vino_drvdata->input_lock);
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);
 		memcpy(&tempvcs, vcs, sizeof(struct vino_channel_settings));
-		spin_unlock(&vino_drvdata->input_lock);
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 		tempvcs.data_format = vino_find_data_format(pf->pixelformat);
 		if (tempvcs.data_format == VINO_DATA_FMT_NONE) {
@@ -2907,10 +3252,13 @@
 static int vino_v4l2_g_fmt(struct vino_channel_settings *vcs,
 			   struct v4l2_format *f)
 {
+	unsigned long flags;
+
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
 		struct v4l2_pix_format *pf = &f->fmt.pix;
-		spin_lock(&vino_drvdata->input_lock);
+
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 		pf->width = (vcs->clipping.right - vcs->clipping.left) /
 			vcs->decimation;
@@ -2929,7 +3277,7 @@

 		pf->priv = 0;

-		spin_unlock(&vino_drvdata->input_lock);
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
 		break;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
@@ -2944,18 +3292,22 @@
 			   struct v4l2_format *f)
 {
 	int data_format;
+	unsigned long flags;

 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
 		struct v4l2_pix_format *pf = &f->fmt.pix;
-		spin_lock(&vino_drvdata->input_lock);
+
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 		if (!vino_is_input_owner(vcs)) {
-			spin_unlock(&vino_drvdata->input_lock);
-			return -EINVAL;
+			spin_unlock_irqrestore(&vino_drvdata->input_lock,
+					       flags);
+			return -EBUSY;
 		}

 		data_format = vino_find_data_format(pf->pixelformat);
+
 		if (data_format == VINO_DATA_FMT_NONE) {
 			vcs->data_format = VINO_DATA_FMT_RGB32;
 			pf->pixelformat =
@@ -2984,7 +3336,7 @@

 		pf->priv = 0;

-		spin_unlock(&vino_drvdata->input_lock);
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
 		break;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
@@ -2999,12 +3351,15 @@
 			     struct v4l2_cropcap *ccap)
 {
 	const struct vino_data_norm *norm;
+	unsigned long flags;

 	switch (ccap->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
-		spin_lock(&vino_drvdata->input_lock);
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
 		norm = &vino_data_norms[vcs->data_norm];
-		spin_unlock(&vino_drvdata->input_lock);
+
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 		ccap->bounds.left = 0;
 		ccap->bounds.top = 0;
@@ -3027,16 +3382,18 @@
 static int vino_v4l2_g_crop(struct vino_channel_settings *vcs,
 			    struct v4l2_crop *c)
 {
+	unsigned long flags;
+
 	switch (c->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
-		spin_lock(&vino_drvdata->input_lock);
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 		c->c.left = vcs->clipping.left;
 		c->c.top = vcs->clipping.top;
 		c->c.width = vcs->clipping.right - vcs->clipping.left;
 		c->c.height = vcs->clipping.bottom - vcs->clipping.top;

-		spin_unlock(&vino_drvdata->input_lock);
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
 		break;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	default:
@@ -3049,18 +3406,21 @@
 static int vino_v4l2_s_crop(struct vino_channel_settings *vcs,
 			    struct v4l2_crop *c)
 {
+	unsigned long flags;
+
 	switch (c->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
-		spin_lock(&vino_drvdata->input_lock);
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 		if (!vino_is_input_owner(vcs)) {
-			spin_unlock(&vino_drvdata->input_lock);
-			return -EINVAL;
+			spin_unlock_irqrestore(&vino_drvdata->input_lock,
+					       flags);
+			return -EBUSY;
 		}
 		vino_set_clipping(vcs, c->c.left, c->c.top,
 				  c->c.width, c->c.height);

-		spin_unlock(&vino_drvdata->input_lock);
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);
 		break;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	default:
@@ -3073,6 +3433,8 @@
 static int vino_v4l2_g_parm(struct vino_channel_settings *vcs,
 			    struct v4l2_streamparm *sp)
 {
+	unsigned long flags;
+
 	switch (sp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
 		struct v4l2_captureparm *cp = &sp->parm.capture;
@@ -3081,9 +3443,11 @@
 		cp->capability = V4L2_CAP_TIMEPERFRAME;
 		cp->timeperframe.numerator = 1;

-		spin_lock(&vino_drvdata->input_lock);
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
 		cp->timeperframe.denominator = vcs->fps;
-		spin_unlock(&vino_drvdata->input_lock);
+
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 		// TODO: cp->readbuffers = xxx;
 		break;
@@ -3099,14 +3463,18 @@
 static int vino_v4l2_s_parm(struct vino_channel_settings *vcs,
 			    struct v4l2_streamparm *sp)
 {
+	unsigned long flags;
+
 	switch (sp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
 		struct v4l2_captureparm *cp = &sp->parm.capture;

-		spin_lock(&vino_drvdata->input_lock);
+		spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
 		if (!vino_is_input_owner(vcs)) {
-			spin_unlock(&vino_drvdata->input_lock);
-			return -EINVAL;
+			spin_unlock_irqrestore(&vino_drvdata->input_lock,
+					       flags);
+			return -EBUSY;
 		}

 		if ((cp->timeperframe.numerator == 0) ||
@@ -3117,7 +3485,8 @@
 			vino_set_framerate(vcs, cp->timeperframe.denominator /
 					   cp->timeperframe.numerator);
 		}
-		spin_unlock(&vino_drvdata->input_lock);
+
+		spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 		// TODO: set buffers according to cp->readbuffers
 		break;
@@ -3301,12 +3670,12 @@
 		err = vino_queue_get_incoming(&vcs->fb_queue, &incoming);
 		if (err) {
 			dprintk("vino_queue_get_incoming() failed\n");
-			return -EIO;
+			return -EINVAL;
 		}
 		err = vino_queue_get_outgoing(&vcs->fb_queue, &outgoing);
 		if (err) {
 			dprintk("vino_queue_get_outgoing() failed\n");
-			return -EIO;
+			return -EINVAL;
 		}

 		dprintk("incoming = %d, outgoing = %d\n", incoming, outgoing);
@@ -3326,8 +3695,10 @@
 			if (err) {
 				err = vino_wait_for_frame(vcs);
 				if (err) {
-					/* interrupted */
-					vino_capture_failed(vcs);
+					/* interrupted or
+					 * no frames captured because
+					 * of frame skipping */
+					// vino_capture_failed(vcs);
 					return -EIO;
 				}
 			}
@@ -3340,10 +3711,12 @@
 		}

 		err = vino_check_buffer(vcs, fb);
+
+		vino_v4l2_get_buffer_status(vcs, fb, b);
+
 		if (err)
 			return -EIO;

-		vino_v4l2_get_buffer_status(vcs, fb, b);
 		break;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
@@ -3409,10 +3782,11 @@
 static int vino_v4l2_queryctrl(struct vino_channel_settings *vcs,
 			       struct v4l2_queryctrl *queryctrl)
 {
+	unsigned long flags;
 	int i;
 	int err = 0;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 	switch (vcs->input) {
 	case VINO_INPUT_D1:
@@ -3447,7 +3821,7 @@
 	}

  found:
-	spin_unlock(&vino_drvdata->input_lock);
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return err;
 }
@@ -3455,16 +3829,21 @@
 static int vino_v4l2_g_ctrl(struct vino_channel_settings *vcs,
 			    struct v4l2_control *control)
 {
-	struct indycam_control indycam_ctrl;
-	struct saa7191_control saa7191_ctrl;
+	unsigned long flags;
 	int err = 0;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);

 	switch (vcs->input) {
-	case VINO_INPUT_D1:
-		i2c_camera_command(DECODER_INDYCAM_GET_CONTROLS,
-				   &indycam_ctrl);
+	case VINO_INPUT_D1: {
+		struct indycam_control indycam_ctrl;
+
+		err = i2c_camera_command(DECODER_INDYCAM_GET_CONTROLS,
+					 &indycam_ctrl);
+		if (err) {
+			err = -EINVAL;
+			goto out;
+		}

 		switch(control->id) {
 		case V4L2_CID_AUTOGAIN:
@@ -3498,10 +3877,17 @@
 			err = -EINVAL;
 		}
 		break;
+	}
 	case VINO_INPUT_COMPOSITE:
-	case VINO_INPUT_SVIDEO:
-		i2c_decoder_command(DECODER_SAA7191_GET_CONTROLS,
-				   &saa7191_ctrl);
+	case VINO_INPUT_SVIDEO: {
+		struct saa7191_control saa7191_ctrl;
+
+		err = i2c_decoder_command(DECODER_SAA7191_GET_CONTROLS,
+					  &saa7191_ctrl);
+		if (err) {
+			err = -EINVAL;
+			goto out;
+		}

 		switch(control->id) {
 		case V4L2_CID_HUE:
@@ -3514,11 +3900,13 @@
 			err = -EINVAL;
 		}
 		break;
+	}
 	default:
 		err =  -EINVAL;
 	}

-	spin_unlock(&vino_drvdata->input_lock);
+out:
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return err;
 }
@@ -3526,15 +3914,21 @@
 static int vino_v4l2_s_ctrl(struct vino_channel_settings *vcs,
 			    struct v4l2_control *control)
 {
-	struct indycam_control indycam_ctrl;
-	struct saa7191_control saa7191_ctrl;
+	unsigned long flags;
 	int i;
 	int err = 0;

-	spin_lock(&vino_drvdata->input_lock);
+	spin_lock_irqsave(&vino_drvdata->input_lock, flags);
+
+	if (!vino_is_input_owner(vcs)) {
+		err = -EBUSY;
+		goto out;
+	}

 	switch (vcs->input) {
-	case VINO_INPUT_D1:
+	case VINO_INPUT_D1: {
+		struct indycam_control indycam_ctrl;
+
 		for (i = 0; i < VINO_INDYCAM_V4L2_CONTROL_COUNT; i++) {
 			if (vino_indycam_v4l2_controls[i].id ==
 			    control->id) {
@@ -3546,12 +3940,12 @@
 					goto ok1;
 				} else {
 					err = -ERANGE;
-					goto error;
+					goto out;
 				}
 			}
 		}
 		err = -EINVAL;
-		goto error;
+		goto out;

 ok1:
 		indycam_ctrl.agc = INDYCAM_VALUE_UNCHANGED;
@@ -3594,14 +3988,19 @@
 			break;
 		default:
 			err =  -EINVAL;
+			goto out;
 		}

-		if (!err)
-			i2c_camera_command(DECODER_INDYCAM_SET_CONTROLS,
-					   &indycam_ctrl);
+		err = i2c_camera_command(DECODER_INDYCAM_SET_CONTROLS,
+					 &indycam_ctrl);
+		if (err)
+			err = -EINVAL;
 		break;
+	}
 	case VINO_INPUT_COMPOSITE:
-	case VINO_INPUT_SVIDEO:
+	case VINO_INPUT_SVIDEO: {
+		struct saa7191_control saa7191_ctrl;
+
 		for (i = 0; i < VINO_SAA7191_V4L2_CONTROL_COUNT; i++) {
 			if (vino_saa7191_v4l2_controls[i].id ==
 			    control->id) {
@@ -3613,12 +4012,12 @@
 					goto ok2;
 				} else {
 					err = -ERANGE;
-					goto error;
+					goto out;
 				}
 			}
 		}
 		err = -EINVAL;
-		goto error;
+		goto out;

 ok2:
 		saa7191_ctrl.hue = SAA7191_VALUE_UNCHANGED;
@@ -3633,18 +4032,21 @@
 			break;
 		default:
 			err =  -EINVAL;
+			goto out;
 		}

-		if (!err)
-			i2c_decoder_command(DECODER_SAA7191_SET_CONTROLS,
-					    &saa7191_ctrl);
+		err = i2c_decoder_command(DECODER_SAA7191_SET_CONTROLS,
+					  &saa7191_ctrl);
+		if (err)
+			err = -EINVAL;
 		break;
+	}
 	default:
 		err =  -EINVAL;
 	}

-error:
-	spin_unlock(&vino_drvdata->input_lock);
+out:
+	spin_unlock_irqrestore(&vino_drvdata->input_lock, flags);

 	return err;
 }
@@ -3864,9 +4266,9 @@
 over:
 	dprintk("poll(): data %savailable\n",
 		(outgoing > 0) ? "" : "not ");
-	if (outgoing > 0) {
+
+	if (outgoing > 0)
 		ret = POLLIN | POLLRDNORM;
-	}

 error:

@@ -3879,6 +4281,7 @@
 	struct video_device *dev = video_devdata(file);
 	struct vino_channel_settings *vcs = video_get_drvdata(dev);

+#ifdef VINO_DEBUG
 	switch (_IOC_TYPE(cmd)) {
 	case 'v':
 		dprintk("ioctl(): V4L1 unsupported (0x%08x)\n", cmd);
@@ -3890,9 +4293,9 @@
 	default:
 		dprintk("ioctl(): unsupported command 0x%08x\n", cmd);
 	}
+#endif

 	switch (cmd) {
-	/* TODO: V4L1 interface (use compatibility layer?) */
 	/* V4L2 interface */
 	case VIDIOC_QUERYCAP: {
 		vino_v4l2_querycap(arg);
@@ -3910,6 +4313,9 @@
 	case VIDIOC_ENUMSTD: {
 		return vino_v4l2_enumstd(vcs, arg);
 	}
+	case VIDIOC_QUERYSTD: {
+		return vino_v4l2_querystd(vcs, arg);
+	}
 	case VIDIOC_G_STD: {
 		return vino_v4l2_g_std(vcs, arg);
 	}
@@ -4099,8 +4505,7 @@
 		return -ENODEV;
 	}

-	printk(KERN_INFO "VINO with chip ID %ld, revision %ld found\n",
-	       VINO_ID_VALUE(rev_id), VINO_REV_NUM(rev_id));
+	printk(KERN_INFO "VINO revision %ld found\n", VINO_REV_NUM(rev_id));

 	return 0;
 }
