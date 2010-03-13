Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 05:41:13 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50819 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491001Ab0CMElF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 05:41:05 +0100
Received: by pwj2 with SMTP id 2so1145438pwj.36
        for <multiple recipients>; Fri, 12 Mar 2010 20:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=PmhfZVavA9GI1SxBc/5y9Qb8LUrzbS7lKl5advSSUQc=;
        b=J+JjKnnmUwOyGt6W5CZC1eve1YwK/vaIHFTOYs8kQjD3LD3qtEDwmbDMcyIlH4f6dH
         OCennhcrlmyKqNUk3DG2lHFqRVZ9WdDm1ggjp9sfLGEAbclOMLH6pQF8Da30/I3F8TSs
         pHKBSpp5Sr/KdGp/d7j+Lhm2dPaT0grLGD0h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=KyFNSKwWrVKeW2ANLA/pzix6iEPQ9gOKtvUa3/TBYLECqiBAuDi50gEmQ4OxEUsI99
         eFKx25eguZcqnKFRs2lJeC0kT/+jkaYHQLip+os3/4v7CeKwAuYP5M4irM7R1UlbGvT6
         ucMKHRLLZkJvZfpCJgaoPRbWxtXLvpzG7zk90=
Received: by 10.115.64.6 with SMTP id r6mr3416873wak.85.1268455257628;
        Fri, 12 Mar 2010 20:40:57 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm2172318pzk.0.2010.03.12.20.40.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:40:57 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v3 0/3] Workaround the Out-of-order Issue of Loongson-2F
Date:   Sat, 13 Mar 2010 12:34:14 +0800
Message-Id: <cover.1268453720.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Hi, Ralf

Is that possible to apply this patchset for both 2.6.33(the stable release) and
2.6.34? then we can get a not broken support for loongson-2f with the
options(-mfix-loongson2f-nop, -mfix-loongson2f-jump) provided by the latest
binutils (>=2.20.1).

Thanks & Regards,
       Wu Zhangjin

-------

Changes:

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

Regards,
        Wu Zhangjin

Wu Zhangjin (3):
  Loongson-2F: Flush the branch target history such as BTB and RAS
  Loongson-2F: Enable fixups of binutils 2.20.1
  Loongson-2F: Fixup of problems introduced by -mfix-loongson2f-jump of
    binutils 2.20.1

 arch/mips/Makefile                 |    4 +++-
 arch/mips/include/asm/stackframe.h |   19 +++++++++++++++++++
 arch/mips/loongson/common/reset.c  |   11 ++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)
