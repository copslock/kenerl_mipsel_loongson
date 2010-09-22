Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 13:38:46 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:48235 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491112Ab0IVLin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 13:38:43 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1002)
        id 6848B4432F; Wed, 22 Sep 2010 12:38:40 +0100 (BST)
Received: from localhost (87-194-181-196.bethere.co.uk [87.194.181.196])
        by arkanian.console-pimps.org (Postfix) with ESMTPSA id 1099B4432D;
        Wed, 22 Sep 2010 12:38:40 +0100 (BST)
Date:   Wed, 22 Sep 2010 12:38:39 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH v6 3/7] MIPS: add support for software performance
 events
Message-ID: <20100922113839.GA6392@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
 <1276058130-25851-4-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276058130-25851-4-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17153

On Wed, Jun 09, 2010 at 12:35:26PM +0800, Deng-Cheng Zhu wrote:
> Software events are required as part of the measurable stuff by the
> Linux performance counter subsystem. Here is the list of events added by
> this patch:
> PERF_COUNT_SW_PAGE_FAULTS
> PERF_COUNT_SW_PAGE_FAULTS_MIN
> PERF_COUNT_SW_PAGE_FAULTS_MAJ
> PERF_COUNT_SW_ALIGNMENT_FAULTS
> PERF_COUNT_SW_EMULATION_FAULTS
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>

This looks OK.

Reviewed-by: Matt Fleming <matt@console-pimps.org>
