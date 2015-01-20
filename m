Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 02:07:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42635 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011913AbbATBHtuFaTa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 02:07:49 +0100
Date:   Tue, 20 Jan 2015 01:07:49 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 26/70] MIPS: kernel: cpu-bugs64: Do not check R6
 cores for existing 64-bit bugs
In-Reply-To: <1421405389-15512-27-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501200105220.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-27-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45345
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> The current HW bugs checked in cpu-bugs64, do not apply to R6 cores
> and they cause compilation problems due to removed <R6 instructions,
> so do not check for them for the time being.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---

Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>

We might even want to limit these errata checks further, to reduce code 
size for people who won't ever care.  No need to rush doing that though.

  Maciej
