Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 23:29:29 +0200 (CEST)
Received: from asavdk3.altibox.net ([109.247.116.14]:37507 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816409AbaFQV31lkgHm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 23:29:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by asavdk3.altibox.net (Postfix) with ESMTP id A074F2003E;
        Tue, 17 Jun 2014 23:29:21 +0200 (CEST)
Received: from asavdk3.altibox.net ([127.0.0.1])
        by localhost (asavdk3.lysetele.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7p4-of_fFzYs; Tue, 17 Jun 2014 23:29:21 +0200 (CEST)
Received: from ravnborg.org (unknown [188.228.89.252])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 50D3A20032;
        Tue, 17 Jun 2014 23:29:19 +0200 (CEST)
Date:   Tue, 17 Jun 2014 23:29:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.16-rc1
Message-ID: <20140617212917.GA22353@ravnborg.org>
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40613
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
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add' [-Werror=implicit-function-declaration]:  => 176:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_negative' [-Werror=implicit-function-declaration]:  => 211:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_return' [-Werror=implicit-function-declaration]:  => 218:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]:  => 169:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_and_test' [-Werror=implicit-function-declaration]:  => 197:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_return' [-Werror=implicit-function-declaration]:  => 239:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]:  => 162:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_and_test' [-Werror=implicit-function-declaration]:  => 204:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_return' [-Werror=implicit-function-declaration]:  => 232:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_set' [-Werror=implicit-function-declaration]:  => 155:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub' [-Werror=implicit-function-declaration]:  => 183:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_and_test' [-Werror=implicit-function-declaration]:  => 190:2
> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_return' [-Werror=implicit-function-declaration]:  => 225:2
> >   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function '__atomic_add_unless' [-Werror=implicit-function-declaration]:  => 53:2
> >   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_cmpxchg' [-Werror=implicit-function-declaration]:  => 89:3
> >   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]:  => 136:2
> 
> sparc-allmodconfig
Not reproduceable here with linus latest. (-rc1 + two patches).
Can you help me with a pointer to the original build log?

	Sam
