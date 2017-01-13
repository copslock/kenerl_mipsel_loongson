Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 16:44:10 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:55102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993940AbdAMPoDsjzci (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jan 2017 16:44:03 +0100
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20D9E6A6D3;
        Fri, 13 Jan 2017 15:43:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-28.rdu2.redhat.com [10.10.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8CD162012;
        Fri, 13 Jan 2017 15:43:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
References: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com> <3131144.4Ej3KFWRbz@wuerfel> <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     dhowells@redhat.com, arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux@armlinux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25482.1484322229.1@warthog.procyon.org.uk>
Date:   Fri, 13 Jan 2017 15:43:49 +0000
Message-ID: <25483.1484322229@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.74 on 10.5.11.28
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 13 Jan 2017 15:43:58 +0000 (UTC)
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56304
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

> -header-y += msr-index.h

I see it on my desktop as /usr/include/asm/msr-index.h and it's been there at
least four years - and as such it's part of the UAPI.  I don't think you can
remove it unless you can guarantee there are no userspace users.

David
