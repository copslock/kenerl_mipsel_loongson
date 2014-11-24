Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:36:37 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34741 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006785AbaKXXgeaDS1h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:34 +0100
Received: by mail-pa0-f46.google.com with SMTP id lj1so10512373pab.33
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QUVodX6YFyE4szYgP2azHmqzlkHCtFEbRf+X8Oi0Sfw=;
        b=vrKxPIBIg+AWvcXupAu3CU5rtDZ5Y380qards0qqeWIKFMMlSvsWsUK7+4bf412dhy
         tqGYUdPQpcc1GGyAIF9+vYpwwzS3NHQaQE6hK2/t19fQ6v1MGIT+VNQrgvtHYbHBw6wE
         xtEhb5ieXfeC4PtADZmPj6gpDNoG3yvsai0NstUJF9p6IyXGeVbOf+rcxdQnZlJkPHhG
         h+71WdfmJ4HKNC20gyxybT8pTuMGzUDCVpaoIEvj8kTRAGDmFBAJriIscXmbbtjt9x8a
         6PuErxoh7i95EXR1B2QVHlsK8fTg15BLz6zFrG5O4sVMRTUBBkcmFm9IG4bJkPEWSNoS
         IFrw==
X-Received: by 10.68.189.67 with SMTP id gg3mr37450938pbc.158.1416872188106;
        Mon, 24 Nov 2014 15:36:28 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:27 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO accesses via DT
Date:   Mon, 24 Nov 2014 15:36:15 -0800
Message-Id: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

My last submission attempted to work around serial driver coexistence
problems on multiplatform kernels.  Since there are still questions
surrounding the best way to solve that problem, this patch series
will focus on the narrower topic of big endian MMIO support on serial.


V2->V3:

 - Document the new DT properties.

 - Add libfdt-based wrapper, to complement the "struct device_node" based
   version.

 - Restructure early_init_dt_scan_chosen_serial() changes to use a
   temporary variable, so it is easy to add more of_setup_earlycon()
   properties later.

 - Make of_serial and serial8250 honor the new "big-endian" property.


This series applies cleanly to:

git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay

but was tested on the mips-for-linux-next branch because my BE platform
isn't supported in mainline yet.


Kevin Cernekee (7):
  of: Add helper function to check MMIO register endianness
  of/fdt: Add endianness helper function for early init code
  of: Document {little,big,native}-endian bindings
  serial: core: Add big-endian iotype
  serial: earlycon: Set UPIO_MEM32BE based on DT properties
  serial: of_serial: Support big-endian register accesses
  serial: 8250: Add support for big-endian MMIO accesses

 .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
 drivers/of/base.c                                  | 23 +++++++++
 drivers/of/fdt.c                                   | 26 +++++++++-
 drivers/tty/serial/8250/8250_core.c                | 20 ++++++++
 drivers/tty/serial/8250/8250_early.c               |  5 ++
 drivers/tty/serial/earlycon.c                      |  4 +-
 drivers/tty/serial/of_serial.c                     |  3 +-
 drivers/tty/serial/serial_core.c                   |  2 +
 include/linux/of.h                                 |  6 +++
 include/linux/of_fdt.h                             |  2 +
 include/linux/serial_core.h                        | 15 +++---
 11 files changed, 155 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/common-properties.txt

-- 
2.1.0
