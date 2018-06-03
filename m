Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2018 16:02:37 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.209]:23986 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992737AbeFCOC3BTz0M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jun 2018 16:02:29 +0200
Received: from [216.82.242.46] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-17.bemta-8.messagelabs.com id 54/49-05522-3F4F31B5; Sun, 03 Jun 2018 14:02:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRWlGSWpSXmKPExsUyLfyHiO7nL8L
  RBnsPK1pMmDqJ3YHR4+jKtUwBjFGsmXlJ+RUJrBlb2jcyFixgrdi89zh7A+Neli5GLg4hgTmM
  Evt+zGWHcH4ySszb9o65i5GTg03AVGL6q4WMILaIgLLEg187GUGKmAX2MUp8bV3JCpIQFvCVe
  HuqDayIRUBV4vqTTewgNq+Ao8Smh1PA4hIC8hKH3zSxQsQFJU7OfAK0mgNokLrE+nlCIGFmoJ
  LmrbPB9goJaEo87/kO1RoscerNCeYJjHyzkHTPQuiehaR7ASPzKkaN4tSistQiXWMLvaSizPS
  MktzEzBxdQwMLvdzU4uLE9NScxKRiveT83E2MwHCrZ2Bg3MH45Uj0IUZJDiYlUd5XFcLRQnxJ
  +SmVGYnFGfFFpTmpxYcYZTg4lCR4LYHhKyRYlJqeWpGWmQMMfJi0BAePkggvN0iat7ggMbc4M
  x0idYpRUUqcVwIkIQCSyCjNg2uDRdslRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8GiBTeD
  LzSuCmvwJazAS0+FkF2OKSRISUVAOjsOHSu/qM+5ODmdoe3qjUPBUYLNVy0Kzq9aQNLC+8d3Z
  mnWmrr17smlOt+unsHukZ6vuq4/891rrk/s2Qe960KOFPre92btOzS5sdHJPQ3VnUxlSQaS2d
  8k59btypF1wHTPOUlL3bE8tv7n3FuVp9627V2N/euvybKxaKfWd4OnlvYKuw42QlluKMREMt5
  qLiRACsiOrVsQIAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-13.tower-96.messagelabs.com!1528034546!89614991!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2729 invoked from network); 3 Jun 2018 14:02:27 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-13.tower-96.messagelabs.com with SMTP; 3 Jun 2018 14:02:27 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Sun, 3 Jun 2018 23:02:26 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004128335@swim-manx.rd.allied-telesis.co.jp>;
 Sun, 3 Jun 2018 23:02:25 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v5 0/1] MIPS: BCM47XX: Apply BCM5300X PCIe erratum workaround
Date:   Sun,  3 Jun 2018 23:02:00 +0900
Message-Id: <20180603140201.10593-1-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jun 2018 14:02:26.0348 (UTC) FILETIME=[80A3DEC0:01D3FB43]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ikegami@allied-telesis.co.jp
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

The workaround is to eanble ExternalSync mode and it is implemented on CFE.
But to enable this without CFE implemented it add the workaround into Linux.

Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org

Tokunori Ikegami (1):
  MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe
    erratum

 arch/mips/bcm47xx/setup.c        | 6 ++++++
 arch/mips/include/asm/mipsregs.h | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.16.1
