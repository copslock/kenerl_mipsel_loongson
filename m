Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 03:46:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35759 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab0JRBqS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 03:46:18 +0200
Date:   Mon, 18 Oct 2010 02:46:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] LD/SD o32 macro GAS fix update
In-Reply-To: <alpine.LFD.2.00.1010101008240.15889@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.00.1010180243140.15889@eddie.linux-mips.org>
References: <alpine.LFD.2.00.1010101008240.15889@eddie.linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 10 Oct 2010, Maciej W. Rozycki wrote:

>  I am about to commit:
> 
> http://sourceware.org/ml/binutils/2010-10/msg00033.html
[...]
> ---
>  Ralf: please apply, including any relevand maintenance branches.  Note I 
> have not tested this change; I have no resources to do so at the moment, 
> sorry.
> 
>  Platform maintainers: please audit your code for any other places that 
> may require such a change.  Note only LD/SD macros are affected, other 
> 64-bit intructions are fine, including LLD/SCD that are not macros on o32 
> (barring any complex address calculations required for modes not directly 
> supported by hardware).

 For the record -- the change has now been applied and will be included in 
binutils 2.21 (which has been scheduled to branch for a while now, but the 
flood of recent fixes seems to have stalled it).

  Maciej
