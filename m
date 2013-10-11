Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Oct 2013 02:51:44 +0200 (CEST)
Received: from e7.ny.us.ibm.com ([32.97.182.137]:40981 "EHLO e7.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JKAvlxSuOC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Oct 2013 02:51:41 +0200
Received: from /spool/local
        by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 10 Oct 2013 20:51:35 -0400
Received: from d01dlp02.pok.ibm.com (9.56.250.167)
        by e7.ny.us.ibm.com (192.168.1.107) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 10 Oct 2013 20:51:34 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9F0846E8041;
        Thu, 10 Oct 2013 20:51:32 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
        by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r9B0pXOw63701036;
        Fri, 11 Oct 2013 00:51:33 GMT
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
        by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r9B0pVf6007588;
        Thu, 10 Oct 2013 20:51:32 -0400
Received: from kernel.stglabs.ibm.com (kernel.stglabs.ibm.com [9.114.214.19])
        by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id r9B0pVOw007576;
        Thu, 10 Oct 2013 20:51:31 -0400
Received: from linux.vnet.ibm.com (srdronam.in.ibm.com [9.124.31.34])
        by kernel.stglabs.ibm.com (Postfix) with SMTP id D705C2401E8;
        Thu, 10 Oct 2013 17:51:29 -0700 (PDT)
Date:   Fri, 11 Oct 2013 06:21:28 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Anton Arapov <anton@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] UPROBES: Remove useless __weak attribute
Message-ID: <20131011005128.GA2199@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20131009120809.GN1615@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20131009120809.GN1615@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: No
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13101100-5806-0000-0000-000023071E56
Return-Path: <srikar@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srikar@linux.vnet.ibm.com
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

* Ralf Baechle <ralf@linux-mips.org> [2013-10-09 14:08:09]:

> <linux/uprobes.h> declares arch_uprobe_skip_sstep() as a weak function.
> But as there is no definition of generic version so when trying to build
> uprobes for an architecture that doesn't yet have a arch_uprobe_skip_sstep()
> implementation, the vmlinux will try to call arch_uprobe_skip_sstep()
> somehwere in Stupidhistan leading to a system crash.  We rather want a
> proper link error so remove arch_uprobe_skip_sstep().
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Will be nice to have another arch(mips) support for uprobes. 

-- 
Thanks and Regards
Srikar Dronamraju
