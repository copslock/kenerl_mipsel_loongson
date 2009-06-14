Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 17:53:56 +0200 (CEST)
Received: from mail-px0-f204.google.com ([209.85.216.204]:43850 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492181AbZFNPxp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 17:53:45 +0200
Received: by pxi42 with SMTP id 42so141317pxi.22
        for <multiple recipients>; Sun, 14 Jun 2009 08:53:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mwuShjwlsRwYAq7uOlwP3n3r9juH/MLxnJOGBA5iGnc=;
        b=V9cSGK/BgHK37CV2kE96kV0vGToRUXTtBHimJusU14xp7tDZSQJ4jdlNNWeM8RsjKa
         WqgEFQE78c2FqG3siPSgFMT2Zjt6m2lwxUHz+XbguGCFP9LGh2atF26oGYAgQGWIgstG
         RtRwUBW5j8CMsWBph1VqbIl4qwXQGfWRQ4qoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gv3vZrAHIK/2D7bTq5+aEsabehdfEQ27uVFMGTqkrotGPLcRhvCYhm8qxaEjICWiRX
         vCun++6F7SDveWEJO0cU73NdWLUsTMC5kq6I/3gs95tbpP/gjchp2WR/pdBxMqR3I12t
         ec0k375q/VYQ8VdLAQhAlIiTNPTJnJauzlq0E=
Received: by 10.114.15.9 with SMTP id 9mr9370193wao.82.1244994784030;
        Sun, 14 Jun 2009 08:53:04 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id m25sm4698731waf.9.2009.06.14.08.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 08:53:03 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: [PATCH v3] filter local function prefixed by $L
Date:	Sun, 14 Jun 2009 23:52:54 +0800
Message-Id: <d0983eb71d7517d0e536352f3288e995abbb0e07.1244994151.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244994151.git.wuzj@lemote.com>
References: <cover.1244994151.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

this patch fixed the warning as following:

mipsel-linux-gnu-objcopy: 'fs/proc/.tmp_gl_devices.o': No such file
mipsel-linux-gnu-ld: fs/proc/.tmp_gl_devices.o: No such file: No such
file or directory
rm: cannot remove `fs/proc/.tmp_gl_devices.o': No such file or directory
rm: cannot remove `fs/proc/.tmp_mx_devices.o': No such file or directory

the real reason of above warning is that the $Lxx local functions will
be treated as global symbols, so, should be filtered.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 scripts/recordmcount.pl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 533d3bf..542cb04 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -343,6 +343,10 @@ sub update_funcs
 	if (!$use_locals) {
 	    return;
 	}
+	# filter $LXXX tags
+	if ("$ref_func" =~ m/\$L/) {
+		return;
+	}
 	$convert{$ref_func} = 1;
     }
 
-- 
1.6.0.4
