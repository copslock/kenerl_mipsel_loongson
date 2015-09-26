Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2015 07:47:06 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34666 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006550AbbIZFrFKQ4p9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2015 07:47:05 +0200
Received: by padhy16 with SMTP id hy16so124599983pad.1;
        Fri, 25 Sep 2015 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CxSHunnICrwyOQIyr/7/wr7r3KSiaotZT3+p3eb2ipY=;
        b=05uD7sNc2ZvAWz+njjG9xIC7KYrXoW0lM3VoSBPaFP/aF7tfAHMOxo9FrJhX4kSkqt
         770m6ZHeQgKkOkmHF0NIByCZEYCPbUbXzILCR/ag1tNj8GYnaP7DvHjLU7jMMh3on31T
         F5T0iXr79ws2KZ2pqKr8YGpmYn1ZAG+i5+I6zdwypfqO4pr7BtPfIHbzxR+74oG0sGzj
         LSe5J6hEqkO/vt5pHEgclPpp6mA86biuUiCMGRrpxZIVB/51G2Eu8ns/CZyTDrp1sU5x
         IIhEqyU6LyhLmgREt5xAUSbxxM8+9lpENuA9nYuG9/2HRe7Pgr8ytD54yXmq+Wysudev
         RMqw==
X-Received: by 10.66.234.138 with SMTP id ue10mr12455699pac.9.1443246417855;
        Fri, 25 Sep 2015 22:46:57 -0700 (PDT)
Received: from debian.corp.sankuai.com ([103.29.140.56])
        by smtp.gmail.com with ESMTPSA id gt1sm7074339pbc.10.2015.09.25.22.46.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2015 22:46:57 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH v3 0/2] Ignore __arch_swab{16,32,64} when using MIPS16
Date:   Sat, 26 Sep 2015 13:41:41 +0800
Message-Id: <1443246103-31122-1-git-send-email-yszhou4tech@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

v3 <- v2

	- Revert the previous fix that adding nomips16 attributes and assembler
	  directives to those functions
	- Exclude __SWAB_64_THRU_32 from the #ifdef..#endif block

v2 <- v1

	Also ignore __arch_swab64 instead of just __arch_swab{16,32}.

Yousong Zhou (2):
  Revert "MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when using
    MIPS16."
  MIPS: UAPI: Ignore __arch_swab{16,32,64} when using MIPS16

 arch/mips/include/uapi/asm/swab.h |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

-- 
1.7.10.4
