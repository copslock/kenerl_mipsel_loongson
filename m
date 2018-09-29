Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2018 20:17:37 +0200 (CEST)
Received: from ec2-34-208-57-251.us-west-2.compute.amazonaws.com ([34.208.57.251]:59828
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990697AbeI2SReCtHvE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Sep 2018 20:17:34 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 0C39F40120; Sat, 29 Sep 2018 11:17:26 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:17:26 -0700
From:   dwalker@fifo99.com
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] add generic builtin command line
Message-ID: <20180929181725.GB27441@fifo99.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@fifo99.com
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

On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> Daniel Walker (7):
>   add generic builtin command line
>   drivers: of: ifdef out cmdline section
>   x86: convert to generic builtin command line
>   arm: convert to generic builtin command line
>   arm64: convert to generic builtin command line
>   mips: convert to generic builtin command line
>   powerpc: convert to generic builtin command line
> 

When I originally submitted these I had a very good conversion with Rob Herring
on the device tree changes. It seemed fairly clear that my approach in these
changes could be done better. It effected specifically arm64, but a lot of other
platforms use the device tree integrally. With arm64 you can reduce the changes
down to only Kconfig changes, and that would likely be the case for many of the
other architecture. I made patches to do this a while back, but have not had
time to test them and push them out.

In terms of mips I think there's a fair amount of work needed to pull out their
architecture specific mangling into something generic. Part of my motivation for
these was to take the architecture specific feature and open that up for all the
architecture. So it makes sense that the mips changes should become part of
that.

The only changes which have no comments are the generic changes, x86, and
powerpc. Those patches have been used at Cisco for years with no issues.
I added those changes into my -next tree for a round of testing. Assuming there
are no issues I can work out the merging with the architecture maintainers.
As for the other changes I think they can be done in time, as long as the
generic parts of upstream the rest can be worked on by any of the architecture
developers.

Daniel
