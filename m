Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 23:11:47 +0100 (CET)
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:55050 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009717AbcADWLp2zO9b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 23:11:45 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D5506C212D;
        Mon,  4 Jan 2016 22:11:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drug38_488843a841b22
X-Filterd-Recvd-Size: 2591
Received: from joe-X200MA.home (pool-96-251-138-91.lsanca.fios.verizon.net [96.251.138.91])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Jan 2016 22:11:38 +0000 (UTC)
Message-ID: <1451945497.4334.107.camel@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
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
Date:   Mon, 04 Jan 2016 14:11:37 -0800
In-Reply-To: <20160104230528-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
         <1451907395-15978-4-git-send-email-mst@redhat.com>
         <1451926073.4334.90.camel@perches.com>
         <20160104230528-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50889
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

On Mon, 2016-01-04 at 23:07 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > > Add virt_ barriers to list of barriers to check for
> > > presence of a comment.
> > 
> > Are these virt_ barriers used anywhere?
> > 
> > I see some virtio_ barrier like uses.
> 
> They will be :) They are added and used by patchset
> 	        arch: barrier cleanup + barriers for virt
> 
> See
> http://article.gmane.org/gmane.linux.kernel.virtualization/26555

Ah, OK, thanks.

Are the virtio_ barriers going away?
If not, maybe those should be added too.
