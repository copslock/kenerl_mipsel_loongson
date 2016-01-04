Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 23:16:01 +0100 (CET)
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:35698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009717AbcADWP5g6N8b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 23:15:57 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 09AF012BA12;
        Mon,  4 Jan 2016 22:15:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waste37_6d6db46fd4c41
X-Filterd-Recvd-Size: 3433
Received: from joe-X200MA.home (pool-96-251-138-91.lsanca.fios.verizon.net [96.251.138.91])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Jan 2016 22:15:51 +0000 (UTC)
Message-ID: <1451945750.4334.111.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
From:   Joe Perches <joe@perches.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Andrey Konovalov <andreyknvl@google.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Date:   Mon, 04 Jan 2016 14:15:50 -0800
In-Reply-To: <20160104224415-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
         <1451907395-15978-2-git-send-email-mst@redhat.com>
         <1451923660.4334.83.camel@perches.com>
         <20160104224415-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50890
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

On Mon, 2016-01-04 at 22:45 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > SMP-only barriers were missing in checkpatch.pl
> > > 
> > > Refactor code slightly to make adding more variants easier.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  scripts/checkpatch.pl | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 2b3c228..0245bbe 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -5116,7 +5116,14 @@ sub process {
> > >  			}
> > >  		}
> > >  # check for memory barriers without a comment.
> > > -		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
> > > +
> > > +		my @barriers = ('mb', 'rmb', 'wmb', 'read_barrier_depends');
> > > +		my @smp_barriers = ('smp_store_release', 'smp_load_acquire', 'smp_store_mb');
> > > +
> > > +		@smp_barriers = (@smp_barriers, map {"smp_" . $_} @barriers);
> > 
> > I think using map, which so far checkpatch doesn't use,
> > makes smp_barriers harder to understand and it'd be
> > better to enumerate them.
> 
> Okay - I'll rewrite using foreach.
> 

I think using the qr form (like 'our $Attribute' and
a bunch of others) is the general style that should
be used for checkpatch.
