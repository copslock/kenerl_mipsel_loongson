Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 18:46:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58576 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995048AbdH2QqUtkzDr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 18:46:20 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7TGkJYg002776;
        Tue, 29 Aug 2017 18:46:19 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7TGkIUG002775;
        Tue, 29 Aug 2017 18:46:18 +0200
Date:   Tue, 29 Aug 2017 18:46:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, trivial@kernel.org
Subject: Re: [PATCH 11/11] MIPS: Declare various variables & functions static
Message-ID: <20170829164618.GE22412@linux-mips.org>
References: <20170823181754.24044-1-paul.burton@imgtec.com>
 <20170823181754.24044-12-paul.burton@imgtec.com>
 <787b1a5b-2e77-41cc-235f-6dfd882b225a@imgtec.com>
 <5605804.ME68hyheDo@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5605804.ME68hyheDo@np-p-burton>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59878
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

On Tue, Aug 29, 2017 at 09:44:16AM -0700, Paul Burton wrote:

> > +#ifdef CONFIG_DEBUG_FS
> >   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
> >   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
> >   static DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats);
> > +#endif
> > 
> > if you're OK with it then I guess it may be best for Ralf to fold this
> > change into your patch?
> 
> D'oh! That looks like a reasonable fix to me - could you fold it in Ralf?

Done that a few hours ago.

  Ralf
