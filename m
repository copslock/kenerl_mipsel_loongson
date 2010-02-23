Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 19:22:04 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:64350 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492399Ab0BWSVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 19:21:37 +0100
Received: by bwz7 with SMTP id 7so2764001bwz.24
        for <linux-mips@linux-mips.org>; Tue, 23 Feb 2010 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ljzI/qDkZ6D2HAfNAglQ6KosIhPmDgIxmqlwVxAivTU=;
        b=P2w0YcR/eyr0tJQItrFoXJNkuZPgSnBg0iVPwZ7xaQJ43hOcKh8R9rSmrPwNIdrIlQ
         Dx3q4x9lxKFrNNMNx3sFhxpibWYWCA5RBzU8XsvOieuAMDhCZFPO5e9W66LDWvab6kN2
         2TqeximnVWh9GlxGj0sNRwVaLyhetftxOAM2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JoyAfMgGloZ6OmtR7qljaJZqX6UthptmIULH21B05Dy9JV2VRVpKu3YiTtSRCBfus/
         dajR1hC7YTJ9rXmSvgT7k7KO7FbKr/aUdO0ivQZ38+DwC37TIIUWTO4pMJgk3oq3/yyy
         dhNpHIYkX5W2A4RmkxZ3YAZ+mMfigtkvXOt6A=
Received: by 10.204.9.134 with SMTP id l6mr3565425bkl.83.1266949290980;
        Tue, 23 Feb 2010 10:21:30 -0800 (PST)
Received: from localhost.localdomain (p5496C184.dip.t-dialin.net [84.150.193.132])
        by mx.google.com with ESMTPS id 15sm2041976bwz.12.2010.02.23.10.21.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 10:21:30 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux Serial <linux-serial@vger.kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 1/2] 8250: allow platform uarts to install PM callback.
Date:   Tue, 23 Feb 2010 19:22:26 +0100
Message-Id: <1266949347-12024-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
References: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The 8250 UART driver provides rudimentary UART PM support and
a callback for systems to do more sophisticated power management.
However, there is no way yet for platform_device uarts to assign
something this internal callback.

This patch adds a callback to struct plat_serial8250_port and a
function to register this callback with 8250 driver internals.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/serial/8250.c       |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h |    6 ++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index a81ff7b..7802266 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2966,7 +2966,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.serial_out		= p->serial_out;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port_with_pm(&port, p->pm);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
@@ -3078,8 +3078,10 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 }
 
 /**
- *	serial8250_register_port - register a serial port
+ *	serial8250_register_port_with_pm - register a serial port and its
+ *					   power management callback.
  *	@port: serial port template
+ *	@pm:   PM callback for this port, can be NULL.
  *
  *	Configure the serial port specified by the request. If the
  *	port exists and is in use, it is hung up and unregistered
@@ -3090,7 +3092,9 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_port(struct uart_port *port)
+int serial8250_register_port_with_pm(struct uart_port *port,
+	void(*pm)(struct uart_port *port, unsigned int state,
+		  unsigned int old))
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -3115,6 +3119,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
+		uart->pm		= pm;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
@@ -3140,6 +3145,26 @@ int serial8250_register_port(struct uart_port *port)
 
 	return ret;
 }
+EXPORT_SYMBOL(serial8250_register_port_with_pm);
+
+/**
+ *	serial8250_register_port - register a serial port
+ *	@port: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int serial8250_register_port(struct uart_port *port)
+{
+	return serial8250_register_port_with_pm(port, NULL);
+}
+
 EXPORT_SYMBOL(serial8250_register_port);
 
 /**
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index fb46aba..25cc3fb 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -14,6 +14,9 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 
+typedef void(*plat8250_pm_func_t)(struct uart_port *port, unsigned int state,
+				  unsigned int old_state);
+
 /*
  * This is the platform device platform_data structure
  */
@@ -32,6 +35,8 @@ struct plat_serial8250_port {
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
+	void 		(*pm)(struct uart_port *port, unsigned int state,
+			      unsigned int old_state);
 };
 
 /*
@@ -62,6 +67,7 @@ enum {
 struct uart_port;
 
 int serial8250_register_port(struct uart_port *);
+int serial8250_register_port_with_pm(struct uart_port *, plat8250_pm_func_t);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
-- 
1.7.0
