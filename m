Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 01:23:35 +0200 (CEST)
Received: from a.mail.sonic.net ([64.142.16.245]:39195 "EHLO a.mail.sonic.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491191Ab1HKXXb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 01:23:31 +0200
Received: from webmail.sonic.net (c.webmail.sonic.net [69.12.221.241])
        by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id p7BNNRRS002586
        for <linux-mips@linux-mips.org>; Thu, 11 Aug 2011 16:23:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Priority: Normal
X-Mailer: AtMail PHP 5.62
Message-ID: <59027.1313105007@sonic.net>
To:     <linux-mips@linux-mips.org>
Reply-To: mikeci@acm.org
X-Origin: 207.114.132.30
X-Atmail-Account: mikeci@sonic.net
Date:   Thu, 11 Aug 2011 16:23:27 -0700
Subject: Possible bug in 8250.c
From:   Ivica Mikec <mikeci@acm.org>
X-archive-position: 30854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikeci@acm.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8917

Hi!


I noticed a problem in 8250.c.

My board has only one UART port, and is 16550 compatible, so in function serial8250_interrupt I see that serial_in function is called twice. Second time, code "else if (end == NULL)" is executed and function return IRQ_NONE. This causes an entry in /proc/irq/spurious:

count 239
unhandled 1
last_unhandled 4294700846 ms

But this is not a spurious interrupt.

Regards.
