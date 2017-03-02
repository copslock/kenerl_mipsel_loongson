Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 16:31:13 +0100 (CET)
Received: from prod-mail-xrelay07.akamai.com ([23.79.238.175]:47493 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdCBPa5hgvWe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 16:30:57 +0100
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 0FCDC433419;
        Thu,  2 Mar 2017 15:30:51 +0000 (GMT)
Received: from prod-mail-relay10.akamai.com (prod-mail-relay10.akamai.com [172.27.118.251])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id EB1D3433407;
        Thu,  2 Mar 2017 15:30:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488468650; bh=SXSsAriYwKxbm7pdjEbv8+7sPijbUhjeRzhJD6AaqHQ=;
        l=751; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=OtL1JmzpsheQS2FlXYAtkK3IiyX04N3/URVWETi/1h60A6aP341ZT4eABD29cJMyi
         stvltuSJfyBDDKmi+NMdfgY7f2FNvXnT4QCBtLFjZCT91511+8Or9yb2kuEllxLu9e
         UHlfyRPeQTsDeRHloqbKJCjSf2QEtv5Lp1DjDHt4=
Received: from [172.28.13.148] (bos-lpjec.kendall.corp.akamai.com [172.28.13.148])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id C08BF1FC86;
        Thu,  2 Mar 2017 15:30:50 +0000 (GMT)
Subject: Re: [PATCH] module: set __jump_table alignment to 8
To:     David Daney <david.daney@cavium.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20170301220453.4756-1-david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <7bc6b5af-85e0-5b06-f979-368b8b840a16@akamai.com>
Date:   Thu, 2 Mar 2017 10:30:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57001
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

On 03/01/2017 05:04 PM, David Daney wrote:
> For powerpc the __jump_table section in modules is not aligned, this
> causes a WARN_ON() splat when loading a module containing a __jump_table.
>
> Strict alignment became necessary with commit 3821fd35b58d
> ("jump_label: Reduce the size of struct static_key"), currently in
> linux-next, which uses the two least significant bits of pointers to
> __jump_table elements.
>
> Fix by forcing __jump_table to 8, which is the same alignment used for
> this section in the kernel proper.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> ---

Looks good to me.

Reviewed-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason
