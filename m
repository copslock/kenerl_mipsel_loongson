Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 19:26:43 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:43806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993875AbdCBS0fGoIrx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 19:26:35 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F95980486;
        Thu,  2 Mar 2017 18:26:28 +0000 (UTC)
Received: from packer-debian-8-amd64.digitalocean.com (vpn-234-230.phx2.redhat.com [10.3.234.230])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id v22IQQNa011150;
        Thu, 2 Mar 2017 13:26:26 -0500
Date:   Thu, 2 Mar 2017 13:26:25 -0500
From:   Jessica Yu <jeyu@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        David Daney <david.daney@cavium.com>,
        Jason Baron <jbaron@akamai.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
Message-ID: <20170302182625.GB13268@packer-debian-8-amd64.digitalocean.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <20170302131119.6f52203f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170302131119.6f52203f@gandalf.local.home>
X-OS:   Linux eisen.io 3.16.0-4-amd64 x86_64
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 02 Mar 2017 18:26:29 +0000 (UTC)
Return-Path: <jeyu@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeyu@redhat.com
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

+++ Steven Rostedt [02/03/17 13:11 -0500]:
>
>Can I get an Ack from a module maintainer?

Acked-by: Jessica Yu <jeyu@redhat.com>

Thanks!

Jessica

>On Wed,  1 Mar 2017 14:04:53 -0800
>David Daney <david.daney@cavium.com> wrote:
>
>> For powerpc the __jump_table section in modules is not aligned, this
>> causes a WARN_ON() splat when loading a module containing a __jump_table.
>>
>> Strict alignment became necessary with commit 3821fd35b58d
>> ("jump_label: Reduce the size of struct static_key"), currently in
>> linux-next, which uses the two least significant bits of pointers to
>> __jump_table elements.
>>
>> Fix by forcing __jump_table to 8, which is the same alignment used for
>> this section in the kernel proper.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>> ---
>>  scripts/module-common.lds | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
>> index 73a2c7d..53234e8 100644
>> --- a/scripts/module-common.lds
>> +++ b/scripts/module-common.lds
>> @@ -19,4 +19,6 @@ SECTIONS {
>>
>>  	. = ALIGN(8);
>>  	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
>> +
>> +	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>>  }
>
