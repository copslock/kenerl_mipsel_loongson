Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 23:00:25 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:29599 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578739AbYCUXAW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2008 23:00:22 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JcqDl-0002Zi-00; Sat, 22 Mar 2008 00:00:21 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 173F1C2DFC; Sat, 22 Mar 2008 00:00:10 +0100 (CET)
Date:	Sat, 22 Mar 2008 00:00:10 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
Message-ID: <20080321230010.GA31135@alpha.franken.de>
References: <1205664563.3050.4.camel@localhost> <1205699257.4159.14.camel@casa> <20080316233619.GA29511@alpha.franken.de> <1205741142.3515.2.camel@localhost> <20080317141828.GA25798@linux-mips.org> <20080317143215.GA11497@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080317143215.GA11497@alpha.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 17, 2008 at 03:32:15PM +0100, Thomas Bogendoerfer wrote:
> On Mon, Mar 17, 2008 at 02:18:28PM +0000, Ralf Baechle wrote:
> > On Mon, Mar 17, 2008 at 09:05:42AM +0100, Giuseppe Sacco wrote:
> > 
> > > The patch you proposed, that use a larger buffer, does not seems to
> > > trigger the bug.
> > 
> > It may help but doesn't have a chance to be accepted upstream.  So
> > this is no more than an useful litmus test.
> 
> sure, that's why I called it a hack. It was just to make sure, that I'm
> on the right track.

below is a patch, which replaces all buffers on the stack, which are
passed to the scsi layer with kmalloced ones.

Giuseppe, could you please check if this fixes your problem, and
doesn't cause new regressions ? 

Thomas.


diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 12f5bae..fd45563 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -482,27 +482,37 @@ int cdrom_get_media_event(struct cdrom_device_info *cdi,
 			  struct media_event_desc *med)
 {
 	struct packet_command cgc;
-	unsigned char buffer[8];
-	struct event_header *eh = (struct event_header *) buffer;
+	unsigned char *buffer;
+	struct event_header *eh;
+	int ret = 1;
+
+	buffer = kmalloc(8, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	eh = (struct event_header *)buffer;
+
+	init_cdrom_command(&cgc, buffer, 8, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_GET_EVENT_STATUS_NOTIFICATION;
 	cgc.cmd[1] = 1;		/* IMMED */
 	cgc.cmd[4] = 1 << 4;	/* media event */
-	cgc.cmd[8] = sizeof(buffer);
+	cgc.cmd[8] = 8;
 	cgc.quiet = 1;
 
 	if (cdi->ops->generic_packet(cdi, &cgc))
-		return 1;
+		goto err;
 
 	if (be16_to_cpu(eh->data_len) < sizeof(*med))
-		return 1;
+		goto err;
 
 	if (eh->nea || eh->notification_class != 0x4)
-		return 1;
+		goto err;
 
-	memcpy(med, &buffer[sizeof(*eh)], sizeof(*med));
-	return 0;
+	memcpy(med, buffer + sizeof(*eh), sizeof(*med));
+	ret = 0;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 /*
@@ -512,68 +522,82 @@ int cdrom_get_media_event(struct cdrom_device_info *cdi,
 static int cdrom_mrw_probe_pc(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
-	char buffer[16];
+	char *buffer;
+	int ret = 1;
+
+	buffer = kmalloc(16, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	init_cdrom_command(&cgc, buffer, 16, CGC_DATA_READ);
 
 	cgc.timeout = HZ;
 	cgc.quiet = 1;
 
 	if (!cdrom_mode_sense(cdi, &cgc, MRW_MODE_PC, 0)) {
 		cdi->mrw_mode_page = MRW_MODE_PC;
-		return 0;
+		ret = 0;
 	} else if (!cdrom_mode_sense(cdi, &cgc, MRW_MODE_PC_PRE1, 0)) {
 		cdi->mrw_mode_page = MRW_MODE_PC_PRE1;
-		return 0;
+		ret = 0;
 	}
-
-	return 1;
+	kfree(buffer);
+	return ret;
 }
 
 static int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 {
 	struct packet_command cgc;
 	struct mrw_feature_desc *mfd;
-	unsigned char buffer[16];
+	unsigned char *buffer;
 	int ret;
 
 	*write = 0;
+	buffer = kmalloc(16, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	init_cdrom_command(&cgc, buffer, 16, CGC_DATA_READ);
 
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
 	cgc.cmd[3] = CDF_MRW;
-	cgc.cmd[8] = sizeof(buffer);
+	cgc.cmd[8] = 16;
 	cgc.quiet = 1;
 
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
-	if (be16_to_cpu(mfd->feature_code) != CDF_MRW)
-		return 1;
+	if (be16_to_cpu(mfd->feature_code) != CDF_MRW) {
+		ret = 1;
+		goto err;
+	}
 	*write = mfd->write;
 
 	if ((ret = cdrom_mrw_probe_pc(cdi))) {
 		*write = 0;
-		return ret;
 	}
-
-	return 0;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 static int cdrom_mrw_bgformat(struct cdrom_device_info *cdi, int cont)
 {
 	struct packet_command cgc;
-	unsigned char buffer[12];
+	unsigned char *buffer;
 	int ret;
 
 	printk(KERN_INFO "cdrom: %sstarting format\n", cont ? "Re" : "");
 
+	buffer = kmalloc(12, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
 	/*
 	 * FmtData bit set (bit 4), format type is 1
 	 */
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_WRITE);
+	init_cdrom_command(&cgc, buffer, 12, CGC_DATA_WRITE);
 	cgc.cmd[0] = GPCMD_FORMAT_UNIT;
 	cgc.cmd[1] = (1 << 4) | 1;
 
@@ -600,6 +624,7 @@ static int cdrom_mrw_bgformat(struct cdrom_device_info *cdi, int cont)
 	if (ret)
 		printk(KERN_INFO "cdrom: bgformat failed\n");
 
+	kfree(buffer);
 	return ret;
 }
 
@@ -659,16 +684,17 @@ static int cdrom_mrw_set_lba_space(struct cdrom_device_info *cdi, int space)
 {
 	struct packet_command cgc;
 	struct mode_page_header *mph;
-	char buffer[16];
+	char *buffer;
 	int ret, offset, size;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	buffer = kmalloc(16, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
 
-	cgc.buffer = buffer;
-	cgc.buflen = sizeof(buffer);
+	init_cdrom_command(&cgc, buffer, 16, CGC_DATA_READ);
 
 	if ((ret = cdrom_mode_sense(cdi, &cgc, cdi->mrw_mode_page, 0)))
-		return ret;
+		goto err;
 
 	mph = (struct mode_page_header *) buffer;
 	offset = be16_to_cpu(mph->desc_length);
@@ -678,55 +704,70 @@ static int cdrom_mrw_set_lba_space(struct cdrom_device_info *cdi, int space)
 	cgc.buflen = size;
 
 	if ((ret = cdrom_mode_select(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	printk(KERN_INFO "cdrom: %s: mrw address space %s selected\n", cdi->name, mrw_address_space[space]);
-	return 0;
+	ret = 0;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 			      struct rwrt_feature_desc *rfd)
 {
 	struct packet_command cgc;
-	char buffer[24];
+	char *buffer;
 	int ret;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	buffer = kmalloc(24, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	init_cdrom_command(&cgc, buffer, 24, CGC_DATA_READ);
 
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;	/* often 0x46 */
 	cgc.cmd[3] = CDF_RWRT;			/* often 0x0020 */
-	cgc.cmd[8] = sizeof(buffer);		/* often 0x18 */
+	cgc.cmd[8] = 24;		        /* often 0x18 */
 	cgc.quiet = 1;
 
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	memcpy(rfd, &buffer[sizeof(struct feature_header)], sizeof (*rfd));
-	return 0;
+	ret = 0;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 static int cdrom_has_defect_mgt(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
-	char buffer[16];
+	char *buffer;
 	__be16 *feature_code;
 	int ret;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	buffer = kmalloc(16, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	init_cdrom_command(&cgc, buffer, 16, CGC_DATA_READ);
 
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
 	cgc.cmd[3] = CDF_HWDM;
-	cgc.cmd[8] = sizeof(buffer);
+	cgc.cmd[8] = 16;
 	cgc.quiet = 1;
 
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	feature_code = (__be16 *) &buffer[sizeof(struct feature_header)];
 	if (be16_to_cpu(*feature_code) == CDF_HWDM)
-		return 0;
-
-	return 1;
+		ret = 0;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 
@@ -817,10 +858,14 @@ static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
 static int mo_open_write(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
-	char buffer[255];
+	char *buffer;
 	int ret;
 
-	init_cdrom_command(&cgc, &buffer, 4, CGC_DATA_READ);
+	buffer = kmalloc(255, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	init_cdrom_command(&cgc, buffer, 4, CGC_DATA_READ);
 	cgc.quiet = 1;
 
 	/*
@@ -837,10 +882,15 @@ static int mo_open_write(struct cdrom_device_info *cdi)
 	}
 
 	/* drive gave us no info, let the user go ahead */
-	if (ret)
-		return 0;
+	if (ret) {
+		ret = 0;
+		goto err;
+	}
 
-	return buffer[3] & 0x80;
+	ret = buffer[3] & 0x80;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
@@ -863,15 +913,19 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
-	char buffer[32];
+	char *buffer;
 	int ret, mmc3_profile;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	buffer = kmalloc(32, GFP_KERNEL);
+	if (!buffer)
+		return;
+
+	init_cdrom_command(&cgc, buffer, 32, CGC_DATA_READ);
 
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
 	cgc.cmd[1] = 0;
 	cgc.cmd[2] = cgc.cmd[3] = 0;		/* Starting Feature Number */
-	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
+	cgc.cmd[8] = 32;		        /* Allocation Length */
 	cgc.quiet = 1;
 
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
@@ -880,6 +934,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 		mmc3_profile = (buffer[6] << 8) | buffer[7];
 
 	cdi->mmc3_profile = mmc3_profile;
+	kfree(buffer);
 }
 
 static int cdrom_is_dvd_rw(struct cdrom_device_info *cdi)
@@ -1594,12 +1649,15 @@ static void setup_send_key(struct packet_command *cgc, unsigned agid, unsigned t
 static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 {
 	int ret;
-	u_char buf[20];
+	u_char *buf;
 	struct packet_command cgc;
 	struct cdrom_device_ops *cdo = cdi->ops;
-	rpc_state_t rpc_state;
+	rpc_state_t *rpc_state;
+
+	buf = kzalloc(20, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	memset(buf, 0, sizeof(buf));
 	init_cdrom_command(&cgc, buf, 0, CGC_DATA_READ);
 
 	switch (ai->type) {
@@ -1610,7 +1668,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		setup_report_key(&cgc, ai->lsa.agid, 0);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
 		ai->lsa.agid = buf[7] >> 6;
 		/* Returning data, let host change state */
@@ -1621,7 +1679,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		setup_report_key(&cgc, ai->lsk.agid, 2);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
 		copy_key(ai->lsk.key, &buf[4]);
 		/* Returning data, let host change state */
@@ -1632,7 +1690,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		setup_report_key(&cgc, ai->lsc.agid, 1);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
 		copy_chal(ai->lsc.chal, &buf[4]);
 		/* Returning data, let host change state */
@@ -1649,7 +1707,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.cmd[2] = ai->lstk.lba >> 24;
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
 		ai->lstk.cpm = (buf[4] >> 7) & 1;
 		ai->lstk.cp_sec = (buf[4] >> 6) & 1;
@@ -1663,7 +1721,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		setup_report_key(&cgc, ai->lsasf.agid, 5);
 		
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
 		ai->lsasf.asf = buf[7] & 1;
 		break;
@@ -1676,7 +1734,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		copy_chal(&buf[4], ai->hsc.chal);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
 		ai->type = DVD_LU_SEND_KEY1;
 		break;
@@ -1689,7 +1747,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 		if ((ret = cdo->generic_packet(cdi, &cgc))) {
 			ai->type = DVD_AUTH_FAILURE;
-			return ret;
+			goto err;
 		}
 		ai->type = DVD_AUTH_ESTABLISHED;
 		break;
@@ -1700,24 +1758,23 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cdinfo(CD_DVD, "entering DVD_INVALIDATE_AGID\n"); 
 		setup_report_key(&cgc, ai->lsa.agid, 0x3f);
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 		break;
 
 	/* Get region settings */
 	case DVD_LU_SEND_RPC_STATE:
 		cdinfo(CD_DVD, "entering DVD_LU_SEND_RPC_STATE\n");
 		setup_report_key(&cgc, 0, 8);
-		memset(&rpc_state, 0, sizeof(rpc_state_t));
-		cgc.buffer = (char *) &rpc_state;
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 
-		ai->lrpcs.type = rpc_state.type_code;
-		ai->lrpcs.vra = rpc_state.vra;
-		ai->lrpcs.ucca = rpc_state.ucca;
-		ai->lrpcs.region_mask = rpc_state.region_mask;
-		ai->lrpcs.rpc_scheme = rpc_state.rpc_scheme;
+		rpc_state = (rpc_state_t *)buf;
+		ai->lrpcs.type = rpc_state->type_code;
+		ai->lrpcs.vra = rpc_state->vra;
+		ai->lrpcs.ucca = rpc_state->ucca;
+		ai->lrpcs.region_mask = rpc_state->region_mask;
+		ai->lrpcs.rpc_scheme = rpc_state->rpc_scheme;
 		break;
 
 	/* Set region settings */
@@ -1728,20 +1785,23 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[4] = ai->hrpcs.pdrc;
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
-			return ret;
+			goto err;
 		break;
 
 	default:
 		cdinfo(CD_WARNING, "Invalid DVD key ioctl (%d)\n", ai->type);
-		return -ENOTTY;
+		ret = -ENOTTY;
+		goto err;
 	}
-
-	return 0;
+	ret = 0;
+err:
+	kfree(buf);
+	return ret;
 }
 
 static int dvd_read_physical(struct cdrom_device_info *cdi, dvd_struct *s)
 {
-	unsigned char buf[21], *base;
+	unsigned char *buf, *base;
 	struct dvd_layer *layer;
 	struct packet_command cgc;
 	struct cdrom_device_ops *cdo = cdi->ops;
@@ -1750,7 +1810,11 @@ static int dvd_read_physical(struct cdrom_device_info *cdi, dvd_struct *s)
 	if (layer_num >= DVD_LAYERS)
 		return -EINVAL;
 
-	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	buf = kmalloc(21, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	init_cdrom_command(&cgc, buf, 21, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
 	cgc.cmd[6] = layer_num;
 	cgc.cmd[7] = s->type;
@@ -1762,7 +1826,7 @@ static int dvd_read_physical(struct cdrom_device_info *cdi, dvd_struct *s)
 	cgc.quiet = 1;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	base = &buf[4];
 	layer = &s->physical.layer[layer_num];
@@ -1786,17 +1850,24 @@ static int dvd_read_physical(struct cdrom_device_info *cdi, dvd_struct *s)
 	layer->end_sector_l0 = base[13] << 16 | base[14] << 8 | base[15];
 	layer->bca = base[16] >> 7;
 
-	return 0;
+	ret = 0;
+err:
+	kfree(buf);
+	return ret;
 }
 
 static int dvd_read_copyright(struct cdrom_device_info *cdi, dvd_struct *s)
 {
 	int ret;
-	u_char buf[8];
+	u_char *buf;
 	struct packet_command cgc;
 	struct cdrom_device_ops *cdo = cdi->ops;
 
-	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	buf = kmalloc(8, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	init_cdrom_command(&cgc, buf, 8, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
 	cgc.cmd[6] = s->copyright.layer_num;
 	cgc.cmd[7] = s->type;
@@ -1804,12 +1875,15 @@ static int dvd_read_copyright(struct cdrom_device_info *cdi, dvd_struct *s)
 	cgc.cmd[9] = cgc.buflen & 0xff;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	s->copyright.cpst = buf[4];
 	s->copyright.rmi = buf[5];
 
-	return 0;
+	ret = 0;
+err:
+	kfree(buf);
+	return ret;
 }
 
 static int dvd_read_disckey(struct cdrom_device_info *cdi, dvd_struct *s)
@@ -1841,26 +1915,33 @@ static int dvd_read_disckey(struct cdrom_device_info *cdi, dvd_struct *s)
 static int dvd_read_bca(struct cdrom_device_info *cdi, dvd_struct *s)
 {
 	int ret;
-	u_char buf[4 + 188];
+	u_char *buf;
 	struct packet_command cgc;
 	struct cdrom_device_ops *cdo = cdi->ops;
 
-	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	buf = kmalloc(4 + 188, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	init_cdrom_command(&cgc, buf, 4 + 188, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
 	cgc.cmd[7] = s->type;
 	cgc.cmd[9] = cgc.buflen & 0xff;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	s->bca.len = buf[0] << 8 | buf[1];
 	if (s->bca.len < 12 || s->bca.len > 188) {
 		cdinfo(CD_WARNING, "Received invalid BCA length (%d)\n", s->bca.len);
-		return -EIO;
+		ret = -EIO;
+		goto err;
 	}
 	memcpy(s->bca.value, &buf[4], s->bca.len);
-
-	return 0;
+	ret = 0;
+err:
+	kfree(buf);
+	return ret;
 }
 
 static int dvd_read_manufact(struct cdrom_device_info *cdi, dvd_struct *s)
@@ -1960,9 +2041,13 @@ static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct packet_command cgc;
-	char buffer[32];
+	char *buffer;
 	int ret;
 
+	buffer = kmalloc(32, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
 	init_cdrom_command(&cgc, buffer, 16, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_SUBCHANNEL;
 	cgc.cmd[1] = 2;     /* MSF addressing */
@@ -1971,7 +2056,7 @@ static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 	cgc.cmd[8] = 16;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
-		return ret;
+		goto err;
 
 	subchnl->cdsc_audiostatus = cgc.buffer[1];
 	subchnl->cdsc_format = CDROM_MSF;
@@ -1986,7 +2071,10 @@ static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 	subchnl->cdsc_absaddr.msf.second = cgc.buffer[10];
 	subchnl->cdsc_absaddr.msf.frame = cgc.buffer[11];
 
-	return 0;
+	ret = 0;
+err:
+	kfree(buffer);
+	return ret;
 }
 
 /*

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
