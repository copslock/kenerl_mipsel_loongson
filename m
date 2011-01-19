Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:28:56 +0100 (CET)
Received: from mail-px0-f177.google.com ([209.85.212.177]:52059 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1AST2v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:28:51 +0100
Received: by pxi7 with SMTP id 7so231768pxi.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=SuDJ50M+xhOBvr5Vs0Tpmpgg/oH8J1HbTuQ7mxBuuU4=;
        b=pA9rpbf47V51mn6w0P7O7FZexr/Z6jn89IpxBtXFnl8VC40MpNHf4zLPtM49fHhNxn
         S2lzKco7vN0ktfKErW/npXFO4u1zeK4WlTHdtY+CdFqhwdfaXCNIuJjV10srn3g06i3U
         A/2fWEWHKLxC0PlzJObd0AeDpqqgKmiD3UH8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XG9OmeyzaiD+AFcXPiR8fn36Cm8CHJqU8ApT8NVegKm6H0KXXJwOqGHGek5P+3257N
         NlaVrlqN/Z7NZ9XFQ9/Z7V9cCpvjFyRubfwp6Crta1ZbNjvp4HLmHJkBjKk4GUVBRy9G
         5xaEmZ9flU7/qAVLUk3kIXpy4sxjSPcLnf3RQ=
Received: by 10.142.133.17 with SMTP id g17mr1119640wfd.167.1295465323466;
        Wed, 19 Jan 2011 11:28:43 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.28.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:28:42 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>,
        linux-mips@linux-mips.org, xzhong86@163.com
Subject: [PATCH 0/5] Misc updates for Ftrace of MIPS
Date:   Thu, 20 Jan 2011 03:28:25 +0800
Message-Id: <cover.1295464855.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf and Steve

This adds several patches for Ftrace of MIPS, most of them are trivial
cleanups, the last one fixes the useful set_graph_function interface provided
by function graph tracer.

The 1st two patches has been sent before, here just resend them.

Thanks very much to Zhiping for reporting the set_graph_function problem.

Regards,
	Wu Zhangjin

Wu Zhangjin (5):
  tracing, MIPS: Speed up function graph tracer
  tracing, MIPS: Substitute in_kernel_space() for in_module()
  tracing, MIPS: Clean up prepare_ftrace_return()
  tracing, MIPS: Clean up ftrace_make_nop()
  tracing, MIPS: Fix set_graph_function of function graph tracer

 arch/mips/kernel/ftrace.c |  179 ++++++++++++++++++++++++---------------------
 1 files changed, 95 insertions(+), 84 deletions(-)
