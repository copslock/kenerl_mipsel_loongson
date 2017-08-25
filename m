Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 13:16:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36340 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992544AbdHYLQfxuLp0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Aug 2017 13:16:35 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7PBGXUS028030;
        Fri, 25 Aug 2017 13:16:33 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7PBGXsO028007;
        Fri, 25 Aug 2017 13:16:33 +0200
Date:   Fri, 25 Aug 2017 13:16:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>
Subject: Re: next/master build: 212 builds: 3 failed, 209 passed, 384 errors,
 58 warnings (next-20170824)
Message-ID: <20170825111633.GD7433@linux-mips.org>
References: <599ea3e4.b785df0a.aff31.4380@mx.google.com>
 <CAK8P3a3G8Mo7qsgnbEXNHzU9MRRCppWhBgAT4DF-z3xgiK+WLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3G8Mo7qsgnbEXNHzU9MRRCppWhBgAT4DF-z3xgiK+WLA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Aug 25, 2017 at 12:19:17AM +0200, Arnd Bergmann wrote:

> On Thu, Aug 24, 2017 at 12:01 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >
> > next/master build: 212 builds: 3 failed, 209 passed, 384 errors, 58 warnings (next-20170824)
> > Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20170824/
> > Tree: next
> > Branch: master
> > Git Describe: next-20170824
> > Git Commit: 9506597de2cde02d48c11d5c250250b9143f59f7
> > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > Built: 4 unique architectures
> >
> > Build Failures Detected:
> >
> > mips: gcc version 6.3.0 (GCC)
> > cavium_octeon_defconfig FAIL
> > decstation_defconfig FAIL
> > jmr3927_defconfig FAIL
> 
> We currently get three build failures on linux-next, all on MIPS, and
> caused by the same patch series from Paul Burton if I read this right:
> 
> > cavium_octeon_defconfig (mips) — FAIL, 378 errors, 0 warnings, 0 section mismatches
> >
> > Errors:
> > arch/mips/kernel/octeon_switch.S:19: Error: unrecognized opcode `leaf(resume)'
> > arch/mips/kernel/octeon_switch.S:21: Error: invalid operands `mfc0 t1,CP0_STATUS'
> > arch/mips/kernel/octeon_switch.S:22: Error: unrecognized opcode `long_s t1,THREAD_STATUS(a0)'
> > arch/mips/kernel/octeon_switch.S:23: Error: unrecognized opcode `cpu_save_nonscratch a0'
> > ...
> 
> Apparently caused by dc2dd0508e19 ("MIPS: Move r4k FP code from
> r4k_switch.S to r4k_fpu.S")
> 
> > decstation_defconfig (mips) — FAIL, 3 errors, 0 warnings, 0 section mismatches
> >
> > Errors:
> > arch/mips/kernel/r2300_fpu.S:40: Error: unrecognized opcode `export_symbol(_save_fp)'
> > arch/mips/kernel/r2300_fpu.S:41: Error: unrecognized opcode `fpu_save_single $4,$9'
> > arch/mips/kernel/r2300_fpu.S:49: Error: unrecognized opcode `fpu_restore_single $4,$9'
> 
> Same for jmr3927_defconfig, both caused by 4e967a53718f ("MIPS: Move r2300
> FP code from r2300_switch.S to r2300_fpu.S").
> 
> I have no idea what exactly causes the problem. Paul, can you have a look?

My name may not be Paul but I fixed it anyway :)

  Ralf
