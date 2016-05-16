Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 04:57:02 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51553 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014177AbcEPC5AkdFDD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 04:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To;
        bh=83fIw9uJBPEdRQPtmqpEiCOTqKvThMbl7zvljhcw6gs=; b=VMNGzmG5LQ8FhdXApcvLg1NrLf
        WvzgI/SAjx4iR+dgzKR7XBcnGrTuyGgvjdvSPtYYiVoavSaZMEpNWBY1FGZ5rSFZI1hObPGA219fy
        MmW7Ua5VCByB/p1eUt0/frnX8JxLOXhnPTe2oKgZVsEPbV+HCJ+5dalzGFnjtXaKfgf+3Q34k2iTW
        88EUUUjCdZI3zgLWjoB3HKi8IPBXNTquVJFRzYG83BNxPvZME5o3mhL4FUg9miuMMYs9+Chioy0D9
        K+GwP5E0bFZUrDunqprrfpu/dQxFVUxYWlhckPLz+asCB5pkVcZN293GaM2eb6A8kJB3GdDdTy/xM
        TGFU03WQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51312 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1b28hr-0026lz-Nt; Mon, 16 May 2016 02:56:31 +0000
To:     stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
Message-ID: <573936E3.3050003@roeck-us.net>
Date:   Sun, 15 May 2016 19:56:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Hi folks,

building mips images with a consistent infrastructure is becoming more and more difficult.
Current state is as follows.

Binutils/	2.22	2.24	2.25
Kernel
3.2		X	-	-
3.4		X	-	-
3.10		X	X	-
3.14		X	X	-
3.16		X	X	-
3.18		X	X	(X) [1]
4.1		X	X	(X)
4.4		X	X	(X)
4.5		X	X	(X)
4.6		X	X	(X)
next		-	X	(X)

[1] (at least) allnoconfig fails to build with binutils 2.25 (2.25.1, more specifically).

I used the following toolchains for the above tests:
- Poky 1.3 (binutils 2.22)
- Poky 2.0 (binutils 2.25.1)
- gcc-4.6.3-nolibc from kernel.org (binutils 2.22)
- gcc-4.9.0-nolibc from kernel.org (binutils 2.24)

For 3.4 and 3.2 kernels to build with binutils v2.24, it would be necessary to
apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_page' functions").
It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It might
make sense to apply this patch to both releases. Would this be possible ?
This way, we would have at least one toolchain which can build all 3.2+ kernels.

Thanks,
Guenter
