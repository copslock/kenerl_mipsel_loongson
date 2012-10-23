Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:53:50 +0200 (CEST)
Received: from mail-ia0-f177.google.com ([209.85.210.177]:34302 "EHLO
        mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825707Ab2JWRxt1bvsD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:53:49 +0200
Received: by mail-ia0-f177.google.com with SMTP id x26so3215887iak.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=fqhZqn6auWlBi3C8BDElrx40n2GPI/tPMfgw8pywwdY=;
        b=rBmxQ2oIdxOYvB4aeoxp69rSqpPx23gXIoNcnjgiQfNxZ8JSOTeUr1SqUgVycZAvxg
         d77aXuinFvpR+jSwdv8XVQGdf0NAkXA/GbOcYQEHDDufPZ/NOX9oLN6yi3ZP2q5YHRhk
         tZbYZ508S/P/jMCaMNWRhtiWKTdS8F0cRDSpjeDTv8ofQcZRbuC6jZK1dcJL/qkJ8yWQ
         s57nLE4RDlr6D1RKJe6yeaA4brZUKwQjWdurYhs7ttB2gvWrTXwsSRdnjlvDbcLTeCJ4
         dC3tvXbdlyyWWgzwuGsn+H0UzF8rDleU1HkXREJM5oGegvPemnhoZTaPjJiHXiUMMV5a
         KYUQ==
MIME-Version: 1.0
Received: by 10.50.193.131 with SMTP id ho3mr21150652igc.51.1351014822703;
 Tue, 23 Oct 2012 10:53:42 -0700 (PDT)
Received: by 10.64.13.233 with HTTP; Tue, 23 Oct 2012 10:53:42 -0700 (PDT)
Date:   Tue, 23 Oct 2012 21:53:42 +0400
Message-ID: <CAA4bVAEFEhap9wCHroouCQZj+X_ccusoV13MmgDqFw1Kp813PA@mail.gmail.com>
Subject: [RFC 00/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D SOC
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34764
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

-- 
Best regards,
  Antony Pavlov
