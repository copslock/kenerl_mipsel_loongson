Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 23:47:26 +0200 (CEST)
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41515 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993006AbeFSVrTKcNdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 23:47:19 +0200
Received: by mail-yb0-f194.google.com with SMTP id f14-v6so476030ybg.8;
        Tue, 19 Jun 2018 14:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D1b452cPMWfxhYWP98VQHWGo0nNdgHczEIl56yxt5ko=;
        b=oLmzg40/Rck/rhv1XigY1toyV6qItZBY3r6G/LmpCA/kPMlS8LeE8w5mDDpBtNW9qF
         X/XAgpu3CIXrTDBOUzQhvOenbQV0g+g1Xl4MvIZN7irEp730lihNXnPh9yIVJTnKqFkY
         n3Sy64nyJ/BtLUMeBHw4xPW+v9kzeUEOlAM7GQcKwyu1nz0+Y/fh70xxO9iC5sXYOLuB
         tOw8mKRT5/Qu13B8FYq5pIVFdekM94qvgw2wX34EEZbl11KKVuj7UbC8t1/Wkva4ZUR5
         5ohu0lmJtTrlIVqrionckyfZNsKwFbLUmTc1HRUuymaXjsZWcOx0KYW+9KcDTHbNKw/H
         BMLg==
X-Gm-Message-State: APt69E2bSLTMU/0Hni7WZLxJjFDjys/RQrfhI1p96CG6LhJHulEDDWiT
        QDPoFLoshOONa4H8X33DT7qqON8=
X-Google-Smtp-Source: ADUXVKJjpMTOv1cNfNTe/7iimKIE2M7xv6w6DgOnL6B6I+k7RnOOEgrOkyazqPwfbGIz3VdAhf3Qrg==
X-Received: by 2002:a25:98c1:: with SMTP id m1-v6mr8921871ybo.265.1529444832972;
        Tue, 19 Jun 2018 14:47:12 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 0/5] MIPS: Clean-up DT bus probing
Date:   Tue, 19 Jun 2018 15:47:05 -0600
Message-Id: <20180619214710.22066-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

This is a series of clean-ups of DT bus probing calls. Generally, the 
DT core code takes care of the default case and arches/platforms only 
need to do their own call if they have non-default matching 
requirements.

Rob

Rob Herring (5):
  MIPS: octeon: use of_platform_populate to probe devices
  MIPS: netlogic: remove unnecessary of_platform_bus_probe call
  MIPS: bmips: remove unnecessary call to register "simple-bus"
  MIPS: generic: remove unnecessary of_platform_populate call
  MIPS: lantiq: remove unnecessary of_platform_default_populate call

 arch/mips/bmips/setup.c                   |  7 -------
 arch/mips/cavium-octeon/octeon-platform.c |  2 +-
 arch/mips/generic/init.c                  | 13 -------------
 arch/mips/lantiq/prom.c                   |  8 --------
 arch/mips/netlogic/xlp/dt.c               | 14 --------------
 5 files changed, 1 insertion(+), 43 deletions(-)

-- 
2.17.1
