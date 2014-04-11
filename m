Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 04:43:52 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:4095 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816288AbaDKCnqIGWli (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Apr 2014 04:43:46 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3B2hclL029807
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Apr 2014 22:43:38 -0400
Received: from madcap2.tricolour.ca (vpn-49-44.rdu2.redhat.com [10.10.49.44])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3B2hYDV014302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 10 Apr 2014 22:43:36 -0400
Date:   Thu, 10 Apr 2014 22:43:34 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        markos.chandras@imgtec.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: use current instead of task in syscall_get_arch
Message-ID: <20140411024334.GD24821@madcap2.tricolour.ca>
References: <1397183132-16528-1-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397183132-16528-1-git-send-email-eparis@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <rgb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rgb@redhat.com
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

On 14/04/10, Eric Paris wrote:
> In commit 6e345746 Markos started using task to determine 64bit vs
> 32bit instead of it being completely CONFIG based.
> 
> In commit 5e937a9a we dropped the 'task' argument to syscall_get_arch()
> across the entire system.
> 
> This obviously results in a build failure when Linus's and the audit
> tree were merged.  This patch should be applied as part of the merge
> conflict, as both sides of the merge are correct and the failure happens
> AT the merge.
> 
> The fix is simple.  The task is always current.  Use current.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Cc: markos.chandras@imgtec.com
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: linux-mips@linux-mips.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  arch/mips/include/asm/syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index d79cded..1258884 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -131,7 +131,7 @@ static inline int syscall_get_arch(void)
>  {
>  	int arch = EM_MIPS;
>  #ifdef CONFIG_64BIT
> -	if (!test_tsk_thread_flag(task, TIF_32BIT_REGS))
> +	if (!test_tsk_thread_flag(current, TIF_32BIT_REGS))
>  		arch |= __AUDIT_ARCH_64BIT;
>  #endif
>  #if defined(__LITTLE_ENDIAN)
> -- 
> 1.9.0

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
