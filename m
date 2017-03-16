Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 16:50:39 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:46436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992111AbdCPPudbmYyH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 16:50:33 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B908FC05AA65;
        Thu, 16 Mar 2017 15:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com B908FC05AA65
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=jolsa@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com B908FC05AA65
Received: from krava (dhcp-1-124.brq.redhat.com [10.34.1.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id E795B60319;
        Thu, 16 Mar 2017 15:50:23 +0000 (UTC)
Date:   Thu, 16 Mar 2017 16:50:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20170316155022.GA25032@krava>
References: <20170315072204.GB26837@kroah.com>
 <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
 <20170316122907.GS12825@kernel.org>
 <20170316124958.GA3620@krava>
 <CAK8P3a1a3uUCQu=FX5n_cLG+wL-LhreNF8fUyavTn5a-87gXLQ@mail.gmail.com>
 <20170316135959.GC3620@krava>
 <CAK8P3a0VCjbVp2Aynq0madWyJ8GCNQD93Fi-M_oy6SkADqKNfQ@mail.gmail.com>
 <20170316150338.GV12825@kernel.org>
 <20170316151704.GA20999@krava>
 <20170316154600.GX12825@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316154600.GX12825@kernel.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 16 Mar 2017 15:50:27 +0000 (UTC)
Return-Path: <jolsa@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57365
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

On Thu, Mar 16, 2017 at 12:46:00PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 16, 2017 at 04:17:04PM +0100, Jiri Olsa escreveu:
> > On Thu, Mar 16, 2017 at 12:03:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Mar 16, 2017 at 03:39:36PM +0100, Arnd Bergmann escreveu:
> > > > On Thu, Mar 16, 2017 at 2:59 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > On Thu, Mar 16, 2017 at 02:44:45PM +0100, Arnd Bergmann wrote:
> > > > >> On Thu, Mar 16, 2017 at 1:49 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >> It's probably another variation of this bug, but the commit you cite got merged
> > > > >> into 4.10-rc1, while the problem still persists in mainline (4.11-rc2+).
> 
> > > > > the problem is in objtool build right? the fix was for perf build
> 
> > > > Ah, got it. Yes, that must be it then. I supposed we coul duplicate what you
> > > > did for perf in objtool, but a cleaner way would be to generalize it for all of
> > > > tools/, right?
> 
> > right, the thing is that objtool is standalone application like perf,
> > and before their builds can go the 'fixdep' needs to be there.. that's
> > a condition to use the tools/build framework
> 
> > not sure how offensive it'd be to current Makefiles if we come with some
> > generalized code to do that.. I'll think about it, but I think we might
> > be better of the way we are now
> 
> > > Humm, can't we have just one fixdep?
>  
> > we have.. it's just the matter who will build it first ;-)
> 
> Ok, I haven't said "can't we have just one fixdep?", what I really said
> was "can't we make sure we don't have races building it?" ;-)

I hope so ;-) but so far I cannot think of anything better than what was introduced in:
  abb26210a395 perf tools: Force fixdep compilation at the start of the build

jirka
