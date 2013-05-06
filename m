Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 May 2013 18:03:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33509 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823054Ab3EFQC6Puhbp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 May 2013 18:02:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r46G2uqB029713;
        Mon, 6 May 2013 18:02:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r46G2swh029712;
        Mon, 6 May 2013 18:02:54 +0200
Date:   Mon, 6 May 2013 18:02:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Build errors caused by modalias generation patch
Message-ID: <20130506160253.GA27181@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36328
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

Andreas,

doing builds of all MIPS defconfigs I observed a fair number of them
were failing to build with errors like these:

cobalt_defconfig:

  CC [M]  drivers/hid/usbhid/hid-quirks.o
  LD [M]  drivers/hid/usbhid/usbhid.o
FATAL: drivers/hid/usbhid/usbhid: sizeof(struct usb_device_id)=32 is not a modulo of the size of section __mod_usb_device_table=48.
Fix definition of struct usb_device_id in mod_devicetable.h
make[5]: *** [drivers/hid/usbhid/usbhid.o] Error 1

gpr_defconfig:

  LD [M]  drivers/atm/fore_200e.o
FATAL: drivers/atm/fore_200e: sizeof(struct pci_device_id)=32 is not a modulo of the size of section __mod_pci_device_table=56.
Fix definition of struct pci_device_id in mod_devicetable.h
make[4]: *** [drivers/atm/fore_200e.o] Error 1

jazz_defconfig:

  Building modules, stage 2.
  MODPOST 355 modules
FATAL: drivers/block/floppy: sizeof(struct pnp_device_id)=16 is not a modulo of the size of section __mod_pnp_device_table=24.
Fix definition of struct pnp_device_id in mod_devicetable.h
make[3]: *** [__modpost] Error 1

malta_defconfig:

  LD [M]  drivers/net/ethernet/chelsio/cxgb3/cxgb3.o
FATAL: drivers/net/ethernet/chelsio/cxgb3/cxgb3: sizeof(struct pci_device_id)=32 is not a modulo of the size of section __mod_pci_device_table=392.
Fix definition of struct pci_device_id in mod_devicetable.h
make[7]: *** [drivers/net/ethernet/chelsio/cxgb3/cxgb3.o] Error 1
make[6]: *** [drivers/net/ethernet/chelsio/cxgb3] Error 2
make[5]: *** [drivers/net/ethernet/chelsio] Error 2

etc.

I can reproduce the issue can only building with a separate object directory.

Reverting 6543becf26fff612cdadeed7250ccc8d49f67f27 [mod/file2alias: make
modalias generation safe for cross compiling] fixes these for me.

  Ralf
