Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 14:39:25 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:53448 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818014Ab3CQNjYYNcBa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Mar 2013 14:39:24 +0100
Received: by mail-pb0-f51.google.com with SMTP id un15so5708306pbc.38
        for <multiple recipients>; Sun, 17 Mar 2013 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=54H6Am+RUf74NywWVsoPfBli5gVeG1FwgHG4+o237XI=;
        b=NGBpTswLeyyIuFL7S2FhSRfJc00/K0o6Uk4dMB/eplRKtEsX9miCrAoQylhZEsGsK5
         SGjEYopZ5dOzCvDfmyfPKARVtY7C26+gOdx8l/ISoVGx48mss4fZC/ApH5o5PYPn9dvl
         1oNX1HBKlSIT2M+A0IGoHaU7tBToZ+jNKEactJcCgZpEl33yfDq9NcT2b1YJun539xtT
         34VS5PcAQs8ICnbBlqTxxQSjlZce1e5nWX168ixh0O9grz03M6Tn3DMjCzbArweI4ldV
         1tfFm1i4RGGL+wB1WK7hHeIx9ZC2Xj+80BdTrLBcZXLv0Vxer9RQg+2i5mQoA/lWcD6J
         JMrA==
X-Received: by 10.68.239.194 with SMTP id vu2mr27764296pbc.147.1363527557841;
        Sun, 17 Mar 2013 06:39:17 -0700 (PDT)
Received: from localhost.localdomain (softbank126010191003.bbtec.net. [126.10.191.3])
        by mx.google.com with ESMTPS id xr3sm16722123pbc.46.2013.03.17.06.39.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 06:39:17 -0700 (PDT)
From:   Alexandre Courbot <gnurou@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, gnurou@gmail.com,
        Alexandre Courbot <acourbot@nvidia.com>
Subject: [RFC 0/3] Removal of GENERIC_GPIO from architecture code
Date:   Sun, 17 Mar 2013 22:42:00 +0900
Message-Id: <1363527723-32713-1-git-send-email-acourbot@nvidia.com>
X-Mailer: git-send-email 1.8.2
X-archive-position: 35901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

These three patches are from a larger set that aims at completely removing the 
GENERIC_GPIO option from platform code and config files as a first step towards 
his complete removal. After that, the use of the generic GPIO API would be 
provided through gpiolib. This series has already been discussed (see 
https://lkml.org/lkml/2013/3/12/167 for details and the rationale between these 
patches) and approved by most architectures, but before having it rolled on 
linux-next I'd like to hear from the 3 following architectures which have not 
replied to the previous patch set and are the most likely to be affected by 
this (other architectures almost all require gpiolib to start with).

mips: pnx833x: used to select GENERIC_GPIO but I'm not sure if it's needed at 
all. I could not find a GPIO driver implementation that did not depend on 
gpiolib. Platform code is sometimes subtle though, so it is possible that I 
just missed it.

m68k: coldfire: turns gpiolib from optional to mandatory. Might increase the 
kernels size by ~15KB for builds that did not make use of gpiolib (are there 
still such builds?)

blackfin: turns gpiolib from optional to mandatory, same side-effect.

Note that all architectures *can* operate with gpiolib, but only the three 
above leave the option to not do so. Since a new GPIO API is being prepared 
around gpiolib amongst other features, the option of only supporting 
GENERIC_GPIO leads to fragmentation and a lot of confusion for both drivers and 
platform code.

If you have any good reason to not see these changes applied, please let me 
know shortly - acks are welcome too.

Thanks,
Alex.

Alexandre Courbot (3):
  mips: pnx833x: remove requirement for GENERIC_GPIO
  m68k: coldfire: use gpiolib
  blackfin: force use of gpiolib

 arch/blackfin/Kconfig | 4 ++--
 arch/m68k/Kconfig.cpu | 3 +--
 arch/mips/Kconfig     | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
1.8.2
