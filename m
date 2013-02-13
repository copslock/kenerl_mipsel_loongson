Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 22:41:12 +0100 (CET)
Received: from mail-ee0-f44.google.com ([74.125.83.44]:59469 "EHLO
        mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827627Ab3BMVlFS3I3Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2013 22:41:05 +0100
Received: by mail-ee0-f44.google.com with SMTP id l10so953999eei.31
        for <linux-mips@linux-mips.org>; Wed, 13 Feb 2013 13:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=JGf43I2JYRg975wQDaa2KePFFzAFZ74m/bpqIgCsU98=;
        b=NfwVTpNye9HggMTsnLL0tv6ndXKjomZOuInOwmN77A5TdfI+rdol3iDbkUrm1OTjc0
         bKnU+QumKaZhLUxjj1Iz2viCNJsOrzoXcQA9R2GgBXbueGaqdrLJnqaMctww6YBwf6LD
         ef9hAND8J6RLW8pr17pRB1k7NuyG+8/UTA5A50TgYdy/8j+WNPVxaNB8gDUpWNlXtkty
         TEt6VdkAD9Bl0DXG1J7ICFy2Vsz1ni96O+luAJPP1SsNXezRJEkY6u5oXu9EY6q25mJD
         JMHn+cIXF4yHtOtBL0pegB1DZ19hi2WWt9Ec3V300/B1lHwkLIYWui3tZl0J7MlCVP2Y
         EAIg==
X-Received: by 10.14.207.200 with SMTP id n48mr8988091eeo.4.1360791659465;
        Wed, 13 Feb 2013 13:40:59 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id r4sm30921681eeo.12.2013.02.13.13.40.57
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 13:40:58 -0800 (PST)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH 1/5] usb: chipidea: big-endian support
Date:   Wed, 13 Feb 2013 23:38:54 +0200
Message-Id: <1360791538-6332-2-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQnxGNWYwx+6Mp2mcp9v50Olt9nxxeQ4witOmBAnso0NTeSITsBiubPEwuQb/YeI0psiGDQg
X-archive-position: 35741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Convert between big-endian and little-endian format when accessing the usb controller structures which are little-endian by specification.
Fix cases where the little-endian memory layout is taken for granted.
The patch doesn't have any effect on the already supported little-endian architectures.

Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
---
 drivers/usb/chipidea/core.c |    2 +-
 drivers/usb/chipidea/udc.c  |   59 +++++++++++++++++++++++--------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index aebf695..3cefb4c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -181,7 +181,7 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 
 	ci->hw_bank.cap = ci->hw_bank.abs;
 	ci->hw_bank.cap += ci->platdata->capoffset;
-	ci->hw_bank.op = ci->hw_bank.cap + ioread8(ci->hw_bank.cap);
+	ci->hw_bank.op = ci->hw_bank.cap + (ioread32(ci->hw_bank.cap) & 0xFF);
 
 	hw_alloc_regmap(ci, false);
 	reg = hw_read(ci, CAP_HCCPARAMS, HCCPARAMS_LEN) >>
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2f45bba..78ac5e5 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -432,10 +432,10 @@ static int _hardware_enqueue(struct ci13xxx_ep *mEp, struct ci13xxx_req *mReq)
 			return -ENOMEM;
 
 		memset(mReq->zptr, 0, sizeof(*mReq->zptr));
-		mReq->zptr->next    = TD_TERMINATE;
-		mReq->zptr->token   = TD_STATUS_ACTIVE;
+		mReq->zptr->next    = cpu_to_le32(TD_TERMINATE);
+		mReq->zptr->token   = cpu_to_le32(TD_STATUS_ACTIVE);
 		if (!mReq->req.no_interrupt)
-			mReq->zptr->token   |= TD_IOC;
+			mReq->zptr->token   |= cpu_to_le32(TD_IOC);
 	}
 	ret = usb_gadget_map_request(&ci->gadget, &mReq->req, mEp->dir);
 	if (ret)
