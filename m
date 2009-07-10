Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 02:46:37 +0200 (CEST)
Received: from mail-px0-f178.google.com ([209.85.216.178]:57309 "EHLO
	mail-px0-f178.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493130AbZGJAqa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2009 02:46:30 +0200
Received: by pxi8 with SMTP id 8so357949pxi.22
        for <multiple recipients>; Thu, 09 Jul 2009 17:46:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=jj8tqH3pWgcZHcqDe9ziVS23rLVC9kMUDuddJ2evI3s=;
        b=UAw28ynriQx6k8qo4x0ctkRPlxFTO6q0Xj0KZrzWciPsNfIYK6ovQnUVupgKdDbAWc
         BkFn71Y+ORcdPULDUMFimxe/duFd4vDBvS8VD1bkRhU1O2CCcVEInMvc9Zj6Jcn/7LGF
         nRSpV47WhqH87jz+8pNpo8NH/y5+T0C1PvmUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=W3uYvcMF3+5iccRa4oCqqRsT6RoBlpbTKcWGN2+IuOcMWyi106BTBJw3MDSgynIA3T
         aK12Ws+mxeBGghLFzlMJ8jkyf0FAoLM0zpzjQxIxqKXp8RpfCXLbnuXOR/IevQZmBHNJ
         xK3n2G8DhTLDkSEaPl1FdjomUGN46OBH3NG6w=
Received: by 10.140.161.3 with SMTP id j3mr934277rve.27.1247186783450;
        Thu, 09 Jul 2009 17:46:23 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id l31sm2668224rvb.13.2009.07.09.17.46.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 17:46:22 -0700 (PDT)
Subject: Re: What's happening with vr41xx_giu.c?
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	yuasa@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <4A5680B5.2090405@necel.com>
References: <4A5680B5.2090405@necel.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 10 Jul 2009 08:46:11 +0800
Message-Id: <1247186771.5607.2.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The same to me.

is there a bug in git?

On Fri, 2009-07-10 at 08:43 +0900, Shinya Kuribayashi wrote:
> Does anyone have a similar symptom?
> 
> ---
> skuribay@ubuntu:linux.git$ git checkout -f master
> Already on 'master'
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$ git log HEAD^..
> commit 4eebdebd71325d0814b1c8e093fd0d1f191da9aa
> Author: Kurt Martin <kurt@mips.com>
> Date:   Wed Jul 8 19:22:35 2009 -0700
> 
>     MIPS: SMTC: Move cross VPE writes to after a TC is assigned to VPE.
> 
>     Signed-off-by: Chris Dearman <chris@mips.com>
>     Signed-off-by: Raghu Gandham <raghu@mips.com>
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$ git status
> # On branch master
> nothing to commit (working directory clean)
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$ make distclean
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       deleted:    drivers/char/vr41xx_giu.c
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> skuribay@ubuntu:linux.git$
> 
