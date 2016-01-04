Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 17:15:24 +0100 (CET)
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:40187 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009659AbcADQPXRgbzV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 17:15:23 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2A7939ED8C;
        Mon,  4 Jan 2016 16:15:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snail54_10bdd62104508
X-Filterd-Recvd-Size: 2800
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Jan 2016 16:15:14 +0000 (UTC)
Message-ID: <1451924114.4334.85.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Cc : Andy Whitcroft" <apw@canonical.com>,
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
        Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 04 Jan 2016 08:15:14 -0800
In-Reply-To: <20160104161123.GJ19062@n2100.arm.linux.org.uk>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
         <1451907395-15978-2-git-send-email-mst@redhat.com>
         <1451923660.4334.83.camel@perches.com>
         <20160104161123.GJ19062@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50861
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

On Mon, 2016-01-04 at 16:11 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > +		my $all_barriers = join('|', (@barriers, @smp_barriers));
> > > +
> > > +		if ($line =~ /\b($all_barriers)\(/) {
> > 
> > It would be better to use /\b$all_barriers\s*\(/
> > as there's no reason for the capture and there
> > could be a space between the function and the
> > open parenthesis.
> 
> I think you mean
> 
> 	/\b(?:$all_barriers)\s*\(/
> 
> as 'all_barriers' will be:
> 
> 	mb|wmb|rmb|smp_mb|smp_wmb|smp_rmb
> 
> and putting that into your suggestion results in:
> 
> 	/\bmb|wmb|rmb|smp_mb|smp_wmb|smp_rmb\s*\(/
> 
> which is clearly wrong - the \b only applies to 'mb' and the \s*\( only
> applies to smp_rmb.

right, thanks.