@@ -446,32 +446,35 @@ static int _hardware_enqueue(struct ci13xxx_ep *mEp, struct ci13xxx_req *mReq)
 	 * TODO - handle requests which spawns into several TDs
 	 */
 	memset(mReq->ptr, 0, sizeof(*mReq->ptr));
-	mReq->ptr->token    = length << ffs_nr(TD_TOTAL_BYTES);
-	mReq->ptr->token   &= TD_TOTAL_BYTES;
-	mReq->ptr->token   |= TD_STATUS_ACTIVE;
+	mReq->ptr->token    = cpu_to_le32(length << ffs_nr(TD_TOTAL_BYTES));
+	mReq->ptr->token   &= cpu_to_le32(TD_TOTAL_BYTES);
+	mReq->ptr->token   |= cpu_to_le32(TD_STATUS_ACTIVE);
 	if (mReq->zptr) {
-		mReq->ptr->next    = mReq->zdma;
+		mReq->ptr->next    = cpu_to_le32(mReq->zdma);
 	} else {
-		mReq->ptr->next    = TD_TERMINATE;
+		mReq->ptr->next    = cpu_to_le32(TD_TERMINATE);
 		if (!mReq->req.no_interrupt)
-			mReq->ptr->token  |= TD_IOC;
+			mReq->ptr->token  |= cpu_to_le32(TD_IOC);
+	}
+	mReq->ptr->page[0]  = cpu_to_le32(mReq->req.dma);
+	for (i = 1; i < 5; i++) {
+		u32 page = mReq->req.dma + i * CI13XXX_PAGE_SIZE;
+		page &= ~TD_RESERVED_MASK;
+		mReq->ptr->page[i] = cpu_to_le32(page);
 	}
