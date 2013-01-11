Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2013 02:58:50 +0100 (CET)
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:2858 "EHLO
        co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823015Ab3AKB6su076J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2013 02:58:48 +0100
Received: from mail220-co9-R.bigfish.com (10.236.132.234) by
 CO9EHSOBE006.bigfish.com (10.236.130.69) with Microsoft SMTP Server id
 14.1.225.23; Fri, 11 Jan 2013 01:58:39 +0000
Received: from mail220-co9 (localhost [127.0.0.1])      by
 mail220-co9-R.bigfish.com (Postfix) with ESMTP id 2CBEA3C02F9; Fri, 11 Jan
 2013 01:58:39 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.69;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0712HT003.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -1
X-BigFish: PS-1(zz1443Izz1ee6h1de0h1202h1e76h1d1ah1d2ahzzz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h1155h)
Received: from mail220-co9 (localhost.localdomain [127.0.0.1]) by mail220-co9
 (MessageSwitch) id 1357869517164784_27553; Fri, 11 Jan 2013 01:58:37 +0000
 (UTC)
Received: from CO9EHSMHS004.bigfish.com (unknown [10.236.132.242])      by
 mail220-co9.bigfish.com (Postfix) with ESMTP id 22FC416004F;   Fri, 11 Jan 2013
 01:58:37 +0000 (UTC)
Received: from BN1PRD0712HT003.namprd07.prod.outlook.com (132.245.2.69) by
 CO9EHSMHS004.bigfish.com (10.236.130.14) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 11 Jan 2013 01:58:37 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.196.36) with Microsoft SMTP Server (TLS) id 14.16.257.4; Fri, 11 Jan
 2013 01:58:35 +0000
Message-ID: <50EF71C9.4010907@caviumnetworks.com>
Date:   Thu, 10 Jan 2013 17:58:33 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Ftrace test failure on MIPS - Looking for insight..
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 35399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Steven,

I am trying to track down the cause of:

.
.
.
Brought up 32 CPUs
Testing tracer function: PASSED
Testing dynamic ftrace: .. filter failed count=0 ..FAILED!
------------[ cut here ]------------
WARNING: at kernel/trace/trace.c:878 register_tracer+0x23c/0x300()
Modules linked in:
Call Trace:
[<ffffffff815a0578>] dump_stack+0x14/0x40
[<ffffffff8113e8fc>] warn_slowpath_common+0x84/0xb0
[<ffffffff811bd04c>] register_tracer+0x23c/0x300
[<ffffffff81100538>] do_one_initcall+0x110/0x178
[<ffffffff8159234c>] kernel_init+0x174/0x318
[<ffffffff81119de4>] ret_from_kernel_thread+0x14/0x1c

---[ end trace 204112383c2d190e ]---
.
.
.


This is a MIPS64 kernel build from Linus' tree of today (commit 
254adaa465c40151df11fc1f88f93e6e86eb61d4)

I think the failure is long standing (since 3.4.x at least).

If you have any ideas off the top of your head as to what the cause 
might be, I would love to hear them.

In any event, I will try to track down the root cause and fix it.  But 
if something jumped out at you, that could speed up my search for the cause.


Thanks in advance,
David Daney
