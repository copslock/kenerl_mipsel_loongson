Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 13:40:00 +0100 (WEST)
Received: from mail-px0-f173.google.com ([209.85.216.173]:40605 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023016AbZFJMjy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2009 13:39:54 +0100
Received: by pxi3 with SMTP id 3so166040pxi.22
        for <multiple recipients>; Wed, 10 Jun 2009 05:39:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/SJ5kNil9IQG7sI9MPdKBtt+Rh+lYb6xcypvztUr7v0=;
        b=CdFFk43aoqZWWej2rVGgIqG/bSHEwlZTTTNgUbtC8AUPDp4pjx5GXHzokmELB+vR3E
         BwMeQq4kfrK8JXW/T9B112J649eK79yUsUhG8dgCbw37LXp7VQuQmXbMMPOZ2AlJd9n3
         2XUfRZFpmtxnKd2kFzpE2szRpWxkF58k45u7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=vQFGn+AvRtO5sWZzU0NGmVfQOm7NkE0DZsURn/7MTPecZeoxjBNKq/3bHLCEMyjdmV
         Le11sLV0EXea1uLIMHgYUC9vtOSeF+7aWaTRwb393iLZT0kCsZaf7ZYEn9gL9mtqIkJS
         Gjuqn3fx2LnN2WLDiAcX8uQvx6OSNmV+TknZo=
Received: by 10.114.185.12 with SMTP id i12mr2043868waf.16.1244637585962;
        Wed, 10 Jun 2009 05:39:45 -0700 (PDT)
Received: from ?192.168.1.101? ([219.246.59.144])
        by mx.google.com with ESMTPS id m28sm8898020waf.37.2009.06.10.05.39.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 05:39:43 -0700 (PDT)
Subject: Re: [loongson-PATCH-v3 10/25] split the loongson-specific part out
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
In-Reply-To: <20090609175130.GC1287@adriano.hkcable.com.hk>
References: <cover.1244120575.git.wuzj@lemote.com>
	 <cc26466a1817a94314d8e118dfcbe38d55190d62.1244120575.git.wuzj@lemote.com>
	 <20090609175130.GC1287@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 10 Jun 2009 20:39:30 +0800
Message-Id: <1244637570.28989.2.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-06-10 at 01:51 +0800, Zhang Le wrote:
> On 21:05 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> 
> [...]
> 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> 
> [...]
> 
> Two cosmetic change suggestions:
> 
> > +config LOONGSON_SYSTEMS
> 
> To keep it in line with other CPU's, I suggest change LOONGSON_SYSTEMS to
> MACH_LOONGSON. This is really a matter of taste. So take it at your own
> discretion. And don't forget change all occurrences of CONFIG_LOONGSON_SYSTEMS
> to CONFIG_MACH_LOONGSON, too.
> 
> > +	bool "Loongson Based Machines"
> 
> There is no need to use capital letter in based and machines here.

seems better, will applied later :-)

best wishes,
Wu Zhangjin
