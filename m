Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 13:08:33 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:36846
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdGRKRolkFNd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 12:17:44 +0200
Received: by mail-wr0-x244.google.com with SMTP id y67so1449587wrb.3
        for <linux-mips@linux-mips.org>; Tue, 18 Jul 2017 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1ekkiy2g+M7FPDZ21WANrrjeUxkf7Ll6rM2VtDBfESc=;
        b=ojuA6SUmhkzgLfJWJIUpufZ8aYi6aeHGBh99geD/lt4pLTDM9n6dPJCjetuMtiShVl
         se9wL6nnf3XTuzFtsT6pwBnMuubBohvHE0iT1x7vV3+6kBb0hxrl/oP3bGdg2rDKpGPp
         2v6DOaVmh8gHRMb59FqCItRqJcET/lV+CWQ6fFwdH0c1lb1CuA1LT6p4JsQpDFbbHpmf
         QOq2RVIYxwH/WOmDhhc0B2K0lJA1zMrq1IShmECCIBlpeEVLWTgivO9Rjsrf+eSniWSu
         ihVj4iPQkk5DTi9Yp7725nlqBxtpuR+BxHKax5OjOfKdkYJcRsTOqK+CjJCkKN4ad59+
         asqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ekkiy2g+M7FPDZ21WANrrjeUxkf7Ll6rM2VtDBfESc=;
        b=qDTcih+rH0Y8z3yHPdh1WODtoKqrF8yI9hPR6tC5GRGDfl/vpORCNxK1NseDBnzSVf
         gx5jFNHY9BdiTqeVx7TABiFB3K82Wkbr25hFogPMc0nuZaJswXjl84nGCOIJNvH1YyK0
         pNHXS8q+D+JenAU99zzx6a/cD5AvIcn1gsycSvQSGIzjYUrjuF/IeF46UQQix4QZHnlb
         Xk9jBBn8E96kFDu4R7/nVhGuDl6F4o/Ac3YT8HMkb66HNf24ZMBMUvTlL1l4pI9IYPIj
         +St7ecNgicFoviClSo3mn/n9snn9c7TQTsQzLRdNGr+q2P973XOZuzrAlsakbbFJkm2c
         rzlw==
X-Gm-Message-State: AIVw1125Y4ee3GAu+s8oQV+ncxwjKK/E/rhlSqbKUtHG//hiiMwsh4bo
        9EWAfpkoeplBjw==
X-Received: by 10.223.179.216 with SMTP id x24mr652602wrd.7.1500373059384;
        Tue, 18 Jul 2017 03:17:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 9sm3253728wml.25.2017.07.18.03.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 03:17:38 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org
Subject: [PATCH 0/9] make clk_get_rate implementations behavior more consistent
Date:   Tue, 18 Jul 2017 12:17:21 +0200
Message-Id: <20170718101730.2541-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59131
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

The common clock and several other clock API implementations allow
calling clk_get_rate with a NULL pointer. While not specified as
expected behavior of the API, device drivers have come to rely on that,
causing them to OOPS when run on a platform with a different clock API
implementation.

Fix this by making sure all clk_get_rate implementations handle
NULL clocks instead of OOPSing.

While some custom implementations even allow ERR_PTR()s, I decided
against that as IIRC the usual idea is that errors should be handled and
not silently carried over.

Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@linux-mips.org

Jonas Gorski (9):
  ARM: ep93xx: allow NULL clock for clk_get_rate
  ARM: mmp: allow NULL clock for clk_get_rate
  blackfin: bf609: allow NULL clock for clk_get_rate
  m68k: allow NULL clock for clk_get_rate
  MIPS: AR7: allow NULL clock for clk_get_rate
  MIPS: BCM63XX: allow NULL clock for clk_get_rate
  MIPS: Loongson 2F: allow NULL clock for clk_get_rate
  MIPS: ralink: allow NULL clock for clk_get_rate
  unicore32: allow NULL clock for clk_get_rate

 arch/arm/mach-ep93xx/clock.c           | 3 +++
 arch/arm/mach-mmp/clock.c              | 4 +++-
 arch/blackfin/mach-bf609/clock.c       | 2 +-
 arch/m68k/coldfire/clk.c               | 3 +++
 arch/mips/ar7/clock.c                  | 3 +++
 arch/mips/bcm63xx/clk.c                | 3 +++
 arch/mips/loongson64/lemote-2f/clock.c | 3 +++
 arch/mips/ralink/clk.c                 | 3 +++
 arch/unicore32/kernel/clock.c          | 3 +++
 9 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.11.0
