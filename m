Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 04:10:23 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:61863 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006945AbaH1CKWRb0UA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 04:10:22 +0200
Received: by mail-pa0-f74.google.com with SMTP id lj1so471033pab.3
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 19:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QivRljOpNQ2E7dhQskpTlPuGh/9oa14m+GDWxDDY4Vk=;
        b=l/uOuGYGg98/fraYnA2HHx/s7Tkm1gMCoRN5Dee7R4vfXW5QJ2wGNc5cJoPx85e/Zt
         vq1LCBtbJQCencj8QJKcFvtlips3TXoSw2yuKFdHDPbUMXz9v+PFjo8PJQ2CuIROAwJg
         tlAm1GLi4z4qYQQjqm507+YU41ok8uYCmZLeRVnp1k6VkudNIUCDx4FShhXJLYvJ5XZz
         sqoda5NJ/N2xOoB4z+87CUg6pimd1Vu32Ay7BSzkKlcKIvcc9Xg8mR8hfz+6qC7NDX8L
         9aRAyYZsSu2YW2z2Ilo/DCI/w8rh4zczaE23Ef61XLG0fbWUHDn7O/kN4RdmfgV0XJmk
         A7zw==
X-Gm-Message-State: ALoCoQmmkz1WfAIiwrDJbv0e2LIZcCIOVvd7M4tTIgOOoJTtx4voQOZxQUYuJd4h8FIytR+2gUtV
X-Received: by 10.66.161.7 with SMTP id xo7mr650761pab.14.1409191815617;
        Wed, 27 Aug 2014 19:10:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id d7si145416yho.2.2014.08.27.19.10.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 19:10:15 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5AF2831C379;
        Wed, 27 Aug 2014 19:10:15 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id ECE84221121; Wed, 27 Aug 2014 19:10:14 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Jayachandran C <jchandra@broadcom.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH v2 0/7] MIPS: Move device-tree files to a common location
Date:   Wed, 27 Aug 2014 19:10:05 -0700
Message-Id: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

To be consistent with other architectures and to avoid unnecessary
makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
and build them with a common makefile.  Per Olof's suggestion in v1,
device-trees are grouped into per-vendor subdirectories.  Note that
since there is currently no Kbuild infrastructure for recursively
building dtbs like there is for object files, the top level Makefile
in arch/mips/boot/dts/ just includes the sub-Makefiles.

Patch 1 sets up the makefiles for building the DTs in arch/mips/boot/dts
and introduces the config option BUILTIN_DTB for platforms that require
it.

Patch 2 introduces the 'dtbs' makefile target to allow building of just
the DT binaries.

Patches 3-7 move the DTs out of the platform directores.

I've build tested this on all affected platforms (Octeon, Lantiq, SEAD3,
Netlogic, and Ralink) as well as Malta.  For platforms where builtin DTBs
are optional (Netlogic and Ralink), I built with and without the builtin
DTBs.

Based on 3.17-rc2.

Changes from v1:
 - moved to per-vendor subdirectories
 - rebased on 3.17-rc2

