Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 14:44:36 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47262 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825885Ab3E0Mof6CHgl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 14:44:35 +0200
Received: by mail-pd0-f175.google.com with SMTP id 6so6216358pdd.34
        for <multiple recipients>; Mon, 27 May 2013 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=WlvLyifPcBYWvayYFdtEyi/dtGSHz0sDsh1/jSho8SU=;
        b=haV93SGgDZ5EF1JVfdRyNkObFZNfv2QBQNxiozdabmpbvVEd8pebRXWdEpIKLYaSMr
         /JOxlYUHU0JKN/lZ/FFi79sha8+pk/UOASpo/Lekh3kM7ryNuQ5Ap6sTJNnKX6N2tosc
         KVIEid10CbzICj2lwacNpqQVqMNkjq3KuiWqBYOHMzWRbiwg+cURY7tbeDPIHZDtvRfa
         GW/rxshdVyNmGsezkcAzPToAYdvN/Mvcc+kW10uOQpXt0q0sxfcnNva7iuVXKhIcDcSX
         azyQjBgS8un4bOHe3BFPmoV0GD1M+vBVAw9fWaF6cqwy9iVyiItVnKgRZgqemkIKnsrM
         f1ow==
X-Received: by 10.66.164.3 with SMTP id ym3mr29825011pab.106.1369658668971;
        Mon, 27 May 2013 05:44:28 -0700 (PDT)
Received: from hades (111-243-158-188.dynamic.hinet.net. [111.243.158.188])
        by mx.google.com with ESMTPSA id zy5sm28459952pbb.43.2013.05.27.05.44.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 05:44:28 -0700 (PDT)
Date:   Mon, 27 May 2013 20:44:21 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, macro@linux-mips.org, Steven.Hill@imgtec.com,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v4 1/3] MIPS: microMIPS: Fix POOL16C minor opcode enum
Message-ID: <20130527124421.GA32322@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36612
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
1.7.10.2 (Apple Git-33)
