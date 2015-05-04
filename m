Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 21:10:25 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35699 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011174AbbEDTKXqf2D6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2015 21:10:23 +0200
Received: by pabtp1 with SMTP id tp1so168727929pab.2;
        Mon, 04 May 2015 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4RjaltHX0SlUh5NjHLyy2vHhseXrYL4jIlqa1kaQ1ZM=;
        b=1HemlSQnF6+LSWSsGZu0qRGpAYkxENQoJCAkDpMRgDluy++qJFCESxguG64rlX/iWp
         VIi1VjQAd2Q4bi55zeoCLAHbSwf4RvagR6YTN93sQsn940zvQkWIHfGPy1ARxLbSkOhs
         sMlVW2OMZt+B8BGeo3Dw0MkQUpnVOAzJ6ImKA4IkRIvZOIXoG/I+/oH8syBMq/S9ui35
         ayPc7u9Ir329J4GFeFaQb/a3pRdlIvANRm4jsze+7IDJCHNe5Q6eZFxAshdejmBr9di1
         6tF/DZ7eObDZ6DAyLNzR8LzHFf76qgy5k05RdXzPtdpb6ZaXXMmBk0oeKP8G5Ww1O3Ok
         LUcQ==
X-Received: by 10.66.177.238 with SMTP id ct14mr44856256pac.121.1430766619654;
        Mon, 04 May 2015 12:10:19 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id vi5sm13503820pbc.89.2015.05.04.12.10.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 12:10:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@chromium.org,
        jogo@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: BMIPS: Centralize FIXADDR_TOP
Date:   Mon,  4 May 2015 12:09:42 -0700
Message-Id: <1430766584-8429-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi all,

This patch series centralizes the special FIXADDR_TOP value required when using
BMIPS3300-class CPUs in Broadcom SoCs to avoid clashes with the System Base Register

Florian Fainelli (2):
  MIPS: BMIPS: Define BMIPS_FIXADDR_TOP in asm/bmips-spaces.h
  MIPS: BCM63xx: Utilize asm/bmips-spaces.h

 arch/mips/include/asm/bmips-spaces.h        | 7 +++++++
 arch/mips/include/asm/mach-bcm63xx/spaces.h | 2 +-
 arch/mips/include/asm/mach-bmips/spaces.h   | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/bmips-spaces.h

-- 
2.1.0
