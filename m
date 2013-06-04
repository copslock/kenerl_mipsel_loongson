Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:31:57 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:58562 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835041Ab3FDVbxJHYGb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:31:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id BD1925A705D;
        Wed,  5 Jun 2013 00:31:50 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id Sw8naMgS+uTW; Wed,  5 Jun 2013 00:31:45 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id C07095BC010;
        Wed,  5 Jun 2013 00:31:45 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/6] staging: octeon-usb: cvmx-usbcx-defs.h cleanup
Date:   Wed,  5 Jun 2013 00:31:29 +0300
Message-Id: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36676
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

This series fixes most of the checkpatch issues in cvmx-usbcx-defs.h:

Before: total: 1785 errors, 1168 warnings, 3086 lines checked
 After: total:    0 errors,   53 warnings, 3647 lines checked

The only remaining issue is "WARNING: do not add new typedefs" which
will be addressed in further cleanups.

There should be no functional changes. Verified as follows:

	- mips-linux-gnu-size reports the same binary size before/after
	  for octeon-usb.ko (compiled binary of the driver).

	- USB mass storage functionality tested with EdgeRouter Lite with
	  the new patches.

A.
 
Aaro Koskinen (6):
  staging: octeon-usb: run cvmx-usbcx-defs.h through Lindent
  staging: octeon-usb: cvmx-usbcx-defs.h: fix comment style
  staging: octeon-usb: cvmx-usbcx-defs.h: avoid long lines in
    CVMX_USBCX macros
  staging: octeon-usb: cvmx-usbcx-defs.h: avoid long lines in comments
  staging: octeon-usb: cvmx-usbcx-defs.h: delete CVS keyword marker
  staging: octeon-usb: cvmx-usbcx-defs.h: reformat license text to fit
    80 cols

 drivers/staging/octeon-usb/cvmx-usbcx-defs.h | 5427 ++++++++++++++------------
 1 file changed, 2994 insertions(+), 2433 deletions(-)

-- 
1.7.10.4
