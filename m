Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 15:33:00 +0200 (CEST)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50123 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823001Ab3FTNcrr-vib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 15:32:47 +0200
Received: by mail-pb0-f43.google.com with SMTP id md12so6273887pbc.30
        for <multiple recipients>; Thu, 20 Jun 2013 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=VjBU7h3f4CpfWYKy6xnMR5TOmPLtqVOqVPGfmNFgufA=;
        b=nbZojoeiikvtOyzQzOACSn3qHFnxgaFxadkU6m7kJXo7s/LZXtpdLYZ53VpGblsuwZ
         6Jx8YB7lhvoRaqpXtwmRWVYi7E1jWo1RncTQkq1BQCN7U2JnmX94pYWVlEIRk+2kjXbT
         0WOMRie4z5VCA/Y8epd7F5HBY1oo4w98gi9U9myDyeAP0eQrLPsxnTjshhkRKuqKq9kw
         vjxIG/+GZ4iVN/8j17fkof453lJ+rMm5ACi2VLB4Fr0quf9bQK3h0bG5IuIL7w+ydrWV
         RqTsLoDhOAJ3L+0za/P2Z/tN4RLakz0bdEN7ms7nIcU8Zy4ZXlwKdKuVMgOncxBsnVCp
         WAWg==
X-Received: by 10.68.178.129 with SMTP id cy1mr2611162pbc.73.1371735160658;
        Thu, 20 Jun 2013 06:32:40 -0700 (PDT)
Received: from hades (111-251-227-40.dynamic.hinet.net. [111.251.227.40])
        by mx.google.com with ESMTPSA id iq6sm334116pbc.1.2013.06.20.06.32.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 06:32:40 -0700 (PDT)
Date:   Thu, 20 Jun 2013 21:32:30 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, macro@linux-mips.org, Steven.Hill@imgtec.com,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v5 1/2] MIPS: microMIPS: Fix POOL16C minor opcode enum
Message-ID: <20130620133230.GA84495@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37054
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
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 0f4aec2..e5a676e 100644
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
+	mm_jrc_op = 0x0d,
+	mm_jalr16_op = 0x0e,
+	mm_jalrs16_op = 0x0f,
+	mm_jraddiusp_op = 0x18,
 };
 
 /*
-- 
1.7.10.2
