Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 10:52:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57298 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991867AbdCOJwRn7pKG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 10:52:17 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2F9RvXS008749;
        Wed, 15 Mar 2017 10:27:57 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2F9Rvgl008748;
        Wed, 15 Mar 2017 10:27:57 +0100
Date:   Wed, 15 Mar 2017 10:27:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] cpu-features.h rename
Message-ID: <20170315092757.GD22089@linux-mips.org>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
 <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
 <be773311-fb5b-949e-378e-09db2baa8cd4@imgtec.com>
 <20170314082906.GG26432@linux-mips.org>
 <d1b970e6-f87e-3e35-7c74-7fc0a6a4c0f2@imgtec.com>
 <80d2de6c-2196-5851-ebd6-308be40ea78f@gmail.com>
 <bf7bb5eb-abeb-7ac5-3610-2a9ce6ad3f66@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7bb5eb-abeb-7ac5-3610-2a9ce6ad3f66@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57286
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

On Wed, Mar 15, 2017 at 08:24:11AM +0100, Marcin Nowakowski wrote:
> Date:   Wed, 15 Mar 2017 08:24:11 +0100
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> To: Florian Fainelli <f.fainelli@gmail.com>, Ralf Baechle
>  <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> Subject: Re: [PATCH 0/2] cpu-features.h rename
> Content-Type: text/plain; charset="windows-1252"; format=flowed
> 
> Hi Florian,
> 
> On 15.03.2017 03:04, Florian Fainelli wrote:
> > 
> > 
> > On 03/14/2017 01:45 AM, Marcin Nowakowski wrote:
> > > Hi Ralf,
> > > 
> > > On 14.03.2017 09:29, Ralf Baechle wrote:
> > > > On Tue, Mar 14, 2017 at 08:40:21AM +0100, Marcin Nowakowski wrote:
> > > > 
> > > > > On 13.03.2017 18:08, Florian Fainelli wrote:
> > > > > > On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
> > > > > > > Since the introduction of GENERIC_CPU_AUTOPROBE
> > > > > > > (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very
> > > > > > > similarily
> > > > > > > named headers: cpu-features.h and cpufeature.h.
> > > > > > > Since the latter is used by all platforms that implement
> > > > > > > GENERIC_CPU_AUTOPROBE functionality, it's better to rename the
> > > > > > > MIPS-specific
> > > > > > > cpu-features.h.
> > > > > > > 
> > > > > > > Marcin Nowakowski (2):
> > > > > > >   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
> > > > > > >   MIPS: rename cpu-features.h -> cpucaps.h
> > > > > > 
> > > > > > That's a lot of churn that could cause some good headaches in
> > > > > > backporting stable changes affecting cpu-feature-overrides.h.
> > > > > > 
> > > > > > Can we just do the cpu-features.h -> cpucaps.h rename and keep
> > > > > > cpu-feature-overrides.h around?
> > > > > 
> > > > > That's of course possible, but I think it would make the naming quite
> > > > > confusing as well, as it would be very unclear for any reader as to
> > > > > why a
> > > > > 'cpu-feature-overrides' overrides 'cpucaps'.
> > > > > 
> > > > > I've looked at the change history of these files and most receive very
> > > > > little updates (which is hardly surprising given the changes are done
> > > > > mostly
> > > > > during initial integration of a new cpu or soon after), and none of the
> > > > > changes in those files were marked for stable. I think it's safe to
> > > > > assume
> > > > > that this pattern is not likely to change, would you agree?
> > > > 
> > > > I've noticed the same pattern - and it's a little concerning.  Not adding
> > > > values for later features means the'll probably be runtime detected
> > > > resulting in a bigger, slower kernel.
> > > 
> > > But that is a type of optimisation that may (should?) be done when new
> > > features are added, which in most cases doesn't make it a candidate for
> > > backporting to stable.
> > 
> > You may be fixing actual bugs by patching this file, e.g: selecting the
> > correct value for e.g: cpu_has_dc_aliases, cpu_has_ic_fills_ic,
> > cpu_dcache_line_size() and so on. Ideally every feature in there has
> > been properly set/cleared in arch/mips/kernel/cpu-probe.c but there
> > could be platform relying exclusively on cpu-feature-overrides.h to
> > provide the correct value.
> 
> Yes, of course that is possible and I'm not dismissing that fact.
> I've only stated that looking at the git history of these files (which dates
> back to 2008 when they were moved from a different location), there have
> been only a few changes to them and most of the changes were not bugfixes
> for specific cores but general code changes applied throughout the tree.
> So in an unlikely case that a bug is discovered that will be fixed by
> updating a specific cpu(caps|feature)-override.h, there would be a slightly
> increased effort required to backport the patch due to a filename
> difference, but IMO that's hardly a reason to prevent any changes and to
> keep the filenames inconsistent?
> It's not like I'm changing the whole logic behind cpu_has functionality ...
> 
> 
> > If not about the backport argument, just changing that many files at
> > once (have they actually been build tested at least?)
> 
> I have build-tested this with some defconfigs affected.
> 
> > just does not seem
> > practical nor worth it to me.
> 
> I think having a sensible file naming scheme is worth the change and you
> seem to see this change as a much bigger one than I do. From my perspective
> this change is a really trivial one.

As a general rule, design for the future, not the past.

  Ralf
