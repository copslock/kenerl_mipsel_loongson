Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 13:16:44 +0200 (CEST)
Received: from mail-wm1-x342.google.com ([IPv6:2a00:1450:4864:20::342]:34884
        "EHLO mail-wm1-x342.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeIZLQk6K62W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 13:16:40 +0200
Received: by mail-wm1-x342.google.com with SMTP id o18-v6so1882741wmc.0;
        Wed, 26 Sep 2018 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uTy+mmOaZ76/eGRokeLFBv4J+yiuPWsYbtjpghyX7A=;
        b=U9vlvx3xFnm5Dnl2bL/EMvO+Sqb9RrBBBlKjy9WtUesqDY93j7qesBt78fctkPugOF
         kdAud/pEu0358FazKHXp53PqACJSI+VO4JPnPeqJuJDGl3N8pEXL3S2YrJnlwhVqrkFo
         0PRG09ULDJgJEXqvtD2tLg7NDiHPESrbz/ChGwulHS1Ua6YUc7n3km7/hk7oNcdZO2rH
         AvLiClvmZZ9cPr9BjL/Vqq+0KwjnKMHWcWTZJWcObV4XdeDfZxP3pB7DC3wtXDa4fGr4
         ZtLZ6aP2+2BSmqdE4XT2/rzzeKf2NYKZaSaKhf9vNVFcz1VDL2+5kuv4m7FPeKKj9fUu
         hXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uTy+mmOaZ76/eGRokeLFBv4J+yiuPWsYbtjpghyX7A=;
        b=pCNg8B4y6NmZYNYKzPe75Zsh/pROZk4w77p/mYPjxs4YXOWZXhnv2L5CQzUf3iaMv4
         RxZmd5pSaB3hKsVx635Cv/YAeJNyh8qVF5Y01Ei6jBWWtxcvt43T6ynxxbjOvegEOBGM
         uxADJTTZExQ7jw7gm50m+r+Eny7SOp1RDBM5TJsP/UcI7gBFp76Rs59NSUs31OzRjmW1
         sXZdWI7PJvXy7yE5MjosQHN8+7EuNhIL5jKKhmlAwl3KefM6JWGADrv2lFNUlsjNPe3T
         qbOWanunWMp9bDrnnChg2QrHCFsgX3IJcFkRIGeFuSOWqrI0HC3j5hHWdWkhq/RczsOJ
         BgeQ==
X-Gm-Message-State: ABuFfoiVItpbyw+LNhdb9QR1G0ugGmhogi50hlkM2sVPs/w7V7nR1/XH
        RvDVnsR1uPxcAN5LsnfNN0D0yOx7r5s=
X-Google-Smtp-Source: ACcGV63wr7yD/mp0J65zlEV62C2QP0xzu4rPFGUWU1nuJHeBvvT2xFLYmgdbzgs86D7RRUq4YFBK2g==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr2613205wmh.151.1537960595212;
        Wed, 26 Sep 2018 04:16:35 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id r64-v6sm3885724wme.42.2018.09.26.04.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 04:16:34 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] MIPS: Lexra CPU support, prerequisite patch
Date:   Wed, 26 Sep 2018 14:16:14 +0300
Message-Id: <20180926111615.6780-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

Hi,

This is the v2 of:
https://www.linux-mips.org/archives/linux-mips/2018-09/msg00641.html

Changelog:

v1 -> v2:
- Rebased on v4.19-rc5
- Addressed Paul's comments:
  https://www.linux-mips.org/archives/linux-mips/2018-09/msg00735.html


The patch is also available at:
https://github.com/yashac3/linux-rtl8186/commits/unaligned_load_store_on_4_19


Please review.

---

This is a prerequisite patch required for adding Lexra CPU [1] support in
arch/mips.
It does not add any Lexra CPU support yet, but it is required for such future
support.

The patch is written on top of v4.19-rc5.

Background:
I'm currently working on porting Linux/MIPS to run on the Realtek RTL8186 SoC [1],
which has Lexra LX5280 CPU [2].

The complete Lexra+RTL8186 support is still WIP [3] so I'm not sending that
for review right now.

Thanks,
Yasha

[1] https://wikidevi.com/wiki/Realtek_RTL8186
[2] https://www.linux-mips.org/wiki/Lexra
[3] https://github.com/yashac3/linux-rtl8186/commits/rtl8186-porting-for-upstream-4.18

Cc: linux-kernel@vger.kernel.org

Yasha Cherikovsky (1):
  MIPS: Add Kconfig variable for CPUs with unaligned load/store
    instructions

 arch/mips/Kconfig            | 35 +++++++++++++++++++++++++--
 arch/mips/kernel/unaligned.c | 47 ++++++++++++++++++------------------
 arch/mips/lib/memcpy.S       | 10 ++++----
 arch/mips/lib/memset.S       | 12 ++++-----
 4 files changed, 67 insertions(+), 37 deletions(-)

-- 
2.19.0
