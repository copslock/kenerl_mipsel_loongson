Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:00:19 +0200 (CEST)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33766 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032403AbcEUL76yWqZI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 13:59:58 +0200
Received: by mail-lf0-f68.google.com with SMTP id z203so638004lfd.0;
        Sat, 21 May 2016 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+UeNxZlijI6SiQknvlSqs6NS4Eij6uSJLpPDRn2QNLk=;
        b=xIn8ApvW3zOcDCzqxxiJOBmKmofUDdJbVuoXLT+paQQvC5w3nnrK5QweeSIAaJeK83
         Gft1UOA0bcPoaUXX8gPV/bFjZsX4MbaTZufGJ9jE6bowyNP9nVUA5n0nYm/nt6zjpbqD
         JjY6gaLihHYv+o1aCrl/b4K5OsrpiqpnVA/TO6W2hELWeMoOo/FjhppG+LZTpIhVcfjl
         n4+D6YvGO0qeuJu+ojQrCgVdm22zoCdZL4ZDVzGikTEYxf/EWjiz3AqJFnRiKkpwKJ7G
         s/ErO2HXyKsJyAccBQDWJpFHuHeHMWlykMrtWCoCqFAykgFzJFwUnncxWCuwmyTHYUR/
         c8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=+UeNxZlijI6SiQknvlSqs6NS4Eij6uSJLpPDRn2QNLk=;
        b=XLgg9fWqADK0v5KfkZjiINCT/MIcJuHsTGvu8CX66QTo7mYxItD2HHedkcNP7aDx+T
         /jcJgYaDoxGnxwmoevdB6+0umGdKo48tip4csQKuIobxvH6NdkFmT3gXKBecKljJGClm
         WGmVyQqWvdtj+w4WSxQ3MXMnlz5iMEVenVi0TDba5+K5xRKJmO6hENirEGt2xlQEO8/R
         pCJJ4tdw3XmSHh2EPeZw190QNOVO0fr3kczuUG14/KDo95vsSF+oeENfAyGKP7dX42Yg
         KXTLb2iWZhA+CePp9n9aHtgZn66TNJ3HJkehi35TV96oTf/9rTg2DN+qbGhpQtxc/95R
         e3Zw==
X-Gm-Message-State: AOPr4FXY3QmFrE9032dv6lO4HGdXVK4lxZrp2hZtsNnH1f5oXd6J3YFG03alZvme+5R4dw==
X-Received: by 10.25.138.134 with SMTP id m128mr2738847lfd.46.1463831993517;
        Sat, 21 May 2016 04:59:53 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id a131sm4253829lfe.1.2016.05.21.04.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 04:59:52 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, chenhc@lemote.com,
        james.hogan@imgtec.com, linux-mips@linux-mips.org
Subject: [PATCH 0181/1529] Fix typo
Date:   Sat, 21 May 2016 13:59:48 +0200
Message-Id: <20160521115948.9288-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/include/asm/hazards.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index dbb1eb6..e0fecf2 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -58,8 +58,8 @@
  * address of a label as argument to inline assembler.	Gas otoh has the
  * annoying difference between la and dla which are only usable for 32-bit
  * rsp. 64-bit code, so can't be used without conditional compilation.
- * The alterantive is switching the assembler to 64-bit code which happens
- * to work right even for 32-bit code ...
+ * The alternative is switching the assembler to 64-bit code which happens
+ * to work right even for 32-bit code...
  */
 #define instruction_hazard()						\
 do {									\
@@ -133,8 +133,8 @@ do {									\
  * address of a label as argument to inline assembler.	Gas otoh has the
  * annoying difference between la and dla which are only usable for 32-bit
  * rsp. 64-bit code, so can't be used without conditional compilation.
- * The alterantive is switching the assembler to 64-bit code which happens
- * to work right even for 32-bit code ...
+ * The alternative is switching the assembler to 64-bit code which happens
+ * to work right even for 32-bit code...
  */
 #define __instruction_hazard()						\
 do {									\
-- 
2.8.2.534.g1f66975
