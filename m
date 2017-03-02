Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 12:18:45 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:57361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992213AbdCBLSiT0ApE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 12:18:38 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3vYqYz54HVz9s7j;
        Thu,  2 Mar 2017 22:18:31 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Daney <david.daney@cavium.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <87varsj6qc.fsf@concordia.ellerman.id.au>
References: <20170301220453.4756-1-david.daney@cavium.com> <87varsj6qc.fsf@concordia.ellerman.id.au>
User-Agent: Notmuch/0.21 (https://notmuchmail.org)
Date:   Thu, 02 Mar 2017 22:18:30 +1100
Message-ID: <8737ewexkp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56995
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> David Daney <david.daney@cavium.com> writes:
>> Strict alignment became necessary with commit 3821fd35b58d
>> ("jump_label: Reduce the size of struct static_key"), currently in
>> linux-next, which uses the two least significant bits of pointers to
>> __jump_table elements.
>
> It would obviously be nice if this could go in before the commit that
> exposes the breakage, but I guess that's problematic because Steve
> doesn't want to rebase the tracing tree.
>
> Steve I think you've already sent your pull request for this cycle? So I
> guess if this can go in your first batch of fixes?

Ugh. Was looking at the wrong tree - Linus has already merged the commit
in question, so the above is all moot.

cheers
