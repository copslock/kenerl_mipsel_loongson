Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 13:00:17 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62685 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823668Ab3E0LAM2pxAK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 13:00:12 +0200
Received: by mail-pb0-f53.google.com with SMTP id un4so6617772pbc.26
        for <multiple recipients>; Mon, 27 May 2013 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OtNtIUEH2LodtKBt+lAru1v2TEBQjsZCha0wQbrk7Iw=;
        b=KYAknKU8qFJFZPLExjik6EzPDG8LLeqMn77nujXg2C85o24v3LtQEJygMu4K2XBn7i
         eYt1HCNHBNnNIDVOHjcr3URfokalq8dHuDsAGV74gkCwJ4vYVqzIEnSXvmONfJLGgj6q
         CeyovkgobUJ5aNGddrmLuvAcYMw7fQffAO/eVEDgwnX9H2caJKjRb2qHdH/vgDK7XRWS
         fAEsU6baNvUWzdvPbCoHt1pbpbB31qQBxKi36dUlwMwxm72et7RopCyraR2CSGpXRak+
         xVuh8ZwIkn8CUVc6FzLok/jxUHGNdBU4indRegHq4M9lThDbI/1Yrx9sd+RIQc+I2xuU
         2v5Q==
X-Received: by 10.66.49.71 with SMTP id s7mr29225363pan.188.1369652405497;
        Mon, 27 May 2013 04:00:05 -0700 (PDT)
Received: from hades (111-243-158-188.dynamic.hinet.net. [111.243.158.188])
        by mx.google.com with ESMTPSA id gh9sm28161280pbc.37.2013.05.27.04.00.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 04:00:04 -0700 (PDT)
Date:   Mon, 27 May 2013 18:59:59 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Steven.Hill@imgtec.com, macro@linux-mips.org,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v3 1/3] MIPS: microMIPS: Fix POOL16C minor opcode enum
Message-ID: <20130527105959.GB31548@hades>
References: <20130527105810.GA31548@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130527105810.GA31548@hades>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

As pointed out by Maciej, POOL16C minor opcodes were mostly shifted
by one bit. Correct those opcodes, and also add jraddiusp to the enum.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 0f4aec2..473a2ac 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -409,10 +409,11 @@ enum mm_32f_73_minor_op {
 enum mm_16c_minor_op {
 	mm_lwm16_op = 0x04,
 	mm_swm16_op = 0x05,
-	mm_jr16_op = 0x18,
-	mm_jrc_op = 0x1a,
-	mm_jalr16_op = 0x1c,
-	mm_jalrs16_op = 0x1e,
+	mm_jr16_op = 0x0c,
+	mm_jraddiusp_op = 0x18,
+	mm_jrc_op = 0x0d,
+	mm_jalr16_op = 0x1e,
+	mm_jalrs16_op = 0x1f,
 };
 
 /*
-- 
1.7.10.2 (Apple Git-33)
