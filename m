Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Feb 2014 05:20:39 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:65102 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825397AbaBSEUgfJk4D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Feb 2014 05:20:36 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s1J4KJUB006998
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Feb 2014 20:20:21 -0800 (PST)
Received: from yow-pgortmak-d1 (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.347.0; Tue, 18 Feb 2014
 20:20:19 -0800
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id 97A32E1D2ED; Tue,
 18 Feb 2014 23:21:09 -0500 (EST)
Date:   Tue, 18 Feb 2014 23:21:09 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH] samples/seccomp/Makefile: Do not build tests if
 cross-compiling for MIPS
Message-ID: <20140219042109.GE5799@windriver.com>
References: <1392312460-24902-1-git-send-email-markos.chandras@imgtec.com>
 <52FD0F46.6040503@gmail.com>
 <CAP=VYLr1D-DQz8U4naa5aEL_AFa_JkO5e+TgFSxpsd_2t3dahQ@mail.gmail.com>
 <53020D12.6060000@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53020D12.6060000@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39339
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

[Re: [PATCH] samples/seccomp/Makefile: Do not build tests if cross-compiling for MIPS] On 17/02/2014 (Mon 13:22) Markos Chandras wrote:

> On 02/14/2014 01:33 AM, Paul Gortmaker wrote:
> >On Thu, Feb 13, 2014 at 1:30 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> >>Really I think we should add a Kconfig item for this and disable the whole
> >>directory for targets that do not support it.
> >
> >Can we do something based on  CONFIG_CROSS_COMPILE vs. adding more Kconfig?
> >
> >Paul.
> >--
> 
> Hi Paul,
> 
> I am not sure how this would solve anything. CONFIG_CROSS_COMPILE
> could be empty, but you can still use 'make
> CROSS_COMPILE=mips-linux-foobar-' or whatever to cross-compile for
> MIPS. So using this symbol to disable tests does not seem right to
> me.
> 
> Another Kconfig symbol should be more appropriate but as far as I
> can see MIPS is the only architecture which has this problem (or I
> may have missed all{yes,mod}config failures from other
> architectures).
> 
> I still think that an "ifndef CONFIG_MIPS" is good enough for now
> until more architectures suffer from this problem in the future. So
> far (and looking at the git history of that file) other
> architectures managed to workaround this.

I don't have a specific preference to any one fix over another; I leave
that to the seccomp folks who review the fix.  But I would like to see
it dealt with ASAP.  The regression has been in linux-next for roughly a
week now, and doing that can mask us from seeing other build regressions
silently stacking up behind this one.  

Thanks,
Paul.
--

> 
> -- markos
> 
