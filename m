Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 09:07:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3198 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990512AbdJEHHtVhEqa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 09:07:49 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B69D29CD58F3F;
        Thu,  5 Oct 2017 08:07:39 +0100 (IST)
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 5 Oct
 2017 08:07:42 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::1092:c22e:588e:c561]) by
 badag03.ba.imgtec.org ([fe80::5efe:10.20.40.115%12]) with mapi id
 14.03.0266.001; Thu, 5 Oct 2017 00:07:37 -0700
From:   Paul Burton <Paul.Burton@imgtec.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 06/11] MIPS: cmpxchg: Implement __cmpxchg() as a function
Thread-Topic: [PATCH 06/11] MIPS: cmpxchg: Implement __cmpxchg() as a
 function
Thread-Index: AQHTPaNXn2Yy3bwiP02MD3F2STiLXqLU1Law
Date:   Thu, 5 Oct 2017 07:07:38 +0000
Message-ID: <D4E56584A8AFC94F836003742821EF82705B9658@badag02.ba.imgtec.org>
References: <49fe6972-163d-3459-6963-582ffcc35b19@linux-m68k.org>
In-Reply-To: <49fe6972-163d-3459-6963-582ffcc35b19@linux-m68k.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.78.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Paul.Burton@imgtec.com
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

Hi Greg,

> On Fri, 9 Jun 2017 17:26:38 -0700, Paul Burton wrote:
> > Replace the macro definition of __cmpxchg() with an inline function,
> > which is easier to read & modify. The cmpxchg() & cmpxchg_local()
> > macros are adjusted to call the new __cmpxchg() function.
> >
> > Signed-off-by: Paul Burton <paul.burton@xxxxxxxxxx>
> > Cc: Ralf Baechle <ralf@xxxxxxxxxxxxxx>
> > Cc: linux-mips@xxxxxxxxxxxxxx
> 
> I think this patch is breaking user space for me. I say "think"
> because it is a bit tricky to bisect for the few patches previous to this one
> since they won't compile cleanly for me (due to this
> https://www.spinics.net/lists/mips/msg68727.html).
> 
> I have a Cavium Octeon 5010 MIPS64 CPU on a custom board, have been
> running it for years running various kernel versions. Linux-4.13 breaks for me,
> and I bisected back to this change.
> 
> What I see is user space bomb strait after boot with console messages like
> this:
> 
> mount[37] killed because of sig - 11
> 
> STACK DUMP:
> <snip>
> 
> I get a lot of them from various programs running from rc scripts.
> It never manages to fully boot to login/shell.
> 
> If I take the linux-4.12 arch/mips/include/asm/cmpxchg.h and drop that in
> place on a linux-4.13 (or even linux-4.14-rc3) I can compile and run everything
> successfully.
> 
> Any thoughts?

Are you running a uniprocessor/non-SMP kernel? Could you try this fix I submitted this fix 5 weeks ago:

https://patchwork.linux-mips.org/patch/17226/

Ralf: Could we get that merged please?

(Apologies if this email is formatted oddly.)

Thanks,
    Paul
