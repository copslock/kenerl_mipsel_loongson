Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:55:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18747 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817913AbaE2KzsH7ghQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 12:55:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 03AED35D39438;
        Thu, 29 May 2014 11:55:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 11:55:41 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 29 May
 2014 11:55:40 +0100
Message-ID: <5387122C.2080203@imgtec.com>
Date:   Thu, 29 May 2014 11:55:40 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 11/23] MIPS: KVM: Fix timer race modifying guest CP0_Cause
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <1401355005-20370-12-git-send-email-james.hogan@imgtec.com> <53870D99.3030900@redhat.com>
In-Reply-To: <53870D99.3030900@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Paolo,

On 29/05/14 11:36, Paolo Bonzini wrote:
> Il 29/05/2014 11:16, James Hogan ha scritto:
>> Currently this is the only asynchronous modification of guest registers,
>> therefore it is fixed by adjusting the implementations of the
>> kvm_set_c0_guest_cause(), kvm_clear_c0_guest_cause(), and
>> kvm_change_c0_guest_cause() macros which are used for modifying the
>> guest CP0_Cause register to use ll/sc to ensure atomic modification.
> 
> Shouldn't you have a loop too around the ll/sc?

Yes, it has a do {} while () look around the inline asm, although I
didn't mention it in the commit message. It's modelled on
arch/mips/include/asm/bitops.h.

Cheers
James
