Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 13:50:18 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:32816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991955AbdCPMuLYPmM- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 13:50:11 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4D3664DAA;
        Thu, 16 Mar 2017 12:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com B4D3664DAA
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=jolsa@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com B4D3664DAA
Received: from krava (dhcp-1-124.brq.redhat.com [10.34.1.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id A954E5C6C9;
        Thu, 16 Mar 2017 12:50:00 +0000 (UTC)
Date:   Thu, 16 Mar 2017 13:49:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41
 warnings (v4.10.1)
Message-ID: <20170316124958.GA3620@krava>
References: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com>
 <CAK8P3a32nbd6Wv9wCjmUX+E3gpnWkAWwKurP9dkuwyf_oegCgg@mail.gmail.com>
 <20170315072204.GB26837@kroah.com>
 <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
 <20170316122907.GS12825@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316122907.GS12825@kernel.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 16 Mar 2017 12:50:06 +0000 (UTC)
Return-Path: <jolsa@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jolsa@redhat.com
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

On Thu, Mar 16, 2017 at 09:29:07AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 15, 2017 at 02:15:22PM +0100, Arnd Bergmann escreveu:
> > On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
> > >
> > > All now queued up in the stable trees, thanks.
> > 
> > Like 4.9.y it builds clean except for a couple of stack frame size warnings
> > and this one that continues to puzzle me.
> > 
> > /bin/sh: 1: /home/buildslave/workspace/kernel-builder/arch/x86/defconfig/allmodconfig+CONFIG_OF=n/label/builder/next/build-x86/tools/objtool//fixdep:
> > Permission denied
> 
> Jiri? Josh?

hum, looks like it imight be related to this fix we did for perf:
  abb26210a395 perf tools: Force fixdep compilation at the start of the build

it's forcing fixdep to be build as first.. having it as a simple dependency
(which AFAICS is objtool case), the make -jX occasionaly raced on high cpu
servers, and executed unfinished binary, hence the permission fail

jirka

> 
> - Arnaldo
>  
> > https://storage.kernelci.org/next/next-20170309/x86-allmodconfig+CONFIG_OF=n/build.log
> > 
> > The same warning is referenced in this email:
> > http://lkml.iu.edu/hypermail/linux/kernel/1612.0/04384.html
> > 
> > but I can't figure out what patch is supposed to address it, or if that
> > patch made it into mainline.
> > 
> > Curiously, only allmodconfig+CONFIG_OF=n seems to be broken, not
> > plain allmodconfig, maybe this could be related to rebuilding in the same
> > object tree without "make clean". Also, all recent kernels (since December)
> > until next-20170309 seem to be affected, but it does not show up on
> > the latest linux-next (next-20170310). I don't seen anything in next-20170310
> > that could have addressed it, so it may also be a coincidence that we don't
> > hit a certain race condition during build this time.
> > 
> > Adding Ingo, Arnaldo and Stephen to Cc, maybe they know what is going
> > on here.
> > 
> >       Arnd
