Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2014 15:49:08 +0200 (CEST)
Received: from helium.waldemar-brodkorb.de ([89.238.66.15]:54331 "EHLO
        helium.waldemar-brodkorb.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822137AbaEPNtGjDKuK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 May 2014 15:49:06 +0200
Received: by helium.waldemar-brodkorb.de (Postfix, from userid 1000)
        id 7254C106A6; Fri, 16 May 2014 15:49:05 +0200 (CEST)
Date:   Fri, 16 May 2014 15:49:04 +0200
From:   Waldemar Brodkorb <wbx@openadk.org>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: serial console on rb532 disabled on boot (linux 3.15rc5)
Message-ID: <20140516134904.GW618@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 3.2.0-4-amd64 x86_64
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wbx@openadk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openadk.org
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

Hi Linux hackers,

I am trying to bootup my Mikrotik RB532 board with the latest
kernel, but my serial console is disabled after boot:
..
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 104, base_baud = 12499875) is a
16550A
console [ttyS0] enabled
console [ttyS0] disabled

I used git bisect to find the problematic commit:
commit 5f5c9ae56c38942623f69c3e6dc6ec78e4da2076
Author: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Date:   Fri Feb 28 14:21:32 2014 +0100

    serial_core: Unregister console in uart_remove_one_port()
    
    If the serial port being removed is used as a console, it must
also be
    unregistered from the console subsystem using
unregister_console().
    
    uart_ops.release_port() will release resources (e.g. iounmap()
the serial
    port registers), causing a crash on subsequent kernel output if
the console
    is still registered.
    
    Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

After reverting the change, everything is fine.

I can provide a .config and dmesg if needed.

Thanks in advance
 Waldemar
