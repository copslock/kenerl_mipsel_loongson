Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:19:08 +0200 (CEST)
Received: from mail-iw0-f179.google.com ([209.85.223.179]:38241 "EHLO
        mail-iw0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491195Ab0DGNTC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:19:02 +0200
Received: by iwn9 with SMTP id 9so511762iwn.0
        for <multiple recipients>; Wed, 07 Apr 2010 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=wW79bNVlvzikJLy0Hs7Y4YPojGmBm75idveX5lbr/FA=;
        b=YTrh92DR0BqgNKcorC8jxqBlQouDfa0Qsge6zOBSWGHVpKkQZwmOn9piLvTzBbU/MA
         LRxupBgzCCJoeeNzLRzPXn0ui4KNAWkz1Xk0K6+/g23BtNvP+VsDdZiga9OJbq6UKZN4
         4jIXh6jKufcl0t3Xt09vOhTM+KZNr/W0TuNG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=adI1UpQ4bG0pdXpG4TmO16l/gqMnEuFA0UOz/qIJn2g2rWp8t6rBT9E+ZjM+pcudOR
         VdoegXXcuEwBJTS/im4hMfYVExychNzWhH1yh1u4psyTbPRCJvjfft3s1UzxlssT8/VB
         T1N8AiOtQlqIwQv9E/ECeqwvlXon84i24qLIs=
Received: by 10.142.59.5 with SMTP id h5mr3393024wfa.185.1270646334897;
        Wed, 07 Apr 2010 06:18:54 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm3753168pzk.15.2010.04.07.06.18.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:18:54 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4 0/4] Workaround the Out-of-order Issue of Loongson-2
Date:   Wed,  7 Apr 2010 21:11:50 +0800
Message-Id: <cover.1270645413.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

v3->v4:

  + Incorporated with the feedbacks from Ralf.
    o add a new kernel config option to allow the users to disable the
    workarounds for the new loongson2f batches(2F03 and newer).
    o enable the workarounds unconditionally for the related loongson2f(2F01/02).
    o use a safer method to fixup the reset issue introduced by the workaround.

v2->v3:

  o Herein, RAS is short for Return Address Stack not Row Address Strobe, at
  the same time, the "model" in the translation of Chapter 15 should be "mode".
  (feedback from Shinya Kuribayashi)
        
v1->v2:

  o Cleanup some comments and align some instructions.
  
----

As the Chapter 15: "Errata: Issue of Out-of-order in loongson"[1] shows, to
workaround the Issue of Loongson-2F，We need to do:

  o When switching from user mode to kernel mode, you should flush the branch
  target history such as BTB and RAS.
 
  o Doing some tricks to the indirect branch target to make sure that the
  indirect branch target can not be in the I/O region.

This patchset applied the above methods and for the binutils patch[3] have been
merged into binutils 2.20.1, so, it's time to upstream this patchset now.
without this patch, the machines will hang when the instruction sequence hit
the Out-of-order Issue of Loongson-2F, therefore, this patchset is very urgent
for both 2.6.33 and 2.6.34.

[1] Chinese Version: http://www.loongson.cn/uploadfile/file/20080821113149.pdf
[2] English Version of Chapter 15:
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source
[3] http://sourceware.org/ml/binutils/2009-11/msg00387.html 

Wu Zhangjin (4):
  Loongson: Add CPU_LOONGSON2F_WORKAROUNDS
  Loongson-2F: Enable fixups of the latest binutils
  Loongson-2F: Flush the branch target history in BTB and RAS (cont.)
  Loongson-2F: Fixup of problems introduced by -mfix-loongson2f-jump

 arch/mips/Kconfig                  |   26 ++++++++++++++++++++++++++
 arch/mips/Makefile                 |   13 +++++++++++++
 arch/mips/include/asm/stackframe.h |    2 +-
 arch/mips/loongson/common/reset.c  |   20 +++++++++++++++++++-
 4 files changed, 59 insertions(+), 2 deletions(-)
