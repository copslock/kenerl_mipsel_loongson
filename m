Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 03:43:27 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:51583 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493545AbZKJCnU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2009 03:43:20 +0100
Received: by yxe42 with SMTP id 42so5103247yxe.22
        for <multiple recipients>; Mon, 09 Nov 2009 18:43:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=pAiz+jCppXZg2skRSoBo6qiDtldoZUqRDlQmMOg0Stw=;
        b=llpKhIFzpmtmbMFoyX5oliymNfGMszVLoKBc94Yl7pqxvPT0DqcLUfhZ+59mN+tiFr
         cxlo2h7Fbcv3+RSb2fKZS65+rkt2xLno4eEf9UNzx9gHYJg03LlmUorHrW1UsmQ/t26r
         ETx8fa6DLOZCCjeB13PIeJQudiksUNCXteH2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=mInCEjbTzQPFlV0cy14rJlHwZkyyqouGac7ah7ylq+Sthk7tPTDZLBmLecKW+coA+B
         f0oJD9PD9V3+oIXvkd/0L1m44L35oBeQGSByZGIh3eL+S/yeALAGm7FqqjQeBzZN//aH
         39ExOm6QZ2cyHZDk8tEpxvHChoCTlzPnRzN5U=
Received: by 10.150.21.22 with SMTP id 22mr1734650ybu.36.1257820987375;
        Mon, 09 Nov 2009 18:43:07 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm123028ywh.48.2009.11.09.18.42.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 18:43:06 -0800 (PST)
Subject: Re: [PATCH v7 17/17] tracing: make function graph tracer work with
 -mmcount-ra-address
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
In-Reply-To: <4AF898E9.3050506@caviumnetworks.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <3a9fc9ca02e8e6e9c3c28797a4c084c1f9d91f69.1257779502.git.wuzhangjin@gmail.com>
	 <0cef783a71333ff96a78aaea8961e3b6b5392665.1257779502.git.wuzhangjin@gmail.com>
	 <18e1d617ed824bb1c10f15216f2ed9ed3de78abd.1257779502.git.wuzhangjin@gmail.com>
	 <3da916c1cb6e05445438826f98a91111f43ff6cd.1257779502.git.wuzhangjin@gmail.com>
	 <d4aa4cdb9b4c25e7a683c923bdeabed847bd8010.1257779502.git.wuzhangjin@gmail.com>
	 <451c55dead5d6afd871de6afd14dbbcf70a0f834.1257779502.git.wuzhangjin@gmail.com>
	 <0c463e2af521e613fd15751a9f610c74cf887292.1257779502.git.wuzhangjin@gmail.com>
	 <695747bff7cddb97d6f43c05c4cf05eb269e402d.1257779502.git.wuzhangjin@gmail.com>
	 <406a8e5e3117737e401bb2bba84ad9b17f99857d.1257779502.git.wuzhangjin@gmail.com>
	 <ceef672f082971118c472d1c079d49762ae43b38.1257779502.git.wuzhangjin@gmail.com>
	 <2113f5f0165feac8cf58c156946adff776f9056d.1257779502.git.wuzhangjin@gmail.com>
	 <4AF898E9.3050506@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 10 Nov 2009 10:42:57 +0800
Message-ID: <1257820977.2822.32.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-09 at 14:34 -0800, David Daney wrote:
> Wu Zhangjin wrote:
> [...]
> > +	cflags-y += $(call cc-option, -mmcount-ra-address)
> [...]
> > +#if (__GNUC__ <= 4 && __GNUC_MINOR__ < 5)
> 
> 
> 
> Sprinkling the code with these #if clauses is ugly and prone to breakage 
> I think.
> 
> The Makefile part is testing for the same feature.
> 
> We do a very similar thing with -msym32, and KBUILD_SYM32.  Perhaps you 
> could rework this patch in a similar manner and test for 
> KBUILD_MCOUNT_RA_ADDRESS instead of the '(__GNUC__ <= 4 && 
> __GNUC_MINOR__ < 5)'
> 

This is really ugly ;)

KBUILD_MCOUNT_RA_ADDRESS is a wonderful idea, thanks!

Regards,
	Wu Zhangjin
