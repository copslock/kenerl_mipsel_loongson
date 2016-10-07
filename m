Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 17:23:24 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:17659 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992226AbcJGPXOBayAE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 17:23:14 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id A2D04EB6F2DE4;
        Fri,  7 Oct 2016 16:23:04 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Oct 2016
 16:23:08 +0100
Received: from [10.20.78.81] (10.20.78.81) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 7 Oct 2016
 16:23:06 +0100
Date:   Fri, 7 Oct 2016 16:22:59 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: VDSO: Drop duplicated -I*/-E* aflags
In-Reply-To: <21016db2fc628c73bc6efa1530ebeb866a30d6ae.1475832139.git-series.james.hogan@imgtec.com>
Message-ID: <alpine.DEB.2.00.1610071622400.31859@tp.orcam.me.uk>
References: <21016db2fc628c73bc6efa1530ebeb866a30d6ae.1475832139.git-series.james.hogan@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.81]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 7 Oct 2016, James Hogan wrote:

> The aflags-vdso is based on ccflags-vdso, which already contains the -I*
> and -EL/-EB flags from KBUILD_CFLAGS, but those flags are needlessly
> added again to aflags-vdso.
> 
> Drop the duplication.
> 
> Reported-by: Maciej W. Rozycki <macro@imgtec.com>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
