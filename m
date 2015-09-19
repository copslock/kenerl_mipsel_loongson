Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Sep 2015 22:16:32 +0200 (CEST)
Received: from one.firstfloor.org ([193.170.194.197]:40469 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007354AbbISUQ34JT5G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Sep 2015 22:16:29 +0200
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 3251686E3D; Sat, 19 Sep 2015 22:16:29 +0200 (CEST)
Date:   Sat, 19 Sep 2015 22:16:29 +0200
From:   Andi Kleen <andi@firstfloor.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 0/3] Add __ioread32_copy() and use it
Message-ID: <20150919201628.GI1747@two.firstfloor.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
 <20150916023219.GD1747@two.firstfloor.org>
 <20150915195031.0a1756a2.akpm@linux-foundation.org>
 <20150916025546.GE1747@two.firstfloor.org>
 <20150918121919.fa20552946703ae772d636e9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150918121919.fa20552946703ae772d636e9@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andi@firstfloor.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@firstfloor.org
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

On Fri, Sep 18, 2015 at 12:19:19PM -0700, Andrew Morton wrote:
> On Wed, 16 Sep 2015 04:55:46 +0200 Andi Kleen <andi@firstfloor.org> wrote:
> 
> > > Under what circumstances will the compiler (or linker?) do this? 
> > 
> > Compiler.
> > 
> > > LTO enabled?
> > 
> > Yes it's for LTO.  The optimization allows the compiler to drop unused
> > functions, which is very popular with users (a lot use it to get smaller
> > kernel images)
> > 
> 
> Does this look truthful and complete?
> 
> 
> --- a/include/linux/compiler-gcc.h~a
> +++ a/include/linux/compiler-gcc.h
> @@ -205,7 +205,10 @@
>  
>  #if GCC_VERSION >= 40600
>  /*
> - * Tell the optimizer that something else uses this function or variable.
> + * When used with Link Time Optimization, gcc can optimize away C functions or
> + * variables which are referenced only from assembly code.  __visible tells the
> + * optimizer that something else uses this function or variable, thus preventing
> + * this.

Yes,

In a few cases I also used it to work around LTO bugs in older gcc
releases. I don't think any of those fixes made it into mainline though,
and they are not needed anymore with 5.x

-Andi
