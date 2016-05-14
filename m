Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2016 17:20:03 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:32928 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028920AbcENPUBDiYPX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2016 17:20:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To;
        bh=NtGxEhxExontIqpTkQAfKNcJ7lsUFIdW4b+soHtJKmg=; b=mZhWyp9cAU5nMVE0RpaNhl2K8e
        cjqR0FlhGxuLeJKxA5z/cYCcROM1+ILuBjuQQaTm27U9SvDpDYDtVYGhNvwrf40xo8m7H3Vj68WGq
        WPOEs8spj7+Yxb02RQ3Q5hFfmyJsHIpTDKUifVQ479MWBYiMB/iNTj6G6g1up997Sgd5UEI49nB7d
        4VaOStEi7+08cK9nBkMmKVk4tfpE3+sCTI/lidTJqOuotnnLZCrXOT9mUAEKOxxqGgDIMoapO7rRn
        wkK0wOEBykHQ3sGmu4q8rnZwEnT8CzUsv0HOPv0nejMahbZPmkPeFfpm/9/BgnLYqu8i+n/PMwilW
        FtFsy7rA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38162 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <private@roeck-us.net>)
        id 1b1bM3-001TjY-8u; Sat, 14 May 2016 15:19:47 +0000
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Guenter Roeck <private@roeck-us.net>
Subject: next: Build errors due to 'MIPS: Add probing & defs for VZ & guest
 features'
Message-ID: <57374216.10307@roeck-us.net>
Date:   Sat, 14 May 2016 08:19:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: private@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: private@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: private@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <private@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: private@roeck-us.net
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

James,

your patch 'MIPS: Add probing & defs for VZ & guest features' causes build errors
in -next when using gcc 4.7.4 / binutils 2.24. This affects almost all mips builds.

{standard input}: Assembler messages:
{standard input}:3306: Warning: Tried to set unrecognized symbol: virt
{standard input}:3307: Error: Unrecognized opcode `mfgc0 $3,$16,0'

and lots of similar messages when building arch/mips/kernel/cpu-probe.o.

Build is fine with gcc 5.2.0 and binutils 2.5.

Bisect log is attached.

Guenter

---
Bisect log:

# bad: [7fd1a8676b7f573be6aa8072e8fa1d4f1bbf8ea7] Add linux-next specific files for 20160513
# good: [44549e8f5eea4e0a41b487b63e616cb089922b99] Linux 4.6-rc7
git bisect start 'HEAD' 'v4.6-rc7'
# bad: [d573c57f72f32687ed2d11ba60ee5e6f5746ccde] Merge remote-tracking branch 'crypto/master'
git bisect bad d573c57f72f32687ed2d11ba60ee5e6f5746ccde
# bad: [cea0bc891cbcb9cd57a95c0fe03cb16ce3716125] Merge branch 'jdelvare-hwmon/master'
git bisect bad cea0bc891cbcb9cd57a95c0fe03cb16ce3716125
# good: [ffa24f116d6f3925e0eebcd4d4ae30d9ac237459] Merge remote-tracking branch 'tegra/for-next'
git bisect good ffa24f116d6f3925e0eebcd4d4ae30d9ac237459
# bad: [cb4699056080a4a094be6080e10c692af0794d93] Merge remote-tracking branch 'btrfs-kdave/for-next'
git bisect bad cb4699056080a4a094be6080e10c692af0794d93
# bad: [9f2e34d4ff5756624948fe7976866749664793c7] Merge remote-tracking branch 'mips/mips-for-linux-next'
git bisect bad 9f2e34d4ff5756624948fe7976866749664793c7
# good: [fe33223366b2c02394274395f4ac43e48c453654] MIPS: Separate XPA CPU feature into LPA and MVH
git bisect good fe33223366b2c02394274395f4ac43e48c453654
# good: [5eae0ba2589f767b5c9c14e662f972084b4a46d7] Merge remote-tracking branch 'arm64/for-next/core'
git bisect good 5eae0ba2589f767b5c9c14e662f972084b4a46d7
# bad: [9ca0b767b011347402eb083f887629b27c8eda54] Merge branch '4.6-fixes' into mips-for-linux-next
git bisect bad 9ca0b767b011347402eb083f887629b27c8eda54
# good: [128639395b2ceacc6a56a0141d0261012bfe04d3] MIPS: Adjust set_pte() SMP fix to handle R10000_LLSC_WAR
git bisect good 128639395b2ceacc6a56a0141d0261012bfe04d3
# good: [6768a2c2e1310acb3e8e8e63a6e2caa146d19d0e] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
git bisect good 6768a2c2e1310acb3e8e8e63a6e2caa146d19d0e
# good: [c1b01a9f21daaf269d77683a4f91f423254f0c3e] MIPS: Add perf counter feature
git bisect good c1b01a9f21daaf269d77683a4f91f423254f0c3e
# bad: [354d36f4304a14aced7e4ffb0d27038cd19b532f] MIPS: Add probing & defs for VZ & guest features
git bisect bad 354d36f4304a14aced7e4ffb0d27038cd19b532f
# good: [b7c0199bf7404e87839ad633e699370ed397d548] MIPS: Add register definitions for VZ ASE registers
git bisect good b7c0199bf7404e87839ad633e699370ed397d548
# good: [cf5c5ac39a33127caa3e4e97f52754a6feede8fd] MIPS: Add guest CP0 accessors
git bisect good cf5c5ac39a33127caa3e4e97f52754a6feede8fd
# first bad commit: [354d36f4304a14aced7e4ffb0d27038cd19b532f] MIPS: Add probing & defs for VZ & guest features
