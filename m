Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 22:06:16 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991960AbdB0VGJp5b-O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 22:06:09 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B37C62026C;
        Mon, 27 Feb 2017 21:06:05 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30CFC2011E;
        Mon, 27 Feb 2017 21:06:03 +0000 (UTC)
Date:   Mon, 27 Feb 2017 16:06:01 -0500
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
Message-ID: <20170227160601.5b79a1fe@gandalf.local.home>
In-Reply-To: <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
        <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
        <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
        <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56907
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

On Mon, 27 Feb 2017 11:59:50 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> For me the size is not the important issue, it is the alignment of the 
> struct jump_entry entries in the table.  I don't understand how your 
> patch helps, and I cannot Acked-by unless I understand what is being 
> done and can see that it is both correct and necessary.

You brought up a very good point and I'm glad that I had Jason Cc all
the arch maintainers in one patch.

I think jump_labels may be much more broken than we think, and Jason's
fix doesn't fix anything. We had this same issues with tracepoints.

I'm looking at jump_label_init, and how we iterate over an array of
struct jump_entry's that was put together by the linker. The problem is
that jump_entry is not a power of 2 in size.

struct jump_entry {
	jump_label_t code;
	jump_label_t target;
	jump_label_t key;
};

When putting together arrays of this kind, the linker is in its right
to add padding for alignment, in the middle of the array! It has no
idea that this is an array, and there's nothing stopping the linker
from messing it up.

For those structs that are a power of 2 in size, there's no reason for
the linker to do anything else, and it "just works". There's plenty of
instances in the kernel that depend on this.

I'm thinking that the sort algorithm either hid the problem or fixed it
somehow (I'm guessing it hid the problem).

I hit the same issue with trace event structures. The solution was to
create the array of pointers to each structure, and dereference the
structures from the array.

See commit e4a9ea5ee ("tracing: Replace trace_event struct array with
pointer array")

-- Steve
