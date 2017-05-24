Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 16:00:19 +0200 (CEST)
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:37043 "EHLO
        outpost5.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbdEXOAK4hudx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 16:00:10 +0200
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1dDWpd-002wvl-BE>; Wed, 24 May 2017 16:00:09 +0200
Received: from mx.physik.fu-berlin.de ([160.45.64.218])
          by relay1.zedat.fu-berlin.de (Exim 4.85)
          with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1dDWpd-000MZW-7R>; Wed, 24 May 2017 16:00:09 +0200
Received: from zlogin1.physik.fu-berlin.de ([160.45.66.10])
        by mx.physik.fu-berlin.de with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1dDWpK-0007BH-Hw; Wed, 24 May 2017 15:59:50 +0200
Received: from glaubitz by zlogin1.physik.fu-berlin.de with local (Exim 4.84_2 #2 (Debian))
        id 1dDWpK-000285-GU; Wed, 24 May 2017 15:59:50 +0200
Date:   Wed, 24 May 2017 15:59:50 +0200
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, monstr@monstr.eu,
        ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Unify the various copies of libgcc into lib
Message-ID: <20170524135950.GB4230@physik.fu-berlin.de>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <23396.1495633764@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23396.1495633764@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: 160.45.64.218
X-ZEDAT-Hint: R
Return-Path: <glaubitz@physik.fu-berlin.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glaubitz@physik.fu-berlin.de
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

On Wed, May 24, 2017 at 02:49:24PM +0100, David Howells wrote:
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
> 
> > ... Unfortunately I don't actually have all these cross compilers setup...
> 
> If you have Fedora, you have the following available as standard
> RPMs:

And if you need more than just the cross-compilers (e.g. libraries for
the target architecture), I recommend a Debian Stretch or newer.

Debian's Multi-Arch allows one to install libraries for the target
system onto your build system. I have used that extensively in the
past, for example to bootstrap GHC for various architectures [1].

Adrian

> [1] https://wiki.debian.org/PortsDocs/BootstrappingGHC

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
