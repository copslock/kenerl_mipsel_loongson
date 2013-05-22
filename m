Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 19:55:46 +0200 (CEST)
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:38208
        "EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825735Ab3EVRzpPc7Sn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 19:55:45 +0200
Received: from mail131-db8-R.bigfish.com (10.174.8.232) by
 DB8EHSOBE002.bigfish.com (10.174.4.65) with Microsoft SMTP Server id
 14.1.225.23; Wed, 22 May 2013 17:55:38 +0000
Received: from mail131-db8 (localhost [127.0.0.1])      by
 mail131-db8-R.bigfish.com (Postfix) with ESMTP id 3E09E401B0;  Wed, 22 May
 2013 17:55:38 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.69;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0712HT004.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -1
X-BigFish: PS-1(z37d5kzbb2dI98dI9371I1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275bhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail131-db8 (localhost.localdomain [127.0.0.1]) by mail131-db8
 (MessageSwitch) id 1369245335947865_5827; Wed, 22 May 2013 17:55:35 +0000
 (UTC)
Received: from DB8EHSMHS026.bigfish.com (unknown [10.174.8.241])        by
 mail131-db8.bigfish.com (Postfix) with ESMTP id E45F24C00B3;   Wed, 22 May 2013
 17:55:35 +0000 (UTC)
Received: from BN1PRD0712HT004.namprd07.prod.outlook.com (132.245.2.69) by
 DB8EHSMHS026.bigfish.com (10.174.4.36) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 22 May 2013 17:55:36 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.196.37) with Microsoft SMTP Server (TLS) id 14.16.311.1; Wed, 22 May
 2013 17:55:24 +0000
Message-ID: <519D0688.40007@caviumnetworks.com>
Date:   Wed, 22 May 2013 10:55:20 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        Gleb Natapov <gleb@redhat.com>, <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 5/6] mips/kvm: Fix ABI by moving manipulation of CP0
 registers to KVM_{G,S}ET_ONE_REG
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com> <1369169695-10444-6-git-send-email-ddaney.cavm@gmail.com> <16CE6694-CEAE-48F1-9F8E-723A657CE470@kymasys.com>
In-Reply-To: <16CE6694-CEAE-48F1-9F8E-723A657CE470@kymasys.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 05/22/2013 10:44 AM, Sanjay Lal wrote:
>
> On May 21, 2013, at 1:54 PM, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> Because not all 256 CP0 registers are ever implemented, we need a
>> different method of manipulating them.  Use the
>> KVM_SET_ONE_REG/KVM_GET_ONE_REG mechanism.
>>
>> Code related to implementing KVM_SET_ONE_REG/KVM_GET_ONE_REG is
>> consolidated in to kvm_trap_emul.c, now unused code and definitions
>> are removed.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>> arch/mips/include/asm/kvm.h      |  91 +++++++++--
>> arch/mips/include/asm/kvm_host.h |   4 -
>> arch/mips/kvm/kvm_mips.c         |  90 +----------
>> arch/mips/kvm/kvm_trap_emul.c    | 338 ++++++++++++++++++++++++++++++++++-----
>> 4 files changed, 383 insertions(+), 140 deletions(-)
[...]
>>
>
> Most of the functions that have been relocated to kvm_trap_emul.c should stay in kvm_mips.c. They are/will shared between the trap and emulate and VZ modes.  They include kvm_mips_reset_vcpu(), kvm_vcpu_ioctl_interrupt(), kvm_arch_vcpu_ioctl().
>
> kvm_mips_get_reg() and kvm_mips_set_reg() should be in kvm_mips.c as they will be shared by the trap and emulate and VZ code.
>

OK, I will revise the patch set to rearrange things in a manner that 
leaves these in kvm_mips.c.  However, this is of secondary importance to 
the question of the suitability of the ABI.


> If you plan on defining specific versions of these functions for Cavium's implementation of KVM, please make them callbacks.
>

There will soon be follow on patches that do exactly that.
