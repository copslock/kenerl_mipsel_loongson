Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 16:23:28 +0100 (CET)
Received: from ra.se.axis.com ([195.60.68.13]:60797 "EHLO ra.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903661Ab1KHPXU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 16:23:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by ra.se.axis.com (Postfix) with ESMTP id 21624130BF
        for <linux-mips@linux-mips.org>; Tue,  8 Nov 2011 16:23:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
        by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id B-uQBj+ANy8n for <linux-mips@linux-mips.org>;
        Tue,  8 Nov 2011 16:23:14 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by ra.se.axis.com (Postfix) with ESMTP id 67207130B3
        for <linux-mips@linux-mips.org>; Tue,  8 Nov 2011 16:23:14 +0100 (CET)
Received: from lnxricardw.se.axis.com (lnxricardw.se.axis.com [10.88.7.1])
        by seth.se.axis.com (Postfix) with ESMTP id 651243E0A5
        for <linux-mips@linux-mips.org>; Tue,  8 Nov 2011 16:23:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lnxricardw.se.axis.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id pA8FNEBN006592
        for <linux-mips@linux-mips.org>; Tue, 8 Nov 2011 16:23:14 +0100
Date:   Tue, 8 Nov 2011 16:23:14 +0100 (CET)
From:   Ricard Wanderlof <ricard.wanderlof@axis.com>
X-X-Sender: ricardw@lnxricardw.se.axis.com
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: built-in command line vs. bootloader-supplied
Message-ID: <Pine.LNX.4.64.1111081603190.30940@lnxricardw.se.axis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-archive-position: 31426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricard.wanderlof@axis.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6809


Hi,

This is my first post to the list, not having had the need to delve into 
the MIPS port at this level before.

When the CONFIG_CMDLINE_BOOL is set, a built-in command line can be set 
in CONFIG_CMDLINE by virtue of arch/mips/kernel/setup.c:arch_mem_init() .

If the boot loader supplies an additional command line (picked up by 
various sub-architecture-specific routines (to pick an example, 
pmc-sierra/msp71xx/msp_prom.c:prom_init_cmdline())), it can be 
concatenated with the built-in command line. This is not supported for all 
architectures, but it is for x86 and MIPS. However, one difference is that 
for x86, the bootloader-supplied command line is appended to the kernel 
built-in one, but for MIPS it's the other way around: the 
bootloader-supplied commands end up first in the command line string, 
appended by the built-in command line.

Is there any reason that it is like this? I could guess a number of 
reasons for one or the other, but it would be nice if someone has a more 
definitive answer. Or is it actually a bug? It would seem that it should 
at least be consistent across architectures.

Looking at the git log, the current state of affairs was committed 
2009-09-21 by Dmitri Vorobiev, stating in the commit message " ... in a 
manner identical to what is currently used for x86." . But at the time x86 
worked as today, i.e. with the builtin first, appended by the 
bootloader-supplied one.

Thanks for any pointers.

/Ricard
-- 
Ricard Wolf Wanderlöf                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
