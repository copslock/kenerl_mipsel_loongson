Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 16:37:09 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993945AbdAMPhC63Spi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jan 2017 16:37:02 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DBC48F27A;
        Fri, 13 Jan 2017 15:36:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-28.rdu2.redhat.com [10.10.116.28])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0DFailJ024694;
        Fri, 13 Jan 2017 10:36:45 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com> <3131144.4Ej3KFWRbz@wuerfel> <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     dhowells@redhat.com, arnd@arndb.de, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, coreteam@netfilter.org,
        fcoe-devel@open-fcoe.org, xen-devel@lists.xenproject.org,
        linux-snps-arc@lists.infradead.org, linux-media@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, openrisc@lists.librecores.org,
        linux-fbdev@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nio2-dev@lists.rocketboards.org,
        linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25062.1484321803.1@warthog.procyon.org.uk>
Date:   Fri, 13 Jan 2017 15:36:43 +0000
Message-ID: <25063.1484321803@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 13 Jan 2017 15:36:53 +0000 (UTC)
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56303
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
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

Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> This header file is exported, thus move it to uapi.

Exported how?

> +#ifdef __INT32_TYPE__
> +#undef __INT32_TYPE__
> +#define __INT32_TYPE__		int
> +#endif
> +
> +#ifdef __UINT32_TYPE__
> +#undef __UINT32_TYPE__
> +#define __UINT32_TYPE__	unsigned int
> +#endif
> +
> +#ifdef __UINTPTR_TYPE__
> +#undef __UINTPTR_TYPE__
> +#define __UINTPTR_TYPE__	unsigned long
> +#endif

These weren't defined by the kernel before, so why do we need to define them
now?

Will defining __UINTPTR_TYPE__ cause problems in compiling libboost by
changing the signature on C++ functions that use uintptr_t?

David
