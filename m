Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 15:50:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16169 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993893AbdAZOt5Vpbl7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2017 15:49:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id CD9C3B859CAB2;
        Thu, 26 Jan 2017 14:49:47 +0000 (GMT)
Received: from [10.20.78.21] (10.20.78.21) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 26 Jan 2017
 14:49:50 +0000
Date:   Thu, 26 Jan 2017 14:49:40 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Robert Schiele <rschiele@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: vdso: Explicitly use
 -fno-asynchronous-unwind-tables
In-Reply-To: <20170126143408.2456-1-alexander.sverdlin@nokia.com>
Message-ID: <alpine.DEB.2.00.1701261445520.13564@tp.orcam.me.uk>
References: <20170126143408.2456-1-alexander.sverdlin@nokia.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.21]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56516
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

On Thu, 26 Jan 2017, Alexander Sverdlin wrote:

> Not every toolchain has -fno-asynchronous-unwind-tables per default on MIPS.
> This patch specifies the necessary option explicitly for VDSO library build.

 It looks reasonable to me, but you need to wrap it into `$(call 
cc-option,...)' as older compilers didn't have this option.

  Maciej
