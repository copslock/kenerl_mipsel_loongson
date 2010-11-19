Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 13:05:18 +0100 (CET)
Received: from service87.mimecast.com ([94.185.240.25]:34624 "HELO
        service87.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491188Ab0KSMFO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Nov 2010 13:05:14 +0100
Received: from cam-owa1.Emea.Arm.com (fw-tnat.cambridge.arm.com [217.140.96.21])
        by service87.mimecast.com;
        Fri, 19 Nov 2010 12:05:10 +0000
Received: from [10.1.68.185] ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
         Fri, 19 Nov 2010 12:05:06 +0000
Subject: Re: [PATCH 3/5] MIPS/Perf-events: Check event state in
 validate_event()
From:   Will Deacon <will.deacon@arm.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
In-Reply-To: <AANLkTikdLqo0-jkLkY-jGxurKMnmv+gb0VWWDZu6TOwd@mail.gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
         <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
         <AANLkTikdLqo0-jkLkY-jGxurKMnmv+gb0VWWDZu6TOwd@mail.gmail.com>
Date:   Fri, 19 Nov 2010 12:05:05 +0000
Message-ID: <1290168306.8175.8.camel@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1
X-OriginalArrivalTime: 19 Nov 2010 12:05:07.0087 (UTC) FILETIME=[01B021F0:01CB87E2]
X-MC-Unique: 110111912051005301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-11-19 at 11:30 +0000, Deng-Cheng Zhu wrote:
> Ah, I see. Thanks for your explanation.
> 
> But by doing this, I think we need to modify validate_group() as well.
> Consider a group which has all its events either not for this PMU or in
> OFF/Error state. Then the last validate_event() in validate_group() does
> not work. Right? So, how about the following:

[...]

If none of the events are for this PMU, then our validate_group()
won't be called. If all the events are OFF/ERROR then I don't see
what's wrong with passing the validation.

Will
