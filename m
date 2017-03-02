Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 19:11:34 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993875AbdCBSL0zDNuB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 19:11:26 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8224B20303;
        Thu,  2 Mar 2017 18:11:23 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5782035E;
        Thu,  2 Mar 2017 18:11:20 +0000 (UTC)
Date:   Thu, 2 Mar 2017 13:11:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc:     David Daney <david.daney@cavium.com>,
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
Message-ID: <20170302131119.6f52203f@gandalf.local.home>
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=XfmF=2L=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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


Can I get an Ack from a module maintainer?

Thanks!

-- Steve


On Wed,  1 Mar 2017 14:04:53 -0800
David Daney <david.daney@cavium.com> wrote:

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
>  scripts/module-common.lds | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
> index 73a2c7d..53234e8 100644
> --- a/scripts/module-common.lds
> +++ b/scripts/module-common.lds
> @@ -19,4 +19,6 @@ SECTIONS {
>  
>  	. = ALIGN(8);
>  	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
> +
> +	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  }
