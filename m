Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:46:43 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:64353 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010440AbbD1EqlgCAaF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:46:41 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI00A882LN6L60@mailout3.w1.samsung.com>; Tue,
 28 Apr 2015 05:46:35 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-74-553f10ae9542
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 7F.ED.04846.EA01F355; Tue,
 28 Apr 2015 05:46:38 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:46:35 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 0/8] clk: Minor cleanups
Date:   Tue, 28 Apr 2015 13:46:15 +0900
Message-id: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xy7rrBOxDDZrPi1o8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4TTurxY8z3SwWrw62sVj83DWP
        xWLVrj+MDhIel/t6mTx2zrrL7rFpVSebx51re9g8jq5cy+SxeUm9R2/zOzaPvi2rGD22X5vH
        7PF5k5zHxrmhAdxRXDYpqTmZZalF+nYJXBkf1rcxFTznrdh7+whzA+N/ri5GTg4JAROJXYs/
        MkLYYhIX7q1n62Lk4hASWMoose7BJSYI5z+jxPeek8wgVWwCxhKbly8BqxIR6GGT2Pr0HliC
        WaBKYt7bHawgtrCAtsSOzvXsIDaLgKrEm0m32UBsXgE3if2XVrFArJOTOHlsMusERu4FjAyr
        GEVTS5MLipPScw31ihNzi0vz0vWS83M3MUKi4MsOxsXHrA4xCnAwKvHwZjDbhwqxJpYVV+Ye
        YpTgYFYS4S3+YxcqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfurvchQgLpiSWp2ampBalFMFkm
        Dk6pBkbpFtWNMXOKp/n/C9b4dqh/zbOs4ws+3br7etYF1UrX/pudOotS1FWvX/sS0X7+lcHU
        Y8Xd5lsnfAnacNKlcGVLy+qLT+X9OVv+3GP9Lhy0g2u77dorayxaxeWS7n77P2PGYT3PBPsN
        ertKX1tFp8p23Jm+9q+IsP6nxV9XHv2dvJGD8/9zO84yJZbijERDLeai4kQATX1HiH4CAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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


Changes since v1
================
1. Rebase on next-20150427 and Sascha Hauer's:
   clk: make strings in parent name arrays const [1]
2. Add patch "clk: tegra: Fix inconsistent indenting".


Description and dependencies
============================
Small cleanups for different clock drivers.

The first three patches are independent.

Rest of the patches (these related to constifying parent names,
including the change for MIPS) depend on the "clk: make strings in
parent name arrays const" from Sascha Hauer [1].


Tested on Arndale Octa (Exynos5420) and Trats2 (Exynos4412). Other
drivers (and MIPS related) only compile tested plus some static
checkers.


[1] http://www.spinics.net/lists/arm-kernel/msg413763.html

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  clk: rockchip: Staticize file-scope declarations
  clk: exynos: Staticize file-scope declarations
  clk: tegra: Fix inconsistent indenting
  clk: tegra: Fix duplicate const for parent names
  clk: cdce706: Constify parent names in clock init data
  clk: sirf: Constify parent names in clock init data
  clk: ls1x: Fix duplicate const for parent names
  MIPS: Alchemy: Remove unneeded cast removing const

 arch/mips/alchemy/common/clock.c     |  6 +--
 drivers/clk/clk-cdce706.c            |  4 +-
 drivers/clk/clk-ls1x.c               |  6 +--
 drivers/clk/rockchip/clk-rk3188.c    |  2 +-
 drivers/clk/rockchip/clk-rk3288.c    |  2 +-
 drivers/clk/samsung/clk-exynos5260.c | 74 ++++++++++++++++++------------------
 drivers/clk/samsung/clk-exynos5420.c | 10 ++---
 drivers/clk/sirf/clk-common.c        | 12 +++---
 drivers/clk/tegra/clk-emc.c          | 18 ++++-----
 9 files changed, 67 insertions(+), 67 deletions(-)

-- 
1.9.1
