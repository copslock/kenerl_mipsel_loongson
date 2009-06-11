Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 17:24:17 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:45187 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492286AbZFKPYL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2009 17:24:11 +0200
Received: by pzk35 with SMTP id 35so80657pzk.22
        for <multiple recipients>; Thu, 11 Jun 2009 08:24:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=6srUrnNQRV7a7nCW6yCN41Agu6I9jZYaYsLoc81Gtjw=;
        b=HptKQ4+EhFS14co1VYtUNxaQaXwo/KTt8pg5HaOFfGyqAHLWhLQj1S0pWD7QBw8DXl
         w63w/gjrOWsWBXwZoBq2Xpai4q72nLkc00yShpiYZz8hYEBmFaRTljv4YfIAxB0J/S16
         54awlJAZukXaZsI9uIicOpm7pGzRHbV+xuTEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=pqkMp4cscCcQAhKbk2k8R2vfKsvHu2uQfd1eYt0qXvCRFJ6rApdFDP4sgjrCAuEErR
         nWxGRcLXzJVLn0xHyyAJ4pPMuJ+qqzQi7BJj7AVcRCpflH0PCfWgvYxtOVpPMvZJ1FZh
         Zl1UflBo7huCZPP72SrgZ2nfVx+Hb57u4crD8=
Received: by 10.114.106.13 with SMTP id e13mr4193736wac.87.1244733422373;
        Thu, 11 Jun 2009 08:17:02 -0700 (PDT)
Received: from ?192.168.1.103? ([219.246.59.144])
        by mx.google.com with ESMTPS id j15sm122239waf.16.2009.06.11.08.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 08:17:01 -0700 (PDT)
Subject: Re: [loongson-dev] Re: [loongson-PATCH-v3 17/25] add a machtype
 kernel command line argument
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
In-Reply-To: <20090611110914.GB20906@adriano.hkcable.com.hk>
References: <cover.1244120575.git.wuzj@lemote.com>
	 <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
	 <20090610154032.GB21877@adriano.hkcable.com.hk>
	 <20090610203123.GA20906@adriano.hkcable.com.hk>
	 <20090611110914.GB20906@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 11 Jun 2009 23:16:55 +0800
Message-Id: <1244733415.10475.67.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-06-11 at 19:09 +0800, Zhang Le wrote:
> On 04:31 Thu 11 Jun     , Zhang Le wrote:
> 
> [...]
> 
> > 
> > diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
> > index d469dc7..34417cf 100644
> > --- a/arch/mips/loongson/common/machtype.c
> > +++ b/arch/mips/loongson/common/machtype.c
> 
> [...]
> 
> > -static __init int machname_setup(char *str)
> > +static __init int machtype_setup(char *str)
> 
> [...]
> 
> > -	for (index = 0;
> > -	     index < MACHTYPE_TOTAL;
> > -	     index++) {
> > -		if (strstr(str, machname[index]) != NULL) {
> > -			mips_machtype = index;
> > -			return 0;
> > +	for (; system_types[machtype]; machtype++)
> > +		if (strstr(str, system_types[machtype])) {
> 
> There is a problem here.
> 
> Because I have used "inches" instead of "inch" in system_types, if you insist
> on using "inch" when passing value to the machtype kernel parameter, this
> strstr() call's two parameters should be swapped:
> 
>              if (strstr(system_types[machtype], str)) {
> 

Acked.

thanks!
Wu Zhangjin

> 
> > +			mips_machtype = machtype;
> > +			break;
> >  		}
> > -	}
> > -	return -1;
> > +	return 0;
> >  }
> >  
> > -__setup("machtype=", machname_setup);
> > +__setup("machtype=", machtype_setup);
> 
> 
