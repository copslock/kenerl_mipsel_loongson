Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 22:44:20 +0200 (CEST)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:51378 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837163AbaEUUoSJEC7a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 22:44:18 +0200
Received: from cpsps-ews28.kpnxchange.com ([10.94.84.194]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 21 May 2014 22:44:12 +0200
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews28.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 21 May 2014 22:44:12 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 21 May 2014 22:44:11 +0200
Message-ID: <1400705051.30334.28.camel@x220>
Subject: Re: [PATCH] MIPS: cavium-octeon: remove checks for CONFIG_CAVIUM_GDB
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 May 2014 22:44:11 +0200
In-Reply-To: <20140521202735.GC23153@alberich>
References: <1400602574.4912.43.camel@x220>
         <20140521202735.GC23153@alberich>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2014 20:44:11.0390 (UTC) FILETIME=[6B79E1E0:01CF7535]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Wed, 2014-05-21 at 22:27 +0200, Andreas Herrmann wrote:
> On Tue, May 20, 2014 at 06:16:14PM +0200, Paul Bolle wrote:
> > Three checks for CONFIG_CAVIUM_GDB were added in v2.6.29. But the
> > Kconfig symbol CAVIUM_GDB was never added to the tree. Remove these
> > checks.
> > 
> > Also remove the last reference to octeon_get_boot_debug_flag(). There is
> > no definition of that function anyway.
> 
> Hmm, yes, this was added with commit
> 5b3b16880f404ca54126210ca86141cceeafc0cf (MIPS: Add Cavium OCTEON
> processor support files to arch/mips/cavium-octeon.) and incomplete
> ever since (in mainline kernel).

I've decided not to mention the exact commits, and only mention
releases, if problems are rather old. Ie, v2.6.29 should mean, to most
observers, "a long time ago".
 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested.
> 
> Removing this dead code shouldn't harm. I also did a quick test of a
> kernel with your patch with an octeon system -- as expected no issues
> observed. (So it's
> Tested-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>)

That's great, thanks!

> > A follow up might be to remove plat_smp_ops.cpus_done. All these
> > callbacks are now (basically) nops.
> 
> I am not sure about completely removing cpus_done from
> plat_smp_ops. Maybe some platform will really make use of this in the
> future.

My view is that cpus_done should just be re-added if that happens.


Paul Bolle
