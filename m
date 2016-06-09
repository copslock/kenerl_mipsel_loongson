Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:59:18 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:50433 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041104AbcFIN7KtV61L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2016 15:59:10 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97633155DE;
        Thu,  9 Jun 2016 13:59:03 +0000 (UTC)
Received: from [10.36.112.33] (ovpn-112-33.ams2.redhat.com [10.36.112.33])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u59Dwv4E031812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 9 Jun 2016 09:59:01 -0400
Subject: Re: [PATCH 00/18] MIPS: KVM: Miscellaneous clean-ups
To:     James Hogan <james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5acf206e-8a07-0566-bab3-fde4ce7fb4b8@redhat.com>
Date:   Thu, 9 Jun 2016 15:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 09 Jun 2016 13:59:03 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53933
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



On 09/06/2016 15:19, James Hogan wrote:
> This patchset does a whole load of miscellaneous and usually quite self
> contained cleanups in the MIPS KVM code, although a few of the patches
> (patches 4-7) are a bit more invasive.
> 
> It is based on my "[PATCH 0/4] MIPS: KVM: Module + non dynamic
> translating fixes" patchset from earlier today.
> 
> Patches 1-3, 10   drop dead or pointless code.
> Patches 4-6       make changes to types (getting rid of uint32_t style
>                   types and changing Cause register to u32).
> Patches 7-8       separate non TLB handling code out of tlb.c into mmu.c,
>                   which is built into the KVM module.
> Patches 9, 12-16  make cleanups to host and guest TLB management code.
> 
> The remaining patches (11, 17-18) make other misc cleanups.

Thanks, will queue to kvm/next.

Paolo
