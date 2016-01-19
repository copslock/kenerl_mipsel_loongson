Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 10:06:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33318 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009054AbcASJG1g4RZz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jan 2016 10:06:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u0J96PVX006414;
        Tue, 19 Jan 2016 10:06:25 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u0J96O0N006413;
        Tue, 19 Jan 2016 10:06:24 +0100
Date:   Tue, 19 Jan 2016 10:06:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: Re: cannot build Linux 4.4: =?utf-8?Q?arch?=
 =?utf-8?B?L21pcHMva2VybmVsL3NpZ25hbC5jOjE0MjoxMjogZXJyb3I6IOKAmHN0cnVj?=
 =?utf-8?Q?t_ucontext=E2=80=99_has_no_member_named_=E2=80=98uc=5Fextcontex?=
 =?utf-8?B?dOKAmQ==?=
Message-ID: <20160119090624.GB25523@linux-mips.org>
References: <569B9CFE.1090007@gmx.de>
 <569BA9BB.3080508@gmx.de>
 <569D9DDD.7080909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <569D9DDD.7080909@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51208
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

On Mon, Jan 18, 2016 at 06:22:21PM -0800, Florian Fainelli wrote:

> Le 17/01/2016 06:48, Heinrich Schuchardt a écrit :
> > On 01/17/2016 02:54 PM, Heinrich Schuchardt wrote:
> >>
> >> HEAD is now at afd2ff9... Linux 4.4
> >> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> >> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member
> >> named ‘uc_extcontext’
> >>   return &uc->uc_extcontext;
> >>             ^
> >> In file included from include/linux/poll.h:11:0,
> >>                  from include/linux/ring_buffer.h:7,
> >>                  from include/linux/trace_events.h:5,
> >>                  from include/trace/syscall.h:6,
> >>                  from include/linux/syscalls.h:81,
> >>                  from arch/mips/kernel/signal.c:26:
> >> arch/mips/kernel/signal.c: In function ‘save_msa_extcontext’:
> >> arch/mips/kernel/signal.c:170:40: error: dereferencing pointer to
> >> incomplete type
> >>
> > 
> > The problem stemmed from make not recognizing that this file was outdated:
> > 
> > Oct 16  2014 arch/mips/include/generated/asm/ucontext.h
> > 
> > Shouldn't make automatically regenerate outdated files?
> 
> The reduced test case can be simplified to these steps:
> 
> git co f1fe2d21f4e1aca8644cea888dc618f0183ad671\^1
> configure your kernel
> ARCH=mips make arch/mips/kernel/signal.o
> git co f1fe2d21f4e1aca8644cea888dc618f0183ad671
> ARCH=mips make arch/mips/kernel/signal.o
> 
> The problem seems to be that if there was a previous build which
> resulted in creating an asm-generic wrapper for a file
> (arch/mips/include/generated/asm/ucontext.h in that case), but this file
> was later moved into an arch-specific, non asm-generic header file, then
> we are just not going to automatically remove this auto-generated
> wrapper, and generate the new one.
> 
> This seems to be aggravated by the fact that commit
> f1fe2d21f4e1aca8644cea888dc618f0183ad671 does not add ucontext.h to
> arch/mips/include/uapi/Kbuild, Paul, James is that intentional?
> 
> After trying to mess a bit with a clean solution, I just gave up and
> decided that this was not worth fixing since it is a very infrequent
> problem.

We lately had about five people reporting similar issues that all could
be resolved with make distclean.

  Ralf
