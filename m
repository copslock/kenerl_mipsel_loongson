Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2010 22:19:35 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:38574 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490996Ab0K1VTc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Nov 2010 22:19:32 +0100
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id D119F1805951
        for <linux-mips@linux-mips.org>; Sun, 28 Nov 2010 22:19:31 +0100 (CET)
X-Auth-Info: CBdgC5wpAhwEGtpaKxdoiwXdXAdtobBBF8uxiDz1SB8=
Received: from lancy.mylan.de (p4FE62A09.dip.t-dialin.net [79.230.42.9])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 725FF1C001CE
        for <linux-mips@linux-mips.org>; Sun, 28 Nov 2010 22:19:31 +0100 (CET)
Message-ID: <4CF2C7B1.5030007@grandegger.com>
Date:   Sun, 28 Nov 2010 22:20:49 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Can't read from mmaped PCI memory space
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

Hello,

I'm trying to read from mmapped PCI memory space on an alchemy board,
but I can't get it to work. Here's the lspci output of the PCI card:

  bash-3.00# lspci -v
  00:00.0 Class 0200: 168c:001b (rev 01)
	Subsystem: 168c:2063
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 0000000040000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [44] Power Management version 2

I used mmap on "/dev/mem" and "/sys/bus/pci/.../resource0", but I do not
read the expected values using "*(volatile u32 *)mmap_addr" from that
region. The value also changes from read to read. Reading from kernel
space just work fine. Am I doing something illegal? Any idea why it does
not work?

TIA,

Wolfgang.
