Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 21:15:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48905 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011767AbbJ1UPq6sDNt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 21:15:46 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 45DCC47430BF9;
        Wed, 28 Oct 2015 20:15:36 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 28 Oct
 2015 20:15:39 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 28 Oct
 2015 13:15:38 -0700
Message-ID: <56312CE9.3090301@imgtec.com>
Date:   Wed, 28 Oct 2015 13:15:37 -0700
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
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>      <5629904A.2070400@imgtec.com>   <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com>   <562FE678.2030307@gmail.com>    <562FE96C.3070002@imgtec.com>   <562FF05A.508@gmail.com>        <562FF15A.1050507@imgtec.com>   <CAOFt0_AFnR0MF2e8rRXhz_wkiGbL2VTFy=AXpcmWTZ9_bYA=VQ@mail.gmail.com>    <56311231.10503@imgtec.com>     <CAOFt0_C3QXKrZ-uta_RrR04hFMbQnNdfoJP7pZjoSSUftc7dCQ@mail.gmail.com>    <56311AA9.6040101@imgtec.com>   <CAOFt0_AvGQcxHAToEevTFt5JGiuhN03XnPxxjQizbZ3dC-06mg@mail.gmail.com>    <563121D5.4030601@imgtec.com> <CAOFt0_DKfouP0r68M8S-CQF=Fk0C7sPpV2WNm=u-wH3_1q=Pzw@mail.gmail.com>
In-Reply-To: <CAOFt0_DKfouP0r68M8S-CQF=Fk0C7sPpV2WNm=u-wH3_1q=Pzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49740
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

On 10/28/2015 12:55 PM, Alex Smith wrote:
> On 28 October 2015 at 19:28, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>> . 
> Clocksources are not per-CPU. If the CP0 counter is the current
> clocksource, then both the kernel and VDSO implementations of
> gettimeofday will read out the CP0 counter from whatever CPU they run
> on.

OK, it was an invalid example. Let's be specific - in case of different 
clock frequency in different CPUs it easy to adjust it in kernel via 
clocksource->read()/etc but it is impossible to adjust that in VDSO 
implementation.

And that can't be fixed easily without some-kind of "per-thread" data 
page for correct multipliers.

There are many problems with assumption that in all kind of MIPS cores 
R4K CP0_COUNT registers are in sync in different CPUs. Even current 
kernel has problems here but I think it is not excuse to mount more on it.

- Leonid.
