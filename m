Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 11:15:05 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:56845 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008374AbcAHKPD42dxC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Jan 2016 11:15:03 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id 2448BA8C;
        Fri,  8 Jan 2016 10:14:59 +0000 (UTC)
Received: from redhat.com (vpn1-6-168.ams2.redhat.com [10.36.6.168])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u08AEmhE027048;
        Fri, 8 Jan 2016 05:14:49 -0500
Date:   Fri, 8 Jan 2016 12:14:48 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joe Perches <joe@perches.com>
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
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
Message-ID: <20160108121352-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-4-git-send-email-mst@redhat.com>
 <1451926073.4334.90.camel@perches.com>
 <20160104230528-mutt-send-email-mst@redhat.com>
 <1451945497.4334.107.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1451945497.4334.107.camel@perches.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50984
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

On Mon, Jan 04, 2016 at 02:11:37PM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 23:07 +0200, Michael S. Tsirkin wrote:
> > On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> > > On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > > > Add virt_ barriers to list of barriers to check for
> > > > presence of a comment.
> > > 
> > > Are these virt_ barriers used anywhere?
> > > 
> > > I see some virtio_ barrier like uses.
> > 
> > They will be :) They are added and used by patchset
> > 	        arch: barrier cleanup + barriers for virt
> > 
> > See
> > http://article.gmane.org/gmane.linux.kernel.virtualization/26555
> 
> Ah, OK, thanks.
> 
> Are the virtio_ barriers going away?
> If not, maybe those should be added too.

I don't mind. I'll queue a patch like that.


-- 
MST
