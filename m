Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 10:43:08 +0200 (CEST)
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:35112 "EHLO
        TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab1EXInE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 10:43:04 +0200
Received: from mail114-tx2-R.bigfish.com (10.9.14.253) by
 TX2EHSOBE001.bigfish.com (10.9.40.21) with Microsoft SMTP Server id
 14.1.225.22; Tue, 24 May 2011 08:42:56 +0000
Received: from mail114-tx2 (localhost.localdomain [127.0.0.1])  by
 mail114-tx2-R.bigfish.com (Postfix) with ESMTP id BF8D8E507ED; Tue, 24 May
 2011 08:42:56 +0000 (UTC)
X-SpamScore: -15
X-BigFish: VPS-15(zzbb2cK4015L1432N98dKzz1202hzz8275bhz32i668h839h61h)
X-Forefront-Antispam-Report: CIP:163.181.249.109;KIP:(null);UIP:(null);IPVD:NLI;H:ausb3twp02.amd.com;RD:none;EFVD:NLI
Received: from mail114-tx2 (localhost.localdomain [127.0.0.1]) by mail114-tx2
 (MessageSwitch) id 1306226576608665_8436; Tue, 24 May 2011 08:42:56 +0000
 (UTC)
Received: from TX2EHSMHS007.bigfish.com (unknown [10.9.14.251]) by
 mail114-tx2.bigfish.com (Postfix) with ESMTP id 7F3331D8050;   Tue, 24 May 2011
 08:42:56 +0000 (UTC)
Received: from ausb3twp02.amd.com (163.181.249.109) by
 TX2EHSMHS007.bigfish.com (10.9.99.107) with Microsoft SMTP Server id
 14.1.225.22; Tue, 24 May 2011 08:42:55 +0000
X-WSS-ID: 0LLOYVH-02-4DR-02
X-M-MSG: 
Received: from sausexedgep02.amd.com (sausexedgep02-ext.amd.com
 [163.181.249.73])      (using TLSv1 with cipher AES128-SHA (128/128 bits))     (No
 client certificate requested)  by ausb3twp02.amd.com (Axway MailGate 3.8.1)
 with ESMTP id 22EF8C83F3;      Tue, 24 May 2011 03:42:52 -0500 (CDT)
Received: from sausexhtp01.amd.com (163.181.3.165) by sausexedgep02.amd.com
 (163.181.36.59) with Microsoft SMTP Server (TLS) id 8.3.106.1; Tue, 24 May
 2011 03:43:00 -0500
Received: from storexhtp01.amd.com (172.24.4.3) by sausexhtp01.amd.com
 (163.181.3.165) with Microsoft SMTP Server (TLS) id 8.3.83.0; Tue, 24 May
 2011 03:42:53 -0500
Received: from gwo.osrc.amd.com (165.204.16.204) by storexhtp01.amd.com
 (172.24.4.3) with Microsoft SMTP Server id 8.3.83.0; Tue, 24 May 2011
 04:42:52 -0400
Received: from erda.amd.com (erda.osrc.amd.com [165.204.15.17]) by
 gwo.osrc.amd.com (Postfix) with ESMTP id 3198549C229;  Tue, 24 May 2011
 09:42:51 +0100 (BST)
Received: by erda.amd.com (Postfix, from userid 35569)  id 095898009; Tue, 24
 May 2011 10:42:50 +0200 (CEST)
Date:   Tue, 24 May 2011 10:42:50 +0200
From:   Robert Richter <robert.richter@amd.com>
To:     Gergely Kis <gergely@homejinni.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Daniel Kalmar <kalmard@homejinni.com>,
        "oprofile-list@lists.sourceforge.net" 
        <oprofile-list@lists.sourceforge.net>
Subject: Re: [PATCH 0/2] MIPS: oprofile: callgraph support
Message-ID: <20110524084250.GR20052@erda.amd.com>
References: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginatorOrg: amd.com
Return-Path: <robert.richter@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips

On 13.05.11 08:38:03, Gergely Kis wrote:
> From: Daniel Kalmar <kalmard@homejinni.com>
> 
> These patches add callgraph/backtrace support to oprofile on MIPS.
> 
> Stack unwinding is done by code examination. For kernelspace, the
> already existing unwind function is utilized that uses kallsyms to
> quickly find the beginning of functions. For userspace a new function
> was added that examines code at and before the pc.
> 
> Daniel Kalmar (2):
>   MIPS: Add unwind_stack_by_address to support unwinding from any
>     kernel code address
>   MIPS: oprofile: Add callgraph support
> 
>  arch/mips/include/asm/stacktrace.h |    4 +
>  arch/mips/kernel/process.c         |   18 +++-
>  arch/mips/oprofile/Makefile        |    2 +-
>  arch/mips/oprofile/backtrace.c     |  173 ++++++++++++++++++++++++++++++++++++
>  arch/mips/oprofile/common.c        |    1 +
>  arch/mips/oprofile/op_impl.h       |    2 +
>  6 files changed, 194 insertions(+), 6 deletions(-)
>  create mode 100644 arch/mips/oprofile/backtrace.c

Daniel and Gergely,

the patches look good so far. I fixed the coding style to have the
opening brace of functions at the beginning of the next line. After
the MIPS maintainer's ack I will apply them to the oprofile tree.

Thanks for your contribution.

Ralf,

please ack.

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
