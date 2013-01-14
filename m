Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 18:23:45 +0100 (CET)
Received: from mail-qc0-f178.google.com ([209.85.216.178]:46119 "EHLO
        mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831940Ab3ANRXofLzOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2013 18:23:44 +0100
Received: by mail-qc0-f178.google.com with SMTP id j34so2619766qco.23
        for <multiple recipients>; Mon, 14 Jan 2013 09:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=MO5qI+NeMafd+DAeDXrxddwLJhGZWaqUpn0xDWRa4SI=;
        b=ICaF5h+YoPXsYXlTZFzjQ4SDGZUbi+NBxyqxs/D7hIBJ+PLHkkGmXOWg20nE8f2wdq
         7Ng9DQiwl7AobeYHXXre+ZYf8VN5KymfnA/wtvwXmdSQWC47nSc5F0d7tZ8ArzL648Pn
         pkyceTuYdnOTEKsG3gp+BOhYKz6TYmgPjOJsncYaKwgCYRMDy4tfJm5yod/Es2CtOUbG
         y+FUAsqa+9vPxWdtQ4OFyziJD1koEtXva2tXd3QUrHlfMsu9Tc87EdRmpMuzqwwCTp7Z
         5hHQM17cO0JokS+JI4vwqTFMoUHEjEqIaL+Xqbi2BTdDAY+neTBGzEWJnxCngti7JCGG
         oR5g==
X-Received: by 10.49.105.73 with SMTP id gk9mr86160436qeb.40.1358184218189;
        Mon, 14 Jan 2013 09:23:38 -0800 (PST)
Received: from localhost.localdomain (ec2-54-243-39-165.compute-1.amazonaws.com. [54.243.39.165])
        by mx.google.com with ESMTPS id x9sm9246556qen.1.2013.01.14.09.23.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 09:23:37 -0800 (PST)
From:   Cong Ding <dinggnu@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Cong Ding <dinggnu@gmail.com>
Subject: [PATCH] mips: kernel/vpe.c: fix wrong KERN_WARNING message
Date:   Mon, 14 Jan 2013 17:23:29 +0000
Message-Id: <1358184212-30381-1-git-send-email-dinggnu@gmail.com>
X-Mailer: git-send-email 1.7.4.5
X-archive-position: 35430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinggnu@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

in the printk, the variable t euqals to NULL, so there is no t->index, we use
v->tc->index instead.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 arch/mips/kernel/vpe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index eec690a..3e20c33 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -705,7 +705,7 @@ static int vpe_run(struct vpe * v)
 
 			printk(KERN_WARNING
 			       "VPE loader: TC %d is already in use.\n",
-                               t->index);
+                               v->tc->index);
 			return -ENOEXEC;
 		}
 	} else {
-- 
1.7.9.5
