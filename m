Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 17:22:00 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993870AbdB1QVu4OMDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 17:21:50 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6E6772021B;
        Tue, 28 Feb 2017 16:21:48 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6182024D;
        Tue, 28 Feb 2017 16:21:45 +0000 (UTC)
Date:   Tue, 28 Feb 2017 11:21:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
Message-ID: <20170228112144.65455de5@gandalf.local.home>
In-Reply-To: <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
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
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=Vz7S=2J=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56926
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

On Tue, 28 Feb 2017 10:25:46 +0530
Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:

> File: ./net/ipv4/xfrm4_input.o
>   [12] __jump_table      PROGBITS        0000000000000000 000639 000018 18 WAM  0   0  1
> File: ./net/ipv4/udplite.o
> File: ./net/ipv4/xfrm4_output.o
>   [ 9] __jump_table      PROGBITS        0000000000000000 000481 000018 18 WAM  0   0  1

Looks like there's some issues right there.

-- Steve
