Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 18:41:48 +0100 (CET)
Received: from mail-pz0-f183.google.com ([209.85.222.183]:58746 "EHLO
        mail-pz0-f183.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492428Ab0BZRlp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 18:41:45 +0100
Received: by pzk13 with SMTP id 13so197845pzk.26
        for <multiple recipients>; Fri, 26 Feb 2010 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=LzPlQlayiNVPkVRy3YPcolNiiYI4KqwG9Zh3hQhRxlU=;
        b=LgOAl5cP7hmCuLJIiMan1oEUPWzMTPmHTMKRVDxPuDq9tsLmW3UW+pOBRuOGXhHcIc
         1FRIxwfH6y9yoUZSUVI3IwVivb34S9rDNQJk98mokyTJzdBrgJu/nJztNFyjP7zyP/lx
         +OL2ctZuaE5PU47aR8rvQiDsHXsd6q64W94UI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=eirHdmqGIKITYuqKw+7V+GDZDp1u/rP+KWyu2eayCpBPNUo6GqZ+D5NIhDU2vkyo6M
         GToS/d/uC1jyaBjZjEF70OBamdDYpcaXh/nRI4hgG6MSM/GP5v96pmuaDAFIqUqmajOb
         AioGLv3G2m+KzTOaAbkfC56nkwup58ujdQ0Ic=
Received: by 10.115.65.23 with SMTP id s23mr391517wak.190.1267206096501;
        Fri, 26 Feb 2010 09:41:36 -0800 (PST)
Received: from ?192.168.1.108? ([219.246.59.52])
        by mx.google.com with ESMTPS id 23sm223977pzk.6.2010.02.26.09.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 09:41:35 -0800 (PST)
Subject: Re: [PATCH -queue 1/3] MIPS: add a common mips_sched_clock()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4B670A45.3010105@caviumnetworks.com>
References: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
         <4B670A45.3010105@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 27 Feb 2010 01:35:24 +0800
Message-ID: <1267205724.2480.166.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2010-02-01 at 09:07 -0800, David Daney wrote:
> Wu Zhangjin wrote:
> 
> > +		"dmultu\t%[cnt],%[mult]\n\t"
> > +		"nor\t%[t1],$0,%[shift]\n\t"
> > +		"mfhi\t%[t2]\n\t"
> > +		"mflo\t%[t3]\n\t"
> > +		"dsll\t%[t2],%[t2],1\n\t"
> > +		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
> > +		"dsllv\t%[t1],%[t2],%[t1]\n\t"
> 
> This is unlikely to work in 32-bit kernels.

So, before the 32-bit version is out, can we make it depends on
CONFIG_64BIT?

Thanks & Regards,
	Wu Zhangjin
