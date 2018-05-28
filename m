Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 02:25:30 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.202]:41596 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992735AbeE1AZVgwp8K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2018 02:25:21 +0200
Received: from [216.82.242.46] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-10.bemta-8.messagelabs.com id 7F/80-04757-07C4B0B5; Mon, 28 May 2018 00:25:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRWlGSWpSXmKPExsUyLfyHiG6BD3e
  0Qd8cYYsJUyexOzB6HF25limAMYo1My8pvyKBNWP7pKyCJtaKex0rmBoYF7N0MXJxCAnMZZQ4
  teUXO4Tzi1Hi8cVLrF2MnBxsAqYS018tZASxRQSUJR782skIUsQscIZR4lHTbqB2Dg5hAV+Jq
  S+kQUwWAVWJJfsKQMp5BRwkOppWM4HYEgLyEoffNIGNFBLQlHje850RIh4s0bjsLOsERu4FjA
  yrGDWKU4vKUot0TYz0kooy0zNKchMzc3QNDSz0clOLixPTU3MSk4r1kvNzNzECvVvPwMC4g/H
  lsuhDjJIcTEqivBYTOaKF+JLyUyozEosz4otKc1KLDzHKcHAoSfAWenNHCwkWpaanVqRl5gDD
  DCYtwcGjJML72wsozVtckJhbnJkOkTrFqCglzpsD0icAksgozYNrg4X2JUZZKWFeRgYGBiGeg
  tSi3MwSVPlXjOIcjErCvPUgU3gy80rgpr8CWswEtHjdanaQxSWJCCmpBkbbS1+KtvRFJu3fzy
  SQNLPNo/DH9gkXSnOSDizRi19/9Kb9vSUTOrLL/pqsq3LMnxUqkCGX99hOc+6jiz+nii+8XSb
  jcrm1fZccV1A1E79uAK//XdtSO80F9x//qq8Nvt9qby+/WGZOycrJ53jk705axmcwNWHSzD22
  rwO1+xz6Pbc0sO57m6nEUpyRaKjFXFScCADckQ4LaAIAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-10.tower-96.messagelabs.com!1527467119!94845021!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22371 invoked from network); 28 May 2018 00:25:20 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-10.tower-96.messagelabs.com with SMTP; 28 May 2018 00:25:20 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Mon, 28 May 2018 09:25:18 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004118814@swim-manx.rd.allied-telesis.co.jp>;
 Mon, 28 May 2018 09:25:18 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rafa~B Mi~Becki <zajec5@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH v2 0/1] MIPS: BCM47XX: Apply BCM5300X PCIe erratum workaround
Date:   Mon, 28 May 2018 09:24:50 +0900
Message-Id: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
X-OriginalArrivalTime: 28 May 2018 00:25:18.0963 (UTC) FILETIME=[5B901C30:01D3F61A]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64077
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafa~B Mi~Becki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org

Tokunori Ikegami (1):
  MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe
    erratum

 arch/mips/include/asm/mipsregs.h |  3 +++
 arch/mips/kernel/cpu-probe.c     | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.16.1
