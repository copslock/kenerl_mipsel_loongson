Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 22:27:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52480 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491158Ab1G0U1q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 22:27:46 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6RKRYVa013231;
        Wed, 27 Jul 2011 21:27:34 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6RKRXDe013228;
        Wed, 27 Jul 2011 21:27:33 +0100
Date:   Wed, 27 Jul 2011 21:27:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ganesan Ramalingam <ganesan18@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org
Subject: Re: Compilation error on linux-mips git
Message-ID: <20110727202733.GA10842@linux-mips.org>
References: <CAJ4A=e4dvK3RVCdha8f_Vs6kbc1cmfzwdAPtUe3+3AUuVddgRA@mail.gmail.com>
 <20110727134737.GA8930@linux-mips.org>
 <CAJ4A=e5bvq-RQ__ktbJ2u0eYJkeNNJOcS9nfBOdEJZrwasty_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4A=e5bvq-RQ__ktbJ2u0eYJkeNNJOcS9nfBOdEJZrwasty_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20121

On Wed, Jul 27, 2011 at 07:40:02PM +0530, Ganesan Ramalingam wrote:
> Date:   Wed, 27 Jul 2011 19:40:02 +0530
> From: Ganesan Ramalingam <ganesan18@gmail.com>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
> Subject: Re: Compilation error on linux-mips git
> Content-Type: multipart/alternative; boundary=0023545bcf24e7046c04a90d9b5b
> 
> Got the error with below version of compiler:
> 
> Target: mips64-unknown-linux-gnu
> Configured with: ../gcc-4.2.2/configure
> --prefix=/home/rpmbuilder/CROSS_TOOLCHAIN
> --with-local-prefix=/home/rpmbuilder/CROSS_TOOLCHAIN/mips64-unknown-linux-gnu
> --target=mips64-unknown-linux-gnu --host=x86-cross-linux-gnu --disable-nls
> --enable-shared --enable-languages=c,c++ --enable-__cxa_atexit --enable-c99
> --enable-long-long --enable-threads=posix --with-arch=xlr --with-float=soft
> --with-tune=xlr
> --with-sysroot=/home/rpmbuilder/CROSS_TOOLCHAIN/mips64-unknown-linux-gnu
> --with-headers=/home/rpmbuilder/CROSS_TOOLCHAIN/mips64-unknown-linux-gnu/usr/include
> Thread model: posix
> gcc version 4.2.2

And the warning is correct; I don't know why later compilers don't spot it.
It's not like the code has any complex control flow.

  Ralf
