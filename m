Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 17:33:41 +0100 (CET)
Received: from conuserg-09.nifty.com ([210.131.2.76]:63571 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992211AbdKGQdfEMYM0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 17:33:35 +0100
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id vA7GVppL022965;
        Wed, 8 Nov 2017 01:31:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com vA7GVppL022965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510072312;
        bh=BhQOIZasmiAImz+osleF0a07RPrt0AJdBKofVbplbiw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ousu2DEK/Dqnftbic8B6+kkUbIAW0ziDGVXcy6RcxC0x1rxZ6OPbFfeQnBGrXHgKT
         wliupLMTfpGzc5kef8/SbN97WeCyQ1QyvIgwPKWHj4VDx5i+8wIIraZAlccF3Utw2E
         c4IXfhllAeY/yY5nowjQ7327Y1zf9P6SzSRCh6QrxDHczx6z0jHcXizeS0iZPAEaLQ
         0lgWWV6k0n/95IA1NeR3pzQ7HKWdtIEQ5bjtMG4QmOdpXuIqTy++88/7VJjMkgTi3I
         eiBWGHogWo7TJGRfByjB+ksirfK2XsFqav8sHSTFIlju4VksfgQ2is3+9PXOnPStCa
         hCTt/EKjUr1oQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michal Marek <mmarek@suse.com>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] kbuild: remove all "obj- := dummy.o" tricks
Date:   Wed,  8 Nov 2017 01:31:45 +0900
Message-Id: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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


This clean-up was prompted by Sam
when I refactored DT building:
https://patchwork.kernel.org/patch/10041881/

If you want to test this series,
apply the following 3 patches:
https://patchwork.kernel.org/patch/10037891/
https://patchwork.kernel.org/patch/10041877/
https://patchwork.kernel.org/patch/10041881/

I CCed DT forks to informs them of conflicts
with those patches Rob Herring offered to apply.
I doubt if he wants to review this series...



Masahiro Yamada (2):
  kbuild: create built-in.o automatically if parent directory wants it
  kbuild: remove all dummy assignments to obj-

 Makefile                                  | 2 +-
 arch/arm/mach-uniphier/Makefile           | 1 -
 arch/mips/boot/dts/brcm/Makefile          | 3 ---
 arch/mips/boot/dts/cavium-octeon/Makefile | 3 ---
 arch/mips/boot/dts/img/Makefile           | 3 ---
 arch/mips/boot/dts/ingenic/Makefile       | 3 ---
 arch/mips/boot/dts/lantiq/Makefile        | 3 ---
 arch/mips/boot/dts/mti/Makefile           | 3 ---
 arch/mips/boot/dts/netlogic/Makefile      | 3 ---
 arch/mips/boot/dts/ni/Makefile            | 3 ---
 arch/mips/boot/dts/pic32/Makefile         | 3 ---
 arch/mips/boot/dts/qca/Makefile           | 3 ---
 arch/mips/boot/dts/ralink/Makefile        | 3 ---
 arch/mips/boot/dts/xilfpga/Makefile       | 3 ---
 firmware/Makefile                         | 3 ---
 samples/bpf/Makefile                      | 3 ---
 samples/hidraw/Makefile                   | 3 ---
 samples/seccomp/Makefile                  | 3 ---
 samples/sockmap/Makefile                  | 3 ---
 samples/statx/Makefile                    | 3 ---
 samples/uhid/Makefile                     | 3 ---
 scripts/Makefile.build                    | 4 ++--
 22 files changed, 3 insertions(+), 61 deletions(-)

-- 
2.7.4
