Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 18:19:23 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63765 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492254Ab0CIRTO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 18:19:14 +0100
Received: by fxm27 with SMTP id 27so3020549fxm.28
        for <multiple recipients>; Tue, 09 Mar 2010 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=mupSUUzEgodFDhcU6NPOe2Qucdsh8bnmY1TEvcbx5+8=;
        b=Pvk6Yd8+oUM+FT4zPn1p1Pekg0xLS6rUo7cNoS7/+sSooVzRzIAftJWBOThVkGyv3Q
         mB05A5H4nocIZDbxJR1vb/p2OKaskF1LNvrn51Wl9VnI8vJW4fmdT4Tgqr9J54DHZ3ha
         CcZ4yXMQ0S+tMlnuRtrKPKaFb8CZtlPYcPBes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NPrO1epbVuuoF6XIpLKq/2lAWvUAcCODQuO159lSYBZX5GnrMrjC9Sw/0FayTrqwrf
         rrMkprdzqwe4MwtMggdjeW+lg6iftBLUldzHl1zUN0W0X00wzcaZwrydcEeG2OT4KuNd
         lJCWiA+1f4vm0akvK/cKZsyngq+5t330QcAHI=
Received: by 10.223.36.92 with SMTP id s28mr109255fad.28.1268155146307;
        Tue, 09 Mar 2010 09:19:06 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 31sm11418183fkt.47.2010.03.09.09.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 09:19:05 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Greg KH <gregkh@suse.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 0/3] Workaround the Out-of-order Issue of Loongson-2F
Date:   Wed, 10 Mar 2010 01:12:30 +0800
Message-Id: <cover.1268153722.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

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
 arch/mips/loongson/common/reset.c  |   12 +++++++++++-
 3 files changed, 33 insertions(+), 2 deletions(-)
