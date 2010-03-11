Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:11:56 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:44214 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490963Ab0CKDLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:11:52 +0100
Received: by bwz7 with SMTP id 7so6743579bwz.24
        for <multiple recipients>; Wed, 10 Mar 2010 19:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=M+/1Nf6//C1Mhbr3obKmGo5Tb9r0JGT/4+1EJGzfUzM=;
        b=gdE2Hu8IlccXs0N8YhLoLiB+dE0aULgO0se/TcECOWenLfyTFO1SfCd/GuVo/kZKdn
         dVlQ8V05lHKvXP2izIzLZhNXA+98VOOxxaoJbKL2yTwvyvbMz5dUDWWEJmDc4kNo55Td
         2vkPTbrLCQK0f1vtUdePA8d+VxbIA9t7q7qrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cPuE2CLki/9FS0Mn2cQs5Q+hIrD2EuZT1JR4hJEMxSXyl5KQImtG2/EuNb3MFAn/xi
         zilN3gL3/euCbri3scmBwa5WcUfQufa3/eD++arGgcugAS3hRw1jyamh4NqevDFUiEZW
         729AZ5F4bLT4UQI6FlICTlO6otIdQpEesGvrg=
Received: by 10.204.7.139 with SMTP id d11mr215201bkd.162.1268277102328;
        Wed, 10 Mar 2010 19:11:42 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id g18sm30688020bkw.13.2010.03.10.19.11.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:11:41 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Sergei Shtylyov <sshtylyov@mvista.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2 0/3] Workaround the Out-of-order Issue of Loongson-2F
Date:   Thu, 11 Mar 2010 11:05:01 +0800
Message-Id: <cover.1268276417.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from old version:

  o Cleanup some comments and align some instructions.
  
----

As the Chapter 15: "Errata: Issue of Out-of-order in loongson"[1] shows, to
workaround the Issue of Loongson-2F，We need to do:

  o When switching from user model to kernel model, you should flush the branch
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