-	mReq->ptr->page[0]  = mReq->req.dma;
-	for (i = 1; i < 5; i++)
-		mReq->ptr->page[i] =
-			(mReq->req.dma + i * CI13XXX_PAGE_SIZE) & ~TD_RESERVED_MASK;
 
 	if (!list_empty(&mEp->qh.queue)) {
 		struct ci13xxx_req *mReqPrev;
 		int n = hw_ep_bit(mEp->num, mEp->dir);
 		int tmp_stat;
+		u32 next = mReq->dma & TD_ADDR_MASK;
 
 		mReqPrev = list_entry(mEp->qh.queue.prev,
 				struct ci13xxx_req, queue);
 		if (mReqPrev->zptr)
-			mReqPrev->zptr->next = mReq->dma & TD_ADDR_MASK;
+			mReqPrev->zptr->next = cpu_to_le32(next);
 		else
-			mReqPrev->ptr->next = mReq->dma & TD_ADDR_MASK;
+			mReqPrev->ptr->next = cpu_to_le32(next);
 		wmb();
 		if (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
 			goto done;
@@ -485,9 +488,9 @@ static int _hardware_enqueue(struct ci13xxx_ep *mEp, struct ci13xxx_req *mReq)
 	}
 
 	/*  QH configuration */
-	mEp->qh.ptr->td.next   = mReq->dma;    /* TERMINATE = 0 */
-	mEp->qh.ptr->td.token &= ~TD_STATUS;   /* clear status */
-	mEp->qh.ptr->cap |=  QH_ZLT;
+	mEp->qh.ptr->td.next   = cpu_to_le32(mReq->dma);    /* TERMINATE = 0 */
+	mEp->qh.ptr->td.token &= cpu_to_le32(~TD_STATUS);   /* clear status */
+	mEp->qh.ptr->cap |=  cpu_to_le32(QH_ZLT);
 
 	wmb();   /* synchronize before ep prime */
 
@@ -509,11 +512,11 @@ static int _hardware_dequeue(struct ci13xxx_ep *mEp, struct ci13xxx_req *mReq)
 	if (mReq->req.status != -EALREADY)
 		return -EINVAL;
 
-	if ((TD_STATUS_ACTIVE & mReq->ptr->token) != 0)
+	if ((cpu_to_le32(TD_STATUS_ACTIVE) & mReq->ptr->token) != 0)
 		return -EBUSY;
 
 	if (mReq->zptr) {
-		if ((TD_STATUS_ACTIVE & mReq->zptr->token) != 0)
+		if ((cpu_to_le32(TD_STATUS_ACTIVE) & mReq->zptr->token) != 0)
 			return -EBUSY;
 		dma_pool_free(mEp->td_pool, mReq->zptr, mReq->zdma);
 		mReq->zptr = NULL;
@@ -523,7 +526,7 @@ static int _hardware_dequeue(struct ci13xxx_ep *mEp, struct ci13xxx_req *mReq)
 
 	usb_gadget_unmap_request(&mEp->ci->gadget, &mReq->req, mEp->dir);
 
-	mReq->req.status = mReq->ptr->token & TD_STATUS;
+	mReq->req.status = le32_to_cpu(mReq->ptr->token) & TD_STATUS;
 	if ((TD_STATUS_HALTED & mReq->req.status) != 0)
 		mReq->req.status = -1;
 	else if ((TD_STATUS_DT_ERR & mReq->req.status) != 0)
@@ -531,7 +534,7 @@ static int _hardware_dequeue(struct ci13xxx_ep *mEp, struct ci13xxx_req *mReq)
 	else if ((TD_STATUS_TR_ERR & mReq->req.status) != 0)
 		mReq->req.status = -1;
 
-	mReq->req.actual   = mReq->ptr->token & TD_TOTAL_BYTES;
+	mReq->req.actual   = le32_to_cpu(mReq->ptr->token) & TD_TOTAL_BYTES;
 	mReq->req.actual >>= ffs_nr(TD_TOTAL_BYTES);
 	mReq->req.actual   = mReq->req.length - mReq->req.actual;
 	mReq->req.actual   = mReq->req.status ? 0 : mReq->req.actual;
@@ -801,7 +804,7 @@ __acquires(mEp->lock)
 		if (retval < 0)
 			break;
 		list_del_init(&mReq->queue);
-		dbg_done(_usb_addr(mEp), mReq->ptr->token, retval);
+		dbg_done(_usb_addr(mEp), le32_to_cpu(mReq->ptr->token), retval);
 		if (mReq->req.complete != NULL) {
 			spin_unlock(mEp->lock);
 			if ((mEp->type == USB_ENDPOINT_XFER_CONTROL) &&
@@ -1045,15 +1048,15 @@ static int ep_enable(struct usb_ep *ep,
 	mEp->qh.ptr->cap = 0;
 
 	if (mEp->type == USB_ENDPOINT_XFER_CONTROL)
-		mEp->qh.ptr->cap |=  QH_IOS;
+		mEp->qh.ptr->cap |=  cpu_to_le32(QH_IOS);
 	else if (mEp->type == USB_ENDPOINT_XFER_ISOC)
-		mEp->qh.ptr->cap &= ~QH_MULT;
+		mEp->qh.ptr->cap &= cpu_to_le32(~QH_MULT);
 	else
-		mEp->qh.ptr->cap &= ~QH_ZLT;
+		mEp->qh.ptr->cap &= cpu_to_le32(~QH_ZLT);
 
 	mEp->qh.ptr->cap |=
-		(mEp->ep.maxpacket << ffs_nr(QH_MAX_PKT)) & QH_MAX_PKT;
-	mEp->qh.ptr->td.next |= TD_TERMINATE;   /* needed? */
+		cpu_to_le32((mEp->ep.maxpacket << ffs_nr(QH_MAX_PKT)) & QH_MAX_PKT);
+	mEp->qh.ptr->td.next |= cpu_to_le32(TD_TERMINATE);   /* needed? */
 
 	/*
 	 * Enable endpoints in the HW other than ep0 as ep0
-- 
1.7.9.5
