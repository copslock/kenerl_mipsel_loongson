Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Nov 2002 13:45:44 +0100 (CET)
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:63421 "EHLO
	crisis.wild-wind.fr.eu.org") by linux-mips.org with ESMTP
	id <S1122121AbSKOMpn>; Fri, 15 Nov 2002 13:45:43 +0100
Received: from hina.wild-wind.fr.eu.org ([192.168.70.139])
	by crisis.wild-wind.fr.eu.org with esmtp (Exim 3.35 #1 (Debian))
	id 18Cfsz-0001XV-00
	for <linux-mips@linux-mips.org>; Fri, 15 Nov 2002 13:47:49 +0100
Received: from maz by hina.wild-wind.fr.eu.org with local (Exim 3.35 #1 (Debian))
	id 18CfqY-0008Ly-00; Fri, 15 Nov 2002 13:45:18 +0100
To: linux-mips@linux-mips.org
Subject: [PATCH] wd33c93 driver cli() removal
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 15 Nov 2002 13:45:17 +0100
Message-ID: <wrpd6p7huhu.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <maz@misterjones.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mzyngier@freesurf.fr
Precedence: bulk
X-list: linux-mips

--=-=-=

Hi all,

As part of my effort to get my R4400 Indigo-2 running 2.5, I've
updated the wd33c93 driver to the new locking. I hope I didn't break
it too much in the process.

Note that this is completly untested, since my I2 still refuses to
boot 2.5.47 (dies silently after loading he kernel). As anyone
succeded in running 2.5 on this platform (sgi-ip22) ?

Thanks,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=wd33c93.patch

Index: drivers/scsi/wd33c93.c
===================================================================
RCS file: /home/cvs/linux/drivers/scsi/wd33c93.c,v
retrieving revision 1.22
diff -u -r1.22 wd33c93.c
--- drivers/scsi/wd33c93.c	2 Nov 2002 06:05:18 -0000	1.22
+++ drivers/scsi/wd33c93.c	15 Nov 2002 12:35:44 -0000
@@ -315,7 +315,6 @@
 {
    struct WD33C93_hostdata *hostdata;
    Scsi_Cmnd *tmp;
-   unsigned long flags;
 
    hostdata = (struct WD33C93_hostdata *)cmd->host->hostdata;
 
@@ -385,8 +384,7 @@
     * sense data is not lost before REQUEST_SENSE executes.
     */
 
-   save_flags(flags);
-   cli();
+   spin_lock_irq (&hostdata->lock);
 
    if (!(hostdata->input_Q) || (cmd->cmnd[0] == REQUEST_SENSE)) {
       cmd->host_scribble = (uchar *)hostdata->input_Q;
@@ -407,7 +405,7 @@
 
 DB(DB_QUEUE_COMMAND,printk(")Q-%ld ",cmd->pid))
 
-   restore_flags(flags);
+   spin_unlock_irq (&hostdata->lock);
    return 0;
 }
 
@@ -765,7 +763,7 @@
    if (!(asr & ASR_INT) || (asr & ASR_BSY))
       return;
 
-   save_flags(flags);
+   spin_lock_irqsave (&hostdata->lock, flags);
 
 #ifdef PROC_STATISTICS
    hostdata->int_cnt++;
@@ -831,7 +829,7 @@
      * is here...
      */
 
-    restore_flags(flags);
+	 spin_unlock_irqrestore (&hostdata->lock, flags);
 
 /* We are not connected to a target - check to see if there
  * are commands waiting to be executed.
@@ -885,7 +883,8 @@
             hostdata->outgoing_len = 1;
 
          hostdata->state = S_CONNECTED;
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
       case CSR_XFER_DONE|PHS_DATA_IN:
@@ -895,7 +894,8 @@
          transfer_bytes(regs, cmd, DATA_IN_DIR);
          if (hostdata->state != S_RUNNING_LEVEL2)
             hostdata->state = S_CONNECTED;
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
       case CSR_XFER_DONE|PHS_DATA_OUT:
@@ -905,7 +905,8 @@
          transfer_bytes(regs, cmd, DATA_OUT_DIR);
          if (hostdata->state != S_RUNNING_LEVEL2)
             hostdata->state = S_CONNECTED;
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
 /* Note: this interrupt should not occur in a LEVEL2 command */
@@ -916,7 +917,8 @@
 DB(DB_INTR,printk("CMND-%02x,%ld",cmd->cmnd[0],cmd->pid))
          transfer_pio(regs, cmd->cmnd, cmd->cmd_len, DATA_OUT_DIR, hostdata);
          hostdata->state = S_CONNECTED;
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
       case CSR_XFER_DONE|PHS_STATUS:
@@ -935,7 +937,8 @@
          else {
             hostdata->state = S_CONNECTED;
             }
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
       case CSR_XFER_DONE|PHS_MESS_IN:
@@ -1085,7 +1088,7 @@
                write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_CONNECTED;
             }
-         restore_flags(flags);
+	 spin_unlock_irqrestore (&hostdata->lock, flags);
          break;
 
 
@@ -1117,12 +1120,13 @@
 /* We are no longer  connected to a target - check to see if
  * there are commands waiting to be executed.
  */
-       restore_flags(flags);
+	    spin_unlock_irqrestore (&hostdata->lock, flags);
             wd33c93_execute(instance);
             }
          else {
             printk("%02x:%02x:%02x-%ld: Unknown SEL_XFER_DONE phase!!---",asr,sr,phs,cmd->pid);
-            }
+            spin_unlock_irqrestore (&hostdata->lock, flags);
+	 }
          break;
 
 
