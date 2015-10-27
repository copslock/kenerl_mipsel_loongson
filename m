Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 22:49:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2395 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011412AbbJ0VtXF6cEW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 22:49:23 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 59561E836927;
        Tue, 27 Oct 2015 21:49:14 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 27 Oct
 2015 21:49:17 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 27 Oct
 2015 21:49:17 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 27 Oct
 2015 14:49:15 -0700
Message-ID: <562FF15A.1050507@imgtec.com>
Date:   Tue, 27 Oct 2015 14:49:14 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com> <5629904A.2070400@imgtec.com> <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com> <562FE678.2030307@gmail.com> <562FE96C.3070002@imgtec.com> <562FF05A.508@gmail.com>
In-Reply-To: <562FF05A.508@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49727
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


> For example, On OCTEON single-chip systems we synchronize the the 
> counters and they don't drift.  So, we can use CPO.Count. However, on 
> two-chip NUMA configurations there may be clock drift between the two 
> chips, so CPO.Count cannot be used as a clocksource.  We have a single 
> kernel image that runs on both types of systems, so we have to be able 
> to enable/disable the gettimeofday() acceleration.
>
Much more interesting the situation then there are a different clock 
frequency in different CPUs.

It seems for me that per-thread memory idea may be required soon.

- Leonid
