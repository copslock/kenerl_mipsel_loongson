Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 16:22:46 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34405 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028421AbcEIOWpRyiSo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2016 16:22:45 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EB1B486A4;
        Mon,  9 May 2016 14:22:37 +0000 (UTC)
Received: from [10.36.112.65] (ovpn-112-65.ams2.redhat.com [10.36.112.65])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u49EMX6n020210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 9 May 2016 10:22:35 -0400
Subject: Re: [PATCH 1/7] MIPS: KVM/locore.S: Don't preserve host ASID around
 vcpu_run
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
 <1462541784-22128-2-git-send-email-james.hogan@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57309D29.6010903@redhat.com>
Date:   Mon, 9 May 2016 16:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1462541784-22128-2-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 09 May 2016 14:22:37 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53312
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



On 06/05/2016 15:36, James Hogan wrote:
> - It is actually redundant, since the host ASID will be restored
>   correctly by kvm_arch_vcpu_put(), which is called almost immediately
>   after kvm_arch_vcpu_ioctl_run() returns.

What happens if the guest does a rogue access to the area where the host
kernel resides?  Would that cause a wrong entry in the TLB?

Paolo
