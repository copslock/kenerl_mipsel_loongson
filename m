Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 10:54:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51655 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824769Ab3F0IyXMzBRy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 10:54:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5R8sIIK030733;
        Thu, 27 Jun 2013 10:54:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5R8sEbB030732;
        Thu, 27 Jun 2013 10:54:14 +0200
Date:   Thu, 27 Jun 2013 10:54:14 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Murray <Andrew.Murray@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: of_pci_range_parser patch series
Message-ID: <20130627085414.GE20848@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Andrew,

I noticed that [1] is now in -next but not the MIPS patch [2], not the
MicroBlaze patch [3].  What is the reason for that?  If it's only the
lack of an ack, here's mine for the MIPS version:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf

[1] http://patchwork.linux-mips.org/patch/5218/
[2] http://patchwork.linux-mips.org/patch/5217/
[3] http://patchwork.linux-mips.org/patch/5216/
