Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 09:10:52 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.232]:39821 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022264AbXGTIKt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 09:10:49 +0100
Received: by nz-out-0506.google.com with SMTP id n1so632826nzf
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2007 01:10:38 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Onx/KKBZ+73ORwW4suTwQiaBZ5P/zvr6ResYhS+r2jfqQlKwtKW2xw7QN3V00YYe5K2a4EUj3fitCAy1CxT4lUTlLbcq+s4eKimXeQxZHELjJkD+PwEnf3mECxHc/PrXn1Z3GP5OjSWpDMuZWORVQOIdFIj/Tz138J40PNkok58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z5lFYnVXPy0JtezpNzmRREmWG+GQaT95lwWbBwvO5H1nerTOa1xLGKwzOeofZpjYgSsbjC4X8M/ND6pBRV5f+HGlfn2IJTjFh5yDaK0ikqhn4HbA9iLNLgbDtpniuoyTlETZ9KAjZyD8d0KotQBa9XPgenk5HZHuxlrohf2EVm4=
Received: by 10.115.107.1 with SMTP id j1mr231566wam.1184919038088;
        Fri, 20 Jul 2007 01:10:38 -0700 (PDT)
Received: by 10.114.67.6 with HTTP; Fri, 20 Jul 2007 01:10:38 -0700 (PDT)
Message-ID: <5861a7880707200110w588eacb8v98b1481b4a2dbd5c@mail.gmail.com>
Date:	Fri, 20 Jul 2007 12:10:38 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] 16KB page size in mips32
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

32-bit Kernel for loongson2e currently use 16KB page size to avoid
cache alias problem.So, the definiton of PGDIR_SHIFT muse be 14+12.

The last is the patch. It's been tested on FuLong mini PC(loongson2e inside).


--------------------

--- a/include/asm-mips/pgtable-32.h 2007-07-19 08:22:43.000000000 +0800
+++ b/include/asm-mips/pgtable-32.h 2007-07-20 11:12:40.000000000 +0800
@@ -46,7 +46,7 @@
 #ifdef CONFIG_64BIT_PHYS_ADDR
 #define PGDIR_SHIFT    21
 #else
-#define PGDIR_SHIFT    22
+#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
 #endif
 #define PGDIR_SIZE (1UL << PGDIR_SHIFT)
 #define PGDIR_MASK (~(PGDIR_SIZE-1))
