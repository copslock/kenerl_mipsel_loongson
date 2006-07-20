Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 08:34:07 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:60326 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133415AbWGTHdx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 08:33:53 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1G3S3g-0002q6-9K; Thu, 20 Jul 2006 08:30:54 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1G3T2U-0002LY-4y; Thu, 20 Jul 2006 09:33:42 +0200
Date:	Thu, 20 Jul 2006 09:33:42 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-laptop@vger.kernel.org, sfr@canb.auug.org.au
Cc:	linux-mips@linux-mips.org
Message-ID: <20060720073342.GL25330@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] APM emulation reunion
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--qYrsQHciA3Wqs7Iv
Content-Type: multipart/mixed; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a patch to unify the APM enulation supports for ARM and MIPS.

I put APM emulation code into a dedicated directory so it can be used
to put there the APM-emu per board specific code. For instance on my
system I added the following lines to the "Kconfig" file:

   config CONFIG_WWPC1000_APM_EMU
          tristate "APM support for WWPC1000"
          depends APM_EMU
          default y

The kernel configuration file is now unique and not duplicated
anymore.

Also I modified the configuration define "CONFIG_APM" to
"CONFIG_APM_EMU" in order to avoid conflicts with real APM
support. Doing like this these boards' configuration files should be
updated:

   arch/arm/configs/bast_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/collie_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/corgi_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/ixp4xx_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/neponset_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/s3c2410_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/simpad_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/spitz_defconfig:CONFIG_APM=3Dy
   arch/arm/configs/trizeps4_defconfig:CONFIG_APM=3Dy

Ciao,

Rodolfo

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-apm-emu-reunion
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f81a623..d039838 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -797,32 +797,7 @@ menu "Power management options"
=20
 source "kernel/power/Kconfig"
=20
-config APM
-	tristate "Advanced Power Management Emulation"
-	---help---
-	  APM is a BIOS specification for saving power using several different
-	  techniques. This is mostly useful for battery powered laptops with
-	  APM compliant BIOSes. If you say Y here, the system time will be
-	  reset after a RESUME operation, the /proc/apm device will provide
-	  battery status information, and user-space programs will receive
-	  notification of APM "events" (e.g. battery status change).
-
-	  In order to use APM, you will need supporting software. For location
-	  and more information, read <file:Documentation/pm.txt> and the
-	  Battery Powered Linux mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  This driver does not spin down disk drives (see the hdparm(8)
-	  manpage ("man 8 hdparm") for that), and it doesn't turn off
-	  VESA-compliant "green" monitors.
-
-	  Generally, if you don't have a battery in your machine, there isn't
-	  much point in using this driver and you should say N. If you get
-	  random kernel OOPSes or reboots that don't seem to be related to
-	  anything, try disabling/enabling this option (or disabling/enabling
-	  APM in your BIOS).
-
-endmenu
+source "drivers/apm-emu/Kconfig"
=20
 source "net/Kconfig"
=20
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index f0c0cdb..fe7d480 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -10,7 +10,6 @@ obj-y		:=3D compat.o entry-armv.o entry-co
 		   process.o ptrace.o semaphore.o setup.o signal.o sys_arm.o \
 		   time.o traps.o
=20
-obj-$(CONFIG_APM)		+=3D apm.o
 obj-$(CONFIG_ISA_DMA_API)	+=3D dma.o
 obj-$(CONFIG_ARCH_ACORN)	+=3D ecard.o=20
 obj-$(CONFIG_FOOTBRIDGE)	+=3D isa.o
