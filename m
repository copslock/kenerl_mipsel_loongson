Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 06:54:49 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:21765
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133374AbVJTFyd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 06:54:33 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K5sWEP001281;
	Wed, 19 Oct 2005 22:54:32 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K5sWmE001278;
	Wed, 19 Oct 2005 22:54:32 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 22:54:32 -0700
To:	linux-mips@linux-mips.org
CC:	linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and write flushing
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the second part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

The Xilleon (32bit MIPS SOC) has a write back buffer that seems to
operate on the pci bus and does not get flushed before a read.  The
result is that a memory barrier must be done before a read intended to
flush PCI writes.

The second problem is that writes need to be flushed in e100_exec_cmd.

I am not sure exactly what was going wrong, but without this patch
packets in the send queue were not being sent until... Well I don't
know exactly when, but reception of packets and interrupts by other devices on
the PCI bus seemed to get them to be kicked out.

The result was that when pinging from an external host, the round trip
time was usually the same as the ping interval (i.e. one second).
This lead to very poor NFS performance.

With the patch applied the ethernet seems to work flawlessly

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Memory barriers and write flushing added for use with xilleon port.

---
commit 8817d129d5d5fc662858925aa39ddda0cb3b73a0
tree bfc8ec97ad24b9477919f861cc29fc396258dc5f
parent 7c598df35a43f53dd6704bb2490f82fcd1e28a9a
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:11:51 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:11:51 -0700

 drivers/net/e100.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -584,6 +584,7 @@ static inline void e100_write_flush(stru
 {
 	/* Flush previous PCI writes through intermediate bridges
 	 * by doing a benign read */
+	wmb();
 	(void)readb(&nic->csr->scb.status);
 }
 
@@ -807,9 +808,13 @@ static inline int e100_exec_cmd(struct n
 		goto err_unlock;
 	}
 
-	if(unlikely(cmd != cuc_resume))
+	wmb();
+	if(unlikely(cmd != cuc_resume)) {
 		writel(dma_addr, &nic->csr->scb.gen_ptr);
+		e100_write_flush(nic);
+	}
 	writeb(cmd, &nic->csr->scb.cmd_lo);
+	e100_write_flush(nic);
 
 err_unlock:
 	spin_unlock_irqrestore(&nic->cmd_lock, flags);
