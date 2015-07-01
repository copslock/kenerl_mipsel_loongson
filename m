Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2015 00:31:04 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27009724AbbGAWbDGFndW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2015 00:31:03 +0200
Date:   Wed, 1 Jul 2015 23:31:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Michal Marek <mmarek@suse.cz>
cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gitignore: Add MIPS vmlinux.32 to the list
In-Reply-To: <20150615091058.GA6984@sepie.suse.cz>
Message-ID: <alpine.LFD.2.11.1507012328480.31747@eddie.linux-mips.org>
References: <1429896460-15026-1-git-send-email-f.fainelli@gmail.com> <CAGVrzcb7oMa97=w_jSDPga6yPV50f6-QEBUnX1fhMFdQqDv1xw@mail.gmail.com> <20150615091058.GA6984@sepie.suse.cz>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 15 Jun 2015, Michal Marek wrote:

> > > MIPS64 kernels builds will produce a vmlinux.32 kernel image for
> > > compatibility, ignore them.
> > 
> > Ralf, Michal, which one of you should take this patch?
> 
> I just applied it to kbuild.git#misc.

 I suggest adding vmlinux.64 for consistency as well.

  Maciej
