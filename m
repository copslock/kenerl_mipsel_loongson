Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 21:03:06 +0100 (CET)
Received: from prod-mail-xrelay07.akamai.com ([23.79.238.175]:61696 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdCAUC7ss4mn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2017 21:02:59 +0100
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 40DAF433441;
        Wed,  1 Mar 2017 20:02:53 +0000 (GMT)
Received: from prod-mail-relay10.akamai.com (prod-mail-relay10.akamai.com [172.27.118.251])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id 1FABC43340A;
        Wed,  1 Mar 2017 20:02:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488398573; bh=RIQYDsqQNGlLwe927nFBXdgyXber0wMc5tsBXIb4uxo=;
        l=2324; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=Oq7yhgM1Z9/tuLclVwFMOJz5bFfd+dxZh+ocaN7L3snUdK6Ba64MUXXFwW/rdtoth
         ZHcUtwSlv50n4azPv/GB4DG8RUDl6qLv2DyKR/Owpjek++S5CgKKSo9MW/pGZXYbhI
         jtVeybmbPgaTFm+1GvHE5y6tBzECKfhY2CDGCemI=
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 8DF621FC86;
        Wed,  1 Mar 2017 20:02:52 +0000 (GMT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
 <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
 <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
 <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
 <23989c10-7b47-3fda-f790-25b53 9704bec@akamai.com>
 <871suh5wtw.fsf@concordia.ellerman.id.au>
 <7e05bd3d-08da-00ba-1b79-c9be8c659524@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <cd989fed-a136-5110-f22e-d334d923ca8b@akamai.com>
Date:   Wed, 1 Mar 2017 15:02:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <7e05bd3d-08da-00ba-1b79-c9be8c659524@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56951
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



On 03/01/2017 11:40 AM, David Daney wrote:
> On 02/28/2017 10:34 PM, Michael Ellerman wrote:
>> Jason Baron <jbaron@akamai.com> writes:
>> ...
>>> I also checked all the other .ko files and they were properly aligned.
>>> So I think this should hopefully work, and I like that its not a
>>> per-arch fix.
>>>
>>> Sachin, sorry to bother you again, but I'm hoping you can try David's
>>> latest patch to scripts/module-common.lds, just to test in your setup.
>>
>> It does fix the problem.
>>
>> I was reproducing with crc_t10dif:
>>
>> [  695.890552] ------------[ cut here ]------------
>> [  695.890709] WARNING: CPU: 15 PID: 3019 at
>> ../kernel/jump_label.c:287 static_key_set_entries+0x74/0xa0
>> [  695.890710] Modules linked in: crc_t10dif(+) crct10dif_generic
>> crct10dif_common ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
>> nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype
>> iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack
>> bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio
>> libcrc32c kvm virtio_balloon binfmt_misc autofs4 virtio_net virtio_pci
>> virtio_ring virtio
>>
>> Which had:
>>
>>   [21] __jump_table      PROGBITS        0000000000000000 0004e8
>> 000018 00  WA  0   0  1
>>
>>
>> And now has:
>>
>>   [18] __jump_table      PROGBITS        0000000000000000 0004d0
>> 000018 00  WA  0   0  8
>>
>> And all other modules have an alignment of 8 on __jump_table, as
>> expected.
>>
>> I'm inclined to merge a version of the balign patch for powerpc anyway,
>> just to be on the safe side. I guess the old code was coping fine with
>> the unaligned keys, but it still makes me nervous.
> 
> 
> The original "balign patch" has a couple of problems:
> 
> 1) 4-byte alignment is not sufficient for 64-bit kernels
> 
> 2) It is redundant if the linker script patch is accepted.
> 
> 

The linker script patch seems reasonable to me.

Maybe its worth adding a comment that the alignment is necessary because
the core jump_label makes use of the 2 lsb bits of its __jump_table
pointer due to commit:

3821fd3 jump_label: Reduce the size of struct static_key

Also, in the comment it says that it fixes an oops. We hit a WARN_ON()
not an oops, although bad things are likely to happen when the branch is
updated.

Thanks,

-Jason
