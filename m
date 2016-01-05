Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 08:21:16 +0100 (CET)
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34091 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007847AbcAEHVOjU34i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 08:21:14 +0100
Received: by mail-pf0-f181.google.com with SMTP id e65so162784522pfe.1;
        Mon, 04 Jan 2016 23:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=jhH272oXWBUcxO+GLQOzsgmYsjN/0b4MSjijYfUjxfw=;
        b=dCZn3zsdOeXt/M5WtS7mqCDKZT9+Rv+QQhYevk3Tl6IzloXpkaH+RkZtpi+sIQ5Opy
         qqyeMRoh7SFgVrJdhHod2h0pj7Xs1zoYCtRR8xN6NTsmX8KXuvuScBMzUxTj5Ze0mgro
         //WUJ1+2jC+hgz2y06BZ9M21EKcRaGsbSgNDeQImo20m4x2FOF9+dVt6GFlXEVXQUuIb
         eSudPD630mjeZzG0uMUAb8BcdrV32JpipM3d9H5AdzyOZ5KzzR372B4W23PiO097b2dh
         K6B9eKkL1F+ci6dDw2JDtVn/PG/wpgd5pAk9d08SigeAQuq8qKuRraYWuXUvGZIH0mVE
         3hsg==
X-Received: by 10.98.43.79 with SMTP id r76mr132658583pfr.9.1451978468382;
        Mon, 04 Jan 2016 23:21:08 -0800 (PST)
Received: from yggdrasil.local (42-72-43-89.EMOME-IP.hinet.net. [42.72.43.89])
        by smtp.gmail.com with ESMTPSA id d26sm101545410pfb.22.2016.01.04.23.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 23:21:07 -0800 (PST)
Date:   Tue, 5 Jan 2016 15:21:01 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Qais Yousef <qais.yousef@imgtec.com>
Cc:     Alex Smith <alex@alex-smith.me.uk>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: VDSO: Fix binutils version test
Message-ID: <20160105151705-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50903
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

Commit 2a037f310bab ("MIPS: VDSO: Fix build error") fixed the logic
for testing binutils version, but introduced another issue.

The ld-ifversion macro is defined as follows:

  $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) || echo $(4))

This macro checks ld version to echo $(3) or echo $(4) based on
the given condition.

It is called as follows in arch/mips/vdso/Makefile:

  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
    $(warning MIPS VDSO requires binutils >= 2.25)
    obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
    ccflags-vdso += -DDISABLE_MIPS_VDSO
  endif

Since $(4) is empty, echo $(4) will evaluate to a simple 'echo'. So, in
case binutils version is indeed greater than 2.25.0, ld-ifversion macro
will return a newline, not the empty string as expected, and that makes
the test fail.

This patch fixes the test condition.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: Alex Smith <alex@alex-smith.me.uk>

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 018f8c7..a54a082 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
+  ifneq ($(call ld-ifversion,-ge,22500000,y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
