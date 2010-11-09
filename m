Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 08:48:13 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:43176 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab0KIHsI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Nov 2010 08:48:08 +0100
Received: by fxm11 with SMTP id 11so4888759fxm.36
        for <multiple recipients>; Mon, 08 Nov 2010 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=bnt5TvfQOHxa0HWfo/uAGtTvLyFjh+MVqX6p0s1X3GM=;
        b=eKiRgXaySy2GlgIZDq9OjvendNBUakNrF83T3MmvqnMwO1EUgq+CnGi0JEeU4iHv5/
         N7FuBa7ybBWnEB9ZvDS+yXn39p394KikccRp5BqZICD2vSZDdrQO2JGDMPlCRLDI5yQQ
         2yzJZ44AFppxnIy+msJ0fNtsb1wnteAP53Qxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EMt1RERH0gU9AedAd1DQhlvLYbg3z6a0GcsqPosBO7fnGwg6LwKDOn9DTabBk4gmsZ
         3UMYq9VYxbcFvbREsp8YjGZxbtp/WxK6kA01HDJ47SMk+9RAL1Hcc2QLrrcBTvG90kd/
         FV9XczTi33SIHY9yZRub9wZd7E2PIhAuVv+Fo=
MIME-Version: 1.0
Received: by 10.223.93.202 with SMTP id w10mr4047285fam.22.1289288883210; Mon,
 08 Nov 2010 23:48:03 -0800 (PST)
Received: by 10.223.86.200 with HTTP; Mon, 8 Nov 2010 23:48:03 -0800 (PST)
Date:   Tue, 9 Nov 2010 15:48:03 +0800
Message-ID: <AANLkTimuGUjcCsnmO3ZgQL-2vD7iD3bgg5V2tDbA_TpU@mail.gmail.com>
Subject: [PATCH] MIPS: Separate two consecutive loads in memset.S
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
Precedence: bulk
X-list: linux-mips

partial_fixup is used in noreorder block.

Separating two consecutive loads can save one cycle on processors with
GPR intrelock and can fix load-use on processors that need a load delay slot.

Also do so for fwd_fixup.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/lib/memset.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 77dc3b2..606c8a9 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -161,16 +161,16 @@ FEXPORT(__bzero)

 .Lfwd_fixup:
        PTR_L           t0, TI_TASK($28)
-       LONG_L          t0, THREAD_BUADDR(t0)
        andi            a2, 0x3f
+      LONG_L          t0, THREAD_BUADDR(t0)
        LONG_ADDU       a2, t1
        jr              ra
         LONG_SUBU      a2, t0

 .Lpartial_fixup:
        PTR_L           t0, TI_TASK($28)
-       LONG_L          t0, THREAD_BUADDR(t0)
        andi            a2, LONGMASK
+      LONG_L          t0, THREAD_BUADDR(t0)
        LONG_ADDU       a2, t1
        jr              ra
         LONG_SUBU      a2, t0
--
1.7.1
