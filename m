Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 08:56:02 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.193]:28357 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133437AbWEBHzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 08:55:52 +0100
Received: by nz-out-0102.google.com with SMTP id j2so2519212nzf
        for <linux-mips@linux-mips.org>; Tue, 02 May 2006 00:55:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BtVgaiK/MYWnSpKzYxQ0pxiAcdHM/AtxEriOkJ7RTW1BKbr459zrwcPOB5/bz8M7+bw3E2AJKOsqkoQb/Li7ixsnMenkU8E/CF9yFpOoQh6C5WqI3djO8TqahotmjIctVa/uIuc9wEF94hkXxbA/8J4IxbRMqM1RENY2kPgcIA4=
Received: by 10.36.129.3 with SMTP id b3mr706761nzd;
        Tue, 02 May 2006 00:55:51 -0700 (PDT)
Received: by 10.36.49.2 with HTTP; Tue, 2 May 2006 00:55:51 -0700 (PDT)
Message-ID: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com>
Date:	Tue, 2 May 2006 09:55:51 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] Make interrupt handler works for all cases
Cc:	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

specially when the kernel is mapped.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>


---

 arch/mips/kernel/genex.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

72821cd1fc2a6e31e31c2babf338425b29e8f11f
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ff7af36..50cb0c2 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -132,7 +132,8 @@ NESTED(handle_int, PT_SIZE, sp)

 	PTR_LA	ra, ret_from_irq
 	move	a0, sp
-	j	plat_irq_dispatch
+	PTR_LA	k0, plat_irq_dispatch
+	jr	k0
 	END(handle_int)

 	__INIT
--
1.3.0.g2473
