Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 20:55:32 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:47057 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816887AbaCFTzax0oiV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Mar 2014 20:55:30 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s26JtFiP021468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 6 Mar 2014 14:55:15 -0500
Received: from madcap2.tricolour.ca (vpn-50-3.rdu2.redhat.com [10.10.50.3])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s26JtB0g006460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 6 Mar 2014 14:55:12 -0500
Date:   Thu, 6 Mar 2014 14:55:10 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com,
        linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/6][RFC] syscall: define syscall_get_arch() for each
 audit-supported arch
Message-ID: <20140306195510.GA16640@madcap2.tricolour.ca>
References: <cover.1393974970.git.rgb@redhat.com>
 <cb88576237b1bc4fc7981200c2c23ae05790db0d.1393974970.git.rgb@redhat.com>
 <531833F0.8080300@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531833F0.8080300@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <rgb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39436
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

On 14/03/06, Markos Chandras wrote:
> Hi Richard,

Hi Markos,

> On 03/05/2014 09:27 PM, Richard Guy Briggs wrote:
> >Each arch that supports audit requires syscall_get_arch() to able to log and
> >identify architecture-dependent syscall numbers.  The information is used in at
> >least two different subsystems, so standardize it in the same call across all
> >arches.
> >
> >Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >
> >---
> >diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> >index 81c8913..41ecde4 100644
> >--- a/arch/mips/include/asm/syscall.h
> >+++ b/arch/mips/include/asm/syscall.h
> >@@ -103,7 +103,7 @@ extern const unsigned long sysn32_call_table[];
> >
> >  static inline int __syscall_get_arch(void)
> >  {
> >-	int arch = EM_MIPS;
> >+	int arch = AUDIT_ARCH_MIPS;
> >  #ifdef CONFIG_64BIT
> >  	arch |=  __AUDIT_ARCH_64BIT;
> >  #endif
> >@@ -113,4 +113,10 @@ static inline int __syscall_get_arch(void)
> >  	return arch;
> >  }
> >
> >+static inline int syscall_get_arch(struct task_struct *task,
> >+				   struct pt_regs *regs)
> >+{
> >+	return __syscall_get_arch();
> >+}
> >+
> >  #endif	/* __ASM_MIPS_SYSCALL_H */
> 
> This is already fixed for MIPS
> 
> http://patchwork.linux-mips.org/patch/6398/
> 
> The code is in linux-next targeting 3.15 as far as I can tell.

Ok, good to see that it is pretty much the same approach.

My patchset is based on 3.13 (as I assume this patch is), so that
conflict will be sorted out once I add to linux-next...

> markos

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
