Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 21:41:52 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.188]:824 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S24086664AbYLCVlr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 21:41:47 +0000
Received: by fk-out-0910.google.com with SMTP id b27so3299497fka.0
        for <linux-mips@linux-mips.org>; Wed, 03 Dec 2008 13:41:46 -0800 (PST)
Received: by 10.181.137.13 with SMTP id p13mr4782658bkn.173.1228340505640;
        Wed, 03 Dec 2008 13:41:45 -0800 (PST)
Received: from ?192.168.178.69? (e179197233.adsl.alicedsl.de [85.179.197.233])
        by mx.google.com with ESMTPS id p9sm9097130fkb.8.2008.12.03.13.41.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 13:41:44 -0800 (PST)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in
 sgiwd93.c
From:	Kay Sievers <kay.sievers@vrfy.org>
To:	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Greg KH <greg@kroah.com>
In-Reply-To: <1228340025.5551.87.camel@localhost.localdomain>
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
	 <1228327306.5551.36.camel@localhost.localdomain>
	 <35647.88.114.226.209.1228329736.squirrel@webmail.movial.fi>
	 <ac3eb2510812031051k9d9312bma119bfae35afc230@mail.gmail.com>
	 <1228330800.5551.58.camel@localhost.localdomain>
	 <ac3eb2510812031229l51912169o3e96346ed51c48f0@mail.gmail.com>
	 <1228337529.5551.72.camel@localhost.localdomain>
	 <ac3eb2510812031259v1a4ebe25tc841daaa2fe5a722@mail.gmail.com>
	 <1228338142.5551.77.camel@localhost.localdomain>
	 <ac3eb2510812031328x38559660rcc13db195e01ea15@mail.gmail.com>
	 <1228340025.5551.87.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Wed, 03 Dec 2008 22:41:36 +0100
Message-Id: <1228340496.6977.19.camel@nga>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1.1 
Content-Transfer-Encoding: 7bit
Return-Path: <kay.sievers@vrfy.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kay.sievers@vrfy.org
Precedence: bulk
X-list: linux-mips

On Wed, 2008-12-03 at 15:33 -0600, James Bottomley wrote:
> On Wed, 2008-12-03 at 22:28 +0100, Kay Sievers wrote:
> > On Wed, Dec 3, 2008 at 22:02, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > On Wed, 2008-12-03 at 21:59 +0100, Kay Sievers wrote:
> > >> On Wed, Dec 3, 2008 at 21:52, James Bottomley
> > >> <James.Bottomley@hansenpartnership.com> wrote:
> > >> > On Wed, 2008-12-03 at 21:29 +0100, Kay Sievers wrote:
> > >> >> On Wed, Dec 3, 2008 at 20:00, James Bottomley
> > >> >> <James.Bottomley@hansenpartnership.com> wrote:
> > >> >> >> We are already in the middle of a ~400 files "struct device" bus_id
> > >> >> >> conversion, and only very few maintainers respond to these patches. We
> > >> >> >> also never got any reply to the SCSI bus_id patch we sent weeks ago.
> > >> >> >> :)
> > >> >> >
> > >> >> > When did you send it?  Searching the scsi archives on bus_id produces no
> > >> >> > results, what was the subject line?
> > >> >>
> > >> >> http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=driver-core/bus_id-scsi.patch;hb=HEAD
> > >> >
> > >> > Hmm, OK ... if you want a review, over the SCSI list is best.
> > >> >
> > >> > Things like this:
> > >> >
> > >> >
> > >> >> --- a/drivers/scsi/scsi_ioctl.c
> > >> >> 182 +++ b/drivers/scsi/scsi_ioctl.c
> > >> >> 183 @@ -170,7 +170,8 @@ static int scsi_ioctl_get_pci(struct scs
> > >> >> 184
> > >> >> 185          if (!dev)
> > >> >> 186                 return -ENXIO;
> > >> >> 187
> > >> >> -        return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
> > >> >> 188 +        return copy_to_user(arg,
> > >> >> 189
> > >> >> +                           dev_name(dev), strlen(dev_name(dev)))? -EFAULT: 0;
> > >> >> 190  }
> > >> >
> > >> > Give cause for concern:  in the original, we know we scribble over 20
> > >> > bytes of user space.  With the new one we scribble over an unknown
> > >> > number (which could potentially be much greater than 20).  That's an
> > >> > accident waiting to happen in userspace.
> > >>
> > >> Yeah, but the name will have no real limit. What should we do here?
> > >> Just Truncate at 20, because we "know" it's not longer?
> > >
> > > Well, the problem is the stupid ioctl which gives nowhere to say how
> > > many bytes the buffer is.  For safety's sake, yes, I think you have to
> > > limit it to 20 bytes.  Otherwise, on the day we introduce long names
> > > some random application using this ioctl will die with data corruption
> > > and that will be extremely hard to debug.
> > 
> > Do you want to take over the patch to the scsi tree, and we will work
> > from there. It's through Greg's tree in -next since a while.
> 
> Sure ... can you send a copy of it rather than me having to pull it out
> of your git tree.

