Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2014 15:28:19 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:38795 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823977AbaBEO2Fh9ZQi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Feb 2014 15:28:05 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s15ERolf006649
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 5 Feb 2014 06:27:50 -0800 (PST)
Received: from yow-pgortmak-d1 (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.2.347.0; Wed, 5 Feb 2014
 06:27:49 -0800
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id 32595E1D171; Wed,
  5 Feb 2014 09:28:25 -0500 (EST)
Date:   Wed, 5 Feb 2014 09:28:25 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <sparclinux@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <x86@kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-m68k@vger.kernel.org>,
        <akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <rusty@rustcorp.com.au>, <linux-arch@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205142824.GA23780@windriver.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
 <20140205060633.GE30094@gmail.com>
 <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
 <20140205064150.GA31568@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20140205064150.GA31568@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[Re: [GIT PULL] tree-wide: clean up no longer required #include <linux/init.h>] On 05/02/2014 (Wed 07:41) Ingo Molnar wrote:

> 
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Ingo,
> > 
> > On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
> > > 
> > > So, if you meant Linus to pull it, you probably want to cite a real 
> > > Git URI along the lines of:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> > 
> > Paul provided the proper git url further down in the mail along with the
> > usual pull request message (I guess he should have put that bit at the
> > top).
> 
> Yeah, indeed, and it even comes with a signed tag, which is an extra 
> nice touch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git tags/init-cleanup
> 
> (I guess the https was mentioned first to lower expectations.)

Just to clarify, the init.git was the repo of raw commits+series file
that was used for testing on linux next; now useless, except for showing
the last several weeks of history (hence the visual http link).  The
signed tag [separate repo] is the application of those commits against
the 3.14-rc1 tag, which was the end goal from the beginning.

Does history matter?  In the case of a cleanup like this, it does only
in the immediate context of this pull request; to help distinguish this
work from some short lived half baked idea that also had its testing
invalidated by arbitrarily rebasing onto the latest shiny tag.

I wouldn't have even mentioned the patch repo, except for the fact that
I know how Linus loves arbitrary rebases [and malformed pull requests]  :)

Thanks,
Paul.
--

> 
> Thanks,
> 
> 	Ingo
