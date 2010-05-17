Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2010 16:56:17 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:61010 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492018Ab0EQO4O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 May 2010 16:56:14 +0200
Received: by fxm12 with SMTP id 12so3694291fxm.36
        for <multiple recipients>; Mon, 17 May 2010 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=UXofLrlVwIfzBIZRgQ2MGvP9SToZ1SKY1l/mUolSR3k=;
        b=wvD2yspMvu8duPiC18YPgLyScjER2cjfRpSM9b9cPXNHcBtsrtC82khuZo1fbqHJD7
         QQXmuQh6Uvqis0Q9qNg8IRPBu+GbSNoFeeERiZDOAOidi44it/Q3gDwYbvmwMHoLcQzb
         nlU1mpMKedopm9cIaNTm2oS5tnepyvayF/YCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tnPKQJOXwo4Zlyxd1M4VpjwoTAhlW5bxoY0FTMYi5RTL4ZKynbyVBjYO9r+1uAeBub
         wo7YP1nObo/OcijbDco3FbCH63VvlIGj3rYewR8LsRJ6PnJJRcXArGxgRAxRnlUu/dlj
         OUYihle9ataG39TR2wOBCnl3CmON/dLkanMuk=
Received: by 10.223.30.10 with SMTP id s10mr6474118fac.4.1274108167103;
        Mon, 17 May 2010 07:56:07 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id 15sm26146469fad.22.2010.05.17.07.56.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 May 2010 07:56:04 -0700 (PDT)
Subject: Re: [PATCH] rtc-cmos: Fix binary mode support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
        rtc-linux@googlegroups.com, david-b@pacbell.net,
        a.zummo@towertech.it, akpm@linux-foundation.org
In-Reply-To: <20100511141039.GG13576@linux-mips.org>
References: <m3zl0mwpez.fsf@anduin.mandriva.com>
         <20100511141039.GG13576@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 17 May 2010 22:55:54 +0800
Message-ID: <1274108154.14193.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf and Arnaud

Just found a bug introduced in this patch, please take a look at the 754
line after applying it, a ";" is needed to append the "dev_warn(dev,
"only 24-hr supported\n")".

Regards,
	Wu Zhangjin

On Tue, 2010-05-11 at 15:10 +0100, Ralf Baechle wrote:
> On Thu, Apr 29, 2010 at 11:58:44AM +0200, Arnaud Patard wrote:
> 
> > [ I'm sending again this patch, hoping it'll get reviewed ]
> 
> I'm showing mercy for the poor sod of a patch by merging it into -my tree
> for -next.
> 
> Thanks Arnaud,
> 
>   Ralf
> 
