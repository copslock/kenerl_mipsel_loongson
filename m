Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:48:19 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48628 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825630Ab2JWRr7SgV0F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:47:59 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520790lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Gr9+PZzPsLhl+lVuG+kGPfFRT7azv9fi7ZXwjZ2WaJU=;
        b=brIBYH+TGqhVCrqgHfklcAEM29xRg5SoPpTDwyDbfV3NsKzhBInBT9aAUx1jowghMg
         N/EVPR89cs7a0qDlIA9JihAnAi312xFkOC62vItUzEzMdbctvUoa8bZv5Cl9H7GzNCjR
         4DDbCNGulIX/c5HMEdGE+u7M7rp5e296ZkDRMeqUP0huh8Z9uqLWU1owSH2NNkz4sb6Z
         huriYBzWQyUVTHcXEjbHKPkVf+pKFx8AtRpo+UWRh9+DQc/vjf+ZHglsvA8Ziliphw74
         T3wHHCsMGR0HUZf2AhtUsnRTeEUWO/84Cyh4FSpjdzXx9AEU8wVQyQ/lxT3nSrztjaay
         aEHQ==
Received: by 10.152.124.111 with SMTP id mh15mr12016234lab.20.1351014469772;
        Tue, 23 Oct 2012 10:47:49 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:48 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [RFC 00/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D SOC
Date:   Tue, 23 Oct 2012 21:43:48 +0400
Message-Id: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

AFAIK the single known chip in Ingenic JZ4750D line is JZ4755.
It has just the same CPU core as JZ4740, but another set of
peripherals (though the program model for the most
of the peripherals is the same).

+-----------------+--------------+--------------+
|                 |   JZ4755     |    JZ4740    |
+-----------------+--------------+--------------+
| UART            |      3       |       4      |
| MSC (mmc/sd)    |      2       |       1      |
| GPIO            |     5x32     |      4x32    |
| TCU (timers)    | 6x16 + 1x32  |      8x16    |
| USB             |  device 2.0  |   host 1.1   |
|                 |              |  device 2.0  |
+-----------------+--------------+--------------+

The most significant advantage of the JZ4755 chip
is the second MIPS core dedicated for image processing.
Also JZ4755 is made with use of more precise technology
and it can run on the higher clock rate (approx. 433 MHz
for JZ4755 vs 336 MHz for JZ4740).

The JZ4755 is used in some game consoles:
* Ritmix RZX-50;
* Dingoo A320E/A380;
* GameLinBox.

This patch series based on the work of Lars-Peter Clausen.
To tell the truth it is the Lars-Peter Clausen's patches
with some fixes and changes.

As most of the code for JZ4750D is very close to code
for JZ4740 we can incorporate the code for JZ4750D
to the code for JZ4740 to avoid code duplication.

I propose to rename 'jz4740' mach directory to 'xburst'
or 'ingenic'.

The patch series introduces the minimal support for the JZ4755,
no peripherals are enabled save UART1. To test the kernel
I run it with incorporated initrd rootfs made with help
of https://github.com/gcwnow/buildroot.git

[RFC 01/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D
[RFC 02/13] MIPS: JZ4750D: Add clock API support
[RFC 03/13] MIPS: JZ4750D: Add IRQ handler code
[RFC 04/13] MIPS: JZ4750D: Add timer support
[RFC 05/13] MIPS: JZ4750D: Add clocksource/clockevent support
[RFC 06/13] MIPS: JZ4750D: Add system reset support
[RFC 07/13] MIPS: JZ4750D: Add setup code
[RFC 08/13] MIPS: JZ4750D: Add serial support
[RFC 09/13] MIPS: JZ4750D: Add prom support
[RFC 10/13] MIPS: JZ4750D: Add platform UART devices
[RFC 11/13] MIPS: JZ4750D: Add Kbuild files
[RFC 12/13] MIPS: JZ4750D: Add rzx50 board support
[RFC 13/13] MIPS: rzx50: Add defconfig file
