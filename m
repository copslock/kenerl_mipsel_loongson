Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 20:28:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24634 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011752AbbJ1T23wEv3t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 20:28:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 758681BDD6C2E;
        Wed, 28 Oct 2015 19:28:20 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 28 Oct
 2015 19:28:23 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 28 Oct
 2015 12:28:22 -0700
Message-ID: <563121D5.4030601@imgtec.com>
Date:   Wed, 28 Oct 2015 12:28:21 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Alex Smith <alex@alex-smith.me.uk>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>      <5629904A.2070400@imgtec.com>   <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com>   <562FE678.2030307@gmail.com>    <562FE96C.3070002@imgtec.com>   <562FF05A.508@gmail.com>        <562FF15A.1050507@imgtec.com>   <CAOFt0_AFnR0MF2e8rRXhz_wkiGbL2VTFy=AXpcmWTZ9_bYA=VQ@mail.gmail.com>    <56311231.10503@imgtec.com>     <CAOFt0_C3QXKrZ-uta_RrR04hFMbQnNdfoJP7pZjoSSUftc7dCQ@mail.gmail.com>    <56311AA9.6040101@imgtec.com> <CAOFt0_AvGQcxHAToEevTFt5JGiuhN03XnPxxjQizbZ3dC-06mg@mail.gmail.com>
In-Reply-To: <CAOFt0_AvGQcxHAToEevTFt5JGiuhN03XnPxxjQizbZ3dC-06mg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49737
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

On 10/28/2015 12:04 PM, Alex Smith wrote:
> On 28 October 2015 at 18:57, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>>
> As I've explained the VDSO will only use the CP0 counter in the same
> situations that the kernel would when it is the active clocksource.
> Any issue that makes the counter unreliable affects the kernel as well
> and is unrelated to the VDSO, so a fix does not belong in this patch.

What would you do if some SoC with different type of cores will define 
CPU1 etc CP0_COUNT as a DIFFERENT clocksource from CPU0 (because of 
frequency etc)? Timekeeping can select CPU0 clocksource but code still 
uses a local CPU1 CP0_COUNT for gettimeofday().

And this kind of solution is the first in line to have an accurate 
timing in systems without GIC and with different clock frequencies.

- Leonid
