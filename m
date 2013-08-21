Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 21:52:07 +0200 (CEST)
Received: from smtp.snhosting.dk ([87.238.248.203]:38332 "EHLO
        smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6839460Ab3HUTwExjiof (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 21:52:04 +0200
Received: from merkur.ravnborg.org (unknown [188.228.89.252])
        by smtp.domainteam.dk (Postfix) with ESMTPA id 77470F1AD9;
        Wed, 21 Aug 2013 21:51:58 +0200 (CEST)
Date:   Wed, 21 Aug 2013 21:51:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [RFC] Get rid of SUBARCH
Message-ID: <20130821195157.GA18191@merkur.ravnborg.org>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

> 
> > The series touches also m68k, sh, mips and unicore32.
> > These architectures magically select a cross compiler if ARCH != SUBARCH.
> > Do really need that behavior?
> 
> This does remove functionality.
> It allows to build a kernel using e.g. "make ARCH=m68k".
> 
> Perhaps this can be moved to generic code? Most (not all!) cross-toolchains
> are called $ARCH-{unknown-,}linux{,-gnu}.
> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.

Today you can specify CROSS_COMPILE in Kconfig.
With this we should be able to remove these hacks.

	Sam
