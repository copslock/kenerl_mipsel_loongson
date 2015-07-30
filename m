Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 01:55:18 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:51963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011687AbbG3XzQXGn-r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Jul 2015 01:55:16 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id BE5F01402D5;
        Fri, 31 Jul 2015 09:55:11 +1000 (AEST)
Date:   Fri, 31 Jul 2015 09:55:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     David Herrmann <dh.herrmann@gmail.com>,
        David Herrmann <dh.herrmann@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>,
        <linux-mips@linux-mips.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
Message-ID: <20150731095511.1a6f1257@canb.auug.org.au>
In-Reply-To: <55BA4375.7010400@windriver.com>
References: <20150729161912.GF18685@windriver.com>
        <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>
        <55BA2B91.5070107@windriver.com>
        <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
        <55BA4375.7010400@windriver.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.28; i586-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

Hi Paul,

On Thu, 30 Jul 2015 11:32:05 -0400 Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>
> Well, it only shows up when we cross compile for mips.  It does not
> seem to be showing up for any other arch (and we cover ~10 of them).
> Nor does it show up for x86 builds.  Also note that the main linux-next
> build machine is actually a PowerPC host.

Actually I do my linux-next builds on an x86_64 host, and the overnight
builds are spread between that and a PowerPC host.

> > Please note that this is HOSTCC running, so it does *NOT* require the
> > toolchain for your cross-compiled architecture.
> > 
> > Also, please tell me why your system has "linux/memfd.h" available,
> > but __NR_memfd_create is undefined?
> 
> My local system is a bog standard ubuntu 14.10 and it sees it.  I dont
> know what distro the linux-next IBM powerpc builder is based on but it
> also sees it....

Our build hosts are running Debian stable and Ubuntu <mumble> (I think -
I will check on this latter).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
