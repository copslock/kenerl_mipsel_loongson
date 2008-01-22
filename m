Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 19:42:47 +0000 (GMT)
Received: from sovereign.computergmbh.de ([85.214.69.204]:45467 "EHLO
	sovereign.computergmbh.de") by ftp.linux-mips.org with ESMTP
	id S28590079AbYAVTmi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 19:42:38 +0000
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 28B69180C8375; Tue, 22 Jan 2008 20:42:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 2279D1CD7695E;
	Tue, 22 Jan 2008 20:42:33 +0100 (CET)
Date:	Tue, 22 Jan 2008 20:42:33 +0100 (CET)
From:	Jan Engelhardt <jengelh@computergmbh.de>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS]: constify function pointer tables
In-Reply-To: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
Message-ID: <Pine.LNX.4.64.0801222042100.5722@fbirervta.pbzchgretzou.qr>
References: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jengelh@computergmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jengelh@computergmbh.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
---
 arch/mips/basler/excite/excite_iodev.c |    2 +-
 arch/mips/kernel/proc.c                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/basler/excite/excite_iodev.c b/arch/mips/basler/excite/excite_iodev.c
index 6af0b21..476d20e 100644
--- a/arch/mips/basler/excite/excite_iodev.c
+++ b/arch/mips/basler/excite/excite_iodev.c
@@ -48,7 +48,7 @@ static DECLARE_WAIT_QUEUE_HEAD(wq);
 
 
 
-static struct file_operations fops =
+static const struct file_operations fops =
 {
 	.owner		= THIS_MODULE,
 	.open		= iodev_open,
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 6e6e947..f30e035 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -89,7 +89,7 @@ static void c_stop(struct seq_file *m, void *v)
 {
 }
 
-struct seq_operations cpuinfo_op = {
+const struct seq_operations cpuinfo_op = {
 	.start	= c_start,
 	.next	= c_next,
 	.stop	= c_stop,
-- 
1.5.3.4
