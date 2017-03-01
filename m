Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 07:35:04 +0100 (CET)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:34633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992213AbdCAGe5dkbSy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Mar 2017 07:34:57 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3vY5K84W32z9s7j;
        Wed,  1 Mar 2017 17:34:52 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jason Baron <jbaron@akamai.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <23989c10-7b47-3fda-f790-25b539704bec@akamai.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com> <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com> <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com> <20170227160601.5b79a1fe@gandalf.local.home> <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com> <20170227170911.2280ca3e@gandalf.local.home> <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com> <20170227173630.57fff459@gandalf.local.home> <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com> <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com> <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com> <20170228112144.65455de5@gandalf.local.home> <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com> <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com> <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com> <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com> <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com> <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com> <23989c10-7b47-3fda-f790-25b53
 9704bec@akamai.com>
User-Agent: Notmuch/0.21 (https://notmuchmail.org)
Date:   Wed, 01 Mar 2017 17:34:51 +1100
Message-ID: <871suh5wtw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Jason Baron <jbaron@akamai.com> writes:
...
> I also checked all the other .ko files and they were properly aligned. 
> So I think this should hopefully work, and I like that its not a 
> per-arch fix.
>
> Sachin, sorry to bother you again, but I'm hoping you can try David's 
> latest patch to scripts/module-common.lds, just to test in your setup.

It does fix the problem.

I was reproducing with crc_t10dif:

[  695.890552] ------------[ cut here ]------------
[  695.890709] WARNING: CPU: 15 PID: 3019 at ../kernel/jump_label.c:287 static_key_set_entries+0x74/0xa0
[  695.890710] Modules linked in: crc_t10dif(+) crct10dif_generic crct10dif_common ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c kvm virtio_balloon binfmt_misc autofs4 virtio_net virtio_pci virtio_ring virtio

Which had:

  [21] __jump_table      PROGBITS        0000000000000000 0004e8 000018 00  WA  0   0  1


And now has:

  [18] __jump_table      PROGBITS        0000000000000000 0004d0 000018 00  WA  0   0  8

And all other modules have an alignment of 8 on __jump_table, as expected.

I'm inclined to merge a version of the balign patch for powerpc anyway,
just to be on the safe side. I guess the old code was coping fine with
the unaligned keys, but it still makes me nervous.

cheers
