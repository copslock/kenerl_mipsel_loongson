Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 13:07:53 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008163AbbCFMHvxB5hE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 13:07:51 +0100
Date:   Fri, 6 Mar 2015 12:07:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 09/15] MIPS: csrc-ioasic: Implement read_sched_clock
In-Reply-To: <1425517137-26463-10-git-send-email-dengcheng.zhu@imgtec.com>
Message-ID: <alpine.LFD.2.11.1503061128280.15786@eddie.linux-mips.org>
References: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com> <1425517137-26463-10-git-send-email-dengcheng.zhu@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46232
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

On Wed, 4 Mar 2015, Deng-Cheng Zhu wrote:

> Use DEC I/O ASIC's free-running counter for sched_clock source. This
> implementation will give high resolution cputime accounting.
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> ---

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
