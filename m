Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 16:59:48 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37038 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491158Ab1FUO7p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2011 16:59:45 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5LExggL014865;
        Tue, 21 Jun 2011 15:59:42 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5LExgA8014863;
        Tue, 21 Jun 2011 15:59:42 +0100
Date:   Tue, 21 Jun 2011 15:59:42 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-mips@linux-mips.org
Subject: Section mismatches in mtx1_defconfig
Message-ID: <20110621145942.GA14197@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17242

WARNING: drivers/watchdog/built-in.o(.data+0x24): Section mismatch in reference from the variable mtx1_wdt to the function .devinit.text:mtx1_wdt_probe()
The variable mtx1_wdt references
the function __devinit mtx1_wdt_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: drivers/watchdog/built-in.o(.data+0x28): Section mismatch in reference from the variable mtx1_wdt to the function .devexit.text:mtx1_wdt_remove()
The variable mtx1_wdt references
the function __devexit mtx1_wdt_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: drivers/built-in.o(.data+0x4ec4): Section mismatch in reference from the variable mtx1_wdt to the function .devinit.text:mtx1_wdt_probe()
The variable mtx1_wdt references
the function __devinit mtx1_wdt_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: drivers/built-in.o(.data+0x4ec8): Section mismatch in reference from the variable mtx1_wdt to the function .devexit.text:mtx1_wdt_remove()
The variable mtx1_wdt references
the function __devexit mtx1_wdt_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
