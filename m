Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2015 03:28:13 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:60180 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011600AbbG3B2L4m0DD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jul 2015 03:28:11 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 84F4F14090B;
        Thu, 30 Jul 2015 11:28:07 +1000 (AEST)
Message-ID: <1438219687.2374.1.camel@ellerman.id.au>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     dh.herrmann@googlemail.com, gregkh@linuxfoundation.org,
        daniel@zonque.org, tixxdz@opendz.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Date:   Thu, 30 Jul 2015 11:28:07 +1000
In-Reply-To: <20150729161912.GF18685@windriver.com>
References: <20150729161912.GF18685@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Wed, 2015-07-29 at 12:19 -0400, Paul Gortmaker wrote:
> Hi David,
> 
> Does it make sense to build this sample when cross compiling?
> 
> The reason I ask is that it has been breaking the linux-next build of
> allmodconfig for a while now, with:
> 
>   HOSTCC  samples/kdbus/kdbus-workers
> samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
> samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
>   p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
>                   ^
> samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
> scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
> make[2]: *** [samples/kdbus/kdbus-workers] Error 1
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/12473453/
> 
> We recently made some changes to skip other sample/test programs when
> cross compiling in mainline 65f6f092a6987 and f59514b6a8c5ca6dd and
> 6a407a81a9abcf.  Maybe it makes sense to do the same here?

Hi Paul,

We also can configure kisskb to not build samples for all_modconfig, which
avoids these sort of issues with a slight decrease in code coverage. We already
disable samples for several other arch all_modconfigs.

cheers
