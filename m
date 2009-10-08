Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 12:34:03 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:45944 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492310AbZJHKd4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 12:33:56 +0200
Received: by pxi17 with SMTP id 17so7273191pxi.21
        for <multiple recipients>; Thu, 08 Oct 2009 03:33:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=J8Y0m7IEIhdTS0vmg+9+3PRr8T3OIAi7C3LXq+WLQkc=;
        b=Z+jOsvMgzvPxyq66RxgyQ50iJSu8lfdjQSATeSyuAiwDLGZn1Oly7GJSDz5kbaVr90
         w9gHE1+E8CwONP6dD7IFCe8smXG6jw5yLJIKERY/UfYw49fEQRgKZ6qFVrbf+wuOX0nr
         x6zc9RmAHiXoJggjdj7fPjT7l47fkplCEJM3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=naRoLjPCigywHnMId7bWW8DBENr22Gu5knMV1Cxe3nQmyfdLtxgn2hjOc5fpxyivgf
         3lj7YrpzhSI0VPvaJhxh7hlE1UX942zWPhFpC+xctCKnR8dXKc7qNLbQi8NgMqsA5daI
         q/QEjKF554XY/dAn3xKBP6MUAHDwhed2+VUbE=
Received: by 10.114.237.37 with SMTP id k37mr1962454wah.31.1254998029156;
        Thu, 08 Oct 2009 03:33:49 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm31185pxi.9.2009.10.08.03.33.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 03:33:48 -0700 (PDT)
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Pavel Machek <pavel@ucw.cz>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20091008092903.GA27054@elf.ucw.cz>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
	 <20091008092903.GA27054@elf.ucw.cz>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 08 Oct 2009 18:33:39 +0800
Message-Id: <1254998019.14496.21.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 2009-10-08 at 11:29 +0200, Pavel Machek wrote:
> On Thu 2009-10-08 16:57:32, Wu Zhangjin wrote:
> > When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
> > laptop, This patch fix it:
> > 
> > if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> > return TRUE, but in reality, if the memory is not continuous, it should
> > be false. for example:
> > 
> > $ cat /proc/iomem | grep "System RAM"
> > 00000000-0fffffff : System RAM
> > 90000000-bfffffff : System RAM
> > 
> > as we can see, it is not continuous, so, some of the memory is not valid
> > but regarded as valid by pfn_valid(), and at last make STD/Hibernate
> > fail when shrinking a too large number of invalid memory.
> > 
> > Here, we fix it via checking pfn is in the "System RAM" or not, if yes,
> > return TRUE.
> 
> "return FALSE"?
> 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Looks mostly ok, small comments below. 
> 
> > @@ -168,13 +168,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> >  
> >  #ifdef CONFIG_FLATMEM
> >  
> > -#define pfn_valid(pfn)							\
> > -({									\
> > -	unsigned long __pfn = (pfn);					\
> > -	/* avoid <linux/bootmem.h> include hell */			\
> > -	extern unsigned long min_low_pfn;				\
> > -									\
> > -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> > +#define pfn_valid(pfn)				\
> > +({						\
> > +	extern int is_pfn_valid(unsigned long); \
> > +	is_pfn_valid(pfn);			\
> >  })
> 
> "extern int pfn_valid here"
> 
> ...and get away without the ugly macro?
> 

Perhaps need to move the whole "#ifdef CONFIG_FLATMEM" to #ifndef
ASSEMBLY, otherwise,

"arch/mips/include/asm/page.h:170: Error: unrecognized opcode `extern
int pfn_valid(unsigned long)'". 

Regards,
	Wu Zhangjin
