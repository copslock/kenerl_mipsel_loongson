Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 23:34:59 +0100 (CET)
Received: from mail.vyatta.com ([76.74.103.46]:34798 "EHLO mail.vyatta.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903622Ab1L0Weq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Dec 2011 23:34:46 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.vyatta.com (Postfix) with ESMTP id E7FBB1420010;
        Tue, 27 Dec 2011 14:34:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
        by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KIaohGOrb16U; Tue, 27 Dec 2011 14:34:43 -0800 (PST)
Received: from nehalam.linuxnetplumber.net (static-50-53-80-93.bvtn.or.frontiernet.net [50.53.80.93])
        by mail.vyatta.com (Postfix) with ESMTPSA id 1B694142000F;
        Tue, 27 Dec 2011 14:34:43 -0800 (PST)
Date:   Tue, 27 Dec 2011 14:34:41 -0800
From:   Stephen Hemminger <shemminger@vyatta.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
Message-ID: <20111227143441.30d2c42f@nehalam.linuxnetplumber.net>
In-Reply-To: <4EFA38D5.1000602@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
        <4EF95247.7000403@gentoo.org>
        <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
        <4EFA38D5.1000602@gentoo.org>
Organization: Vyatta
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 32202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@vyatta.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20177

On Tue, 27 Dec 2011 16:29:57 -0500
Joshua Kinard <kumba@gentoo.org> wrote:

> MIPS I/O registers are always memory-mapped, and to prevent the compiler
> from trying to over-optimize, volatile is used to make sure we always read a
> value from the hardware and not from some cached value.

Almost every other network driver had memory mapped register.
The problem is volatile is that the compiler is stupid and wrong.
Using explicit barriers is preferred and ensures correct and fast
code.
