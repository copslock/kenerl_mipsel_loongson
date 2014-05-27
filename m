Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 06:50:54 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:51977 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822096AbaE0EuwElMdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 06:50:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s4R4oflI008926
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 26 May 2014 21:50:41 -0700 (PDT)
Received: from localhost (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.169.1; Mon, 26 May
 2014 21:50:40 -0700
Date:   Tue, 27 May 2014 12:50:38 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     Li Zefan <lizefan@huawei.com>
CC:     <ralf@linux-mips.org>, <huawei.libin@huawei.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140527045038.GB16193@pek-yzhang-d1>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
 <5384119E.7010606@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5384119E.7010606@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.162.188]
Return-Path: <yong.zhang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
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

BTW, I realy don't care who credits the patch and Ralf said that
he will applied the one which moves the place of udelay_val.

Anyway, if your company pays you more money if you contribute to
the community, just take it and talk about it with Ralf ;-)

Thanks,
Yong

On Tue, May 27, 2014 at 12:16:30PM +0800, Li Zefan wrote:
> I'm not quite happy about what happaned here. There's a story behind
> this patch.
> 
> One of our Huawei product encountered a bug, and they're using WindRiver4,
> so the kernel is 2.6.34.
> 
> Because they bought your licnece, they asked for your help, but
> you were reluctant on this issue, and the problem remained there
> for about one month.
> 
> At last they turned to us for help. We're the kernel department in
> Huawei, but maintaining this product kernel isn't our job. Still
> Li Bin devoted his time to analyzing this bug, and he did a great
> job.
> 
> Li Bin told the product team what was wrong and was about to send
> a fix for upstream kernel. They told you our analysis for further
> confirmation, and you were so reluctant to help but so quick to
> send the fix.
> 
> Li Bin never reported this bug, but he fixed it. It's a shame that
> you took the credit from us.
> 
> On 2014/5/21 13:36, Yong Zhang wrote:
> > asid_cache must be unsigned long otherwise on 64bit system
> > it will become 0 if the value in get_new_mmu_context()
> > reaches 0xffffffff and in the end the assumption of
> > ASID_FIRST_VERSION is not true anymore thus leads to
> > more dangerous things.
> > 
> 
> We should describe what problem this bug can lead to, which
> will help people who encounter the same problem and google it.
> 
> > Reported-by: libin <huawei.libin@huawei.com>
> > Signed-off-by: Yong Zhang <yong.zhang@windriver.com>
> 
> Should mark the patch for stable trees. Though 2.6.34 is EOL,
> the fix should be backported to other kernels.
> 
> > ---
> > 
> > V2<-V1: Add the reporter.
> > 
> >  arch/mips/include/asm/cpu-info.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> > index f6299be..ebcc2ed 100644
> > --- a/arch/mips/include/asm/cpu-info.h
> > +++ b/arch/mips/include/asm/cpu-info.h
> > @@ -40,7 +40,7 @@ struct cache_desc {
> >  
> >  struct cpuinfo_mips {
> >  	unsigned int		udelay_val;
> > -	unsigned int		asid_cache;
> > +	unsigned long		asid_cache;
> >  
> >  	/*
> >  	 * Capability and feature descriptor structure for MIPS CPU
> > 
