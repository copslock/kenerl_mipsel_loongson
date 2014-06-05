Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 18:12:13 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:37293 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6822133AbaFEQMLkP1Kv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 18:12:11 +0200
Received: from [67.246.153.56] ([67.246.153.56:53596] helo=gandalf.local.home)
        by cdptpa-oedge03 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id 56/D7-25046-5D690935; Thu, 05 Jun 2014 16:12:06 +0000
Date:   Thu, 5 Jun 2014 12:12:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: gcc warning in my trace_benchmark() code
Message-ID: <20140605121204.18ee5f2d@gandalf.local.home>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40440
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

I'm going through some of the warnings that Fengguang Wu's test bot has
discovered, and one of them is from a MIPS allmodconfig build.

https://lists.01.org/pipermail/kbuild-all/2014-May/004751.html

   kernel/trace/trace_benchmark.c: In function 'trace_do_benchmark':
>> kernel/trace/trace_benchmark.c:84:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>> kernel/trace/trace_benchmark.c:85:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
   kernel/trace/trace_benchmark.c:38:6: warning: unused variable 'seedsq' [-Wunused-variable]

vim +84 kernel/trace/trace_benchmark.c

    78		if (bm_cnt > 1) {
    79			/*
    80			 * Apply Welford's method to calculate standard deviation:
    81			 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
    82			 */
    83			stddev = (u64)bm_cnt * bm_totalsq - bm_total * bm_total;
  > 84			do_div(stddev, bm_cnt);
  > 85			do_div(stddev, bm_cnt - 1);
    86		} else
    87			stddev = 0;
    88	



Is there something special with do_div in mips that I should be aware
of?

-- Steve
