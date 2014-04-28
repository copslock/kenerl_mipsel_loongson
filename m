Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2014 14:37:49 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:21011 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816002AbaD1Mhq4VeRo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Apr 2014 14:37:46 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3SC1Pba017531
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Apr 2014 08:01:29 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3SC1K4i023988;
        Mon, 28 Apr 2014 08:01:21 -0400
Message-ID: <535E4310.10308@redhat.com>
Date:   Mon, 28 Apr 2014 14:01:20 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39963
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

Il 25/04/2014 17:19, James Hogan ha scritto:
> Expose the KVM guest CP0_Count bias (from the monotonic kernel time) to
> userland in nanosecond units via a new KVM_REG_MIPS_COUNT_BIAS register
> accessible with the KVM_{GET,SET}_ONE_REG ioctls. This gives userland
> control of the bias so that it can exactly match its own monotonic time.
>
> The nanosecond bias is stored separately from the raw bias used
> internally (since nanoseconds isn't a convenient or efficient unit for
> various timer calculations), and is recalculated each time the raw count
> bias is altered. The raw count bias used in CP0_Count determination is
> recalculated when the nanosecond bias is altered via the KVM_SET_ONE_REG
> ioctl.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney <david.daney@cavium.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>

If it is possible and not too hairy to use a raw value in userspace 
(together with KVM_REG_MIPS_COUNT_HZ), please do it---my suggestions 
were just that, a suggestion.  Otherwise, the patch looks good.

Paolo
