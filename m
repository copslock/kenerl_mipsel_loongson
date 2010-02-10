Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:56:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46245 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492412Ab0BJX4y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2010 00:56:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1ANupEW007981;
        Thu, 11 Feb 2010 00:56:52 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1ANuoPG007979;
        Thu, 11 Feb 2010 00:56:50 +0100
Date:   Thu, 11 Feb 2010 00:56:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/6] MIPS Read Inhibit/eXecute Inhibit support (v2).
Message-ID: <20100210235649.GA7975@linux-mips.org>
References: <4B733C71.8030304@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B733C71.8030304@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 10, 2010 at 03:08:33PM -0800, David Daney wrote:

> This patch set adds execute and read inhibit support.  By default glibc
> based tool chains will create mappings for data areas of a program and
> shared libraries with PROT_EXEC cleared.  With this patch applied, a
> SIGSEGV is correctly sent if an attempt is made to execute from data
> areas.
> 
> The first three patch just make a few tweaks in preperation for the
> main body of the patch in 4/6.  The last two turn on the feature for
> some Octeon CPUs.
> 
> I will reply with the six patches.
> 
> David Daney (6):
>   MIPS: Use 64-bit stores to c0_entrylo on 64-bit kernels.
>   MIPS: Add accessor functions and bit definitions for c0_PageGrain
>   MIPS: Add TLBR and ROTR to uasm.
>   MIPS: Implement Read Inhibit/eXecute Inhibit
>   MIPS: Give Octeon+ CPUs their own cputype.
>   MIPS: Enable Read Inhibit/eXecute Inhibit for Octeon+ CPUs

Hangs on IP27 after

[...]
Calibrating delay loop... 178.17 BogoMIPS (lpj=89088)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)

  Ralf
