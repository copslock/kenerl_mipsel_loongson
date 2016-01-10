Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 20:29:27 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:36173 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009342AbcAJT3ZDqNG7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 20:29:25 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id C2CD2C0032F8;
        Sun, 10 Jan 2016 19:29:17 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AJT7mb000806;
        Sun, 10 Jan 2016 14:29:08 -0500
Date:   Sun, 10 Jan 2016 21:29:06 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
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
Subject: Re: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <20160110212531-mutt-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
 <1452427000-4520-2-git-send-email-mst@redhat.com>
 <1452438425.7773.21.camel@perches.com>
 <1452439051.7773.27.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452439051.7773.27.camel@perches.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

On Sun, Jan 10, 2016 at 07:17:31AM -0800, Joe Perches wrote:
> On Sun, 2016-01-10 at 07:07 -0800, Joe Perches wrote:
> > On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> > > SMP-only barriers were missing in checkpatch.pl
> > > 
> > > Refactor code slightly to make adding more variants easier.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > If I use a variable called $smp_barriers, I'd expect
> > it to actually be the smp_barriers, not to have to
> > prefix it with smp_ before using it.
> > 
> > 		my $smp_barriers = qr{
> > 			smp_store_release|
> > 			smp_load_acquire|
> > 			smp_store_mb|
> > 			smp_read_barrier_depends
> 
> That's missing (?:barriers) too.

My version has it but need to add ?: to avoid
a capture group.

> btw: shouldn't this also have
> 	smp_mb__(?:before|after)_atomic
> ?

Good catch, included in the next version.

-- 
MST
