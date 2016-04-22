Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 18:00:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54436 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025160AbcDVQATNhj0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 18:00:19 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 1DFA5C6049AD7;
        Fri, 22 Apr 2016 17:00:10 +0100 (IST)
Received: from [10.20.78.30] (10.20.78.30) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 22 Apr 2016
 17:00:12 +0100
Date:   Fri, 22 Apr 2016 17:00:03 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "stable # v4 . 0+" <stable@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Disable preemption during prctl(PR_SET_FP_MODE,
 ...)
In-Reply-To: <1461239038-19991-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1604221659110.21846@tp.orcam.me.uk>
References: <1461239038-19991-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.30]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53210
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

On Thu, 21 Apr 2016, Paul Burton wrote:

> Whilst a PR_SET_FP_MODE prctl is performed there are decisions made
> based upon whether the task is executing on the current CPU. This may
> change if we're preempted, so disable preemption to avoid such changes
> for the lifetime of the mode switch.

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

 Thanks!

  Maciej