diff --git a/arch/arm/kernel/apm.c b/arch/arm/kernel/apm.c
deleted file mode 100644
index 33c5568..0000000
--- a/arch/arm/kernel/apm.c
+++ /dev/null
@@ -1,604 +0,0 @@
-/*
- * bios-less APM driver for ARM Linux=20
- *  Jamey Hicks <jamey@crl.dec.com>
- *  adapted from the APM BIOS driver for Linux by Stephen Rothwell (sfr@li=
nuxcare.com)
- *
- * APM 1.2 Reference:
- *   Intel Corporation, Microsoft Corporation. Advanced Power Management
- *   (APM) BIOS Interface Specification, Revision 1.2, February 1996.
- *
- * [This document is available from Microsoft at:
- *    http://www.microsoft.com/hwdev/busbios/amp_12.htm]
- */
-#include <linux/module.h>
-#include <linux/poll.h>
-#include <linux/timer.h>
-#include <linux/slab.h>
-#include <linux/proc_fs.h>
-#include <linux/miscdevice.h>
-#include <linux/apm_bios.h>
-#include <linux/capability.h>
-#include <linux/sched.h>
-#include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/init.h>
-#include <linux/completion.h>
-
-#include <asm/apm.h> /* apm_power_info */
-#include <asm/system.h>
-
-/*
- * The apm_bios device is one of the misc char devices.
- * This is its minor number.
- */
-#define APM_MINOR_DEV	134
-
-/*
- * See Documentation/Config.help for the configuration options.
- *
- * Various options can be changed at boot time as follows:
- * (We allow underscores for compatibility with the modules code)
- *	apm=3Don/off			enable/disable APM
- */
-
-/*
- * Maximum number of events stored
- */
-#define APM_MAX_EVENTS		16
-
-struct apm_queue {
-	unsigned int		event_head;
-	unsigned int		event_tail;
-	apm_event_t		events[APM_MAX_EVENTS];
-};
-
-/*
- * The per-file APM data
- */
-struct apm_user {
-	struct list_head	list;
-
-	unsigned int		suser: 1;
-	unsigned int		writer: 1;
-	unsigned int		reader: 1;
-
-	int			suspend_result;
-	unsigned int		suspend_state;
-#define SUSPEND_NONE	0		/* no suspend pending */
-#define SUSPEND_PENDING	1		/* suspend pending read */
-#define SUSPEND_READ	2		/* suspend read, pending ack */
-#define SUSPEND_ACKED	3		/* suspend acked */
-#define SUSPEND_DONE	4		/* suspend completed */
-
-	struct apm_queue	queue;
-};
-
-/*
- * Local variables
- */
-static int suspends_pending;
-static int apm_disabled;
-static int arm_apm_active;
-
-static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
-static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
-
-/*
- * This is a list of everyone who has opened /dev/apm_bios
- */
-static DECLARE_RWSEM(user_list_lock);
-static LIST_HEAD(apm_user_list);
-
-/*
- * kapmd info.  kapmd provides us a process context to handle
- * "APM" events within - specifically necessary if we're going
- * to be suspending the system.
- */
-static DECLARE_WAIT_QUEUE_HEAD(kapmd_wait);
-static DECLARE_COMPLETION(kapmd_exit);
-static DEFINE_SPINLOCK(kapmd_queue_lock);
-static struct apm_queue kapmd_queue;
-
-
-static const char driver_version[] =3D "1.13";	/* no spaces */
-
-
-
-/*
- * Compatibility cruft until the IPAQ people move over to the new
- * interface.
- */
-static void __apm_get_power_status(struct apm_power_info *info)
-{
-}
-
-/*
- * This allows machines to provide their own "apm get power status" functi=
on.
- */
-void (*apm_get_power_status)(struct apm_power_info *) =3D __apm_get_power_=
status;
-EXPORT_SYMBOL(apm_get_power_status);
-
-
-/*
- * APM event queue management.
- */
-static inline int queue_empty(struct apm_queue *q)
-{
-	return q->event_head =3D=3D q->event_tail;
-}
-
-static inline apm_event_t queue_get_event(struct apm_queue *q)
-{
-	q->event_tail =3D (q->event_tail + 1) % APM_MAX_EVENTS;
-	return q->events[q->event_tail];
-}
-
-static void queue_add_event(struct apm_queue *q, apm_event_t event)
-{
-	q->event_head =3D (q->event_head + 1) % APM_MAX_EVENTS;
-	if (q->event_head =3D=3D q->event_tail) {
-		static int notified;
-
-		if (notified++ =3D=3D 0)
-		    printk(KERN_ERR "apm: an event queue overflowed\n");
-		q->event_tail =3D (q->event_tail + 1) % APM_MAX_EVENTS;
-	}
-	q->events[q->event_head] =3D event;
-}
-
-static void queue_event_one_user(struct apm_user *as, apm_event_t event)
-{
-	if (as->suser && as->writer) {
-		switch (event) {
-		case APM_SYS_SUSPEND:
-		case APM_USER_SUSPEND:
-			/*
-			 * If this user already has a suspend pending,
-			 * don't queue another one.
-			 */
-			if (as->suspend_state !=3D SUSPEND_NONE)
-				return;
-
-			as->suspend_state =3D SUSPEND_PENDING;
-			suspends_pending++;
-			break;
-		}
-	}
-	queue_add_event(&as->queue, event);
-}
-
-static void queue_event(apm_event_t event, struct apm_user *sender)
-{
-	struct apm_user *as;
-
-	down_read(&user_list_lock);
-	list_for_each_entry(as, &apm_user_list, list) {
-		if (as !=3D sender && as->reader)
-			queue_event_one_user(as, event);
-	}
-	up_read(&user_list_lock);
-	wake_up_interruptible(&apm_waitqueue);
-}
-
-static void apm_suspend(void)
-{
-	struct apm_user *as;
-	int err =3D pm_suspend(PM_SUSPEND_MEM);
-
-	/*
-	 * Anyone on the APM queues will think we're still suspended.
-	 * Send a message so everyone knows we're now awake again.
-	 */
-	queue_event(APM_NORMAL_RESUME, NULL);
-
-	/*
-	 * Finally, wake up anyone who is sleeping on the suspend.
-	 */
-	down_read(&user_list_lock);
-	list_for_each_entry(as, &apm_user_list, list) {
-		as->suspend_result =3D err;
-		as->suspend_state =3D SUSPEND_DONE;
-	}
-	up_read(&user_list_lock);
-
-	wake_up(&apm_suspend_waitqueue);
-}
-
-static ssize_t apm_read(struct file *fp, char __user *buf, size_t count, l=
off_t *ppos)
-{
-	struct apm_user *as =3D fp->private_data;
-	apm_event_t event;
-	int i =3D count, ret =3D 0;
-
-	if (count < sizeof(apm_event_t))
-		return -EINVAL;
-
-	if (queue_empty(&as->queue) && fp->f_flags & O_NONBLOCK)
-		return -EAGAIN;
-
-	wait_event_interruptible(apm_waitqueue, !queue_empty(&as->queue));
-
-	while ((i >=3D sizeof(event)) && !queue_empty(&as->queue)) {
-		event =3D queue_get_event(&as->queue);
-
-		ret =3D -EFAULT;
-		if (copy_to_user(buf, &event, sizeof(event)))
-			break;
-
-		if (event =3D=3D APM_SYS_SUSPEND || event =3D=3D APM_USER_SUSPEND)
-			as->suspend_state =3D SUSPEND_READ;
-
-		buf +=3D sizeof(event);
-		i -=3D sizeof(event);
-	}
-
-	if (i < count)
-		ret =3D count - i;
-
-	return ret;
-}
-
-static unsigned int apm_poll(struct file *fp, poll_table * wait)
-{
-	struct apm_user *as =3D fp->private_data;
-
-	poll_wait(fp, &apm_waitqueue, wait);
-	return queue_empty(&as->queue) ? 0 : POLLIN | POLLRDNORM;
-}
-
-/*
- * apm_ioctl - handle APM ioctl
- *
- * APM_IOC_SUSPEND
- *   This IOCTL is overloaded, and performs two functions.  It is used to:
- *     - initiate a suspend
- *     - acknowledge a suspend read from /dev/apm_bios.
- *   Only when everyone who has opened /dev/apm_bios with write permission
- *   has acknowledge does the actual suspend happen.
- */
-static int
-apm_ioctl(struct inode * inode, struct file *filp, u_int cmd, u_long arg)
-{
-	struct apm_user *as =3D filp->private_data;
-	unsigned long flags;
-	int err =3D -EINVAL;
-
-	if (!as->suser || !as->writer)
-		return -EPERM;
-
-	switch (cmd) {
-	case APM_IOC_SUSPEND:
-		as->suspend_result =3D -EINTR;
-
-		if (as->suspend_state =3D=3D SUSPEND_READ) {
-			/*
-			 * If we read a suspend command from /dev/apm_bios,
-			 * then the corresponding APM_IOC_SUSPEND ioctl is
-			 * interpreted as an acknowledge.
-			 */
-			as->suspend_state =3D SUSPEND_ACKED;
-			suspends_pending--;
-		} else {
-			/*
-			 * Otherwise it is a request to suspend the system.
-			 * Queue an event for all readers, and expect an
-			 * acknowledge from all writers who haven't already
-			 * acknowledged.
-			 */
-			queue_event(APM_USER_SUSPEND, as);
-		}
-
-		/*
-		 * If there are no further acknowledges required, suspend
-		 * the system.
-		 */
-		if (suspends_pending =3D=3D 0)
-			apm_suspend();
-
-		/*
-		 * Wait for the suspend/resume to complete.  If there are
-		 * pending acknowledges, we wait here for them.
-		 *
-		 * Note that we need to ensure that the PM subsystem does
-		 * not kick us out of the wait when it suspends the threads.
-		 */
-		flags =3D current->flags;
-		current->flags |=3D PF_NOFREEZE;
-
-		/*
-		 * Note: do not allow a thread which is acking the suspend
-		 * to escape until the resume is complete.
-		 */
-		if (as->suspend_state =3D=3D SUSPEND_ACKED)
-			wait_event(apm_suspend_waitqueue,
-					 as->suspend_state =3D=3D SUSPEND_DONE);
-		else
-			wait_event_interruptible(apm_suspend_waitqueue,
-					 as->suspend_state =3D=3D SUSPEND_DONE);
-
-		current->flags =3D flags;
-		err =3D as->suspend_result;
-		as->suspend_state =3D SUSPEND_NONE;
-		break;
-	}
-
-	return err;
-}
-
-static int apm_release(struct inode * inode, struct file * filp)
-{
-	struct apm_user *as =3D filp->private_data;
-	filp->private_data =3D NULL;
-
-	down_write(&user_list_lock);
-	list_del(&as->list);
-	up_write(&user_list_lock);
-
-	/*
-	 * We are now unhooked from the chain.  As far as new
-	 * events are concerned, we no longer exist.  However, we
-	 * need to balance suspends_pending, which means the
-	 * possibility of sleeping.
-	 */
-	if (as->suspend_state !=3D SUSPEND_NONE) {
-		suspends_pending -=3D 1;
-		if (suspends_pending =3D=3D 0)
-			apm_suspend();
-	}
-
-	kfree(as);
-	return 0;
-}
-
-static int apm_open(struct inode * inode, struct file * filp)
-{
-	struct apm_user *as;
-
-	as =3D (struct apm_user *)kzalloc(sizeof(*as), GFP_KERNEL);
-	if (as) {
-		/*
-		 * XXX - this is a tiny bit broken, when we consider BSD
-		 * process accounting. If the device is opened by root, we
-		 * instantly flag that we used superuser privs. Who knows,
-		 * we might close the device immediately without doing a
-		 * privileged operation -- cevans
-		 */
-		as->suser =3D capable(CAP_SYS_ADMIN);
-		as->writer =3D (filp->f_mode & FMODE_WRITE) =3D=3D FMODE_WRITE;
-		as->reader =3D (filp->f_mode & FMODE_READ) =3D=3D FMODE_READ;
-
-		down_write(&user_list_lock);
-		list_add(&as->list, &apm_user_list);
-		up_write(&user_list_lock);
-
-		filp->private_data =3D as;
-	}
-
-	return as ? 0 : -ENOMEM;
-}
-
-static struct file_operations apm_bios_fops =3D {
-	.owner		=3D THIS_MODULE,
-	.read		=3D apm_read,
-	.poll		=3D apm_poll,
-	.ioctl		=3D apm_ioctl,
-	.open		=3D apm_open,
-	.release	=3D apm_release,
-};
-
-static struct miscdevice apm_device =3D {
-	.minor		=3D APM_MINOR_DEV,
-	.name		=3D "apm_bios",
-	.fops		=3D &apm_bios_fops
-};
-
-
-#ifdef CONFIG_PROC_FS
-/*
- * Arguments, with symbols from linux/apm_bios.h.
- *
- *   0) Linux driver version (this will change if format changes)
- *   1) APM BIOS Version.  Usually 1.0, 1.1 or 1.2.
- *   2) APM flags from APM Installation Check (0x00):
- *	bit 0: APM_16_BIT_SUPPORT
- *	bit 1: APM_32_BIT_SUPPORT
- *	bit 2: APM_IDLE_SLOWS_CLOCK
- *	bit 3: APM_BIOS_DISABLED
- *	bit 4: APM_BIOS_DISENGAGED
- *   3) AC line status
- *	0x00: Off-line
- *	0x01: On-line
- *	0x02: On backup power (BIOS >=3D 1.1 only)
- *	0xff: Unknown
- *   4) Battery status
- *	0x00: High
- *	0x01: Low
- *	0x02: Critical
- *	0x03: Charging
- *	0x04: Selected battery not present (BIOS >=3D 1.2 only)
- *	0xff: Unknown
- *   5) Battery flag
- *	bit 0: High
- *	bit 1: Low
- *	bit 2: Critical
- *	bit 3: Charging
- *	bit 7: No system battery
- *	0xff: Unknown
- *   6) Remaining battery life (percentage of charge):
- *	0-100: valid
- *	-1: Unknown
- *   7) Remaining battery life (time units):
- *	Number of remaining minutes or seconds
- *	-1: Unknown
- *   8) min =3D minutes; sec =3D seconds
- */
-static int apm_get_info(char *buf, char **start, off_t fpos, int length)
-{
-	struct apm_power_info info;
-	char *units;
-	int ret;
-
-	info.ac_line_status =3D 0xff;
-	info.battery_status =3D 0xff;
-	info.battery_flag   =3D 0xff;
-	info.battery_life   =3D -1;
-	info.time	    =3D -1;
-	info.units	    =3D -1;
-
-	if (apm_get_power_status)
-		apm_get_power_status(&info);
-
-	switch (info.units) {
-	default:	units =3D "?";	break;
-	case 0: 	units =3D "min";	break;
-	case 1: 	units =3D "sec";	break;
-	}
-
-	ret =3D sprintf(buf, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
-		     driver_version, APM_32_BIT_SUPPORT,
-		     info.ac_line_status, info.battery_status,
-		     info.battery_flag, info.battery_life,
-		     info.time, units);
-
- 	return ret;
-}
-#endif
-
-static int kapmd(void *arg)
-{
-	daemonize("kapmd");
-	current->flags |=3D PF_NOFREEZE;
-
-	do {
-		apm_event_t event;
-
-		wait_event_interruptible(kapmd_wait,
-				!queue_empty(&kapmd_queue) || !arm_apm_active);
-
-		if (!arm_apm_active)
-			break;
-
-		spin_lock_irq(&kapmd_queue_lock);
-		event =3D 0;
-		if (!queue_empty(&kapmd_queue))
-			event =3D queue_get_event(&kapmd_queue);
-		spin_unlock_irq(&kapmd_queue_lock);
-
-		switch (event) {
-		case 0:
-			break;
-
-		case APM_LOW_BATTERY:
-		case APM_POWER_STATUS_CHANGE:
-			queue_event(event, NULL);
-			break;
-
-		case APM_USER_SUSPEND:
-		case APM_SYS_SUSPEND:
-			queue_event(event, NULL);
-			if (suspends_pending =3D=3D 0)
-				apm_suspend();
-			break;
-
-		case APM_CRITICAL_SUSPEND:
-			apm_suspend();
-			break;
-		}
-	} while (1);
-
-	complete_and_exit(&kapmd_exit, 0);
-}
-
-static int __init apm_init(void)
-{
-	int ret;
-
-	if (apm_disabled) {
-		printk(KERN_NOTICE "apm: disabled on user request.\n");
-		return -ENODEV;
-	}
-
-	arm_apm_active =3D 1;
-
-	ret =3D kernel_thread(kapmd, NULL, CLONE_KERNEL);
-	if (ret < 0) {
-		arm_apm_active =3D 0;
-		return ret;
-	}
-
-#ifdef CONFIG_PROC_FS
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
-#endif
-
-	ret =3D misc_register(&apm_device);
-	if (ret !=3D 0) {
-		remove_proc_entry("apm", NULL);
-
-		arm_apm_active =3D 0;
-		wake_up(&kapmd_wait);
-		wait_for_completion(&kapmd_exit);
-	}
-
-	return ret;
-}
-
-static void __exit apm_exit(void)
-{
-	misc_deregister(&apm_device);
-	remove_proc_entry("apm", NULL);
-
-	arm_apm_active =3D 0;
-	wake_up(&kapmd_wait);
-	wait_for_completion(&kapmd_exit);
-}
-
-module_init(apm_init);
-module_exit(apm_exit);
-
-MODULE_AUTHOR("Stephen Rothwell");
-MODULE_DESCRIPTION("Advanced Power Management");
-MODULE_LICENSE("GPL");
-
-#ifndef MODULE
-static int __init apm_setup(char *str)
-{
-	while ((str !=3D NULL) && (*str !=3D '\0')) {
-		if (strncmp(str, "off", 3) =3D=3D 0)
-			apm_disabled =3D 1;
-		if (strncmp(str, "on", 2) =3D=3D 0)
-			apm_disabled =3D 0;
-		str =3D strchr(str, ',');
-		if (str !=3D NULL)
-			str +=3D strspn(str, ", \t");
-	}
-	return 1;
-}
-
-__setup("apm=3D", apm_setup);
-#endif
-
-/**
- * apm_queue_event - queue an APM event for kapmd
- * @event: APM event
- *
- * Queue an APM event for kapmd to process and ultimately take the
- * appropriate action.  Only a subset of events are handled:
- *   %APM_LOW_BATTERY
- *   %APM_POWER_STATUS_CHANGE
- *   %APM_USER_SUSPEND
- *   %APM_SYS_SUSPEND
- *   %APM_CRITICAL_SUSPEND
- */
-void apm_queue_event(apm_event_t event)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&kapmd_queue_lock, flags);
-	queue_add_event(&kapmd_queue, event);
-	spin_unlock_irqrestore(&kapmd_queue_lock, flags);
-
-	wake_up_interruptible(&kapmd_wait);
-}
-EXPORT_SYMBOL(apm_queue_event);
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 309757a..ccdee59 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2018,35 +2018,15 @@ config SECCOMP
=20
 	  If unsure, say Y. Only embedded should say N here.
