Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 15:53:41 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:58029 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992990AbcGENxeXsEQl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jul 2016 15:53:34 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD9B31665;
        Tue,  5 Jul 2016 13:53:27 +0000 (UTC)
Received: from [10.36.112.53] (ovpn-112-53.ams2.redhat.com [10.36.112.53])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u65DrO6J025658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 5 Jul 2016 09:53:25 -0400
Subject: Re: [PATCH 00/14] MIPS: KVM: Dynamically generate exception code
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
 <20160705134815.GK7075@linux-mips.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9a513b3-2458-f7f9-071a-60af77e6c449@redhat.com>
Date:   Tue, 5 Jul 2016 15:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160705134815.GK7075@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 05 Jul 2016 13:53:27 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54222
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



On 05/07/2016 15:48, Ralf Baechle wrote:
> On Thu, Jun 23, 2016 at 05:34:33PM +0100, James Hogan wrote:
> 
>> These patches change the MIPS KVM exception entry code to be dynamically
>> assembled by the MIPS "uasm" in-kernel assembler, directly into unmapped
>> memory at run time by a new entry.c. Previously this code was statically
>> assembled from locore.S at build time and later copied into unmapped
>> memory at run time.
>>
>> Patches 1-5 add support for the necessary instructions to uasm.
>>
>> Patches 6-8 do the minimal-change conversion of locore.S to entry.c
>> using uasm (I've used -M10% so the diff is shown as a file move).
>>
>> Patches 9-14 make some related improvements that are possible now that
>> it is dynamically generated, such as avoiding messy runtime conditionals
>> in assembly code, making use of KScratch registers when available, and
>> simplifying the initial GP register save sequence & jump to common code.
>>
>> Ralf: Since the uasm patches (1-5) are needed for the later patches, I
>> suggest these all go together via the KVM tree (on which the whole
>> patchset is based), so Acks are welcome if they're okay with you.
> 
> Yes, please, so for the MIPS bits, that is patche 01..05:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Good, I'll apply the whole bunch.

Paolo
