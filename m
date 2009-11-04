Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 16:17:05 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:37744 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492399AbZKDPQ6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 16:16:58 +0100
Received: by ewy12 with SMTP id 12so1820770ewy.0
        for <multiple recipients>; Wed, 04 Nov 2009 07:16:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=uPMiYkTdkl/bcsbqmGdJ4svWR1DrMHF05znDJbFE0n0=;
        b=UtPpQb4DM0LuGyH89CV/trUAR/MQ898DJDxexDNObvlrlu5zaU2/cAhLSufgPalCBB
         K8QwKoYEe/V/OyMG4NbTjOpgeXlfdMUXHs3669q047aCOG86DlbsxgP0i+lh1zWR47Wa
         3hVRmJjQAWCA/CgyufgMRTbYSbDyqyczUreYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=X65MgGcuFV1iA73nwyA2+dtzzpK7nUAiIg5lN9+v+1vB2v2OSZalswDGiZLVS0cRhM
         /kQRX3F+UL9zgRk76/ABBUabfLull1NjKyTebpIna5RLxCVA2lFGqqacfxd9h1QTnCmZ
         m6faFwaf8r0w6gfM5Gtg45wskpcjWqoIor7Rs=
Received: by 10.216.93.12 with SMTP id k12mr484165wef.195.1257347813157;
        Wed, 04 Nov 2009 07:16:53 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id u14sm3429709gvf.18.2009.11.04.07.16.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 07:16:52 -0800 (PST)
Subject: Re: [PATCH -queue v0 5/6] [loongson] rtc: enable legacy RTC driver
 on fuloong2f
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <20091104141545.GA18408@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <e13ed33a99dbf14f223360d414aa2b2c5caa9b1f.1257325319.git.wuzhangjin@gmail.com>
	 <m3eioetvx5.fsf@anduin.mandriva.com>
	 <1257333527.8716.20.camel@falcon.domain.org>
	 <20091104141545.GA18408@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 04 Nov 2009 23:12:59 +0800
Message-ID: <1257347585.16033.0.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-04 at 15:15 +0100, Ralf Baechle wrote:
> On Wed, Nov 04, 2009 at 07:18:47PM +0800, Wu Zhangjin wrote:
> 
> > In reality, fuloong2e, fuloong2f and yeeloong2f work fine with RTC_LIB,
> > but relative patches need to append to drivers/rtc/rtc-cmos.c and also
> > need a RTC platform device. If what I remembered is right, Gdium also
> > need corresponding patches to make it work with RTC_LIB.
> > 
> > Herein, I just let the basic support for those machines work, and then,
> > the RTC_LIB support will be sent out later.
> > 
> > and a small question: if legacy RTC driver works well on these machines,
> > why should we forbid people to use it? I think it's better to remove the
> > "select RTC_LIB" line for MIPS, and then, the people will be free to
> > choose what they want, and even for the users whose platform not support
> > RTC_LIB.
> 
> RTC_LIB is the way to go; the non-RTC_LIB drivers are there only for
> backward compatbility.  A grep through the defcconfig files for all
> platforms on all architectures finds that by now all have set
> CONFIG_RTC_LIB and the remaining users of CONFIG_RTC, CONFIG_JS_RTC,
> CONFIG_GEN_RTC, CONFIG_EFI_RTC, CONFIG_DS1302 (which all depend on !RTC_LIB)
> are all defconfig files which seem to be slowly bitrotting.
> 
> Time to axe !RTC_LIB?  I'm tempted.
> 

Okay, later, I will send the patches for RTC_LIB support asap, I'm
testing it currently ;)

Regards,
	Wu Zhangjin