=20
-config PM
-	bool "Power Management support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOC_AU1X00
-
-config APM
-        tristate "Advanced Power Management Emulation"
-	depends on PM
-        ---help---
-	  APM is a BIOS specification for saving power using several different
-	  techniques. This is mostly useful for battery powered systems with
-	  APM compliant BIOSes. If you say Y here, the system time will be
-	  reset after a RESUME operation, the /proc/apm device will provide
-	  battery status information, and user-space programs will receive
-	  notification of APM "events" (e.g. battery status change).
-
-	  In order to use APM, you will need supporting software. For location
-	  and more information, read <file:Documentation/pm.txt> and the
-	  Battery Powered Linux mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  This driver does not spin down disk drives (see the hdparm(8)
-	  manpage ("man 8 hdparm") for that), and it doesn't turn off
-	  VESA-compliant "green" monitors.
-
-	  Generally, if you don't have a battery in your machine, there isn't
-	  much point in using this driver and you should say N. If you get
-	  random kernel OOPSes or reboots that don't seem to be related to
-	  anything, try disabling/enabling this option (or disabling/enabling
-	  APM in your BIOS).
+endmenu
+
+menu "Power management options"
+
+if SOC_AU1X00
+source "kernel/power/Kconfig"
+endif
+
+source "drivers/apm-emu/Kconfig"
=20
 endmenu
