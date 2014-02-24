Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2014 10:27:31 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:14162 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825311AbaBXJ1ZhcuQW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Feb 2014 10:27:25 +0100
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     Viller Hsiao <villerhsiao@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH v2 0/2] MIPS: ftrace: Fix icache flush issue
Thread-Topic: [PATCH v2 0/2] MIPS: ftrace: Fix icache flush issue
Thread-Index: AQHPL6JcK+Nwc65iykWvWXFmMBBmC5rEJTJg
Date:   Mon, 24 Feb 2014 09:27:18 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D140F40E@LEMAIL01.le.imgtec.org>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
In-Reply-To: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.95]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2014_02_24_09_27_19
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Qais.Yousef@imgtec.com
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

> -----Original Message-----
> From: Viller Hsiao [mailto:villerhsiao@gmail.com]
> Sent: 22 February 2014 07:47
> To: linux-mips@linux-mips.org
> Cc: rostedt@goodmis.org; fweisbec@gmail.com; mingo@redhat.com; ralf@linux-
> mips.org; Qais Yousef; Viller Hsiao
> Subject: [PATCH v2 0/2] MIPS: ftrace: Fix icache flush issue
> 
> In 32-bit mode, the start address of flushing icache is wrong because of error
> address calculation. It causes system crash at boot when dynamic function trace is
> enabled. This issue existed since linux-3.8.
> 
> In the patch set, I fixed the flushing range and refined the macros used by it to
> pass compilation.
> 
> Patch 1 is tried to improve the usability of some macros such that we can make
> patch 2 cleaner. Patch 2 fixes this issue.
> 
> This patch set is based on commit 7d3f1a5 of mips-for-linux-next branch.
> 
> Viller Hsiao (2):
>   MIPS: ftrace: Tweak safe_load()/safe_store() macros
>   MIPS: ftrace: Fix icache flush range error
> 

Both patches look good to me. Thanks for the fixes.

Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>

Qais

>  arch/mips/include/asm/ftrace.h | 20 ++++++++++----------
>  arch/mips/kernel/ftrace.c      |  5 ++---
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> --
> 1.8.4.3
