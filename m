Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 10:47:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34276 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992400AbdHJIrBlaiGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 10:47:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B2F95D39B987A;
        Thu, 10 Aug 2017 09:46:53 +0100 (IST)
Received: from [10.20.78.47] (10.20.78.47) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 10 Aug 2017
 09:46:55 +0100
Date:   Thu, 10 Aug 2017 09:46:44 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 5/5] MIPS: Allow floating point support to be
 disabled
In-Reply-To: <20170807094132.GA23183@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1708100146580.17596@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706162029030.23046@tp.orcam.me.uk> <20170616202120.18435-1-paul.burton@imgtec.com> <20170807094132.GA23183@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.47]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59473
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

On Mon, 7 Aug 2017, Ralf Baechle wrote:

> Or we simply make the kernel panic when it detects an FPU but has no
> FPU support?

 Why would we want to make the kernel panic in the presence of an optional 
unused hardware component?

 Paul's proposal looks reasonable to me.  If people want to throw away FPU 
support to save on memory, then let them do that.  Just make that depend 
on EMBEDDED or suchlike, so that it's not a decision taken lightly.

  Maciej
