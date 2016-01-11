Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 11:36:07 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:55292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008101AbcAKKgE5toVe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2016 11:36:04 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id D69728E757;
        Mon, 11 Jan 2016 10:35:59 +0000 (UTC)
Received: from redhat.com (vpn1-6-10.ams2.redhat.com [10.36.6.10])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0BAZlmB009876;
        Mon, 11 Jan 2016 05:35:48 -0500
Date:   Mon, 11 Jan 2016 12:35:47 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
Message-ID: <20160111123423-mutt-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com>
 <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
 <1452466336.7773.46.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452466336.7773.46.camel@perches.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51051
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

On Sun, Jan 10, 2016 at 02:52:16PM -0800, Joe Perches wrote:
> On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
> > On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > Add virt_ barriers to list of barriers to check for
> > > presence of a comment.
> []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > > @@ -5133,7 +5133,8 @@ sub process {
> > > ����������������}x;
> > > ����������������my $all_barriers = qr{
> > > ������������������������$barriers|
> > > -�����������������������smp_(?:$smp_barrier_stems)
> > > +�����������������������smp_(?:$smp_barrier_stems)|
> > > +�����������������������virt_(?:$smp_barrier_stems)
> > 
> > Sorry I'm late to the party here, but would it make sense to write this as:
> > 
> > (?:smp|virt)_(?:$smp_barrier_stems)
> 
> Yes.  Perhaps the name might be better as barrier_stems.
> 
> Also, ideally this would be longest match first or use \b
> after the matches so that $all_barriers could work
> successfully without a following \s*\(
> 
> my $all_barriers = qr{
> 	(?:smp|virt)_(?:barrier_stems)|
> 	$barriers)
> }x;
> 
> or maybe add separate $smp_barriers and $virt_barriers
> 
> <shrug>  it doesn't matter much in any case

OK just to clarify - are you OK with merging the patch as is?
Refactorings can come as patches on top if required.

-- 
MST
