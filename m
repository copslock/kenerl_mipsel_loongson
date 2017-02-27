Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 23:09:28 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991960AbdB0WJUQmlM9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 23:09:20 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 98236202F0;
        Mon, 27 Feb 2017 22:09:15 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231102025B;
        Mon, 27 Feb 2017 22:09:13 +0000 (UTC)
Date:   Mon, 27 Feb 2017 17:09:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
Message-ID: <20170227170911.2280ca3e@gandalf.local.home>
In-Reply-To: <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
        <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
        <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
        <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
        <20170227160601.5b79a1fe@gandalf.local.home>
        <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56909
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

On Mon, 27 Feb 2017 13:41:13 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> On 02/27/2017 01:06 PM, Steven Rostedt wrote:
> > On Mon, 27 Feb 2017 11:59:50 -0800
> > David Daney <ddaney@caviumnetworks.com> wrote:
> >  
> >> For me the size is not the important issue, it is the alignment of the
> >> struct jump_entry entries in the table.  I don't understand how your
> >> patch helps, and I cannot Acked-by unless I understand what is being
> >> done and can see that it is both correct and necessary.  
> >
> > You brought up a very good point and I'm glad that I had Jason Cc all
> > the arch maintainers in one patch.
> >
> > I think jump_labels may be much more broken than we think, and Jason's
> > fix doesn't fix anything. We had this same issues with tracepoints.
> >
> > I'm looking at jump_label_init, and how we iterate over an array of
> > struct jump_entry's that was put together by the linker. The problem is
> > that jump_entry is not a power of 2 in size.
> >  
> 
> ELF sections may have an ENTSIZE property exactly for arrays.  Since 
> each jump_entry will have a unique value they cannot be merged, but we 
> can tell the assembler they are an array and get them properly packed. 
> Perhaps something like (untested):
> 
>     .pushsection __jump_table,  \"awM\",@progbits,24
>     FOO
>     .popsection
> 

And the linker will honor this too?

-- Steve
