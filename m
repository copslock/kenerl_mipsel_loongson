Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 17:46:21 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:54608 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097305AbZJHPqP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 17:46:15 +0200
Received: by fxm21 with SMTP id 21so5092634fxm.33
        for <multiple recipients>; Thu, 08 Oct 2009 08:46:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=AODrkPqhsTfduQv0rsiFZk1bC6as9Ar3nXXpednUZ7c=;
        b=v/sz8/klvSizIU3RGylqKkgkriiyRoXxgpk2BKh8WYEkANLKSh/cUuRvZxBQRBxcuy
         vbiEQTN9IiZSPvjgokUaLrMj25mXzpPvscQ/ysuHfMCMzZjfIw/PlMV8wJPcd/xe3An/
         L0GeB5isS2FkmUkj5qdICcIxU0Tr+lDuAiofE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=f3py08J8CdGzvQuzLsy9ocFlqh84t5UzBxS8Xxm6rMLQe8pf1aRRdF5XjgIlCk8Rkq
         eZP/2wwA4TqiTS7a06+wMMnq70tb5IwUxc9FvYdtaLqQa/KBnkE3dF8sh7MWjvjwCLZb
         s8wW4GeRpiHCjgO0nHlh9dJiFb/teTg/6gevw=
Received: by 10.102.160.15 with SMTP id i15mr573573mue.130.1255016768430;
        Thu, 08 Oct 2009 08:46:08 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id j2sm194535mue.16.2009.10.08.08.46.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 08:46:07 -0700 (PDT)
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20091008144230.GA682@linux-mips.org>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
	 <20091008144230.GA682@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 08 Oct 2009 23:46:00 +0800
Message-Id: <1255016760.14496.57.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-08 at 16:42 +0200, Ralf Baechle wrote:
> On Thu, Oct 08, 2009 at 04:57:32PM +0800, Wu Zhangjin wrote:
> 
> > When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
> > laptop, This patch fix it:
> > 
> > if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> > return TRUE, but in reality, if the memory is not continuous, it should
> > be false. for example:
> 
> Hm...  All that pfn_valid() indicates is that a page frame number is valid
> to index a pfn.  That is that a pfn is valid to index the mem_map array.
> 
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
> Are the non-memory parts marked as reserved?
> 
No, so, is that a need to mark them?

Regrads,
	Wu Zhangjin