=20
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 881c467..34e8a25 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -13,8 +13,6 @@ binfmt_irix-objs	:=3D irixelf.o irixinv.o=20
=20
 obj-$(CONFIG_MODULES)		+=3D mips_ksyms.o module.o
=20
-obj-$(CONFIG_APM)		+=3D apm.o
-
 obj-$(CONFIG_CPU_R3000)		+=3D r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+=3D r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX49XX)	+=3D r4k_fpu.o r4k_switch.o
diff --git a/drivers/Makefile b/drivers/Makefile
index fc2d744..c3c2abd 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PARISC)		+=3D parisc/
 obj-$(CONFIG_RAPIDIO)		+=3D rapidio/
 obj-y				+=3D video/
 obj-$(CONFIG_ACPI)		+=3D acpi/
+obj-$(CONFIG_APM_EMU)		+=3D apm-emu/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+=3D pnp/
diff --git a/drivers/apm-emu/Kconfig b/drivers/apm-emu/Kconfig
new file mode 100644
index 0000000..a37f1cc
--- /dev/null
+++ b/drivers/apm-emu/Kconfig
@@ -0,0 +1,25 @@
+#
+# APM Emulator Configuration
+#
+
+config APM_EMU
+        tristate "Advanced Power Management (APM) Emulation"
+        ---help---
+	  APM is a BIOS specification for saving power using several different
+	  techniques. This is mostly useful for battery powered systems with
+	  APM compliant BIOSes. If you say Y here, the system time will be
+	  reset after a RESUME operation, the /proc/apm device will provide
+	  battery status information, and user-space programs will receive
+	  notification of APM "events" (e.g. battery status change).
+
+	  In order to use APM, you will need supporting software. For location
+	  and more information, read <file:Documentation/pm.txt> and the
+	  Battery Powered Linux mini-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  Please, note that this driver is just an emulation of BIOS APM, so
+	  you have to add specific support for your board in order to make
+	  it work.
+
+	  Generally, if you don't have a battery in your machine, there isn't
+	  much point in using this driver and you should say N.
diff --git a/drivers/apm-emu/Makefile b/drivers/apm-emu/Makefile
new file mode 100644
index 0000000..751ce37
--- /dev/null
+++ b/drivers/apm-emu/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Linux APM Emulator
+#
+
+obj-$(CONFIG_APM_EMU)               +=3D apm-emu.o
diff --git a/arch/mips/kernel/apm.c b/drivers/apm-emu/apm-emu.c
similarity index 90%
rename from arch/mips/kernel/apm.c
rename to drivers/apm-emu/apm-emu.c
index 528e731..e96dccf 100644
--- a/arch/mips/kernel/apm.c
+++ b/drivers/apm-emu/apm-emu.c
@@ -1,15 +1,39 @@
 /*
- * bios-less APM driver for MIPS Linux
- *  Jamey Hicks <jamey@crl.dec.com>
- *  adapted from the APM BIOS driver for Linux by Stephen Rothwell (sfr@li=
nuxcare.com)
+ * Generic bios-less APM driver for Linux
  *
- * APM 1.2 Reference:
- *   Intel Corporation, Microsoft Corporation. Advanced Power Management
- *   (APM) BIOS Interface Specification, Revision 1.2, February 1996.
+ * Derived from "arch/arm/kernel/apm.c" and generalized by
+ *  Rodolfo Giometti <giometti@linux.it>
  *
- * [This document is available from Microsoft at:
- *    http://www.microsoft.com/hwdev/busbios/amp_12.htm]
+ * Copyright 2006 Rodolfo Giometti <giometti@linux.it>
+ *
+ * Original copyright message:
+ *
+ *   bios-less APM driver for ARM Linux
+ *    Jamey Hicks <jamey@crl.dec.com>
+ *    adapted from the APM BIOS driver for Linux by
+ *    Stephen Rothwell (sfr@linuxcare.com)
+ *
+ *   APM 1.2 Reference:
+ *     Intel Corporation, Microsoft Corporation. Advanced Power Management
+ *     (APM) BIOS Interface Specification, Revision 1.2, February 1996.
+ *
+ *   [This document is available from Microsoft at:
+ *      http://www.microsoft.com/hwdev/busbios/amp_12.htm]
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
  */