@@ -1133,7 +1137,8 @@
             hostdata->state = S_RUNNING_LEVEL2;
             write_wd33c93(regs, WD_COMMAND_PHASE, 0x41);
             write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
       case CSR_XFER_DONE|PHS_MESS_OUT:
@@ -1163,7 +1168,8 @@
 DB(DB_INTR,printk("%02x",hostdata->outgoing_msg[0]))
          hostdata->outgoing_len = 0;
          hostdata->state = S_CONNECTED;
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+	 break;
 
 
       case CSR_UNEXP_DISC:
@@ -1184,7 +1190,8 @@
          if (cmd == NULL) {
             printk(" - Already disconnected! ");
             hostdata->state = S_UNCONNECTED;
-            return;
+            spin_unlock_irqrestore (&hostdata->lock, flags);
+	    return;
             }
 DB(DB_INTR,printk("UNEXP_DISC-%ld",cmd->pid))
          hostdata->connected = NULL;
@@ -1200,7 +1207,7 @@
  * there are commands waiting to be executed.
  */
     /* look above for comments on scsi_done() */
-    restore_flags(flags);
+	 spin_unlock_irqrestore (&hostdata->lock, flags);
          wd33c93_execute(instance);
          break;
 
@@ -1228,7 +1235,6 @@
                else
                   cmd->result = cmd->SCp.Status | (cmd->SCp.Message << 8);
                cmd->scsi_done(cmd);
-          restore_flags(flags);
                break;
             case S_PRE_TMP_DISC:
             case S_RUNNING_LEVEL2:
@@ -1250,6 +1256,7 @@
 /* We are no longer connected to a target - check to see if
  * there are commands waiting to be executed.
  */
+	 spin_unlock_irqrestore (&hostdata->lock, flags);
          wd33c93_execute(instance);
          break;
 
@@ -1367,7 +1374,8 @@
 
          if (!cmd) {
             printk("---TROUBLE: target %d.%d not in disconnect queue---",id,lun);
-            return;
+            spin_unlock_irqrestore (&hostdata->lock, flags);
+	    return;
             }
 
    /* Ok, found the command - now start it up again. */
@@ -1397,10 +1405,12 @@
             hostdata->state = S_CONNECTED;
 
 DB(DB_INTR,printk("-%ld",cmd->pid))
-         break;
+         spin_unlock_irqrestore (&hostdata->lock, flags);
+ break;
          
       default:
          printk("--UNKNOWN INTERRUPT:%02x:%02x:%02x--",asr,sr,phs);
+	 spin_unlock_irqrestore (&hostdata->lock, flags);
       }
 
 DB(DB_INTR,printk("} "))
@@ -1850,12 +1860,9 @@
 #endif
 
 
-   { unsigned long flags;
-     save_flags(flags);
-     cli();
-     reset_wd33c93(instance);
-     restore_flags(flags);
-   }
+   spin_lock_irq (&hostdata->lock);
+   reset_wd33c93(instance);
+   spin_unlock_irq (&hostdata->lock);
 
    printk("wd33c93-%d: chip=%s/%d no_sync=0x%x no_dma=%d",instance->host_no,
          (hostdata->chip==C_WD33C93)?"WD33c93":
@@ -1884,7 +1891,6 @@
 
 char *bp;
 char tbuf[128];
-unsigned long flags;
 struct Scsi_Host *instance;
 struct WD33C93_hostdata *hd;
 Scsi_Cmnd *cmd;
@@ -1949,8 +1955,7 @@
       return len;
       }
 
-   save_flags(flags);
-   cli();
+   spin_lock_irq (&hd->lock);
    bp = buf;
    *bp = '\0';
    if (hd->proc & PR_VERSION) {
@@ -2025,7 +2030,7 @@
          }
       }
    strcat(bp,"\n");
-   restore_flags(flags);
+   spin_unlock_irq (&hd->lock);
    *start = buf;
    if (stop) {
       stop = 0;
Index: drivers/scsi/wd33c93.h
===================================================================
RCS file: /home/cvs/linux/drivers/scsi/wd33c93.h,v
retrieving revision 1.9
diff -u -r1.9 wd33c93.h
--- drivers/scsi/wd33c93.h	29 May 2002 08:12:10 -0000	1.9
+++ drivers/scsi/wd33c93.h	15 Nov 2002 12:35:45 -0000
@@ -217,6 +217,7 @@
 struct WD33C93_hostdata {
     struct Scsi_Host *next;
     wd33c93_regs     regs;
+    spinlock_t       lock;
     uchar            clock_freq;
     uchar            chip;             /* what kind of wd33c93? */
     uchar            microcode;        /* microcode rev */

--=-=-=

-- 
Places change, faces change. Life is so very strange.

--=-=-=--
