Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:16:51 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34846 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993119AbcLSCIYGD8qK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:24 +0100
Received: by mail-lf0-f65.google.com with SMTP id p100so6144272lfg.2;
        Sun, 18 Dec 2016 18:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JhDCI4JnwR2XYaDkj77U/NBgHHF3DPyRXQ1N9LhDO/A=;
        b=JYw2YZxGu6AVaYP3guPnYQGNDeQiKS/VAQ6d0SIlgALxhtl+9namPcEKwCXM/S7M3M
         SmBeqg/fTbEtTtjV0eXCmvWS42jykZnqyWZ3l+oSA03zvGdsvwPLgWcJ9NVqf/69DLXe
         a9xgom2cykbGWQIfOoETku2+GT6IX7o6phER9mOg8hJJcNorAsC+n0RBU9ets2WvUqJi
         U0vmNEdVtlThEjlQUUedg9LXEW1HAaR+omPcEUcKm+CsSGlYHcM39DZmsda42evfOdmz
         8QVK2qb49wUnDb5TyFG6p7Tn0S/e6BqTMPHZyISAw98SZfrY7rPr+NedM1aQPHt6jB8o
         KVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JhDCI4JnwR2XYaDkj77U/NBgHHF3DPyRXQ1N9LhDO/A=;
        b=UtdOucGBXKszv2V1bfLk8cGQbW64U8m7/NtQT7Xk+TZGIt1fG8ejWpW51jah1mOKuO
         T74gItCVLv1ew7FHS83j+2qmxn5uyI9apjR1xN8cUmmlGjGYL0NuZA3aT12W6gy2xhCa
         Ep/CKYYjZ/d9rK+1hLCmeULKi193zhw+cFQG8YzIK9uWTZBrr3OH8zCCOTuWZ+14qOxB
         XfvQyU/i7pdP+kw2TsV0rxYnonkPnhtO/dW6iyG8ogmOb4bLDBX7n7nVVg21P1KBZtHP
         DxpyeG3LQPqUW6rekhVlSnqbJdAH7xOh4U9/zp3BK9o8mO/Ef+tUd66ye5hJPqdbIkNU
         OW3w==
X-Gm-Message-State: AIkVDXIdYEyv1I3v4euFlk09x6zW0aV6TMLHilrSfcn0q/vqs75/EycBIn8JHoDzVQJ4Lg==
X-Received: by 10.46.5.15 with SMTP id 15mr6189945ljf.64.1482113295547;
        Sun, 18 Dec 2016 18:08:15 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:15 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 21/21] MIPS memblock: Deactivate old bootmem allocator
Date:   Mon, 19 Dec 2016 05:07:46 +0300
Message-Id: <1482113266-13207-22-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Memblock allocator can be successfully used from now for early
memory management.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2ef1e2d..527f2fe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -40,9 +40,9 @@ config MIPS
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select IRQ_FORCED_THREADING
+	select NO_BOOTMEM
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
-	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select BUILDTIME_EXTABLE_SORT
 	select GENERIC_CLOCKEVENTS
-- 
2.6.6
