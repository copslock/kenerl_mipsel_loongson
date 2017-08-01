Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2017 16:08:48 +0200 (CEST)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:37218 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994626AbdHAOIj73oIY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Aug 2017 16:08:39 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 9727C3F6AB
        for <linux-mips@linux-mips.org>; Tue,  1 Aug 2017 16:08:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R7Xesjokfxnc for <linux-mips@linux-mips.org>;
        Tue,  1 Aug 2017 16:08:32 +0200 (CEST)
Received: from [10.0.1.7] (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 459F03F38C
        for <linux-mips@linux-mips.org>; Tue,  1 Aug 2017 16:08:29 +0200 (CEST)
From:   Fredrik Noring <noring@nocrew.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Update PS2 R5900 to kernel 4.x?
Message-Id: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
Date:   Tue, 1 Aug 2017 16:08:27 +0200
To:     linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.3259)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hello MIPS maintainers,

I'm trying update the PS2 R5900 patch to kernel version 4.x. I started
at 2.6.35 and it was easy up to v3.9-rc1 commit 64b3122 which crashes with
a memory fault at boot:

  commit 64b3122df48b81a40366a11f299ab819138c96e8
  Author: Al Viro <viro@zeniv.linux.org.uk>
  Date:   Thu Dec 27 11:52:32 2012 -0500
  
      mips: take the "zero newsp means inherit the parent's one" to copy_thread()
      
      Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I've pushed the patched (working) parent commit here:

  https://github.com/frno7/linux/tree/ps2-v3.9-rc1-974fdb3

The whole PS2 R5900 patch is quite large, but I suspect the problem is limited
to changes in arch/mips/kernel, more specifically:

  arch/mips/kernel/process.c
  arch/mips/kernel/scall32-n32.S
  arch/mips/kernel/syscall.c

(Several system calls etc. have been rearranged since 2.6.35.) I've been stuck
for a couple of days trying to get this to work. Would anyone be able to help?

Many thanks,
Fredrik
