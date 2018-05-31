Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 03:04:09 +0200 (CEST)
Received: from mail1.bemta12.messagelabs.com ([216.82.251.6]:6480 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeEaBD7sDYut (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2018 03:03:59 +0200
Received: from [216.82.249.212] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta-12.messagelabs.com id 1B/B9-27145-DF94F0B5; Thu, 31 May 2018 01:03:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRWlGSWpSXmKPExsUyLfyHiO4fT/5
  og7Y9ahYTpk5id2D0OLpyLVMAYxRrZl5SfkUCa8a8ezsYC96wVBzbMJWlgbGXpYuRi0NIYC6j
  RPOrq+wQzi9GiU8LnzJ2MXJysAmYSkx/tRDMFhFQlnjwaycjSBGzwCNGiXmNP9hBEsICvhJHH
  51mAbFZBFQl3q/dzNbFyMHBK+AocWS7FkhYQkBe4vCbJlYQm1dAUOLkzCcsICXMAuoS6+cJgY
  SZgUqat85mBrGFBDQlnvd8Z4RoDZZY/PgL6wRGvllIumchdM9C0r2AkXkVo0ZxalFZapGusal
  eUlFmekZJbmJmjq6hoZFebmpxcWJ6ak5iUrFecn7uJkZgsNUzMDDuYHy2P/oQoyQHk5Io7+Vq
  vmghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErz/PPijhQSLUtNTK9Iyc4BhD5OW4OBREuHlBIa+E
  G9xQWJucWY6ROoUo6KUOO8hkD4BkERGaR5cGyzWLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYF
  QS5r0EMoUnM68EbvoroMVMQIufTOQGWVySiJCSamDUu7Qu3u/49lU321KUcq8o/7z3k397r63
  njeeHHmsyJuSpbE2M8p6Z4Hx53i+BRwKX40x8woMsvLyuv38XvHivW3fM62ZVqe1drg/3n4rl
  ei/75PCWiVtFd8q8zZvWvPxA9UWFi5MmRf0IePw4sj1276XHdwqsF5jcnZqauvfB+xUeM1fFi
  j9rVGIpzkg01GIuKk4EAAfF9R6wAgAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-2.tower-219.messagelabs.com!1527728635!185471199!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16112 invoked from network); 31 May 2018 01:03:56 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-2.tower-219.messagelabs.com with SMTP; 31 May 2018 01:03:56 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Thu, 31 May 2018 10:03:55 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004125305@swim-manx.rd.allied-telesis.co.jp>;
 Thu, 31 May 2018 10:03:54 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v3 0/1] MIPS: BCM47XX: Apply BCM5300X PCIe erratum workaround
Date:   Thu, 31 May 2018 10:02:39 +0900
Message-Id: <20180531010240.16991-1-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2018 01:03:55.0436 (UTC) FILETIME=[3F8716C0:01D3F87B]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64130
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
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org

Tokunori Ikegami (1):
  MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe
    erratum

 arch/mips/bcm47xx/setup.c        | 7 +++++++
 arch/mips/include/asm/mipsregs.h | 3 +++
 2 files changed, 10 insertions(+)

-- 
2.16.1
