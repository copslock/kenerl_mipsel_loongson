Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 17:41:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56274 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823049Ab3FTPk7gdQHJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 17:40:59 +0200
Date:   Thu, 20 Jun 2013 16:40:59 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH UPDATED 4/4] MIPS: Move definition of SMP processor id
 register to header file
In-Reply-To: <20130620144821.GB30061@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1306201630180.29828@linux-mips.org>
References: <1370965298-29210-4-git-send-email-jchandra@broadcom.com> <1371559516-4862-1-git-send-email-jchandra@broadcom.com> <1371559516-4862-2-git-send-email-jchandra@broadcom.com> <20130620144821.GB30061@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 20 Jun 2013, Ralf Baechle wrote:

> So I've removed it again for now.
> 
> Maciej, I wonder why does gas in MIPS III/IV mode accept
> 
> 	dmfc0	$reg1, $cp0reg
> 
> but not
> 
> 	dmfc0	$reg1, $cp0reg, 0
> 
> The generated code is the same after all.  Same for MIPS I/II mode and 
> mfc0.

 The <sel> operand and instruction field was only added to these 
instructions with the MIPS64 ISA (MIPS32 ISA for MFC0/MTC0).  Previously 
processors did not decode this field and consequently the assembler 
notation only supports two operands.

 Since AFAICT the offending pieces are macros I suggest simply dumping the 
redundant ", 0" part, the two-argument form is as you've observed 
equivalent.

  Maciej
