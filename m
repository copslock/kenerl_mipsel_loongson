Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 02:28:24 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:53525 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007512AbbB0B2WJ1yu6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 02:28:22 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id D5F8B21B8E0;
        Fri, 27 Feb 2015 03:28:21 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id XThm-Y34j9Dk; Fri, 27 Feb 2015 03:28:16 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id DF7905BC012;
        Fri, 27 Feb 2015 03:28:16 +0200 (EET)
Date:   Fri, 27 Feb 2015 03:28:16 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: elf: Set O32 default FPU flags
Message-ID: <20150227012816.GA590@fuloong-minipc.musicnaut.iki.fi>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
 <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46029
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

On Thu, Feb 26, 2015 at 11:11:30AM +0000, Markos Chandras wrote:
> Set good default FPU flags (FR0) for O32 binaries similar to what the
> kernel does for the N64/N32 ones. This also fixes a regression
> introduced in commit 46490b572544 ("MIPS: kernel: elf: Improve the
> overall ABI and FPU mode checks") when MIPS_O32_FP64_SUPPORT is
> disabled. In that case, the mips_set_personality_fp() did not set the
> FPU mode at all because it assumed that the FPU mode was already set
> properly. That led to O32 userland problems.
> 
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Reported-by: Mans Rullgard <mans@mansr.com>
> Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

This seems to fix some strange openssl issues on my Loongson system
(O32, hard-float) with 4.0-rc1.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
