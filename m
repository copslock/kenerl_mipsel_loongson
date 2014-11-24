Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 14:31:39 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:39355 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006860AbaKXNbiME9lE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Nov 2014 14:31:38 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAODV6QH026747
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Nov 2014 08:31:08 -0500
Received: from warthog.procyon.org.uk ([10.3.112.3])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAODUxCt030761;
        Mon, 24 Nov 2014 08:31:00 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
References: <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-x86_64@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15470.1416835748.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Mon, 24 Nov 2014 13:30:58 +0000
Message-ID: <15567.1416835858@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44376
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

Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> +#define get_scalar_volatile_pointer(x) ({ \
> +	typeof(x) *__p = &(x); \
> +	volatile typeof(x) *__vp = __p; \
> +	(void)(long)*__p; __vp; })
> +#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))

Might this cause two loads from memory under some conditions?  Once for the
fourth line and once for the fifth?

(Apologies if this has already been discussed)

David
