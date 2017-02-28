Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 19:39:41 +0100 (CET)
Received: from prod-mail-xrelay08.akamai.com ([96.6.114.112]:54907 "EHLO
        prod-mail-xrelay08.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdB1SjfKdzZi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 19:39:35 +0100
Received: from prod-mail-xrelay08.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id E404B20000D;
        Tue, 28 Feb 2017 18:39:28 +0000 (GMT)
Received: from prod-mail-relay09.akamai.com (prod-mail-relay09.akamai.com [172.27.22.68])
        by prod-mail-xrelay08.akamai.com (Postfix) with ESMTP id C385E200004;
        Tue, 28 Feb 2017 18:39:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488307168; bh=X2SMddg5i6cnFPh4i161bW+HYQgf/IiduD2tKxCOico=;
        l=2688; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=MLOGcMKwsiuoOgyE+Oc5xhCPxWq9Pr6LsYkjtG6+rAxoZATygSZb/qJtz83Vg4NGm
         ZZUh74h+BywGYi/Lv8nl7SYkJKUQAwP+7/TV4ZunBaTLtbuzCDbtOdXnlD40k6hOaJ
         jWRC02QrkoCF/TKIwP88w/NFFR6c2VbtIAsAHzps=
Received: from [172.28.13.148] (bos-lpjec.kendall.corp.akamai.com [172.28.13.148])
        by prod-mail-relay09.akamai.com (Postfix) with ESMTP id EA37E1E08A;
        Tue, 28 Feb 2017 18:39:27 +0000 (GMT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
Date:   Tue, 28 Feb 2017 13:39:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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



On 02/28/2017 01:16 PM, David Daney wrote:
> On 02/28/2017 08:21 AM, Steven Rostedt wrote:
>> On Tue, 28 Feb 2017 10:25:46 +0530
>> Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>>
>>> File: ./net/ipv4/xfrm4_input.o
>>>   [12] __jump_table      PROGBITS        0000000000000000 000639
>>> 000018 18 WAM  0   0  1
>>> File: ./net/ipv4/udplite.o
>>> File: ./net/ipv4/xfrm4_output.o
>>>   [ 9] __jump_table      PROGBITS        0000000000000000 000481
>>> 000018 18 WAM  0   0  1
>>
>> Looks like there's some issues right there.
>
> Those look good to me 18/18 = 1 with no remainder.  The odd numbers are
> the offset of the section in the ELF file.
>
> If you look at the stack trace, it seems that it is during module loading.
>
> Are the primitives for generating the tables doing something different
> for the module case?  I am not familiar enough with the powerpc ABIs to
> know.
>
> Try this:
>
> $ perl -n -e 's/\[ /\[/; my @f = split " "; print hex($f[5]) % 0x18 if
> $#f > 5; print $_' <~/jump_table.log
>
>
> There are no entries with size that is not a multiple of 0x18.
>
> I think my patch to add the ENTSIZE is not doing anything here.
>
> I suspect that the alignment of the __jump_table section in the .ko
> files is not correct, and you are seeing some sort of problem due to that.
>
>

Hi,

Yes, if you look at the trace that Sachin sent the module being loaded 
that does the WARN_ON() is nfsd.ko.

That module from Sachin's trace has:

   [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0 
18 WAM  0   0  1

So its not the size but rather the start offset '03fd77', that is the 
problem here. That is what the WARN_ON triggers on, that the start of 
the table is not 4-byte aligned.

Using a ppc cross-compiler and the ENTSIZE patch that line does not 
change, however if I use the initial patch posted in this thread, the 
start does align to 4-bytes and thus the warning goes away, as Sachin 
verified. In fact, without the patch I found several modules that don't 
start at the proper alignment, however with the patch that started this 
thread they were all properly aligned.

In terms of the '.balign' causing holes, we originally added the 
'_ASM_ALIGN' to x86 for precisely this reason. See commit:
ef64789 jump label: Add _ASM_ALIGN for x86 and x86_64 and discussion.

In addition, we have a lot of runtime with the .balign in the tree and 
I'm not aware of any holes in the table. I think the code would blow up 
pretty badly if there were.

A number of arches were already using the '.balign', and the patch I 
proposed simply added it to remaining ones, now that we added a 
WARN_ON() to catch this condition.

Thanks,

-Jason