Sure, here is it. These are the files I could compile-test. I have
another patch, which touches the stuff I couldn't compile, I will send
that in the next days.

Thanks,
Kay


From: Kay Sievers <kay.sievers@vrfy.org>
Subject: SCSI: struct device - replace bus_id with dev_name(), dev_set_name()

CC: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/misc/enclosure.c            |    8 +++---
 drivers/scsi/aic94xx/aic94xx_tmf.c  |    2 -
 drivers/scsi/hosts.c                |    6 +----
 drivers/scsi/ipr.c                  |    2 -
 drivers/scsi/ipr.h                  |    2 -
 drivers/scsi/libsas/sas_discover.c  |    2 -
 drivers/scsi/libsas/sas_dump.c      |    2 -
 drivers/scsi/libsas/sas_port.c      |    2 -
 drivers/scsi/raid_class.c           |    3 --
 drivers/scsi/scsi_debug.c           |    4 +--
 drivers/scsi/scsi_ioctl.c           |    3 +-
 drivers/scsi/scsi_scan.c            |    7 ++----
 drivers/scsi/scsi_sysfs.c           |   12 ++++------
 drivers/scsi/scsi_transport_fc.c    |   18 +++++++--------
 drivers/scsi/scsi_transport_iscsi.c |   11 +++------
 drivers/scsi/scsi_transport_sas.c   |   42 ++++++++++++++++++------------------
 drivers/scsi/scsi_transport_srp.c   |    2 -
 drivers/scsi/sd.c                   |    2 -
 drivers/scsi/ses.c                  |    2 -
 19 files changed, 63 insertions(+), 69 deletions(-)

