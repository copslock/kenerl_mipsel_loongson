Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 14:36:21 +0200 (CEST)
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:9696 "EHLO
        TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491076Ab1FJMgM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2011 14:36:12 +0200
Received: from mail175-tx2-R.bigfish.com (10.9.14.251) by
 TX2EHSOBE005.bigfish.com (10.9.40.25) with Microsoft SMTP Server id
 14.1.225.22; Fri, 10 Jun 2011 12:36:03 +0000
Received: from mail175-tx2 (localhost.localdomain [127.0.0.1])  by
 mail175-tx2-R.bigfish.com (Postfix) with ESMTP id 0994B109832A;        Fri, 10 Jun
 2011 12:36:03 +0000 (UTC)
X-SpamScore: -12
X-BigFish: VPS-12(zz1432N98dK4015Lzz1202hzz8275bhz32i668h839h61h)
X-Forefront-Antispam-Report: CIP:163.181.249.108;KIP:(null);UIP:(null);IPVD:NLI;H:ausb3twp01.amd.com;RD:none;EFVD:NLI
Received: from mail175-tx2 (localhost.localdomain [127.0.0.1]) by mail175-tx2
 (MessageSwitch) id 1307709362846720_18102; Fri, 10 Jun 2011 12:36:02 +0000
 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.250]) by
 mail175-tx2.bigfish.com (Postfix) with ESMTP id BE4031AD004B;  Fri, 10 Jun
 2011 12:36:02 +0000 (UTC)
Received: from ausb3twp01.amd.com (163.181.249.108) by
 TX2EHSMHS038.bigfish.com (10.9.99.138) with Microsoft SMTP Server id
 14.1.225.22; Fri, 10 Jun 2011 12:36:02 +0000
X-WSS-ID: 0LMKQZZ-01-809-02
X-M-MSG: 
Received: from sausexedgep02.amd.com (sausexedgep02-ext.amd.com
 [163.181.249.73])      (using TLSv1 with cipher AES128-SHA (128/128 bits))     (No
 client certificate requested)  by ausb3twp01.amd.com (Axway MailGate 3.8.1)
 with ESMTP id 221B91028133;    Fri, 10 Jun 2011 07:35:59 -0500 (CDT)
Received: from sausexhtp02.amd.com (163.181.3.152) by sausexedgep02.amd.com
 (163.181.36.59) with Microsoft SMTP Server (TLS) id 8.3.106.1; Fri, 10 Jun
 2011 07:36:06 -0500
Received: from storexhtp02.amd.com (172.24.4.4) by sausexhtp02.amd.com
 (163.181.3.152) with Microsoft SMTP Server (TLS) id 8.3.83.0; Fri, 10 Jun
 2011 07:36:00 -0500
Received: from gwo.osrc.amd.com (165.204.16.204) by storexhtp02.amd.com
 (172.24.4.4) with Microsoft SMTP Server id 8.3.83.0; Fri, 10 Jun 2011
 08:35:58 -0400
Received: from erda.amd.com (erda.osrc.amd.com [165.204.15.17]) by
 gwo.osrc.amd.com (Postfix) with ESMTP id 3C0A349C1A8;  Fri, 10 Jun 2011
 13:35:58 +0100 (BST)
Received: by erda.amd.com (Postfix, from userid 35569)  id 0D26E800A; Fri, 10
 Jun 2011 14:35:57 +0200 (CEST)
Date:   Fri, 10 Jun 2011 14:35:57 +0200
From:   Robert Richter <robert.richter@amd.com>
To:     Gergely Kis <gergely@homejinni.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Daniel Kalmar <kalmard@homejinni.com>,
        "oprofile-list@lists.sourceforge.net" 
        <oprofile-list@lists.sourceforge.net>
Subject: Re: [PATCH 0/2] MIPS: oprofile: callgraph support
Message-ID: <20110610123557.GQ20052@erda.amd.com>
References: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
 <20110524084250.GR20052@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110524084250.GR20052@erda.amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginatorOrg: amd.com
X-archive-position: 30316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9115

On 24.05.11 10:42:50, Robert Richter wrote:
> On 13.05.11 08:38:03, Gergely Kis wrote:
> > From: Daniel Kalmar <kalmard@homejinni.com>
> > 
> > These patches add callgraph/backtrace support to oprofile on MIPS.
> > 
> > Stack unwinding is done by code examination. For kernelspace, the
> > already existing unwind function is utilized that uses kallsyms to
> > quickly find the beginning of functions. For userspace a new function
> > was added that examines code at and before the pc.
> > 
> > Daniel Kalmar (2):
> >   MIPS: Add unwind_stack_by_address to support unwinding from any
> >     kernel code address
> >   MIPS: oprofile: Add callgraph support
> > 
> >  arch/mips/include/asm/stacktrace.h |    4 +
> >  arch/mips/kernel/process.c         |   18 +++-
> >  arch/mips/oprofile/Makefile        |    2 +-
> >  arch/mips/oprofile/backtrace.c     |  173 ++++++++++++++++++++++++++++++++++++
> >  arch/mips/oprofile/common.c        |    1 +
> >  arch/mips/oprofile/op_impl.h       |    2 +
> >  6 files changed, 194 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/mips/oprofile/backtrace.c

If there are no objections I will apply the patches next week to the
oprofile tree.

Thanks, 

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
