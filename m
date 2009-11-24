Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 00:24:40 +0100 (CET)
Received: from vitalin.sorra.shikadi.net ([64.71.152.201]:3077 "EHLO
        vitalin.sorra.shikadi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493618AbZKXXYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 00:24:36 +0100
Received: from berkeloid.vlook.shikadi.net ([172.16.255.5])
        by vitalin.sorra.shikadi.net with esmtp (Exim 4.62)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1ND49s-0003tz-EP
        for linux-mips@linux-mips.org; Wed, 25 Nov 2009 08:46:52 +1000
Received: from korath.teln.shikadi.net ([192.168.0.14])
        by berkeloid.teln.shikadi.net with esmtp (Exim 4.68)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1ND49r-0007Lu-Jx
        for linux-mips@linux-mips.org; Wed, 25 Nov 2009 08:46:51 +1000
Message-ID: <4B0C625B.5070408@shikadi.net>
Date:   Wed, 25 Nov 2009 08:46:51 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.1.22) Gecko/20090809 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Can you add a signature to the kernel ELF image?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <a.nielsen@shikadi.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@shikadi.net
Precedence: bulk
X-list: linux-mips

Hi all,

I'm trying to port the kernel to an NCD HMX X-Terminal (MIPS R4600), but the 
one thing I have to do before I can actually boot the image is attach a 
signature to it. I have the signature 'code' in assembly[1], but I'm not sure 
how to link it so that it ends up as the first bit of code in the ELF image 
(the very first instruction is a 'b' to jump over the actual signature text.)

Without this the boot monitor will refuse to boot the kernel.  Any suggestions 
as to how I might accomplish this?

Many thanks,
Adam.

[1] http://www.linux-mips.org/wiki/HMX
