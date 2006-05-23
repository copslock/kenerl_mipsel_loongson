Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 15:40:04 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:925 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133732AbWEWNj4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 May 2006 15:39:56 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FiX3P-0007Am-L3
	for linux-mips@linux-mips.org; Tue, 23 May 2006 15:36:07 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FiX7M-00015x-7y
	for linux-mips@linux-mips.org; Tue, 23 May 2006 15:40:12 +0200
Date:	Tue, 23 May 2006 15:40:12 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060523134012.GB28124@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Late console
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

due my job on sleep I need the serial console till sleep time so let
me propose this patch that disables serial port suspend if a console
is running on it and the kernel has CONFIG_DEBUG_KERNEL flag on.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1x00-late-console

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 9e27aee..27ed4f2 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1919,6 +1919,14 @@ int uart_suspend_port(struct uart_driver
 {
 	struct uart_state *state = drv->state + port->line;
 
+#ifdef CONFIG_DEBUG_KERNEL
+	if (uart_console(port)) {
+		printk(KERN_INFO "warning! Serial console %s%d is not disabled in debug kernel mode\n",
+			drv->dev_name, port->line);
+		return 0;
+	}
+#endif
+
 	mutex_lock(&state->mutex);
 
 	if (state->info && state->info->flags & UIF_INITIALIZED) {

--5vNYLRcllDrimb99--
