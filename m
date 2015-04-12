Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Apr 2015 01:22:02 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:55449 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009084AbbDLXV7wzIZV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Apr 2015 01:21:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 4031956F779;
        Mon, 13 Apr 2015 02:22:00 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id UxCAh8qDE30y; Mon, 13 Apr 2015 02:21:55 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 3F72D5BC011;
        Mon, 13 Apr 2015 02:21:55 +0300 (EEST)
Date:   Mon, 13 Apr 2015 02:21:54 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: elf: Set O32 default FPU flags
Message-ID: <20150412232154.GA26498@fuloong-minipc.musicnaut.iki.fi>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
 <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
 <alpine.LFD.2.11.1504071617580.21028@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504071617580.21028@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Tue, Apr 07, 2015 at 05:36:08PM +0100, Maciej W. Rozycki wrote:
> On Thu, 26 Feb 2015, Markos Chandras wrote:
> > Set good default FPU flags (FR0) for O32 binaries similar to what the
> > kernel does for the N64/N32 ones. This also fixes a regression
> > introduced in commit 46490b572544 ("MIPS: kernel: elf: Improve the
> > overall ABI and FPU mode checks") when MIPS_O32_FP64_SUPPORT is
> > disabled. In that case, the mips_set_personality_fp() did not set the
> > FPU mode at all because it assumed that the FPU mode was already set
> > properly. That led to O32 userland problems.
> > 
> > Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Reported-by: Mans Rullgard <mans@mansr.com>
> > Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> 
>  Can you please backport this change to 4.0 ASAP, preferably before it 
> hits the actual release?
> 
>  It fixes a 3.19->4.0 regression, likely affecting all FPU processors and 
> wreaking havoc.  For example I came across a system that boots 3.19 just 
> fine, but hangs in `ypbind' with 4.0.  It works again with this change 
> applied.

It seems this patch, and some other fixes for fatal regressions,
missed 4.0, although they were reported right after the -rc1 was out.

Basically 4.0 is unusable for MIPS users.

:-(

A.
