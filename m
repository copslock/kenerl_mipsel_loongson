Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 22:45:22 +0100 (CET)
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:50181 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010866AbcAKVpSHrh8s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2016 22:45:18 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 075ACC2135;
        Mon, 11 Jan 2016 21:45:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clam27_674740afabd04
X-Filterd-Recvd-Size: 2036
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Jan 2016 21:45:09 +0000 (UTC)
Message-ID: <1452548708.7773.57.camel@perches.com>
Subject: Re: [PATCH v4 0/3] checkpatch: handling of memory barriers
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
        Julian Calaby <julian.calaby@gmail.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Date:   Mon, 11 Jan 2016 13:45:08 -0800
In-Reply-To: <1452509968-19778-1-git-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51064
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

On Mon, 2016-01-11 at 13:00 +0200, Michael S. Tsirkin wrote:
> As part of memory barrier cleanup, this patchset
> extends checkpatch to make it easier to stop
> incorrect memory barrier usage.

Thanks Michael.

Acked-by: Joe Perches <joe@perches.com>