Andrew Bresticker (7):
  MIPS: Create common infrastructure for building built-in device-trees
  MIPS: Add support for building device-tree binaries
  MIPS: Octeon: Move device-trees to arch/mips/boot/dts/cavium-octeon/
  MIPS: Lantiq: Move device-trees to arch/mips/boot/dts/lantiq/
  MIPS: sead3: Move device-trees to arch/mips/boot/dts/mti/
  MIPS: Netlogic: Move device-trees to arch/mips/boot/dts/netlogic/
  MIPS: ralink: Move device-trees to arch/mips/boot/dts/ralink/

 arch/mips/Kconfig                                          |  5 +++++
 arch/mips/Makefile                                         | 11 +++++++++++
 arch/mips/boot/.gitignore                                  |  1 +
 arch/mips/boot/dts/Makefile                                | 14 ++++++++++++++
 arch/mips/boot/dts/cavium-octeon/Makefile                  |  2 ++
 arch/mips/{ => boot/dts}/cavium-octeon/octeon_3xxx.dts     |  0
 arch/mips/{ => boot/dts}/cavium-octeon/octeon_68xx.dts     |  0
 arch/mips/boot/dts/lantiq/Makefile                         |  1 +
 arch/mips/{lantiq/dts => boot/dts/lantiq}/danube.dtsi      |  0
 arch/mips/{lantiq/dts => boot/dts/lantiq}/easy50712.dts    |  0
 arch/mips/boot/dts/mti/Makefile                            |  1 +
 arch/mips/{mti-sead3 => boot/dts/mti}/sead3.dts            |  0
 arch/mips/boot/dts/netlogic/Makefile                       |  4 ++++
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_evp.dts  |  0
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_fvp.dts  |  0
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_gvp.dts  |  0
 arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_svp.dts  |  0
 arch/mips/boot/dts/ralink/Makefile                         |  4 ++++
 arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a.dtsi     |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a_eval.dts |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt2880.dtsi      |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt2880_eval.dts  |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3050.dtsi      |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3052_eval.dts  |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3883.dtsi      |  0
 arch/mips/{ralink/dts => boot/dts/ralink}/rt3883_eval.dts  |  0
 arch/mips/cavium-octeon/.gitignore                         |  2 --
 arch/mips/cavium-octeon/Makefile                           | 10 ----------
 arch/mips/lantiq/Kconfig                                   |  1 +
 arch/mips/lantiq/Makefile                                  |  2 --
 arch/mips/lantiq/dts/Makefile                              |  1 -
 arch/mips/mti-sead3/Makefile                               |  4 ----
 arch/mips/netlogic/Kconfig                                 |  4 ++++
 arch/mips/netlogic/Makefile                                |  1 -
 arch/mips/netlogic/dts/Makefile                            |  4 ----
 arch/mips/ralink/Kconfig                                   |  4 ++++
 arch/mips/ralink/Makefile                                  |  2 --
 arch/mips/ralink/dts/Makefile                              |  4 ----
 38 files changed, 52 insertions(+), 30 deletions(-)
 create mode 100644 arch/mips/boot/dts/Makefile
 create mode 100644 arch/mips/boot/dts/cavium-octeon/Makefile
 rename arch/mips/{ => boot/dts}/cavium-octeon/octeon_3xxx.dts (100%)
 rename arch/mips/{ => boot/dts}/cavium-octeon/octeon_68xx.dts (100%)
 create mode 100644 arch/mips/boot/dts/lantiq/Makefile
 rename arch/mips/{lantiq/dts => boot/dts/lantiq}/danube.dtsi (100%)
 rename arch/mips/{lantiq/dts => boot/dts/lantiq}/easy50712.dts (100%)
 create mode 100644 arch/mips/boot/dts/mti/Makefile
 rename arch/mips/{mti-sead3 => boot/dts/mti}/sead3.dts (100%)
 create mode 100644 arch/mips/boot/dts/netlogic/Makefile
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_evp.dts (100%)
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_fvp.dts (100%)
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_gvp.dts (100%)
 rename arch/mips/{netlogic/dts => boot/dts/netlogic}/xlp_svp.dts (100%)
 create mode 100644 arch/mips/boot/dts/ralink/Makefile
 rename arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/mt7620a_eval.dts (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt2880.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt2880_eval.dts (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3050.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3052_eval.dts (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3883.dtsi (100%)
 rename arch/mips/{ralink/dts => boot/dts/ralink}/rt3883_eval.dts (100%)
 delete mode 100644 arch/mips/cavium-octeon/.gitignore
 delete mode 100644 arch/mips/lantiq/dts/Makefile
 delete mode 100644 arch/mips/netlogic/dts/Makefile
 delete mode 100644 arch/mips/ralink/dts/Makefile

-- 
2.1.0.rc2.206.gedb03e5
