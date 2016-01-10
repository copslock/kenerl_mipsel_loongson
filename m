Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 16:07:13 +0100 (CET)
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:47332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010522AbcAJPHLoz2py (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2016 16:07:11 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0649012BD0F;
        Sun, 10 Jan 2016 15:07:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hen21_3e15d44460310
X-Filterd-Recvd-Size: 3376
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Jan 2016 15:07:06 +0000 (UTC)
Message-ID: <1452438425.7773.21.camel@perches.com>
Subject: Re: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
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
Date:   Sun, 10 Jan 2016 07:07:05 -0800
In-Reply-To: <1452427000-4520-2-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
         <1452427000-4520-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51039
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

On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> SMP-only barriers were missing in checkpatch.pl
> 
> Refactor code slightly to make adding more variants easier.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5116,7 +5116,25 @@ sub process {
>  			}
>  		}
>  # check for memory barriers without a comment.
> -		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
> +
> +		my $barriers = qr{
> +			mb|
> +			rmb|
> +			wmb|
> +			read_barrier_depends
> +		}x;
> +		my $smp_barriers = qr{
> +			store_release|
> +			load_acquire|
> +			store_mb|
> +			($barriers)
> +		}x;

If I use a variable called $smp_barriers, I'd expect
it to actually be the smp_barriers, not to have to
prefix it with smp_ before using it.

		my $smp_barriers = qr{
			smp_store_release|
			smp_load_acquire|
			smp_store_mb|
			smp_read_barrier_depends
		}x;

or

		my $smp_barriers = qr{
			smp_(?:store_release|load_acquire|store_mb|read_barrier_depends)
		}x;

 
> +		my $all_barriers = qr{
> +			$barriers|
> +			smp_($smp_barriers)
> +		}x;

And this shouldn't have a capture group.

		my $all_barriers = qr{
			$barriers|
			$smp_barriers
		}x;		
> +
> +		if ($line =~ /\b($all_barriers)\s*\(/) {

This doesn't need the capture group either (?:all_barriers)

>  			if (!ctx_has_comment($first_line, $linenr))
> {
>  				WARN("MEMORY_BARRIER",
>  				     "memory barrier without
> comment\n" . $herecurr);
