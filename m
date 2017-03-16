Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 13:29:27 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992227AbdCPM3VFaB5- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 13:29:21 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 43E182049C;
        Thu, 16 Mar 2017 12:29:17 +0000 (UTC)
Received: from jouet.infradead.org (unknown [179.97.44.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A75420260;
        Thu, 16 Mar 2017 12:29:14 +0000 (UTC)
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 31D921444C7; Thu, 16 Mar 2017 09:29:07 -0300 (BRT)
Date:   Thu, 16 Mar 2017 09:29:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41
 warnings (v4.10.1)
Message-ID: <20170316122907.GS12825@kernel.org>
References: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com>
 <CAK8P3a32nbd6Wv9wCjmUX+E3gpnWkAWwKurP9dkuwyf_oegCgg@mail.gmail.com>
 <20170315072204.GB26837@kroah.com>
 <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <acme@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acme@kernel.org
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

Em Wed, Mar 15, 2017 at 02:15:22PM +0100, Arnd Bergmann escreveu:
> On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
> >
> > All now queued up in the stable trees, thanks.
> 
> Like 4.9.y it builds clean except for a couple of stack frame size warnings
> and this one that continues to puzzle me.
> 
> /bin/sh: 1: /home/buildslave/workspace/kernel-builder/arch/x86/defconfig/allmodconfig+CONFIG_OF=n/label/builder/next/build-x86/tools/objtool//fixdep:
> Permission denied

Jiri? Josh?

- Arnaldo
 
> https://storage.kernelci.org/next/next-20170309/x86-allmodconfig+CONFIG_OF=n/build.log
> 
> The same warning is referenced in this email:
> http://lkml.iu.edu/hypermail/linux/kernel/1612.0/04384.html
> 
> but I can't figure out what patch is supposed to address it, or if that
> patch made it into mainline.
> 
> Curiously, only allmodconfig+CONFIG_OF=n seems to be broken, not
> plain allmodconfig, maybe this could be related to rebuilding in the same
> object tree without "make clean". Also, all recent kernels (since December)
> until next-20170309 seem to be affected, but it does not show up on
> the latest linux-next (next-20170310). I don't seen anything in next-20170310
> that could have addressed it, so it may also be a coincidence that we don't
> hit a certain race condition during build this time.
> 
> Adding Ingo, Arnaldo and Stephen to Cc, maybe they know what is going
> on here.
> 
>       Arnd
