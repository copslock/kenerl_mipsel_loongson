Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:37:42 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56328 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834996Ab3DMJhlCuR5U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:37:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 0/3] tty: serial: make of_serial work on Ralink SoC
Date:   Sat, 13 Apr 2013 11:33:35 +0200
Message-Id: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Ralink SoC uses the same 8250 iotype as AU1x00. In order to make this work form
a devicetree, the correct iotype needs to be probed inside
of_platform_serial_setup().

Ralink SoC has a different iosize than AU1x00, which causes
serial8250_port_size() to return 0x1000 instead of the correct 0x100. Instead of
adding another static if statement we probe the real iosize from the resource
inside the devicetree.

Gabor Juhos (2):
  tty: serial: add iosize field to struct uart_port
  tty: of_serial: initialize port.iosize from resource

John Crispin (1):
  tty: of_serial: allow rt288x-uart to load from OF

 drivers/tty/serial/8250/8250_core.c |    3 +++
 drivers/tty/serial/of_serial.c      |   11 +++++++++--
 include/linux/serial_core.h         |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
1.7.10.4
