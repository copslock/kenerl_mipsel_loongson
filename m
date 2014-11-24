Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:05:15 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:60980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009790AbaKXUFOiQFx7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:05:14 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAOK51Z7017425
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Nov 2014 15:05:01 -0500
Received: from warthog.procyon.org.uk ([10.3.112.3])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAOK4sGX009620;
        Mon, 24 Nov 2014 15:04:55 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <547381D7.2070404@de.ibm.com>
References: <547381D7.2070404@de.ibm.com> <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <15567.1416835858@warthog.procyon.org.uk> <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com> <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12208.1416859494.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 24 Nov 2014 20:04:54 +0000
Message-ID: <12209.1416859494@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44399
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

> Looks really nice, but does not work with ACCESS_ONCE is on the left-hand side:
> 
> 
> include/linux/rculist.h: In function 'hlist_add_before_rcu':
> ./arch/x86/include/asm/barrier.h:127:18: error: lvalue required as left operand of assignment
>   ACCESS_ONCE(*p) = (v);      \
> 
> Alexei's variant is also broken:
> 
> include/linux/cgroup.h: In function 'task_css':
> include/linux/compiler.h:381:40: error: invalid operands to binary + (have 'struct css_set *' and 'struct css_set * volatile')
>  #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))
> 
> Anyone with a new propopal? ;-)                                        ^

Reserve ACCESS_ONCE() for reading and add an ASSIGN_ONCE() or something like
that for writing?

David
