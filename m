Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2010 19:51:07 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:32325 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491107Ab0JDRvC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Oct 2010 19:51:02 +0200
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o94Hovk5012595
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 4 Oct 2010 13:50:57 -0400
Received: from redhat.com (dhcp-100-19-194.bos.redhat.com [10.16.19.194])
        by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o94HovYO032251;
        Mon, 4 Oct 2010 13:50:57 -0400
Date:   Mon, 4 Oct 2010 13:50:39 -0400
From:   Jason Baron <jbaron@redhat.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Rabin Vincent <rabin@rab.in>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH] jump label: Add MIPS support.
Message-ID: <20101004175039.GC2900@redhat.com>
References: <1285697432-29244-1-git-send-email-ddaney@caviumnetworks.com> <AANLkTimEJQE3i9Wa1X=Rkw1goJA9c5Sso-iWV=hLG6KF@mail.gmail.com> <4CAA122B.40502@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CAA122B.40502@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Return-Path: <jbaron@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 04, 2010 at 10:43:07AM -0700, David Daney wrote:
> On 10/03/2010 11:15 AM, Rabin Vincent wrote:
>> On Tue, Sep 28, 2010 at 11:40 PM, David Daney<ddaney@caviumnetworks.com>  wrote:
>>> +void arch_jump_label_text_poke_early(jump_label_t addr)
>>> +{
>>> +       union mips_instruction *insn_p =
>>> +               (union mips_instruction *)(unsigned long)addr;
>>> +
>>> +       insn_p->word = 0; /* nop */
>>> +       flush_icache_range((unsigned long)insn_p,
>>> +                          (unsigned long)insn_p + sizeof(*insn_p));
>>> +}
>>
>> Can't this function be a no-op on MIPS?  This seems to be
>> used on x86 to patch in the optimal nop instruction, but
>> on MIPS the optimal/only nop instruction should already
>> be in place at build time.  Same thing for the SPARC
>> implementation.
>>
>
> Yes, I think you are correct.
>
> On MIPS the NOP is already optimal.  I will respin the MIPS patch to  
> make arch_jump_label_text_poke_early() be empty.
>
> davem wasn't CCed on the original message, so I added him.  I would  
> defer to him on the SPARC version.
>
>

that's right, arch_jump_label_text_poke_early() can probably be a no-op
for most arches.

We can also look at adding an empty definition into the generic
header. So that arches don't have to provide an empty definition.

thanks,

-Jason
