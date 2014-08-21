Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:03:27 +0200 (CEST)
Received: from mail-qg0-f74.google.com ([209.85.192.74]:45273 "EHLO
        mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVD0Nuy3P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:03:26 +0200
Received: by mail-qg0-f74.google.com with SMTP id a108so936848qge.3
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bmFC9o5EvKUToHvpTaihYhDV0avPSpO/jdTynaLBXP4=;
        b=mPeSuPx5tJjeJ85s3Nj0pEehFkYuYeyod1R17exHNzW1s+QyjnVMBVdgIpZyK+cHDf
         70EQZTixelFUGOgsgM+Ii7V/apB68fKjlzHdFxJSR9i15yCHPqHDs2D+6w4w827M/F0H
         pvBAZL1hWPF6Uj5D+JDxNPO3lTEhUVXKAQbkpzxcTGI33e6oOry+min1qFCZjEseAz1V
         z/baRvRUxn3h8msxaqRp+LnaWXee00fBtU81+mUIkGaIT5GHBFt+wW2WRdvBjW92Ja6Z
         i2AzAQ+EzlijsYFbefMTTXDm3VyJmatHpuTzC2zDij52Bj9nzFrB0AvXrxDIVb6vKIWj
         /72g==
X-Gm-Message-State: ALoCoQmFKVJqrZyPy8INb2Fd5fd7shtGJYXAS5G9BeqK2ImZCebkf5e+azDT2g/NKW0gjd6jJ3SK
X-Received: by 10.224.0.137 with SMTP id 9mr624491qab.5.1408651486004;
        Thu, 21 Aug 2014 13:04:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id f44si123250yhf.1.2014.08.21.13.04.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:45 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C246031C5D0;
        Thu, 21 Aug 2014 13:04:45 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 65A9D220378; Thu, 21 Aug 2014 13:04:45 -0700 (PDT)
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
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 0/7] MIPS: Move device-tree files to a common location
Date:   Thu, 21 Aug 2014 13:04:19 -0700
Message-Id: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42175
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
and build them with a common makefile.

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

Based on 3.17-rc1.

Andrew Bresticker (7):
  MIPS: Create common infrastructure for building built-in device-trees
  MIPS: Add support for building device-tree binaries
  MIPS: Octeon: Move device-trees to arch/mips/boot/dts/
  MIPS: Lantiq: Move device-trees to arch/mips/boot/dts/
  MIPS: sead3: Move device-trees to arch/mips/boot/dts/
  MIPS: Netlogic: Move device-trees to arch/mips/boot/dts/
  MIPS: ralink: Move device-trees to arch/mips/boot/dts/

 arch/mips/Kconfig                                    |  5 +++++
 arch/mips/Makefile                                   | 11 +++++++++++
 arch/mips/boot/.gitignore                            |  1 +
 arch/mips/boot/dts/Makefile                          | 20 ++++++++++++++++++++
 arch/mips/{lantiq => boot}/dts/danube.dtsi           |  0
 arch/mips/{lantiq => boot}/dts/easy50712.dts         |  0
 arch/mips/{ralink => boot}/dts/mt7620a.dtsi          |  0
 arch/mips/{ralink => boot}/dts/mt7620a_eval.dts      |  0
 .../mips/{cavium-octeon => boot/dts}/octeon_3xxx.dts |  0
 .../mips/{cavium-octeon => boot/dts}/octeon_68xx.dts |  0
 arch/mips/{ralink => boot}/dts/rt2880.dtsi           |  0
 arch/mips/{ralink => boot}/dts/rt2880_eval.dts       |  0
 arch/mips/{ralink => boot}/dts/rt3050.dtsi           |  0
 arch/mips/{ralink => boot}/dts/rt3052_eval.dts       |  0
 arch/mips/{ralink => boot}/dts/rt3883.dtsi           |  0
 arch/mips/{ralink => boot}/dts/rt3883_eval.dts       |  0
 arch/mips/{mti-sead3 => boot/dts}/sead3.dts          |  0
 arch/mips/{netlogic => boot}/dts/xlp_evp.dts         |  0
 arch/mips/{netlogic => boot}/dts/xlp_fvp.dts         |  0
 arch/mips/{netlogic => boot}/dts/xlp_gvp.dts         |  0
 arch/mips/{netlogic => boot}/dts/xlp_svp.dts         |  0
 arch/mips/cavium-octeon/.gitignore                   |  2 --
 arch/mips/cavium-octeon/Makefile                     | 10 ----------
 arch/mips/lantiq/Kconfig                             |  1 +
 arch/mips/lantiq/Makefile                            |  2 --
 arch/mips/lantiq/dts/Makefile                        |  1 -
 arch/mips/mti-sead3/Makefile                         |  4 ----
 arch/mips/netlogic/Kconfig                           |  4 ++++
 arch/mips/netlogic/Makefile                          |  1 -
 arch/mips/netlogic/dts/Makefile                      |  4 ----
 arch/mips/ralink/Kconfig                             |  4 ++++
 arch/mips/ralink/Makefile                            |  2 --
 arch/mips/ralink/dts/Makefile                        |  4 ----
 33 files changed, 46 insertions(+), 30 deletions(-)
 create mode 100644 arch/mips/boot/dts/Makefile
 rename arch/mips/{lantiq => boot}/dts/danube.dtsi (100%)
 rename arch/mips/{lantiq => boot}/dts/easy50712.dts (100%)
 rename arch/mips/{ralink => boot}/dts/mt7620a.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/mt7620a_eval.dts (100%)
 rename arch/mips/{cavium-octeon => boot/dts}/octeon_3xxx.dts (100%)
 rename arch/mips/{cavium-octeon => boot/dts}/octeon_68xx.dts (100%)
 rename arch/mips/{ralink => boot}/dts/rt2880.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/rt2880_eval.dts (100%)
 rename arch/mips/{ralink => boot}/dts/rt3050.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/rt3052_eval.dts (100%)
 rename arch/mips/{ralink => boot}/dts/rt3883.dtsi (100%)
 rename arch/mips/{ralink => boot}/dts/rt3883_eval.dts (100%)
 rename arch/mips/{mti-sead3 => boot/dts}/sead3.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_evp.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_fvp.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_gvp.dts (100%)
 rename arch/mips/{netlogic => boot}/dts/xlp_svp.dts (100%)
 delete mode 100644 arch/mips/cavium-octeon/.gitignore
 delete mode 100644 arch/mips/lantiq/dts/Makefile
 delete mode 100644 arch/mips/netlogic/dts/Makefile
 delete mode 100644 arch/mips/ralink/dts/Makefile

-- 
2.1.0.rc2.206.gedb03e5
