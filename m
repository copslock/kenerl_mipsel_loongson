Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 18:25:58 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:24357 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816207AbaE1QZzo42pQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 May 2014 18:25:55 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4SGOAJc008904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 28 May 2014 12:24:11 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s4SGO56L018244;
        Wed, 28 May 2014 12:24:06 -0400
Message-ID: <53860DA4.9020703@redhat.com>
Date:   Wed, 28 May 2014 18:24:04 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, Gleb Natapov <gleb@kernel.org>,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-15-git-send-email-james.hogan@imgtec.com> <535A9AF5.30105@gmail.com> <2197488.6tnytXFBJm@radagast> <535B7E58.4070304@redhat.com> <5385F0E4.1080207@imgtec.com>
In-Reply-To: <5385F0E4.1080207@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 28/05/2014 16:21, James Hogan ha scritto:
> The implementation in QEMU that I've settled upon makes do with just
> COUNT_CTL and COUNT_RESUME, but with a slight kernel modification so
> that COUNT_RESUME is writeable (to any positive monotonic nanosecond
> value <= now). It works fairly cleanly and correctly even with stopping
> and starting VM clock (gdb, stop/cont, savevm/loadvm, live migration),
> to match the behaviour of the existing mips cpu timer emulation, so I
> plan to drop this bias patch, and will post a v2 patchset soon with just
> a few modifications.

It makes sense to have writable registers in the emulator, even if they 
are read-only in real hardware.  We also do that for x86, FWIW.

So the idea looks okay to me.

Paolo