--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -119,7 +119,7 @@ enclosure_register(struct device *dev, c
 	edev->edev.class = &enclosure_class;
 	edev->edev.parent = get_device(dev);
 	edev->cb = cb;
-	snprintf(edev->edev.bus_id, BUS_ID_SIZE, "%s", name);
+	dev_set_name(&edev->edev, name);
 	err = device_register(&edev->edev);
 	if (err)
 		goto err;
@@ -170,7 +170,7 @@ EXPORT_SYMBOL_GPL(enclosure_unregister);
 static void enclosure_link_name(struct enclosure_component *cdev, char *name)
 {
 	strcpy(name, "enclosure_device:");
-	strcat(name, cdev->cdev.bus_id);
+	strcat(name, dev_name(&cdev->cdev));
 }
 
 static void enclosure_remove_links(struct enclosure_component *cdev)
@@ -256,9 +256,9 @@ enclosure_component_register(struct encl
 	cdev = &ecomp->cdev;
 	cdev->parent = get_device(&edev->edev);
 	if (name)
-		snprintf(cdev->bus_id, BUS_ID_SIZE, "%s", name);
+		dev_set_name(cdev, name);
 	else
-		snprintf(cdev->bus_id, BUS_ID_SIZE, "%u", number);
+		dev_set_name(cdev, "%u", number);
 
 	cdev->release = enclosure_component_release;
 	cdev->groups = enclosure_groups;
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -189,7 +189,7 @@ int asd_I_T_nexus_reset(struct domain_de
 	asd_clear_nexus_I_T(dev, NEXUS_PHASE_PRE);
 	/* send a hard reset */
 	ASD_DPRINTK("sending %s reset to %s\n",
-		    reset_type ? "hard" : "soft", phy->dev.bus_id);
+		    reset_type ? "hard" : "soft", dev_name(&phy->dev));
 	res = sas_phy_reset(phy, reset_type);
 	if (res == TMF_RESP_FUNC_COMPLETE) {
 		/* wait for the maximum settle time */
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -388,8 +388,7 @@ struct Scsi_Host *scsi_host_alloc(struct
 		shost->dma_boundary = 0xffffffff;
 
 	device_initialize(&shost->shost_gendev);
-	snprintf(shost->shost_gendev.bus_id, BUS_ID_SIZE, "host%d",
-		shost->host_no);
+	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
 #ifndef CONFIG_SYSFS_DEPRECATED
 	shost->shost_gendev.bus = &scsi_bus_type;
 #endif
@@ -398,8 +397,7 @@ struct Scsi_Host *scsi_host_alloc(struct
 	device_initialize(&shost->shost_dev);
 	shost->shost_dev.parent = &shost->shost_gendev;
 	shost->shost_dev.class = &shost_class;
-	snprintf(shost->shost_dev.bus_id, BUS_ID_SIZE, "host%d",
-		 shost->host_no);
+	dev_set_name(&shost->shost_dev, "host%d", shost->host_no);
 	shost->shost_dev.groups = scsi_sysfs_shost_attr_groups;
 
 	shost->ehandler = kthread_run(scsi_error_handler, shost,
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -2184,7 +2184,7 @@ static void ipr_dump_location_data(struc
 		sizeof(struct ipr_dump_entry_header);
 	driver_dump->location_entry.hdr.data_type = IPR_DUMP_DATA_TYPE_ASCII;
 	driver_dump->location_entry.hdr.id = IPR_DUMP_LOCATION_ID;
-	strcpy(driver_dump->location_entry.location, ioa_cfg->pdev->dev.bus_id);
+	strcpy(driver_dump->location_entry.location, dev_name(&ioa_cfg->pdev->dev));
 	driver_dump->hdr.num_entries++;
 }
 
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1272,7 +1272,7 @@ struct ipr_dump_entry_header {
 
 struct ipr_dump_location_entry {
 	struct ipr_dump_entry_header hdr;
-	u8 location[BUS_ID_SIZE];
+	u8 location[20];
 }__attribute__((packed));
 
 struct ipr_dump_trace_entry {
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -169,7 +169,7 @@ int sas_notify_lldd_dev_found(struct dom
 		if (res) {
 			printk("sas: driver on pcidev %s cannot handle "
 			       "device %llx, error:%d\n",
-			       sas_ha->dev->bus_id,
+			       dev_name(sas_ha->dev),
 			       SAS_ADDR(dev->sas_addr), res);
 		}
 	}
--- a/drivers/scsi/libsas/sas_dump.c
+++ b/drivers/scsi/libsas/sas_dump.c
@@ -56,7 +56,7 @@ void sas_dprint_phye(int phyid, enum phy
 
 void sas_dprint_hae(struct sas_ha_struct *sas_ha, enum ha_event he)
 {
-	SAS_DPRINTK("ha %s: %s event\n", sas_ha->dev->bus_id,
+	SAS_DPRINTK("ha %s: %s event\n", dev_name(sas_ha->dev),
 		    sas_hae_str[he]);
 }
 
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -113,7 +113,7 @@ static void sas_form_port(struct asd_sas
 	sas_port_add_phy(port->port, phy->phy);
 
 	SAS_DPRINTK("%s added to %s, phy_mask:0x%x (%16llx)\n",
-		    phy->phy->dev.bus_id,port->port->dev.bus_id,
+		    dev_name(&phy->phy->dev), dev_name(&port->port->dev),
 		    port->phy_mask,
 		    SAS_ADDR(port->attached_sas_addr));
 
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -237,8 +237,7 @@ int raid_component_add(struct raid_templ
 	rc->dev.parent = get_device(component_dev);
 	rc->num = rd->component_count++;
 
-	snprintf(rc->dev.bus_id, sizeof(rc->dev.bus_id),
-		 "component-%d", rc->num);
+	dev_set_name(&rc->dev, "component-%d", rc->num);
 	list_add_tail(&rc->node, &rd->component_list);
 	rc->dev.class = &raid_class.class;
 	err = device_add(&rc->dev);
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2508,7 +2508,7 @@ static void pseudo_0_release(struct devi
 }
 
 static struct device pseudo_primary = {
-	.bus_id		= "pseudo_0",
+	.init_name	= "pseudo_0",
 	.release	= pseudo_0_release,
 };
 
@@ -2680,7 +2680,7 @@ static int sdebug_add_adapter(void)
         sdbg_host->dev.bus = &pseudo_lld_bus;
         sdbg_host->dev.parent = &pseudo_primary;
         sdbg_host->dev.release = &sdebug_release_adapter;
-        sprintf(sdbg_host->dev.bus_id, "adapter%d", scsi_debug_add_host);
+        dev_set_name(&sdbg_host->dev, "adapter%d", scsi_debug_add_host);
 
         error = device_register(&sdbg_host->dev);
 
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -170,7 +170,8 @@ static int scsi_ioctl_get_pci(struct scs
 
         if (!dev)
 		return -ENXIO;
-        return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
+        return copy_to_user(arg,
+			    dev_name(dev), strlen(dev_name(dev)))? -EFAULT: 0;
 }
 
 
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -411,8 +411,7 @@ static struct scsi_target *scsi_alloc_ta
 	device_initialize(dev);
 	starget->reap_ref = 1;
 	dev->parent = get_device(parent);
-	sprintf(dev->bus_id, "target%d:%d:%d",
-		shost->host_no, channel, id);
+	dev_set_name(dev, "target%d:%d:%d", shost->host_no, channel, id);
 #ifndef CONFIG_SYSFS_DEPRECATED
 	dev->bus = &scsi_bus_type;
 #endif
@@ -1010,7 +1009,7 @@ static int scsi_probe_and_add_lun(struct
 		if (rescan || !scsi_device_created(sdev)) {
 			SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO
 				"scsi scan: device exists on %s\n",
-				sdev->sdev_gendev.bus_id));
+				dev_name(&sdev->sdev_gendev)));
 			if (sdevp)
 				*sdevp = sdev;
 			else
@@ -1149,7 +1148,7 @@ static void scsi_sequential_lun_scan(str
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 
 	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: Sequential scan of"
-				    "%s\n", starget->dev.bus_id));
+				    "%s\n", dev_name(&starget->dev)));
 
 	max_dev_lun = min(max_scsi_luns, shost->max_lun);
 	/*
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1079,16 +1079,14 @@ void scsi_sysfs_device_initialize(struct
 	device_initialize(&sdev->sdev_gendev);
 	sdev->sdev_gendev.bus = &scsi_bus_type;
 	sdev->sdev_gendev.type = &scsi_dev_type;
-	sprintf(sdev->sdev_gendev.bus_id,"%d:%d:%d:%d",
-		sdev->host->host_no, sdev->channel, sdev->id,
-		sdev->lun);
-	
+	dev_set_name(&sdev->sdev_gendev, "%d:%d:%d:%d",
+		     sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+
 	device_initialize(&sdev->sdev_dev);
 	sdev->sdev_dev.parent = &sdev->sdev_gendev;
 	sdev->sdev_dev.class = &sdev_class;
-	snprintf(sdev->sdev_dev.bus_id, BUS_ID_SIZE,
-		 "%d:%d:%d:%d", sdev->host->host_no,
-		 sdev->channel, sdev->id, sdev->lun);
+	dev_set_name(&sdev->sdev_dev, "%d:%d:%d:%d",
+		     sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
 	sdev->scsi_level = starget->scsi_level;
 	transport_setup_device(&sdev->sdev_gendev);
 	spin_lock_irqsave(shost->host_lock, flags);
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -2486,8 +2486,8 @@ fc_rport_create(struct Scsi_Host *shost,
 	device_initialize(dev);			/* takes self reference */
 	dev->parent = get_device(&shost->shost_gendev); /* parent reference */
 	dev->release = fc_rport_dev_release;
-	sprintf(dev->bus_id, "rport-%d:%d-%d",
-		shost->host_no, channel, rport->number);
+	dev_set_name(dev, "rport-%d:%d-%d",
+		     shost->host_no, channel, rport->number);
 	transport_setup_device(dev);
 
 	error = device_add(dev);
@@ -3157,8 +3157,8 @@ fc_vport_setup(struct Scsi_Host *shost, 
 	device_initialize(dev);			/* takes self reference */
 	dev->parent = get_device(pdev);		/* takes parent reference */
 	dev->release = fc_vport_dev_release;
-	sprintf(dev->bus_id, "vport-%d:%d-%d",
-		shost->host_no, channel, vport->number);
+	dev_set_name(dev, "vport-%d:%d-%d",
+		     shost->host_no, channel, vport->number);
 	transport_setup_device(dev);
 
 	error = device_add(dev);
@@ -3181,19 +3181,19 @@ fc_vport_setup(struct Scsi_Host *shost, 
 	 */
 	if (pdev != &shost->shost_gendev) {
 		error = sysfs_create_link(&shost->shost_gendev.kobj,
-				 &dev->kobj, dev->bus_id);
+				 &dev->kobj, dev_name(dev));
 		if (error)
 			printk(KERN_ERR
 				"%s: Cannot create vport symlinks for "
 				"%s, err=%d\n",
-				__func__, dev->bus_id, error);
+				__func__, dev_name(dev), error);
 	}
 	spin_lock_irqsave(shost->host_lock, flags);
 	vport->flags &= ~FC_VPORT_CREATING;
 	spin_unlock_irqrestore(shost->host_lock, flags);
 
 	dev_printk(KERN_NOTICE, pdev,
-			"%s created via shost%d channel %d\n", dev->bus_id,
+			"%s created via shost%d channel %d\n", dev_name(dev),
 			shost->host_no, channel);
 
 	*ret_vport = vport;
@@ -3290,7 +3290,7 @@ fc_vport_terminate(struct fc_vport *vpor
 		return stat;
 
 	if (dev->parent != &shost->shost_gendev)
-		sysfs_remove_link(&shost->shost_gendev.kobj, dev->bus_id);
+		sysfs_remove_link(&shost->shost_gendev.kobj, dev_name(dev));
 	transport_remove_device(dev);
 	device_del(dev);
 	transport_destroy_device(dev);
@@ -3322,7 +3322,7 @@ fc_vport_sched_delete(struct work_struct
 		dev_printk(KERN_ERR, vport->dev.parent,
 			"%s: %s could not be deleted created via "
 			"shost%d channel %d - error %d\n", __func__,
-			vport->dev.bus_id, vport->shost->host_no,
+			dev_name(&vport->dev), vport->shost->host_no,
 			vport->channel, stat);
 }
 
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -187,8 +187,7 @@ iscsi_create_endpoint(int dd_size)
 
 	ep->id = id;
 	ep->dev.class = &iscsi_endpoint_class;
-	snprintf(ep->dev.bus_id, BUS_ID_SIZE, "ep-%llu",
-		 (unsigned long long) id);
+	dev_set_name(&ep->dev, "ep-%llu", (unsigned long long) id);
 	err = device_register(&ep->dev);
         if (err)
                 goto free_ep;
@@ -724,8 +723,7 @@ int iscsi_add_session(struct iscsi_cls_s
 	}
 	session->target_id = id;
 
-	snprintf(session->dev.bus_id, BUS_ID_SIZE, "session%u",
-		 session->sid);
+	dev_set_name(&session->dev, "session%u", session->sid);
 	err = device_add(&session->dev);
 	if (err) {
 		iscsi_cls_session_printk(KERN_ERR, session,
@@ -898,8 +896,7 @@ iscsi_create_conn(struct iscsi_cls_sessi
 	if (!get_device(&session->dev))
 		goto free_conn;
 
-	snprintf(conn->dev.bus_id, BUS_ID_SIZE, "connection%d:%u",
-		 session->sid, cid);
+	dev_set_name(&conn->dev, "connection%d:%u", session->sid, cid);
 	conn->dev.parent = &session->dev;
 	conn->dev.release = iscsi_conn_release;
 	err = device_register(&conn->dev);
@@ -1816,7 +1813,7 @@ iscsi_register_transport(struct iscsi_tr
 		priv->t.create_work_queue = 1;
 
 	priv->dev.class = &iscsi_transport_class;
-	snprintf(priv->dev.bus_id, BUS_ID_SIZE, "%s", tt->name);
+	dev_set_name(&priv->dev, "%s", tt->name);
 	err = device_register(&priv->dev);
 	if (err)
 		goto free_priv;
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -207,7 +207,7 @@ static int sas_bsg_initialize(struct Scs
 	struct request_queue *q;
 	int error;
 	struct device *dev;
-	char namebuf[BUS_ID_SIZE];
+	char namebuf[20];
 	const char *name;
 	void (*release)(struct device *);
 
@@ -219,7 +219,7 @@ static int sas_bsg_initialize(struct Scs
 	if (rphy) {
 		q = blk_init_queue(sas_non_host_smp_request, NULL);
 		dev = &rphy->dev;
-		name = dev->bus_id;
+		name = dev_name(dev);
 		release = NULL;
 	} else {
 		q = blk_init_queue(sas_host_smp_request, NULL);
@@ -629,10 +629,10 @@ struct sas_phy *sas_phy_alloc(struct dev
 	INIT_LIST_HEAD(&phy->port_siblings);
 	if (scsi_is_sas_expander_device(parent)) {
 		struct sas_rphy *rphy = dev_to_rphy(parent);
-		sprintf(phy->dev.bus_id, "phy-%d:%d:%d", shost->host_no,
+		dev_set_name(&phy->dev, "phy-%d:%d:%d", shost->host_no,
 			rphy->scsi_target_id, number);
 	} else
-		sprintf(phy->dev.bus_id, "phy-%d:%d", shost->host_no, number);
+		dev_set_name(&phy->dev, "phy-%d:%d", shost->host_no, number);
 
 	transport_setup_device(&phy->dev);
 
@@ -770,7 +770,7 @@ static void sas_port_create_link(struct 
 	int res;
 
 	res = sysfs_create_link(&port->dev.kobj, &phy->dev.kobj,
-				phy->dev.bus_id);
+				dev_name(&phy->dev));
 	if (res)
 		goto err;
 	res = sysfs_create_link(&phy->dev.kobj, &port->dev.kobj, "port");
@@ -785,7 +785,7 @@ err:
 static void sas_port_delete_link(struct sas_port *port,
 				 struct sas_phy *phy)
 {
-	sysfs_remove_link(&port->dev.kobj, phy->dev.bus_id);
+	sysfs_remove_link(&port->dev.kobj, dev_name(&phy->dev));
 	sysfs_remove_link(&phy->dev.kobj, "port");
 }
 
@@ -821,11 +821,11 @@ struct sas_port *sas_port_alloc(struct d
 
 	if (scsi_is_sas_expander_device(parent)) {
 		struct sas_rphy *rphy = dev_to_rphy(parent);
-		sprintf(port->dev.bus_id, "port-%d:%d:%d", shost->host_no,
-			rphy->scsi_target_id, port->port_identifier);
+		dev_set_name(&port->dev, "port-%d:%d:%d", shost->host_no,
+			     rphy->scsi_target_id, port->port_identifier);
 	} else
-		sprintf(port->dev.bus_id, "port-%d:%d", shost->host_no,
-			port->port_identifier);
+		dev_set_name(&port->dev, "port-%d:%d", shost->host_no,
+			     port->port_identifier);
 
 	transport_setup_device(&port->dev);
 
@@ -935,7 +935,7 @@ void sas_port_delete(struct sas_port *po
 	if (port->is_backlink) {
 		struct device *parent = port->dev.parent;
 
-		sysfs_remove_link(&port->dev.kobj, parent->bus_id);
+		sysfs_remove_link(&port->dev.kobj, dev_name(parent));
 		port->is_backlink = 0;
 	}
 
@@ -984,7 +984,8 @@ void sas_port_add_phy(struct sas_port *p
 		/* If this trips, you added a phy that was already
 		 * part of a different port */
 		if (unlikely(tmp != phy)) {
-			dev_printk(KERN_ERR, &port->dev, "trying to add phy %s fails: it's already part of another port\n", phy->dev.bus_id);
+			dev_printk(KERN_ERR, &port->dev, "trying to add phy %s fails: it's already part of another port\n",
+				   dev_name(&phy->dev));
 			BUG();
 		}
 	} else {
@@ -1023,7 +1024,7 @@ void sas_port_mark_backlink(struct sas_p
 		return;
 	port->is_backlink = 1;
 	res = sysfs_create_link(&port->dev.kobj, &parent->kobj,
-				parent->bus_id);
+				dev_name(parent));
 	if (res)
 		goto err;
 	return;
@@ -1367,11 +1368,12 @@ struct sas_rphy *sas_end_device_alloc(st
 	rdev->rphy.dev.release = sas_end_device_release;
 	if (scsi_is_sas_expander_device(parent->dev.parent)) {
 		struct sas_rphy *rphy = dev_to_rphy(parent->dev.parent);
-		sprintf(rdev->rphy.dev.bus_id, "end_device-%d:%d:%d",
-			shost->host_no, rphy->scsi_target_id, parent->port_identifier);
+		dev_set_name(&rdev->rphy.dev, "end_device-%d:%d:%d",
+			     shost->host_no, rphy->scsi_target_id,
+			     parent->port_identifier);
 	} else
-		sprintf(rdev->rphy.dev.bus_id, "end_device-%d:%d",
-			shost->host_no, parent->port_identifier);
+		dev_set_name(&rdev->rphy.dev, "end_device-%d:%d",
+			     shost->host_no, parent->port_identifier);
 	rdev->rphy.identify.device_type = SAS_END_DEVICE;
 	sas_rphy_initialize(&rdev->rphy);
 	transport_setup_device(&rdev->rphy.dev);
@@ -1411,8 +1413,8 @@ struct sas_rphy *sas_expander_alloc(stru
 	mutex_lock(&sas_host->lock);
 	rdev->rphy.scsi_target_id = sas_host->next_expander_id++;
 	mutex_unlock(&sas_host->lock);
-	sprintf(rdev->rphy.dev.bus_id, "expander-%d:%d",
-		shost->host_no, rdev->rphy.scsi_target_id);
+	dev_set_name(&rdev->rphy.dev, "expander-%d:%d",
+		     shost->host_no, rdev->rphy.scsi_target_id);
 	rdev->rphy.identify.device_type = type;
 	sas_rphy_initialize(&rdev->rphy);
 	transport_setup_device(&rdev->rphy.dev);
@@ -1445,7 +1447,7 @@ int sas_rphy_add(struct sas_rphy *rphy)
 	transport_add_device(&rphy->dev);
 	transport_configure_device(&rphy->dev);
 	if (sas_bsg_initialize(shost, rphy))
-		printk("fail to a bsg device %s\n", rphy->dev.bus_id);
+		printk("fail to a bsg device %s\n", dev_name(&rphy->dev));
 
 
 	mutex_lock(&sas_host->lock);
--- a/drivers/scsi/scsi_transport_srp.c
+++ b/drivers/scsi/scsi_transport_srp.c
@@ -212,7 +212,7 @@ struct srp_rport *srp_rport_add(struct S
 	rport->roles = ids->roles;
 
 	id = atomic_inc_return(&to_srp_host_attrs(shost)->next_port_id);
-	sprintf(rport->dev.bus_id, "port-%d:%d", shost->host_no, id);
+	dev_set_name(&rport->dev, "port-%d:%d", shost->host_no, id);
 
 	transport_setup_device(&rport->dev);
 
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1875,7 +1875,7 @@ static int sd_probe(struct device *dev)
 	device_initialize(&sdkp->dev);
 	sdkp->dev.parent = &sdp->sdev_gendev;
 	sdkp->dev.class = &sd_disk_class;
-	strncpy(sdkp->dev.bus_id, sdp->sdev_gendev.bus_id, BUS_ID_SIZE);
+	dev_set_name(&sdkp->dev, dev_name(&sdp->sdev_gendev));
 
 	if (device_add(&sdkp->dev))
 		goto out_free_index;
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -525,7 +525,7 @@ static int ses_intf_add(struct device *c
 	if (!scomp)
 		goto err_free;
 
-	edev = enclosure_register(cdev->parent, sdev->sdev_gendev.bus_id,
+	edev = enclosure_register(cdev->parent, dev_name(&sdev->sdev_gendev),
 				  components, &ses_enclosure_callbacks);
 	if (IS_ERR(edev)) {
 		err = PTR_ERR(edev);
