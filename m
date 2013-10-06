Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Oct 2013 22:35:56 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:55377 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6867680Ab3JFUffehvb- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Oct 2013 22:35:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 9987421B875;
        Sun,  6 Oct 2013 23:35:31 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id kbQsB7hdRXxq; Sun,  6 Oct 2013 23:35:27 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id 67D1B5BC004;
        Sun,  6 Oct 2013 23:35:27 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>
Cc:     richard@nod.at, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/2] staging: octeon-ethernet: IRQ handling fixes
Date:   Sun,  6 Oct 2013 23:35:14 +0300
Message-Id: <1381091716-23531-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.4.rc3
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

This is a second version of two patches sent earlier:
	http://marc.info/?t=138039800600001&r=1&w=2
	http://marc.info/?t=138039800600002&r=1&w=2

The patch 1 is changed so that it won't touch the init/probe path. The
driver will still fail if CPU0 is not around, but that was not accepted
to be a bug.

The patch 2 is unmodified.

Test cases for EdgeRouter Lite:

1)
	- Start pinging Octeon from a remote host with 1 second interval.
	- Wait 10 seconds.
	- Set /proc/irq/24/smp_affinity to 2.
	- Wait 10 seconds.
	- Quit ping.

	- Expected result:
		No packet loss reported.
	- Unexpected/failed result:
		Packet loss.

2)
	- Boot Octeon with kernel parameter "octeon-ethernet.max_rx_cpus=1".
	- Saturate the Octeon with external traffic (e.g. flood ping).

	- Expected result:
		Max 50% CPU time is consumed. Second core is available for
		other tasks.
	- Unexpected/failed result:
		100% CPU time is consumed. System is unresponsive.

Aaro Koskinen (2):
  staging: octeon-ethernet: allow to set IRQ smp_affinity freely
  staging: octeon-ethernet: allow to use only 1 CPU for packet
    processing

 drivers/staging/octeon/ethernet-rx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
1.8.4.rc3
