Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 21:00:57 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43873 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835005Ab3EQTAwOzMa- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 21:00:52 +0200
Received: by mail-pd0-f176.google.com with SMTP id r11so297795pdi.35
        for <multiple recipients>; Fri, 17 May 2013 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=53vBIkw1nwq5W6F2hOvQiTNCa+3hCpsCg4vg9PibiPo=;
        b=MuYke5n6RkRWoZMdKd6cBu8+1860V/lUvlD5O552kpA3zp+PiRceY/DkWEGH8Zaw49
         NDwE/qYBzQr2UY4/Iead33AhsIVbvs0nCIdyom73YWaX0oc1BUmtlpx0WUj2Puh7gtNL
         B0Mc5w0uy8+X2k8ilPBast5YtpnL4gO570WFQ9c+hZyv21Qm5IuspHexNioiWdeCMrCQ
         7Vvpd0bZ5CtvtndDN4KT4KuCe3QcSDdjSnjdNFelClspNBzb86mDR5WYBKy5IiVyxgDn
         avcRk9l2rYTPmVCvtmZpvItLGPymJ6HHEI9yAnIrZyrCqm3LcCGQnKRwNlZpZvDwv043
         xDJA==
X-Received: by 10.66.251.202 with SMTP id zm10mr50516797pac.53.1368817245662;
        Fri, 17 May 2013 12:00:45 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id zy5sm12215101pbb.43.2013.05.17.12.00.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 12:00:44 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4HJ0hgC011583;
        Fri, 17 May 2013 12:00:43 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4HJ0eOt011582;
        Fri, 17 May 2013 12:00:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] perf tools: Add MIPS userspace DWARF callchains.
Date:   Fri, 17 May 2013 12:00:36 -0700
Message-Id: <1368817238-11548-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

These patches to the perf tool depend on the kernel patch here:

http://www.linux-mips.org/archives/linux-mips/2013-05/msg00124.html

With these two applied, I get the same nice call graphs on MIPS that
are obtained on my x86_64 workstation.

The patches are against Jiri Olsa's
git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git perf/core
branch.  I hope that is the proper thing to base these things off of.

David Daney (2):
  perf tools: Add support for MIPS userspace DWARF callchains.
  perf tools: Hook up MIPS unwind and dwarf-regs in the Makefile

 tools/perf/Makefile                      |  3 ++
 tools/perf/arch/mips/Makefile            |  7 +++
 tools/perf/arch/mips/include/perf_regs.h | 84 ++++++++++++++++++++++++++++++++
 tools/perf/arch/mips/util/dwarf-regs.c   | 37 ++++++++++++++
 tools/perf/arch/mips/util/unwind.c       | 20 ++++++++
 tools/perf/config/Makefile               | 12 ++++-
 6 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/include/perf_regs.h
 create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/mips/util/unwind.c

-- 
1.7.11.7
