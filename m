Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2013 13:50:01 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:23622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867712Ab3JJLty5ALRV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Oct 2013 13:49:54 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ABnnNt029346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 10 Oct 2013 07:49:50 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-105.brq.redhat.com [10.34.1.105])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r9ABnk7s018574;
        Thu, 10 Oct 2013 07:49:48 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Thu, 10 Oct 2013 13:43:17 +0200 (CEST)
Date:   Thu, 10 Oct 2013 13:43:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Anton Arapov <anton@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] UPROBES: Remove useless __weak attribute
Message-ID: <20131010114314.GA24592@redhat.com>
References: <20131009120809.GN1615@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131009120809.GN1615@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 10/09, Ralf Baechle wrote:
>
> <linux/uprobes.h> declares arch_uprobe_skip_sstep() as a weak function.
> But as there is no definition of generic version so when trying to build
> uprobes for an architecture that doesn't yet have a arch_uprobe_skip_sstep()
> implementation, the vmlinux will try to call arch_uprobe_skip_sstep()
> somehwere in Stupidhistan leading to a system crash.  We rather want a
> proper link error so remove arch_uprobe_skip_sstep().
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  include/linux/uprobes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 2a9d75d..cec7397 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -124,7 +124,7 @@ extern int uprobe_post_sstep_notifier(struct pt_regs *regs);
>  extern int uprobe_pre_sstep_notifier(struct pt_regs *regs);
>  extern void uprobe_notify_resume(struct pt_regs *regs);
>  extern bool uprobe_deny_signal(void);
> -extern bool __weak arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_regs *regs);
> +extern bool arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_regs *regs);

Agreed. I'll take this patch, thanks.

Oleg.
