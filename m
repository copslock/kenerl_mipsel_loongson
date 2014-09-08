Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 16:12:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38099 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008454AbaIHOMzOH0BA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 16:12:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1EED14D0AB251;
        Mon,  8 Sep 2014 15:12:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 8 Sep 2014 15:12:48 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 8 Sep
 2014 15:12:47 +0100
Message-ID: <540DB95F.6070609@imgtec.com>
Date:   Mon, 8 Sep 2014 15:12:47 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Release of Linux MTI-3.14-LTS kernel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Imagination Technologies is pleased to announce the release of its 3.14
LTS (Long-Term Support) MIPS kernel. The changelog below is based off
the stable Linux 3.14.10 release done by Greg Kroah-Hartman in commit
bbae7add628cfe96a1facd578dd1eddcd1030de7 back on June 30th. The code
repository is hosted at the Linux/MIPS project GIT:

http://git.linux-mips.org/?p=linux-mti.git;a=shortlog;h=refs/heads/linux-mti-3.14

We look forward to any comments or feedback.

        The Imagination MIPS Kernel Team


ChangeLog:

Upstream:
- Move to Linux 3.14.10

Userland visible changes:
- MIPS 32/64 seccomp support
- Do not set any FCSR cause bits from userland

Boot setup related changes:
- SMP/CPS support
- Deprecate SMP/CMP

New drivers and features:
- m5150 support
- p5600 support
- perf support for interAptiv/proAptiv/p5600
- EVA support
- Malta power management support
- Malta powering down support
- Hardware Table Walker support
- MAAR support
- Dedicated RI/XI exception handlers
- Hotplug support
- cpuidle support

Developer visible changes:
- SMTC removal
- Enable DEVTMPFS on malta_defconfigs
- Add more microassembler instructions
- 16K by default on Malta SMP defconfigs
- Set max cpus to 8 on Malta SMP defconfigs

Fixes:
- Detect instruction cache aliases
- Fix 1074K CPU support
- GIC fixes
- KVM T&E fixes
- sead3/BE networking fix
- Misc other code fixes, build fixes and cleanups

-- 
markos
