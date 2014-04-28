Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2014 17:43:08 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:33125 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822188AbaD1PnGAy1Mi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Apr 2014 17:43:06 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3SFgrP3028236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 28 Apr 2014 11:42:53 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s3SFgng1013851;
        Mon, 28 Apr 2014 11:42:50 -0400
Message-ID: <535E76F9.7050001@redhat.com>
Date:   Mon, 28 Apr 2014 17:42:49 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>  <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>     <535E4310.10308@redhat.com> <CAAG0J981KYb6vqC7FZ1=cJykj3Pmk02FwPGQvVFuZaowHzAMFg@mail.gmail.com>
In-Reply-To: <CAAG0J981KYb6vqC7FZ1=cJykj3Pmk02FwPGQvVFuZaowHzAMFg@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39965
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

Il 28/04/2014 17:17, James Hogan ha scritto:
>> > If it is possible and not too hairy to use a raw value in userspace
>> > (together with KVM_REG_MIPS_COUNT_HZ), please do it---my suggestions were
>> > just that, a suggestion.  Otherwise, the patch looks good.
> Do you mean expose the raw internal offset to userland instead of the
> nanosecond one? Yeh it should be possible & slightly simpler for both
> kernel and Qemu actually.

Yes, when I reviewed the QEMU patches I missed this consequence of 
exposing the HZ.

> Qemu could then store that value (or the Count register) straight into
> env->CP0_Count (depending on Cause.DC), then hw/mips/cputimer.c would
> pretty much continue to work accurately. cputimer.c is only really
> made use of by tcg at the moment though (reading/writing
> count/compare/cause.DC), but it still makes sense to be consistent.

Yup.  cputimer.c would just use a HZ value stored in CPUMIPSState 
(TIMER_FREQ for TCG) instead of hardcoding TIMER_FREQ I guess.

Paolo
