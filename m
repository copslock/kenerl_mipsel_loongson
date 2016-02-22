Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 19:38:24 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34281 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011154AbcBVSiXD0ctN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 19:38:23 +0100
Received: by mail-pa0-f48.google.com with SMTP id fy10so95059946pac.1
        for <linux-mips@linux-mips.org>; Mon, 22 Feb 2016 10:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iGpOxUzQd0p5kC0OOIcZHizEpUxVMVt9PzXizcCJzGI=;
        b=JwziAswcthGYM3mXF6m9mYqlbOr7FJwABl3kz3lgem0b75lmewAVcySSNWBDiLsZjJ
         mVU/y9VxMdfjViPZg1s/JRvpsfv/QugGcSrnGP8Ez6/P/k+rMdRU18mvPpD4HWAAHpvv
         bdrTedCCnaLZwI0jZZOgHo7Lg7cIVW7ZhUPVUxjp3Mm3bNsGnUopa1dQcenlgMADfwfT
         OIBHJWqw62y3d4Fieq8dXSl0p/up6qKqP4CqPkHVNF1qL9lZrkW4jR5iVBco7cahw+zo
         VmqHxrpJzh9/EmsJVH8DFamx4q1darHvjSYjbYoMbT/7b5/6w5ASpNA8e3S3r0GfV5OU
         NHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iGpOxUzQd0p5kC0OOIcZHizEpUxVMVt9PzXizcCJzGI=;
        b=BGzjXRhmX/a2Atah38RkgTiWIse7U29k2depKJeWNUQCqVtmS2sOKMzMW8e+SfWyl+
         QxmOSSRfOMTLqskw2LR5bjKk36r1GEkX9binBC9bkA+i0/OEt6Q56Xm59vXEelLpIQNa
         ZLT+BNnu/YfGZTbsnsYczuChl5/WGvx/Q1KT1bHDXMceZ/RxDRPe+PW7mL2HUanaFu51
         IIwg627B7XcHS8eb1q0DNO1K11Wue3a5AUnVNDp2eHMn0pIvSKEOaY1aRBaoR+4Jh7cs
         CM2fqo6KizDNSCr169L+Z2gtI78yi2BF+nHfIU1YuHUvmbIuTaq0MfuxiKOdBlvbSPvr
         7l1w==
X-Gm-Message-State: AG10YOT+QSHKfuQr/BiJxbC1Ooi8HdGz44xlNw/rKz+O7aarv66pndaZOio8j6rCGRdv4g==
X-Received: by 10.66.102.40 with SMTP id fl8mr39238681pab.126.1456166297102;
        Mon, 22 Feb 2016 10:38:17 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id s23sm38531096pfi.12.2016.02.22.10.38.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 10:38:15 -0800 (PST)
Message-ID: <56CB5595.1090505@gmail.com>
Date:   Mon, 22 Feb 2016 10:38:13 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     david.daney@cavium.com, linux-mips@linux-mips.org
Subject: Re: Does CN68XX still need DCache prefetch workaround?
References: <56CB51CE.6070905@windriver.com>
In-Reply-To: <56CB51CE.6070905@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 02/22/2016 10:22 AM, Yang Shi wrote:
> I David,
>
> When I booted up 4.5-rc4 kernel on CN68xx board, both pass 1.1 and pass
> 2.2 reports:
>
> Kernel panic - not syncing: OCTEON II DCache prefetch workaround not in
> place (cfa00000).
> Please build kernel with proper options (CONFIG_CAVIUM_CN63XXP1).
>
> According to the description of he option, it should just have impact on
> 63xx pass 1.x. It looks confusing.
>

The name of the Kconfig variable is CAVIUM_CN63XXP1.  It turns out that 
it is also needed for somethings that are not cn63xxP1.  It is a bit 
confusing, but as of now we decided not to rename the Kconfig variable.

> Any hint is appreciated?

Enable it and see what happens.

>
> Thanks,
> Yang
>
