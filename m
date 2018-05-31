Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2018 00:19:34 +0200 (CEST)
Received: from mail1.bemta12.messagelabs.com ([216.82.251.10]:21633 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994686AbeEaWT0jmOKJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2018 00:19:26 +0200
Received: from [216.82.251.38] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-10.bemta-12.messagelabs.com id 18/A6-21411-CE4701B5; Thu, 31 May 2018 22:19:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRWlGSWpSXmKPExsUyLfyHiO7rEoF
  og1lTzS0mTJ3E7sDocXTlWqYAxijWzLyk/IoE1oyJLcsYC2axVszaP5u1gXE7SxcjF4eQwBxG
  ibmPXkM5PxklJu7Yxt7FyMnBJmAqMf3VQkYQW0RAWeLBr52MIEXMAo8YJeY1/gArEhbwlbjWs
  ZcJxGYRUJVYcuIoaxcjBwevgIPEk1W8IGEJAXmJw2+aWEFsXgFBiZMzn7CAlDALqEusnycEEm
  YGKmneOpsZxBYS0JR43vOdEaI1WOLjxAOsExj5ZiHpnoXQPQtJ9wJG5lWMGsWpRWWpRbpGlnp
  JRZnpGSW5iZk5uoaGRnq5qcXFiempOYlJxXrJ+bmbGIHBVs/AwLiD8d8X30OMkhxMSqK8k+UE
  ooX4kvJTKjMSizPii0pzUosPMcpwcChJ8OoCg1dIsCg1PbUiLTMHGPYwaQkOHiUR3svFQGne4
  oLE3OLMdIjUKUZFKXFeJ5A+AZBERmkeXBss1i4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEu
  a9CzKeJzOvBG76K6DFTECLX8uCLS5JREhJNTCWOi35usvcZYsAw/NfHcnWojJumix1NY5a+sF
  zLnzfsbxw88SUGUvXTzjdf3C53VLrxIdLjzMIX7/ByufGZPMywX5ntal/A/PRq7uSfuRr5+c/
  mbLI4r3SKm+RbNlSEebKX2lBQf8n5qUJS4YFzLJtsVgt8dJd69pxv0WcYRyTwh8+D/FbG6rEU
  pyRaKjFXFScCAD0w2RUsAIAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-7.tower-163.messagelabs.com!1527805163!159705674!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2524 invoked from network); 31 May 2018 22:19:23 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-7.tower-163.messagelabs.com with SMTP; 31 May 2018 22:19:23 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Fri, 1 Jun 2018 07:19:22 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004126746@swim-manx.rd.allied-telesis.co.jp>;
 Fri, 1 Jun 2018 07:19:22 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v4 0/1] MIPS: BCM47XX: Apply BCM5300X PCIe erratum workaround
Date:   Fri,  1 Jun 2018 07:19:10 +0900
Message-Id: <20180531221911.6210-1-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2018 22:19:22.0938 (UTC) FILETIME=[6D7931A0:01D3F92D]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64140
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
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
