Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 20:26:03 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:64678 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903777Ab2B1TZG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 20:25:06 +0100
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1SJOuvT014095;
        Tue, 28 Feb 2012 11:24:59 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/5] serial: MIPS swarm sb1250-duart.c driver needs module.h
Date:   Tue, 28 Feb 2012 14:24:45 -0500
Message-Id: <1330457088-14587-3-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
X-archive-position: 32573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This driver is a module and needs module.h, otherwise
it will break when we remove a bogus usage of module.h
from one of the other MIPS headers.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/sb1250-duart.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 0be8a2f..f76b1688 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/major.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
-- 
1.7.9.1
