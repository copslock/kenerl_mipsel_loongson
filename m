Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 13:23:43 +0100 (CET)
Received: from mail-gx0-f224.google.com ([209.85.217.224]:45684 "EHLO
        mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492141Ab0BTMXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2010 13:23:40 +0100
Received: by gxk24 with SMTP id 24so1146004gxk.7
        for <multiple recipients>; Sat, 20 Feb 2010 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=k6C+4pl3q3FQdoajqnPIQsZ1OyVxALulHiw7vVQTxho=;
        b=rnFDP4h6oUZ4pzb5RDIHlGQu+9tYw6fwVFTMgXPdl/fLch+v2GoagkfmVdCgf6CIZg
         DgDwiTDFS/m/4i2mKyvNA8bXlEoPxJlJWyun8YML8riL0aYrqIgcykmg0AxLeGI7bjKj
         YediGz7qmh0v9AbcqsV7uVLGzrgDLg4tOjzeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MRkY3zUr7Y6xcXwgxkQZ0BWsg0zWWSSWgvsun01LhBOus2MtnhMputIwh/uetW1y5M
         poiuXrFl3JiHpQLUQM2BCRjoRQ7OErlwz1JZv89KfZgaZhh0xkls6FzJXS9Pl7msIjzc
         Y2PI7sSj3aLXFJ0xzR1530tzFaVCr7KJEUw90=
Received: by 10.101.145.15 with SMTP id x15mr2376721ann.8.1266668613281;
        Sat, 20 Feb 2010 04:23:33 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm975191gxk.8.2010.02.20.04.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 04:23:32 -0800 (PST)
Date:   Sat, 20 Feb 2010 21:23:22 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue] MIPS: fix HIGHMEM build error
Message-Id: <20100220212322.03c5eb09.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

arch/mips/mm/highmem.c: In function 'kmap_init':
arch/mips/mm/highmem.c:130: error: 'init_mm' undeclared (first use in this function)
arch/mips/mm/highmem.c:130: error: (Each undeclared identifier is reported only once
arch/mips/mm/highmem.c:130: error: for each function it appears in.)

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/mm/highmem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index e274fda..127d732 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
-- 
1.7.0
