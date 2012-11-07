Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2012 12:32:11 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4531 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823426Ab2KGLcKRf-J1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Nov 2012 12:32:10 +0100
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 07 Nov 2012 03:28:27 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 7 Nov 2012 03:31:25 -0800
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1CB5340FE4; Wed, 7
 Nov 2012 03:31:51 -0800 (PST)
Date:   Wed, 7 Nov 2012 17:02:01 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 03/15] MIPS: Netlogic: select MIPSR2 for XLP
Message-ID: <20121107113200.GC23086@jayachandranc.netlogicmicro.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
 <3172102a3b041fdefbc721e3a25a95427bdec384.1351688140.git.jchandra@broadcom.com>
 <20121031132850.GB6365@linux-mips.org>
 <20121101102455.GA9437@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
In-Reply-To: <20121101102455.GA9437@jayachandranc.netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7C849A513T43628124-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 34917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Thu, Nov 01, 2012 at 03:54:55PM +0530, Jayachandran C. wrote:
> On Wed, Oct 31, 2012 at 02:28:50PM +0100, Ralf Baechle wrote:
> > On Wed, Oct 31, 2012 at 06:31:29PM +0530, Jayachandran C wrote:
> > 
> > > Disable PGD_C0_CONTEXT option for XLP, which does not work.
> > 
> > Why does this not work on XLP?
> > 
> 
> I see a kernel crash around the time init starts, planning to
> look at this next. For now, I thought I will enable R2 and disable
> PGD_C0_CONTEXT so that we get the rest of the R2 stuff for XLP.

On XLP the XContext PTEbase is [63:55], but the current code tries to
use XContext [63:48] to store the processor ID, which will not work.

I can probably work around the issue by changing the shift from 51 to
58, but that would not leave enough space for the 128 cpu config we
want to support.

I will send patch to fix this and to use the XLP c0 scratch registers
(cop0 $22) in the tlb handlers. But until the PGD_C0_CONTEXT code is
updated, this patch is probably the best solution.

JC.
