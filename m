Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 00:33:22 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:56765 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992851AbeEOWdPYTmjS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 00:33:15 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx26.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 15 May 2018 22:32:22 +0000
Received: from [10.20.78.107] (10.20.78.107) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 15
 May 2018 15:32:50 -0700
Date:   Tue, 15 May 2018 23:32:11 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] MIPS: DSP ASE regset support
Message-ID: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526423542-853316-32019-19570-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi,

 For years, quite oddly, we have been missing DSP ASE register state from 
core files.  These days regsets are used to define what goes into a core 
file, so here's a change adding one.

 As a side effect ptrace(2) can now also access this regset, however no 
complementing client implementation has been made.  Eventually that'll 
have to change though so that DSP ASE registers can be correctly accessed 
in n32 processes, which suffer from ptrace(2) 32-bit data types truncating 
contents exchanged by PTRACE_PEEKUSR and PTRACE_POKEUSR requests with 
64-bit registers and no means defined to access partial registers via this 
API.

 In the course of this implementation I came across two bugs affecting the 
area being updated and hence this has become a small patch series with the 
audience wider than originally expected.

 See individual commit descriptions for the details of changes made.  

 NB there is no strict functional dependency between 1/3 and 2/3-3/3, so 
the order of commits does not have to be preserved as far as these two 
subsets are concerned.  However 3/3 does trigger the problem addressed 
with 1/3 (and gracefully handles it), hence the grouping in a series.

 Please apply.

  Maciej
