Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 08:59:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34907 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009645AbbGWG64JZXUI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jul 2015 08:58:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6N6wmXA006020;
        Thu, 23 Jul 2015 08:58:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6N6wVcG006019;
        Thu, 23 Jul 2015 08:58:31 +0200
Date:   Thu, 23 Jul 2015 08:58:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
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
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150723065830.GA5919@linux-mips.org>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au>
 <20150722141501.GA3203@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150722141501.GA3203@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:

> > 
> > You haven't wired it up properly on powerpc, but I haven't mentioned it because
> > I'd rather we did it.
> > 
> > cheers
> 
> It looks like I will be spinning a V5, so I will drop all but the x86
> system calls additions in that version.

The MIPS bits are looking good however, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

With my ack, will you keep them or maybe carry them as a separate patch?

Cheers,

  Ralf
