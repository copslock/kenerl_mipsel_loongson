Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 00:12:54 +0100 (CET)
Received: from a.ns.miles-group.at ([95.130.255.143]:7604 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012538AbcAEXMwGH0A0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jan 2016 00:12:52 +0100
Received: (qmail 26674 invoked by uid 89); 5 Jan 2016 23:12:51 -0000
Received: by simscan 1.3.1 ppid: 26669, pid: 26672, t: 0.0485s
         scanners: attach: 1.3.1
Received: from unknown (HELO ?192.168.0.10?) (richard@nod.at@213.47.235.169)
  by radon.swed.at with ESMTPA; 5 Jan 2016 23:12:51 -0000
Subject: Re: [PATCH v2 12/32] x86/um: reuse asm-generic/barrier.h
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-13-git-send-email-mst@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        xen-devel@lists.xenproject.org, Jeff Dike <jdike@addtoit.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        user-mode-linux-user@lists.sourceforge.net
From:   Richard Weinberger <richard@nod.at>
Message-ID: <568C4DEA.5070601@nod.at>
Date:   Wed, 6 Jan 2016 00:12:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1451572003-2440-13-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Am 31.12.2015 um 20:07 schrieb Michael S. Tsirkin:
> On x86/um CONFIG_SMP is never defined.  As a result, several macros
> match the asm-generic variant exactly. Drop the local definitions and
> pull in asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
