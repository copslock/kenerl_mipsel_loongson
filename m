Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 19:03:55 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:53431
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992408AbeITRDvVnEOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 19:03:51 +0200
Received: by mail-wm1-x341.google.com with SMTP id b19-v6so262416wme.3;
        Thu, 20 Sep 2018 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OihSbtX6r/5FcAq4RCGAb9NXTtzuxjqR/7Wa5bdSJbk=;
        b=qIruuPQQTMZH9jcueFcJd1fLCT8nJpQUj6pUXz95Pwry4lGMb0eoEMIxlKwBu/d0Vr
         e08pIk3dKwcgsZIQI6WvXCqTIS0xniHZ8O6al9gGV905Xif68S0jvdOSRdA9emoiODqc
         8wPKm5UxxCPXn/jBvFCnAfzOOW2V1ya+wW0ZUurnk9xWaTbpeTTsBRNe+hUKnysDPAyJ
         +C1N5L5fM0E9EsafzliYYLdsAqvJGo+kyNT3TVn17uxNG1rBr0hWfW6BkMXLHC7owDx/
         PJd4ECU8bq1GVnW3bUFfFY0Nj/lGXl80FL0+vklyzDKUVUTIygeGSMHTApZyM5UovQ2b
         zbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OihSbtX6r/5FcAq4RCGAb9NXTtzuxjqR/7Wa5bdSJbk=;
        b=DP8XOtClbjYcK1JNynoKGyfsAk2pSITe16otUJnxUNR3Oy5PQFZKGvkvJd6Epm0vla
         QPTej5XzRsZQc5b92jJz8iLTPJoYFWRGxmaJwEZnv3PT8RgifN4WWEMDIPvap7P1cVdq
         cKNg45PPM1Iror0uCHkkmelHD4c6W0+afBdttoqzO3fxTX5paV9kkA5TuN3i9U6A7lx3
         R0ivRT1vOV1/cLKbr7w3RcD/G83iryQDNhbnS29OBOoteg/9mF4p0fmuYJIRS9jLHexC
         tBF1Fr2Y08jQzYiSD8PR36fSvdTWk1DY5fWGLUZeDgBfFG6ecA4hqRn5Fad0xIWX3qz0
         78UQ==
X-Gm-Message-State: APzg51BbIoTSr3QT2+m5I9TnGFM1oh7KSsF2OfdDjee6wVKqCjUT9naY
        KctaQoE9QB5l1aeg8po0qksFstZYLY8=
X-Google-Smtp-Source: ANB0Vdau4htIXZcDW86bmGFhHcxY+6O9ra2kvuKmnZV2LQcWtiaXuEACpdzvF5bGY6G/uFulMsQ3xA==
X-Received: by 2002:a1c:ac1:: with SMTP id 184-v6mr3499939wmk.119.1537463024959;
        Thu, 20 Sep 2018 10:03:44 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id t131-v6sm1540221wmg.10.2018.09.20.10.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:03:44 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Yasha Cherikovsky <yasha.che3@gmail.com>
Subject: [PATCH 0/1] MIPS: Lexra CPU support, prerequisite patch
Date:   Thu, 20 Sep 2018 20:03:05 +0300
Message-Id: <20180920170306.9157-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66462
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

This is a prerequisite patch required for adding Lexra CPU [1] support in
arch/mips.
It does not add any Lexra CPU support yet, but it is required for such future
support.

The patch is written on top of v4.18.

Background:
I'm currently working on porting Linux/MIPS to run on the Realtek RTL8186 SoC [1],
which has Lexra LX5280 CPU [2].

The complete Lexra + RTL8186 support is still WIP [3] so I'm not sending that
for review right now.

Thanks,
Yasha

[1] https://wikidevi.com/wiki/Realtek_RTL8186
[2] https://www.linux-mips.org/wiki/Lexra
[3] https://github.com/yashac3/linux-rtl8186/commits/rtl8186-porting-for-upstream-4.18


Yasha Cherikovsky (1):
  MIPS: Add new Kconfig variable to avoid unaligned access instructions

 arch/mips/Kconfig            |  7 +++++--
 arch/mips/kernel/unaligned.c | 24 ++++++++++++------------
 arch/mips/lib/memcpy.S       | 10 +++++-----
 arch/mips/lib/memset.S       | 12 ++++++------
 4 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.19.0
