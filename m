Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 18:17:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39884 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6855122AbaEVQRsW3gTm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2014 18:17:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CF615C7F98BA5;
        Thu, 22 May 2014 17:17:38 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 22 May
 2014 17:17:41 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 22 May 2014 17:17:41 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 22 May
 2014 17:17:40 +0100
Message-ID: <537E2290.900@imgtec.com>
Date:   Thu, 22 May 2014 17:15:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 07/15] MIPS: Add mips_cpunum() function.
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-8-git-send-email-andreas.herrmann@caviumnetworks.com> <537C89B5.2030907@imgtec.com> <20140522161342.GI11800@alberich>
In-Reply-To: <20140522161342.GI11800@alberich>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40247
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

On 22/05/14 17:13, Andreas Herrmann wrote:
> On Wed, May 21, 2014 at 12:10:45PM +0100, James Hogan wrote:
>> On 20/05/14 15:47, Andreas Herrmann wrote:
>>> +static inline unsigned int mips_cpunum(void)
>>> +{
>>> +	return read_c0_ebase() & 0x3ff; /* Low 10 bits of ebase. */
>>> +}
>>
>> If this is going to go in mips generic code I think it should be clearly
>> defined, especially in the presence of MT, otherwise perhaps it makes
>> sense for it to go in a paravirt specific header?
> 
> It's just wrapper to read ebase_cpunum. Currently only used in the
> paravirt-code (to get CPUnum for a guest CPU -- which eventually is
> read from guest cp0 context).
> 
> I am not sure whether it needs to be moved to a paravirt specific
> header.
> 
>> I.e. does it return the core number of the running VPE (if so it should
>> probably do something like below as in decode_configs() and go in
>> smp.h), or does it simply always return that field in ebase register (in
>> which case it should probably have ebase in the name and a comment to
>> clarify that it doesn't necessarily map directly to core/vpe number).
> 
> Under KVM (MIPSVZ) it effectively returns vcpu_id and thus such a
> comment could be added for clarification.
> 
> So, should we name it get_ebase_cpunum() but keep it in this header
> (and also replace the 1 or 2 occurrences of "read_c0_ebase() & 0x3ff"
> in the non-paravirt code with it)?

That sounds reasonable to me.

Cheers
James
