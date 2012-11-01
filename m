Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 11:21:40 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2343 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816671Ab2KAKVjH-3xn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2012 11:21:39 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 01 Nov 2012 03:20:14 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 1 Nov 2012 03:20:52 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0013340FE3; Thu, 1
 Nov 2012 03:21:20 -0700 (PDT)
Date:   Thu, 1 Nov 2012 15:54:56 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 03/15] MIPS: Netlogic: select MIPSR2 for XLP
Message-ID: <20121101102455.GA9437@jayachandranc.netlogicmicro.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
 <3172102a3b041fdefbc721e3a25a95427bdec384.1351688140.git.jchandra@broadcom.com>
 <20121031132850.GB6365@linux-mips.org>
MIME-Version: 1.0
In-Reply-To: <20121031132850.GB6365@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7C8C93542102952504-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 34838
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

On Wed, Oct 31, 2012 at 02:28:50PM +0100, Ralf Baechle wrote:
> On Wed, Oct 31, 2012 at 06:31:29PM +0530, Jayachandran C wrote:
> 
> > Disable PGD_C0_CONTEXT option for XLP, which does not work.
> 
> Why does this not work on XLP?
> 

I see a kernel crash around the time init starts, planning to
look at this next. For now, I thought I will enable R2 and disable
PGD_C0_CONTEXT so that we get the rest of the R2 stuff for XLP.

JC.
