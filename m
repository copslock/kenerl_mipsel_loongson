Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:53:43 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:63541 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009241AbaLTBwv4A44b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:52:51 +0100
Received: by mail-ie0-f171.google.com with SMTP id ar1so1761865iec.2;
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67ctObem/IUxWATF59NDSqlbGNmMbnIxoZtEYpr5E80=;
        b=Vv//GgTDTjwuojb1CtWEgOcgmD8rXRhj7oza/jJlMB06VaTdcapAWM5kRP+1nWLB2V
         sXcr8z2qtPnYcWLO318AVGObL3UnjvY6FocjUuuVQCp88KiYLQuqRk786Mck7hUl0Qck
         y/Hfh+NJlWmkZY1+bjJLECBH4n14BJuO+DZ0bcQeX6EcgcMjSaX5VKgW+Ve8RpatCbsa
         Eg/Kk+2psLMuG3qo+dsfYZuzelfdUjlN+5HPh+xTCMCZDtuxo/6M3T5qvXQhGf23JQcX
         NaYP5XnD9t7v1b24Mp8BCYE/NrFLI6v5iwG3D4ODDytvLy9xhl/riHn0rd6LBxGap6sf
         BUuQ==
X-Received: by 10.50.50.140 with SMTP id c12mr117563igo.5.1419040366443;
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id e33sm5345528ioi.9.2014.12.19.17.52.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1qixb008554;
        Fri, 19 Dec 2014 17:52:44 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1qiG4008553;
        Fri, 19 Dec 2014 17:52:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [RFC PATCH v2 3/5] MIPS: Add instruction coding for SYNCI and add trap formats.
Date:   Fri, 19 Dec 2014 17:52:38 -0800
Message-Id: <1419040360-8502-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44868
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/uapi/asm/inst.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 89c2243..7cd4107 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -100,7 +100,8 @@ enum rt_op {
 	bltzal_op, bgezal_op, bltzall_op, bgezall_op,
 	rt_op_0x14, rt_op_0x15, rt_op_0x16, rt_op_0x17,
 	rt_op_0x18, rt_op_0x19, rt_op_0x1a, rt_op_0x1b,
-	bposge32_op, rt_op_0x1d, rt_op_0x1e, rt_op_0x1f
+	bposge32_op, rt_op_0x1d, rt_op_0x1e, rt_op_0x1f,
+	op_synci = rt_op_0x1f
 };
 
 /*
@@ -547,6 +548,15 @@ struct r_format {			/* Register format */
 	;))))))
 };
 
+struct t_format {			/* Trap format */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int rt : 5,
+	__BITFIELD_FIELD(unsigned int code : 10,
+	__BITFIELD_FIELD(unsigned int func : 6,
+	;)))))
+};
+
 struct p_format {		/* Performance counter format (R10000) */
 	__BITFIELD_FIELD(unsigned int opcode : 6,
 	__BITFIELD_FIELD(unsigned int rs : 5,
@@ -881,6 +891,7 @@ union mips_instruction {
 	struct u_format u_format;
 	struct c_format c_format;
 	struct r_format r_format;
+	struct t_format t_format;
 	struct p_format p_format;
 	struct f_format f_format;
 	struct ma_format ma_format;
-- 
1.7.11.7
