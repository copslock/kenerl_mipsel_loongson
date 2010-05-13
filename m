Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2010 03:35:31 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:46229 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492355Ab0EMBf1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 May 2010 03:35:27 +0200
Received: by pzk32 with SMTP id 32so442678pzk.21
        for <multiple recipients>; Wed, 12 May 2010 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=321kclP9O9qC5VvQDjIcvr0ltnh0POgtbAi5oDnxUr8=;
        b=C9pzJC09w//A7/GJIX8zzaZvTOE0Q6aKhCBSaL4RtRR7E+Bu2PdGjpsEpdrvfzJLUa
         8/1tzOR/DkU9QA51PazAQlbbxMfFnVxq8KGA+D70faOLIvFHChit9Geh2si+R0dOHHmZ
         oQZY11OwvzEiAq9B2xoeejIHYUM3d0whZL5yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=k2ZJu9rE+zJ5+S4BYImLdqohfzlec9BejPCQUCE1aXIMkM2EzDHjQl/ACttd7uY2ic
         58m25g0YZuw7RtzNJgzM5oMP0eAsPmCM+6pb20dwfK5xSzN3xMny1jUD8Pd6KZsX9gB2
         5YFAi8bqs4lgBTemw8tpq0DpeCFieFtb5qPmk=
Received: by 10.114.33.33 with SMTP id g33mr6584896wag.104.1273714517547;
        Wed, 12 May 2010 18:35:17 -0700 (PDT)
Received: from [192.168.2.222] ([202.201.14.140])
        by mx.google.com with ESMTPS id n32sm6036710wae.22.2010.05.12.18.35.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 18:35:16 -0700 (PDT)
Subject: Re: [PATCH 2/9] tracing: MIPS: mcount.S: Fixup of the 32bit
 support with gcc 4.5
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <david.s.daney@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <4BEAE260.9060805@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
         <fd8a13e37a33c1075da184f4fe92b0d9afc51c09.1273669419.git.wuzhangjin@gmail.com>
         <4BEAE260.9060805@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 13 May 2010 09:35:11 +0800
Message-ID: <1273714511.26290.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-05-12 at 10:16 -0700, David Daney wrote:
> On 05/12/2010 06:23 AM, Wu Zhangjin wrote:
> > From: Wu Zhangjin<wuzhangjin@gmail.com>
> >
> > As the doc[1] of gcc-4.5 shows, the -mmcount-ra-address uses register
> > $12 to transfer the stack offset of the return address to the _mcount
> > function. in 64bit kernel, $12 is t0, but in 32bit kernel, it is t4, so,
> > we need to use $12 instead of t0 here to cover the 64bit and 32bit
> > support.
> >
> > [1] Gcc doc: MIPS Options
> > http://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html
> >
> > Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> 
> Would it be better to do?:
> 
> #define MCOUNT_RA_ADDRESS_REG $12
> 
> s/t0/MCOUNT_RA_ADDRESS_REG/g

Good idea, will change it later.

Regards,
	Wu Zhangjin
