Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 16:08:47 +0100 (CET)
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:60832 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008675AbcAJPIp0cdZy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2016 16:08:45 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E9E436B6D6;
        Sun, 10 Jan 2016 15:08:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet24_4bb96679f3906
X-Filterd-Recvd-Size: 3007
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Jan 2016 15:08:40 +0000 (UTC)
Message-ID: <1452438519.7773.23.camel@perches.com>
Subject: Re: [PATCH v2 2/3] checkpatch: check for __smp outside barrier.h
From:   Joe Perches <joe@perches.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Date:   Sun, 10 Jan 2016 07:08:39 -0800
In-Reply-To: <1452427000-4520-3-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
         <1452427000-4520-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Sun, 2016-01-10 at 13:57 +0200, Michael S. Tsirkin wrote:
> Introduction of __smp barriers cleans up a bunch of duplicate code, but
> it gives people an additional handle onto a "new" set of barriers - just
> because they're prefixed with __* unfortunately doesn't stop anyone from
> using it (as happened with other arch stuff before.)
> 
> Add a checkpatch test so it will trigger a warning.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5141,6 +5141,16 @@ sub process {
>  			}
>  		}
>  
> +		my $underscore_smp_barriers = qr{__smp_($smp_barriers)}x;

another unnecessary capture group

> +
> +		if ($realfile !~ m@^include/asm-generic/@ &&
> +		    $realfile !~ m@/barrier\.h$@ &&
> +		    $line =~ m/\b($underscore_smp_barriers)\s*\(/ &&
> +		    $line !~ m/^.\s*\#\s*define\s+($underscore_smp_barriers)\s*\(/) {
> +			WARN("MEMORY_BARRIER",
> +			     "__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
> +		}
> +
>  # check for waitqueue_active without a comment.
>  		if ($line =~ /\bwaitqueue_active\s*\(/) {
>  			if (!ctx_has_comment($first_line, $linenr)) {
