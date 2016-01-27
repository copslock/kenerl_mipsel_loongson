Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 15:57:32 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:36679 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011114AbcA0O5X6fOJm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 15:57:23 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id C2A37C06C9FC;
        Wed, 27 Jan 2016 14:57:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-46.phx2.redhat.com [10.3.113.46])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0REv8IX013219;
        Wed, 27 Jan 2016 09:57:08 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20160127083546.GJ6357@twins.programming.kicks-ass.net>
References: <20160127083546.GJ6357@twins.programming.kicks-ass.net> <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com> <56980145.5030901@imgtec.com> <20160114204827.GE3818@linux.vnet.ibm.com> <56981212.7050301@imgtec.com> <20160114222046.GH3818@linux.vnet.ibm.com> <20160126102402.GE6357@twins.programming.kicks-ass.net> <20160126103200.GI6375@twins.programming.kicks-ass.net> <20160126110053.GA21553@arm.com> <20160126201143.GV4503@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] documentation: Add disclaimer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15881.1453906627.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 27 Jan 2016 14:57:07 +0000
Message-ID: <15882.1453906627@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51480
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

Peter Zijlstra <peterz@infradead.org> wrote:

> +==========
> +DISCLAIMER
> +==========
> +
> +This document is not a specification; it is intentionally (for the sake of
> +brevity) and unintentionally (due to being human) incomplete. This document is
> +meant as a guide to using the various memory barriers provided by Linux, but
> +in case of any doubt (and there are many) please ask.
> +
> +I repeat, this document is not a specification of what Linux expects from
> +hardware.

The purpose of this document is twofold:

 (1) to specify the minimum functionality that one can rely on for any
     particular barrier, and

 (2) to provide a guide as to how to use the barriers that are available.

Note that an architecture can provide more than the minimum requirement for
any particular barrier, but if the barrier provides less than that, it is
incorrect.

Note also that it is possible that a barrier may be a no-op for an
architecture because the way that arch works renders an explicit barrier
unnecessary in that case.

> +

Can you bung an extra blank line in here if you have to redo this at all?

> +========
> +CONTENTS
> +========
>  
>   (*) Abstract memory access model.
>  

David
