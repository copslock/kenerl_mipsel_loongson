Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 03:42:18 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27026727AbbEPBmQUeEo1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 03:42:16 +0200
Date:   Sat, 16 May 2015 02:42:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: cpu: Alter MIPS_CPU_* definitions to fill
 gap
In-Reply-To: <20150515191443.GF2322@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505160204280.4923@eddie.linux-mips.org>
References: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com> <1431530234-32460-2-git-send-email-james.hogan@imgtec.com> <20150515191443.GF2322@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47429
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

On Fri, 15 May 2015, Ralf Baechle wrote:

> After solving the include ordering issue, that is ...

 I think the issue just means these generic BIT* macros (and GENMASK* too) 
belong to a header that does not rely on machine dependencies.  And quite 
possibly one that has no C code at all as they would be useful, in a 
variant appropriately defined, for assembly code too (e.g. to replace 
stuff in <asm/mipsregs.h> where we have `(_ULCAST_(1) << 0)', etc.).

 Putting them back to <linux/types.h> where some of them originally came 
from with d05be13b might be one option.

  Maciej
