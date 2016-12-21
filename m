Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2016 13:13:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23410 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992703AbcLUMNp5nCFz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Dec 2016 13:13:45 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9FCD4B15B958D;
        Wed, 21 Dec 2016 12:13:37 +0000 (GMT)
Received: from [10.20.78.44] (10.20.78.44) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 21 Dec 2016
 12:13:39 +0000
Date:   Wed, 21 Dec 2016 12:13:28 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v3 3/5] MIPS: Only change $28 to thread_info if coming
 from user mode
In-Reply-To: <1482157260-18730-4-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.00.1612211212140.6743@tp.orcam.me.uk>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com> <1482157260-18730-4-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.44]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56111
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

On Mon, 19 Dec 2016, Matt Redfearn wrote:

> Changes in v3:
> Drop superfluous nop that would have been in delay slot with .set
> noreorder but is no longer required now that the code is .set reorder.

LGTM

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
