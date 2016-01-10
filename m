Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 23:52:24 +0100 (CET)
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:50098 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009255AbcAJWwXSvqsi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2016 23:52:23 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8569A268E12;
        Sun, 10 Jan 2016 22:52:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glove86_31188289a5937
X-Filterd-Recvd-Size: 3157
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Jan 2016 22:52:17 +0000 (UTC)
Message-ID: <1452466336.7773.46.camel@perches.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
From:   Joe Perches <joe@perches.com>
To:     Julian Calaby <julian.calaby@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Date:   Sun, 10 Jan 2016 14:52:16 -0800
In-Reply-To: <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
         <1452454200-8844-4-git-send-email-mst@redhat.com>
         <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51050
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

On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
> On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Add virt_ barriers to list of barriers to check for
> > presence of a comment.
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -5133,7 +5133,8 @@ sub process {
> > ����������������}x;
> > ����������������my $all_barriers = qr{
> > ������������������������$barriers|
> > -�����������������������smp_(?:$smp_barrier_stems)
> > +�����������������������smp_(?:$smp_barrier_stems)|
> > +�����������������������virt_(?:$smp_barrier_stems)
> 
> Sorry I'm late to the party here, but would it make sense to write this as:
> 
> (?:smp|virt)_(?:$smp_barrier_stems)

Yes.  Perhaps the name might be better as barrier_stems.

Also, ideally this would be longest match first or use \b
after the matches so that $all_barriers could work
successfully without a following \s*\(

my $all_barriers = qr{
	(?:smp|virt)_(?:barrier_stems)|
	$barriers)
}x;

or maybe add separate $smp_barriers and $virt_barriers

<shrug>  it doesn't matter much in any case
