Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:41:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53082 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010703AbbJWBljVoUiB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:41:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 66ACFEB6D7B8B;
        Fri, 23 Oct 2015 02:41:33 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 23 Oct
 2015 02:41:33 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Fri, 23 Oct
 2015 02:41:33 +0100
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 22 Oct
 2015 18:41:31 -0700
Message-ID: <5629904A.2070400@imgtec.com>
Date:   Thu, 22 Oct 2015 18:41:30 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

You can not use R4K CP0_count in SMP (multicore) without core-specific 
adjustment.
After first power-saving with core clock off or core down the values in 
CP0_count
in different cores are absolutely different.

Until you include in system a patch like 
http://patchwork.linux-mips.org/patch/10871/

     "MIPS: Setup an instruction emulation in VDSO protected page 
instead of user stack"

which creates a per-thread memory and put into that memory an adjustment 
value
(which can be changed during re-schedule to another core), the use of 
R4K counter is incorrect
in SMP environment.

Note: It is also possible to setup and maintain a per-core page with 
that value too as
an alternative variant for adjustment.
