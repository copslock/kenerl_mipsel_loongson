Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 17:55:04 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47702 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491755Ab1HDPy6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Aug 2011 17:54:58 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p74Fsv0S006536
        for <linux-mips@linux-mips.org>; Thu, 4 Aug 2011 16:54:57 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p74FsvU7006534
        for linux-mips@linux-mips.org; Thu, 4 Aug 2011 16:54:57 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Thu, 4 Aug 2011 16:54:57 +0100
Resent-Message-ID: <20110804155457.GB5297@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from mail-ww0-f43.google.com ([74.125.82.43]:49194 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491188Ab1HDOih (ORCPT
        <rfc822;ralf@linux-mips.org>); Thu, 4 Aug 2011 16:38:37 +0200
Received: by wwe32 with SMTP id 32so1349764wwe.24
        for <ralf@linux-mips.org>; Thu, 04 Aug 2011 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JpmtN0F+lYQC2pnx0bv+kLkCPfJOh15xhq1vXR2W3Sw=;
        b=DWS9QrSlv+PPkL2gPZbXGDE+hISbXXh8nIeYrHz3n6iVKlw1KJKMbrW+6AGWdZtjwQ
         mWuUgJgxx2A7fAlGGrKEsE1szL3B/KOaycbd7vBjTy7f5IwA8Oyzc+oOs28Sh4klGD8o
         aoiUgE5MRZ9uIF44BTI02JqrOVXms0B2ISSnw=
MIME-Version: 1.0
Received: by 10.216.237.233 with SMTP id y83mr1432975weq.9.1312468711520; Thu,
 04 Aug 2011 07:38:31 -0700 (PDT)
Received: by 10.216.46.136 with HTTP; Thu, 4 Aug 2011 07:38:31 -0700 (PDT)
Date:   Thu, 4 Aug 2011 22:38:31 +0800
Message-ID: <CAJd=RBA9ihp94TtjkWbAVo1Y_2+Vp1VskJWVahN85biCEAYWtQ@mail.gmail.com>
Subject: [RFC patch] MIPS: select correct tc
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 30836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3440

If we could find tc on the tc list for @index, the found tc should be returned.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---
 arch/mips/kernel/vpe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index dbb6b40..044b700 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -192,7 +192,7 @@ static struct tc *get_tc(int index)
 	}
 	spin_unlock(&vpecontrol.tc_list_lock);

-	return NULL;
+	return res;
 }

 /* allocate a vpe and associate it with this minor (or index) */
