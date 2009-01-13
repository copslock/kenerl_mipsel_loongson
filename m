Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 20:48:01 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7732 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21364955AbZAMUr4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 20:47:56 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496cfde90000>; Tue, 13 Jan 2009 15:47:41 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 12:46:50 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 12:46:49 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n0DKkjuw030165;
	Tue, 13 Jan 2009 12:46:45 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n0DKki0V030163;
	Tue, 13 Jan 2009 12:46:44 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] 8250: Initialize more fields in early_serial_setup.
Date:	Tue, 13 Jan 2009 12:46:44 -0800
Message-Id: <1231879604-30140-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 13 Jan 2009 20:46:49.0639 (UTC) FILETIME=[0EA14370:01C975C0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The initial patch that initialized the fields individually omitted a
couple that evidently are required by mips/rb532.  This should fix it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 1889a63..e2c3a85 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2837,6 +2837,8 @@ int __init early_serial_setup(struct uart_port *port)
 	p->regshift     = port->regshift;
 	p->iotype       = port->iotype;
 	p->flags        = port->flags;
+	p->type		= port->type;
+	p->line		= port->line;
 	p->mapbase      = port->mapbase;
 	p->private_data = port->private_data;
 
-- 
1.5.6.6
