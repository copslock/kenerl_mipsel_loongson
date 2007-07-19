Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:41:48 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:4828 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022586AbXGSMlq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 13:41:46 +0100
Received: by ug-out-1314.google.com with SMTP id u2so422177uge
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 05:41:28 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=ESHFpIU8QYnf0ZSk602MTR4EiRnj6pU/6iy5tKE8hyvypoOnEunngL6fae9h7AUeg2P9HymLyenT7UJmjvXdGMFi6gNV1v8djhAKFsOgZlyalQTunYwxzCVplxMPYQxUQ0GXPUGpUbYz9CoZKbsWdstIX3fNr2wUwgGINzpT/w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=CmFQEbklL7ENb3Z2K+iKLYv7suVZ7/qESgPsfz2iDcfDQRKe/AKLY5l5ki4NBfu76Jfzl5SGxyd2x0hyLbWzbaPcMYWNveCV0swAFKOr4YXgVf+m88yGOUFPkRqN7q/FJNftcMwKgn7pExQeDFEkR5RJU/EYZXZHXFAfo0GSYr4=
Received: by 10.86.57.9 with SMTP id f9mr1913635fga.1184848888738;
        Thu, 19 Jul 2007 05:41:28 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTPS id f31sm4406365fkf.2007.07.19.05.41.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jul 2007 05:41:27 -0700 (PDT)
Message-ID: <469F5BD9.3080601@innova-card.com>
Date:	Thu, 19 Jul 2007 14:40:57 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] User stack pointer randomisation
References: <469F5345.5010209@innova-card.com> <20070719123030.GA21934@linux-mips.org>
In-Reply-To: <20070719123030.GA21934@linux-mips.org>
X-Enigmail-Version: 0.94.4.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jul 19, 2007 at 02:04:21PM +0200, Franck Bui-Huu wrote:
> 
> Okay, applied.
> 

ouch you were too fast ;)

I think Nigel is right in his last comment.

Do you care to amend this on top of what you applied ?

-- 8< --

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 42a60b4..d6b9653 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -27,7 +27,6 @@
 #include <linux/kallsyms.h>
 #include <linux/random.h>
 
-#include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/dsp.h>
@@ -464,13 +463,14 @@ out:
 }
 
 /*
- * Don't forget that the stack pointer must be aligned on a 8 bytes
- * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
+ * The stack pointer must be aligned on a 8 bytes boundary for 32-bits
+ * ABI and 16 bytes for 64-bits ABI. To make things simple we force to
+ * the maximum alignment required by any ABI.
  */
 unsigned long arch_align_stack(unsigned long sp)
 {
 	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() & ~PAGE_MASK;
 
-	return sp & ALMASK;
+	return sp & ~0xf;
 }
