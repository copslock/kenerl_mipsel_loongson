Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 14:56:12 +0200 (CEST)
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:7961
        "EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1FOM4H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 14:56:07 +0200
Received: from mail12-db3-R.bigfish.com (10.3.81.241) by
 DB3EHSOBE003.bigfish.com (10.3.84.23) with Microsoft SMTP Server id
 14.1.225.22; Wed, 15 Jun 2011 12:55:58 +0000
Received: from mail12-db3 (localhost.localdomain [127.0.0.1])   by
 mail12-db3-R.bigfish.com (Postfix) with ESMTP id BC3941B818C;  Wed, 15 Jun
 2011 12:55:58 +0000 (UTC)
X-SpamScore: -8
X-BigFish: VPS-8(zz1432N98dKzz1202hzz8275bhz32i668h839h61h)
X-Forefront-Antispam-Report: CIP:163.181.249.108;KIP:(null);UIP:(null);IPVD:NLI;H:ausb3twp01.amd.com;RD:none;EFVD:NLI
Received: from mail12-db3 (localhost.localdomain [127.0.0.1]) by mail12-db3
 (MessageSwitch) id 1308142558525996_12748; Wed, 15 Jun 2011 12:55:58 +0000
 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.247]) by
 mail12-db3.bigfish.com (Postfix) with ESMTP id 725AA480051;    Wed, 15 Jun 2011
 12:55:58 +0000 (UTC)
Received: from ausb3twp01.amd.com (163.181.249.108) by
 DB3EHSMHS008.bigfish.com (10.3.87.108) with Microsoft SMTP Server id
 14.1.225.22; Wed, 15 Jun 2011 12:55:57 +0000
X-WSS-ID: 0LMU196-01-0QE-02
X-M-MSG: 
Received: from sausexedgep02.amd.com (sausexedgep02-ext.amd.com
 [163.181.249.73])      (using TLSv1 with cipher AES128-SHA (128/128 bits))     (No
 client certificate requested)  by ausb3twp01.amd.com (Axway MailGate 3.8.1)
 with ESMTP id 261EE1028235;    Wed, 15 Jun 2011 07:55:54 -0500 (CDT)
Received: from sausexhtp02.amd.com (163.181.3.152) by sausexedgep02.amd.com
 (163.181.36.59) with Microsoft SMTP Server (TLS) id 8.3.106.1; Wed, 15 Jun
 2011 07:56:18 -0500
Received: from storexhtp02.amd.com (172.24.4.4) by sausexhtp02.amd.com
 (163.181.3.152) with Microsoft SMTP Server (TLS) id 8.3.83.0; Wed, 15 Jun
 2011 07:55:56 -0500
Received: from gwo.osrc.amd.com (165.204.16.204) by storexhtp02.amd.com
 (172.24.4.4) with Microsoft SMTP Server id 8.3.83.0; Wed, 15 Jun 2011
 08:55:54 -0400
Received: from erda.amd.com (erda.osrc.amd.com [165.204.15.17]) by
 gwo.osrc.amd.com (Postfix) with ESMTP id 0C4D549C174;  Wed, 15 Jun 2011
 13:55:54 +0100 (BST)
Received: by erda.amd.com (Postfix, from userid 35569)  id D3D1F8547; Wed, 15
 Jun 2011 14:55:53 +0200 (CEST)
Date:   Wed, 15 Jun 2011 14:55:53 +0200
From:   Robert Richter <robert.richter@amd.com>
To:     Daniel Kalmar <kalmard@homejinni.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Gergely Kis <gergely@homejinni.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "oprofile-list@lists.sourceforge.net" 
        <oprofile-list@lists.sourceforge.net>
Subject: Re: [PATCH 0/2] MIPS: oprofile: callgraph support
Message-ID: <20110615125553.GC20052@erda.amd.com>
References: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
 <20110524084250.GR20052@erda.amd.com>
 <20110610123557.GQ20052@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110610123557.GQ20052@erda.amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginatorOrg: amd.com
X-archive-position: 30409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12321

On 10.06.11 14:35:57, Robert Richter wrote:
> On 24.05.11 10:42:50, Robert Richter wrote:
> > On 13.05.11 08:38:03, Gergely Kis wrote:
> > > From: Daniel Kalmar <kalmard@homejinni.com>
> > > 
> > > These patches add callgraph/backtrace support to oprofile on MIPS.
> > > 
> > > Stack unwinding is done by code examination. For kernelspace, the
> > > already existing unwind function is utilized that uses kallsyms to
> > > quickly find the beginning of functions. For userspace a new function
> > > was added that examines code at and before the pc.
> > > 
> > > Daniel Kalmar (2):
> > >   MIPS: Add unwind_stack_by_address to support unwinding from any
> > >     kernel code address
> > >   MIPS: oprofile: Add callgraph support
> > > 
> > >  arch/mips/include/asm/stacktrace.h |    4 +
> > >  arch/mips/kernel/process.c         |   18 +++-
> > >  arch/mips/oprofile/Makefile        |    2 +-
> > >  arch/mips/oprofile/backtrace.c     |  173 ++++++++++++++++++++++++++++++++++++
> > >  arch/mips/oprofile/common.c        |    1 +
> > >  arch/mips/oprofile/op_impl.h       |    2 +
> > >  6 files changed, 194 insertions(+), 6 deletions(-)
> > >  create mode 100644 arch/mips/oprofile/backtrace.c
> 
> If there are no objections I will apply the patches next week to the
> oprofile tree.

Applied to oprofile/core. Thanks Daniel.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
