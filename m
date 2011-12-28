Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2011 01:29:12 +0100 (CET)
Received: from mail.vyatta.com ([76.74.103.46]:35884 "EHLO mail.vyatta.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903622Ab1L1A3H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Dec 2011 01:29:07 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.vyatta.com (Postfix) with ESMTP id 3C5761420010;
        Tue, 27 Dec 2011 16:29:06 -0800 (PST)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
        by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NYqqRoJfFpyn; Tue, 27 Dec 2011 16:29:05 -0800 (PST)
Received: from nehalam.linuxnetplumber.net (static-50-53-80-93.bvtn.or.frontiernet.net [50.53.80.93])
        by mail.vyatta.com (Postfix) with ESMTPSA id 3F046142000F;
        Tue, 27 Dec 2011 16:29:05 -0800 (PST)
Date:   Tue, 27 Dec 2011 16:29:03 -0800
From:   Stephen Hemminger <shemminger@vyatta.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
Message-ID: <20111227162903.48c6c619@nehalam.linuxnetplumber.net>
In-Reply-To: <4EFA4B40.8090502@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
        <4EF95247.7000403@gentoo.org>
        <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
        <4EFA38D5.1000602@gentoo.org>
        <20111227143441.30d2c42f@nehalam.linuxnetplumber.net>
        <4EFA4B40.8090502@gentoo.org>
Organization: Vyatta
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 32204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@vyatta.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20229

On Tue, 27 Dec 2011 17:48:32 -0500
Joshua Kinard <kumba@gentoo.org> wrote:

> On 12/27/2011 17:34, Stephen Hemminger wrote:
> 
> > On Tue, 27 Dec 2011 16:29:57 -0500
> > Joshua Kinard <kumba@gentoo.org> wrote:
> > 
> >> MIPS I/O registers are always memory-mapped, and to prevent the compiler
> >> from trying to over-optimize, volatile is used to make sure we always read a
> >> value from the hardware and not from some cached value.
> > 
> > Almost every other network driver had memory mapped register.
> > The problem is volatile is that the compiler is stupid and wrong.
> > Using explicit barriers is preferred and ensures correct and fast
> > code.
> 
> 
> I am somewhat new to driver development, so I do not know all the tricks of
> the trade just yet.  Do you have references to doing explicit barriers that
> I can look at?  Might be worth trying on the RTC driver I have to get the
> hang of them.
> 

Start by reading volatile considered harmful and memory barriers in kernel
Documentation directory. Paul does a better job of explaining it than
I could ever do :-)