+
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/timer.h>
@@ -80,7 +104,7 @@ #define SUSPEND_DONE	4		/* suspend compl
  */
 static int suspends_pending;
 static int apm_disabled;
-static int mips_apm_active;
+static int apm_emu_active;
=20
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
@@ -475,9 +499,9 @@ static int kapmd(void *arg)
 		apm_event_t event;
=20
 		wait_event_interruptible(kapmd_wait,
-				!queue_empty(&kapmd_queue) || !mips_apm_active);
+				!queue_empty(&kapmd_queue) || !apm_emu_active);
=20
-		if (!mips_apm_active)
+		if (!apm_emu_active)
 			break;
=20
 		spin_lock_irq(&kapmd_queue_lock);
@@ -520,11 +544,11 @@ static int __init apm_init(void)
 		return -ENODEV;
 	}
=20
-	mips_apm_active =3D 1;
+	apm_emu_active =3D 1;
=20
 	ret =3D kernel_thread(kapmd, NULL, CLONE_KERNEL);
 	if (ret < 0) {
-		mips_apm_active =3D 0;
+		apm_emu_active =3D 0;
 		return ret;
 	}
=20
@@ -536,7 +560,7 @@ #endif
 	if (ret !=3D 0) {
 		remove_proc_entry("apm", NULL);
=20
-		mips_apm_active =3D 0;
+		apm_emu_active =3D 0;
 		wake_up(&kapmd_wait);
 		wait_for_completion(&kapmd_exit);
 	}
@@ -549,7 +573,7 @@ static void __exit apm_exit(void)
 	misc_deregister(&apm_device);
 	remove_proc_entry("apm", NULL);
=20
-	mips_apm_active =3D 0;
+	apm_emu_active =3D 0;
 	wake_up(&kapmd_wait);
 	wait_for_completion(&kapmd_exit);
 }

--S66JdqtemGhvbcZP--

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEvzHWQaTCYNJaVjMRAi4tAKDcu4N15Oa7/p4F9OPIzfJWMHkk2QCguC1y
6T2Whm0RcdhIka7j+RWw6Yk=
=zOX5
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--
