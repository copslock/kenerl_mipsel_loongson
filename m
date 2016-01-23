Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:19:53 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33060 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014846AbcAWURyurIXd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:54 +0100
Received: by mail-lb0-f182.google.com with SMTP id x4so57483891lbm.0
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=obMFf0CmOkyqiLj7gw9dOddu0QsSzImReyjnlDcVBec=;
        b=oQSt100I/pawisf/QhJ32DpjBu01FK57tiHGFx0I6oj14J8azoUBfTWUjhA/0tItfA
         03etkEPI0VFE/pBlmZR82+xY+hEhd25mSKn0BfePeCpAe0P1GP7RuV6w5RveQvNTtY68
         k0l2ZgV0Fpk6IDJguCf4mGMSznHhXx4zUuGTBB61DVtwYE+er3hqRWaHDxBeQI7ogArC
         +78pmddUAE+lYuq++bZJi8ya/SX/aIgiXFYw40yk5d57eQk+hwrlitFROmXq8kwGstPG
         Bk5R5YdOoYrXM5sFcN8m489PkfCTa89rRs5eyi925Ug7bU4gvcwpvA/DNaY8FAl8E/Id
         C0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=obMFf0CmOkyqiLj7gw9dOddu0QsSzImReyjnlDcVBec=;
        b=nLRICbFWXsEKAnyroGSJs7Uk0LD+/hZC0XVkf44ItNNVibd1EdeGa4lIKI9nbhLGHG
         b50i/UMA6C4+vqqHPkcUC+bUfNJ1kUqtg/1naTX99WYCUBrxo08Z5zyXgszdjSLl49H5
         5GUMUqEhhy1YOOuLxOmi6VTXob6UTo2dTGhpG/QYMiq8lybyAum1DesfX1CAqr5Yl8ee
         Oe2xBRjD+nyReYGGA56XtSSs8+ORetgTQ5kbvYGqxG/aUtKcKndVR/N+9EZmaQLX5KZd
         2UG6ygakyLQAKeAXPiDAmzRN9uToxmivPJBdjlFF35tUY63IrRDk7MXWB7lQ9KgvzKty
         LIdQ==
X-Gm-Message-State: AG10YOQpLwm6xb8pVnLeuZvFXB4XahmmljpHb+MAY55sRwVVy1i9YIhBrg1svFRYQSfp9Q==
X-Received: by 10.112.72.130 with SMTP id d2mr1492598lbv.141.1453580269579;
        Sat, 23 Jan 2016 12:17:49 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:49 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v3 07/14] MIPS: dts: qca: simplify Makefile
Date:   Sat, 23 Jan 2016 23:17:24 +0300
Message-Id: <1453580251-2341-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Do as arch/mips/boot/dts/ralink/Makefile does.
Without this patch adding a dtb-file leads
to adding __two__ lines to the Makefile.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
---
 arch/mips/boot/dts/qca/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 2d61455d..244329e 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,8 +1,7 @@
 # All DTBs
-dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
 
-# Select a DTB to build in the kernel
-obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-- 
2.6.2
