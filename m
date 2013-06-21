Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 13:03:26 +0200 (CEST)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49003 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818323Ab3FULDPJ3JQJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 13:03:15 +0200
Received: by mail-pb0-f42.google.com with SMTP id un1so7612239pbc.29
        for <multiple recipients>; Fri, 21 Jun 2013 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Vxh3lDjYNxW91+FWhLTaIvCibZrHWUbCy1z3O/zoFZc=;
        b=RFq4jRd9A3IMk69larmFmEvxMvB6Enn85R9gannZ4DJxfxrscmAOqhgGHaw6jmyXjQ
         TcriEzZn/6wCHsA43mx8PMxIcyJuTkLNhY9uJatlwngk9U/1QC6pG21bzg0f+yijl1+R
         I3GUffwzrDAb4y2ELAfu6l1+N4iACGPA9+XQtk/a+4D9O1uBppq77vhYXsVuobXmibMS
         TfCfosFRUI+c1u1iMYp0uP4tCFiaw+es4HM06ZfAvLfEXc0A2Arp/y3NImBEpoocTk++
         hMMcBFFEkVf1pC2t8ct2iWOiiodNM5F/JkYWrBohSwgayZLhbN8E87KO0CNw9wJ14YKu
         QGWw==
X-Received: by 10.68.35.3 with SMTP id d3mr11837430pbj.155.1371812588007;
        Fri, 21 Jun 2013 04:03:08 -0700 (PDT)
Received: from hades.local (111-243-154-157.dynamic.hinet.net. [111.243.154.157])
        by mx.google.com with ESMTPSA id iq2sm4446758pbb.19.2013.06.21.04.03.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:03:07 -0700 (PDT)
Date:   Fri, 21 Jun 2013 19:03:01 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Add missing cpu_has_mips_1 guardian
Message-ID: <20130621110301.GA23195@hades.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37080
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

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/include/asm/cpu-features.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e5ec8fc..df5e523 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -136,7 +136,9 @@
 #endif
 #endif
 
+#ifndef cpu_has_mips_1
 # define cpu_has_mips_1		(cpu_data[0].isa_level & MIPS_CPU_ISA_I)
+#endif
 #ifndef cpu_has_mips_2
 # define cpu_has_mips_2		(cpu_data[0].isa_level & MIPS_CPU_ISA_II)
 #endif
-- 
1.7.10.2
