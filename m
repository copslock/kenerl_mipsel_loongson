Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:21:18 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:61191 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492545AbZJYPSd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:18:33 +0100
Received: by pzk35 with SMTP id 35so7469372pzk.22
        for <multiple recipients>; Sun, 25 Oct 2009 08:18:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=98aeXiFxfMvCXjNgA2vhZJ5kjJj9mEMQvP9UOvGmrXU=;
        b=i8lt8A9zZG33MJ8ibKq2So3uqR9OgaJrJEuRcc7NjHEj5OnlmHosCDKPYHWhtJrDMQ
         cKs1ZITu70j6VIsS4dAIaVWfo8ZnIucZwRBUpmrtdKFmj3JOM3DHQPV1WdG6ZagsFMfn
         pvnwRALTQ7uwsCrDzrz5l6RoD9QXCu5JIZsyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J117MHTf4gfMZtfKbE+1XF8l2n87k9LiM7aV/lS3VVunExWTTFHfMiMwspEppCrl3o
         UN1TZGbvsYHNCseovVd6c0flqCVGWzLMAp3qy2M52S/QssckQKaD8106JPh7eoxTQFF5
         P9tFSls/vp7spNw+9vU99LoZTDD/gqkOGDG/8=
Received: by 10.114.7.13 with SMTP id 13mr1100879wag.82.1256483905688;
        Sun, 25 Oct 2009 08:18:25 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.18.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:18:24 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v5 09/11] tracing: add IRQENTRY_EXIT for MIPS
Date:	Sun, 25 Oct 2009 23:17:00 +0800
Message-Id: <6ad82af0c2ec8ef7b9f536b0a97bf65d385c3945.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch fix the following error with FUNCTION_GRAPH_TRACER=y:

kernel/built-in.o: In function `print_graph_irq':
trace_functions_graph.c:(.text+0x6dba0): undefined reference to `__irqentry_text_start'
trace_functions_graph.c:(.text+0x6dba8): undefined reference to `__irqentry_text_start'
trace_functions_graph.c:(.text+0x6dbd0): undefined reference to `__irqentry_text_end'
trace_functions_graph.c:(.text+0x6dbd4): undefined reference to `__irqentry_text_end'

(This patch is need to support function graph tracer of MIPS)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/vmlinux.lds.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 162b299..f25df73 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
 		*(.text.*)
 		*(.fixup)
 		*(.gnu.warning)
-- 
1.6.2.1
