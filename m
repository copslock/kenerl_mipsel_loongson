Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Apr 2006 00:00:04 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:27091 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133623AbWDGW7z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Apr 2006 23:59:55 +0100
Received: (qmail 21725 invoked from network); 8 Apr 2006 03:12:52 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2006 03:12:52 -0000
Message-ID: <4436F140.3030007@ru.mvista.com>
Date:	Sat, 08 Apr 2006 03:09:52 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	Clem Taylor <clem.taylor@gmail.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] FIx mprotect() syscall for MIPS32 w/36-bit physical address
 support
References: <ecb4efd10512071351scea736fg8d026e3fa3c54c79@mail.gmail.com> <20060202165436.GB17352@linux-mips.org>
In-Reply-To: <20060202165436.GB17352@linux-mips.org>
Content-Type: multipart/mixed;
 boundary="------------000004060904030800020404"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000004060904030800020404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Fix mprotect() syscall for MIPS32 CPUs with 36-bit physical address
support: pte_modify() macro didn't clear the hardware page protection bits
before modifying...

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------000004060904030800020404
Content-Type: text/plain;
 name="MIPS32-36bit-phys-addr-mprotect-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS32-36bit-phys-addr-mprotect-fix.patch"

diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 702a28f..80b3605 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -335,8 +335,9 @@ static inline pgprot_t pgprot_noncached(
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	pte.pte_low &= _PAGE_CHG_MASK;
-	pte.pte_low |= pgprot_val(newprot);
+	pte.pte_low  &= _PAGE_CHG_MASK;
+	pte.pte_high &= ~0x3f;
+	pte.pte_low  |= pgprot_val(newprot);
 	pte.pte_high |= pgprot_val(newprot) & 0x3f;
 	return pte;
 }


--------------000004060904030800020404--
