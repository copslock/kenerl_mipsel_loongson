Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Dec 2007 18:22:32 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.168]:5893 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20032895AbXLWSWX (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Sun, 23 Dec 2007 18:22:23 +0000
Received: by ug-out-1314.google.com with SMTP id k3so976678ugf.38
        for <linux-mips@ftp.linux-mips.org>; Sun, 23 Dec 2007 10:22:13 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FUHfUCzrO0wUM4wc5uS21wJjp2RnX8jYLCNSmVeDzCU=;
        b=XI2H8UWj6N4OUVt9adMY6IirJDJjiSAapTF1O0GdXx/4iCoYH4tlM3Am0udESGgPRzVBRYWBMc9FoZw7QhSJ+Mckv2OgF44jlgS9guRde91L1ytYynUyVvUHtspkLwtHDf+ndhrbaA8Zt2m9Dw305bBJkMaqvTJEpZQP4uzUupQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CLo4Ki64M1JomDp8m4J4hUji2rmcGAXyDJtzk/FK/wlsqHbuwMTdcykhaSLTKGKWKE3pLUNa0+DmvFe+wagYlTjVCCh0CThbY9YreGd/TSUpCtRsIO7wF96YE8OOXPwb1vlLblD3Z+PsfY1/YcRyvIYCYoephekDdGYCc8GVylQ=
Received: by 10.67.116.2 with SMTP id t2mr2085074ugm.62.1198434133079;
        Sun, 23 Dec 2007 10:22:13 -0800 (PST)
Received: by 10.67.117.17 with HTTP; Sun, 23 Dec 2007 10:22:13 -0800 (PST)
Message-ID: <9e0cf0bf0712231022o4a282e70i8cecd70ecc452505@mail.gmail.com>
Date:	Sun, 23 Dec 2007 20:22:13 +0200
From:	"Alon Bar-Lev" <alon.barlev@gmail.com>
To:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	ppopov@mvista.com
Subject: Re: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile fail)
In-Reply-To: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
Return-Path: <alon.barlev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alon.barlev@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

Forgot to write that I checked mips & linus gits, and the problem still exists.

Best Regards,
Alon Bar-Lev.

On 12/23/07, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> Hello,
>
> When I have:
> CONFIG_MIPS_DB1550
> CONFIG_SOC_AU1550
> CONFIG_SOC_AU1X00
> CONFIG_PM
>
> MEM_SDREFCFG is used at:
> arch/mips/au1000/common/power.c::pm_do_freq()
>
> While the MEM_SDREFCFG constant is declare only for CONFIG_SOC_AU1000,
> CONFIG_SOC_AU1500, CONFIG_SOC_AU1100 at:
> include/asm-mips/mach-au1x00/au1000.h
>
> Maybe MEM_SDREFCFG should be defined for CONFIG_SOC_AU1X00?
> Or there should be #ifdef for its usage in power.c?
>
> Best Regards,
> Alon Bar-Lev.
>
