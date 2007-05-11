Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 20:24:00 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.180]:37444 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021976AbXEKTX5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 20:23:57 +0100
Received: by py-out-1112.google.com with SMTP id u52so886263pyb
        for <linux-mips@linux-mips.org>; Fri, 11 May 2007 12:23:56 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k6TWZIHLpRWhIN4a6fiwA1KAaTZETH2S+VN3w1zC5rvL6rl9tfRSd4I56LLk2GWP8xgqCht81r1Qj/D1io2zR4b66VEIrmPsTQ857e6gfU6NY3W/kHC68z5EvWZfR4Z5D1WvO+s1VIDkqP3nHVdGmlb41GM/t7dKO5iW6qhvFK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tUdbq27jCiVSdBol8mUSIUtdaaO47k8rodRk4o/bRTL7s/5ogyIqxDS+LmlziAId9C8CE05lWEigkEZCUfQyHyPvGar7hQKR8jLwxs9D3DFxBOEMe5MB5j1RtXmaQ/3ev3jE3ldzZw/sc4wJ8m/oJzBEJqwDK9bjEkoWaYRK5Jk=
Received: by 10.65.159.3 with SMTP id l3mr5917563qbo.1178911436106;
        Fri, 11 May 2007 12:23:56 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Fri, 11 May 2007 12:23:55 -0700 (PDT)
Message-ID: <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
Date:	Fri, 11 May 2007 21:23:55 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
In-Reply-To: <20070512.005905.26096031.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
	 <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
	 <20070512.005905.26096031.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/11/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>  archprepare:
>  ifdef CONFIG_MIPS32_N32
> -       $(Q)$(MAKE) $(build)=arch/mips missing-syscalls-n32
> +       @echo '  Checking missing-syscalls for N32'
> +       $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
>  endif
>  ifdef CONFIG_MIPS32_O32
> -       $(Q)$(MAKE) $(build)=arch/mips missing-syscalls-o32
> +       @echo '  Checking missing-syscalls for O32'
> +       $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
>  endif
>

Well I'm not sure how revelant are the echos...

But I still think that (a) you shouldn't put any command in
'archprepare' multiple rule (b) you should move this rule from the
cleaning targets.

Thanks
-- 
               Franck
