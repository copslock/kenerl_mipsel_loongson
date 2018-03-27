Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 13:08:12 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:38818 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeC0LIDfbIbW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 13:08:03 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 27 Mar 2018 11:07:57 +0000
Received: from [10.20.78.222] (10.20.78.222) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 27 Mar 2018
 04:08:05 -0700
Date:   Tue, 27 Mar 2018 12:07:44 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maxim Uvarov <muvarov@gmail.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Make the default for PHYSICAL_START always
 64-bit
In-Reply-To: <20180327092438.GA17660@saruman>
Message-ID: <alpine.DEB.2.00.1803271146110.2163@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1803240129140.2163@tp.orcam.me.uk> <20180327092438.GA17660@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1522148877-298553-586-23742-1
X-BESS-VER: 2018.3-r1803262126
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191445
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
X-archive-position: 63247
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

On Tue, 27 Mar 2018, James Hogan wrote:

> > Make the default for PHYSICAL_START always 64-bit, ensuring that a 
> > correct sign-extended value is used if a 32-bit image is loaded by a 
> > 64-bit system, and matching how the load address is set in platform 
> > Makefile fragments (arch/mips/*/Platform) in the absence of the 
> > PHYSICAL_START configuration option.
> 
> This looks correct given the defaults in the Makefile fragments. However
> I presume a 32BIT kernel will produce a 32-bit ELF, in which case the
> result will be indistinguishable? For other kernel image formats which
> always use 64-bit pointers perhaps it matters more (if they can be
> loaded by kexec-tools). uImage is 32-bit ISTR, and our ITB stuff seems
> to only use 32bit addresses for CONFIG_32BIT. I don't now about other
> formats.

 For ELF it does not matter, but as you say $VMLINUX_LOAD_ADDRESS and 
$VMLINUX_ENTRY_ADDRESS is needed for software which does not interpret ELF 
files.  However my interpretation is based solely on source examination 
and the commit description and not actual use of these features.  I assume 
platform Makefile fragments do use 64-bit representation for a reason 
though.

> So unless I hear otherwise I'll probably drop the stable tag and apply
> for 4.17.

 I won't insist on backporting.  After all it's the default only and the 
value can be entered manually if the default does not work.

  Maciej
