Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 06:29:45 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:57556 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491019Ab0JPE3m convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 06:29:42 +0200
Received: by qyk4 with SMTP id 4so2042400qyk.15
        for <linux-mips@linux-mips.org>; Fri, 15 Oct 2010 21:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Ws556u+HgcY4y2KLAHJ2yncvm1Rt68m1jwALoksvoXY=;
        b=WxVwdZX7cHiUMSbWFJ3MjarzJXjkcwWIXx8g9GpaIXBo0agB/DOSqat63lXBLEF5Fk
         RQ/r2w9QdGDs7GW2T//Vmw3wIRogUZSGxci+rUOpPI0q5VrJb1eO6bvc5NdvUWFxLHMw
         1ulwHH2BInRp5oj8zKgoj2Fk9bu9rKwFLF0jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZreMZhlzHhhLDpCK2RMLVwUznJpc2L+2wvdvYlW6htXoaR21L1WrTcbvzZ6PnOE+b7
         QTk3CIg+zqyiYM8H54Kqc4g6+1lUQXCo0UlXCBC7CxrjqGFHrjrO2gYrjqha9JOn8pYq
         Q1m/55pWWbhYz45E5vgVfrS5cfCkw1LyMQb38=
MIME-Version: 1.0
Received: by 10.229.250.193 with SMTP id mp1mr1475922qcb.129.1287203374794;
 Fri, 15 Oct 2010 21:29:34 -0700 (PDT)
Received: by 10.229.82.6 with HTTP; Fri, 15 Oct 2010 21:29:34 -0700 (PDT)
In-Reply-To: <E1P6yLw-0007i6-SH@localhost>
References: <E1P6yLw-0007i6-SH@localhost>
Date:   Fri, 15 Oct 2010 22:29:34 -0600
Message-ID: <AANLkTinObhLpUNqCJ+0d4FSKF1gg2=TcXCThKpfQd9Fz@mail.gmail.com>
Subject: Fwd: [MIPS] Fix compile failure in 2.6.36-rc8 on 32-bit MIPS
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

Too sleepy, missed linux-mips on the To: list of this patch!

Shane

---------- Forwarded message ----------
From: Shane McDonald <mcdonald.shane@gmail.com>
Date: Fri, Oct 15, 2010 at 10:26 PM
Subject: [MIPS] Fix compile failure in 2.6.36-rc8 on 32-bit MIPS
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
ralf@linux-mips.org, viro@ftp.linux.org.uk


There was a typo in commit d27240b, MIPS: Sanitize restart logics,
that causes a compile failure in 2.6.36-rc8 on 32-bit MIPS systems.
This patch corrects that typo.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/kernel/scall32-o32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 58fb2bc..fbaabad 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -63,7 +63,7 @@ stack_done:
       sw      t0, PT_R7(sp)           # set error flag
       beqz    t0, 1f

-       lw      t1, PR_R2(sp)           # syscall number
+       lw      t1, PT_R2(sp)           # syscall number
       negu    v0                      # error
       sw      t1, PT_R0(sp)           # save it for syscall restarting
 1:     sw      v0, PT_R2(sp)           # result
--
1.6.2.4
