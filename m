Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:07:49 +0200 (CEST)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34393 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835163Ab3FGXDztvK0X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:55 +0200
Received: by mail-ie0-f175.google.com with SMTP id a14so1721654iee.20
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lDEmhXfudmoKPDJ7hoeH4haAqGoa7FYiZaGww7VenBQ=;
        b=eZNlgeA57EWnGAOFNwfGNGDbygnHG6PgfaiubV+N4q0tiPzsnSEb7ys49cuXOTCepq
         UxUL4qZrazRjJvO8hsVCzsB2yaY6N2uIkswF+ZEbbQoj7BZe0clUCofaIzN2rcVNd0SA
         TWeCOisWIg9Ki7TYVKMJjYpj5IFOKmKwmwJ32Wrww2CNLxeI9X1o34995xTR23YRsNyu
         P07ULFaDhB9osxJn1xja29oolriedHjUyIu0CNq2pkw74CewUJqCATDHY+MNIhizlXtj
         QBFbAOgR37fZLqoEmXkzjfTmNrYpYKFn7UJlYM3sl0Zau2TIjsou8SLCHFcIks8kdQGc
         KQUA==
X-Received: by 10.50.80.9 with SMTP id n9mr432968igx.42.1370646229751;
        Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ik6sm205045igb.3.2013.06.07.16.03.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3k87006658;
        Fri, 7 Jun 2013 16:03:47 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3k0i006657;
        Fri, 7 Jun 2013 16:03:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 12/31] MIPS: Add instruction format information for WAIT, MTC0, MFC0, et al.
Date:   Fri,  7 Jun 2013 16:03:16 -0700
Message-Id: <1370646215-6543-13-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

---
 arch/mips/include/uapi/asm/inst.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 0f4aec2..133abc1 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -117,7 +117,8 @@ enum bcop_op {
 enum cop0_coi_func {
 	tlbr_op	      = 0x01, tlbwi_op	    = 0x02,
 	tlbwr_op      = 0x06, tlbp_op	    = 0x08,
-	rfe_op	      = 0x10, eret_op	    = 0x18
+	rfe_op	      = 0x10, eret_op	    = 0x18,
+	wait_op	      = 0x20
 };
 
 /*
@@ -567,6 +568,24 @@ struct b_format {			/* BREAK and SYSCALL */
 	;)))
 };
 
+struct c0_format {			/* WAIT, TLB?? */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int co : 1,
+	BITFIELD_FIELD(unsigned int code : 19,
+	BITFIELD_FIELD(unsigned int func : 6,
+	;))))
+};
+
+struct c0m_format {			/* MTC0, MFC0, ... */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int func : 5,
+	BITFIELD_FIELD(unsigned int rt : 5,
+	BITFIELD_FIELD(unsigned int rd : 5,
+	BITFIELD_FIELD(unsigned int code : 8,
+	BITFIELD_FIELD(unsigned int sel : 3,
+	;))))))
+};
+
 struct ps_format {			/* MIPS-3D / paired single format */
 	BITFIELD_FIELD(unsigned int opcode : 6,
 	BITFIELD_FIELD(unsigned int rs : 5,
@@ -857,6 +876,8 @@ union mips_instruction {
 	struct f_format f_format;
 	struct ma_format ma_format;
 	struct b_format b_format;
+	struct c0_format c0_format;
+	struct c0m_format c0m_format;
 	struct ps_format ps_format;
 	struct v_format v_format;
 	struct fb_format fb_format;
-- 
1.7.11.7
