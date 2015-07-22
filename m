Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 03:25:23 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:60792 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011180AbbGVBZVXjBBR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jul 2015 03:25:21 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id EE9AE140310;
        Wed, 22 Jul 2015 11:25:16 +1000 (AEST)
Message-ID: <1437528316.16792.7.camel@ellerman.id.au>
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and
 munlockall system calls
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric B Munson <emunson@akamai.com>, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-am33-list@redhat.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 22 Jul 2015 11:25:16 +1000
In-Reply-To: <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
         <1437508781-28655-3-git-send-email-emunson@akamai.com>
         <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48376
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

On Tue, 2015-07-21 at 13:44 -0700, Andrew Morton wrote:
> On Tue, 21 Jul 2015 15:59:37 -0400 Eric B Munson <emunson@akamai.com> wrote:
> 
> > With the refactored mlock code, introduce new system calls for mlock,
> > munlock, and munlockall.  The new calls will allow the user to specify
> > what lock states are being added or cleared.  mlock2 and munlock2 are
> > trivial at the moment, but a follow on patch will add a new mlock state
> > making them useful.
> > 
> > munlock2 addresses a limitation of the current implementation.  If a
> > user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> > that MCL_FUTURE should be removed, they would have to call munlockall()
> > followed by mlockall(MCL_CURRENT) which could potentially be very
> > expensive.  The new munlockall2 system call allows a user to simply
> > clear the MCL_FUTURE flag.
> 
> This is hard.  Maybe we shouldn't have wired up anything other than
> x86.  That's what we usually do with new syscalls.

Yeah I think so.

You haven't wired it up properly on powerpc, but I haven't mentioned it because
I'd rather we did it.

cheers
