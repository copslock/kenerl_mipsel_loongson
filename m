Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 09:29:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52782 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994768AbdCNI3Hi0NIp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 09:29:07 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2E8T6OD015770;
        Tue, 14 Mar 2017 09:29:06 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2E8T6h0015769;
        Tue, 14 Mar 2017 09:29:06 +0100
Date:   Tue, 14 Mar 2017 09:29:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] cpu-features.h rename
Message-ID: <20170314082906.GG26432@linux-mips.org>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
 <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
 <be773311-fb5b-949e-378e-09db2baa8cd4@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be773311-fb5b-949e-378e-09db2baa8cd4@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57198
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

On Tue, Mar 14, 2017 at 08:40:21AM +0100, Marcin Nowakowski wrote:

> On 13.03.2017 18:08, Florian Fainelli wrote:
> > On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
> > > Since the introduction of GENERIC_CPU_AUTOPROBE
> > > (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very similarily
> > > named headers: cpu-features.h and cpufeature.h.
> > > Since the latter is used by all platforms that implement
> > > GENERIC_CPU_AUTOPROBE functionality, it's better to rename the MIPS-specific
> > > cpu-features.h.
> > > 
> > > Marcin Nowakowski (2):
> > >   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
> > >   MIPS: rename cpu-features.h -> cpucaps.h
> > 
> > That's a lot of churn that could cause some good headaches in
> > backporting stable changes affecting cpu-feature-overrides.h.
> > 
> > Can we just do the cpu-features.h -> cpucaps.h rename and keep
> > cpu-feature-overrides.h around?
> 
> That's of course possible, but I think it would make the naming quite
> confusing as well, as it would be very unclear for any reader as to why a
> 'cpu-feature-overrides' overrides 'cpucaps'.
> 
> I've looked at the change history of these files and most receive very
> little updates (which is hardly surprising given the changes are done mostly
> during initial integration of a new cpu or soon after), and none of the
> changes in those files were marked for stable. I think it's safe to assume
> that this pattern is not likely to change, would you agree?

I've noticed the same pattern - and it's a little concerning.  Not adding
values for later features means the'll probably be runtime detected
resulting in a bigger, slower kernel.

  Ralf
