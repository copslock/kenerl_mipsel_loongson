Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Apr 2010 10:54:58 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:37768 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492215Ab0DHIyz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Apr 2010 10:54:55 +0200
Received: by pzk16 with SMTP id 16so151821pzk.22
        for <multiple recipients>; Thu, 08 Apr 2010 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=m8ZBz3rGvtaXCR+EIxwKWDToOdMJvJ10zQr8mkP6W6c=;
        b=Sp/rVPZb48RwdPhe6Kg9p0JRLflPWvaOSzyLb3xhmUQvDbiFfI1xr15ZrmcMMIJl8S
         v+Os/zaXMaYWwFjpwscGpmKFFBGVX9d5cYor1wo+CjxbKH6xAemfX0F1AaiSl2IHXG/v
         Ihds5XNwpyXM52HCJFl3duhd55oz+e+yPaQ+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=XFROc5WsOSfr9hMA5go82w2yy9mTlIapWo3eyxKnUWZX5YefOFt+XapYTrlrqVW6dX
         2ty3NWCcYBBEGylTR+r+GwcmP2el+4uUr/cLuR1W/utaDyzNAY8YVRhnQFlKM7hbgZoG
         RU/3/cFAiWSAOtc96jsLlQu2jleTH452BNYrU=
Received: by 10.140.58.18 with SMTP id g18mr8629607rva.46.1270716887004;
        Thu, 08 Apr 2010 01:54:47 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm4362589pzk.8.2010.04.08.01.54.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 01:54:46 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] Loongson-2F: Enable fixups of the latest
 binutils
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Zhang Le <r0bertz@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100407171632.GA1137@woodpecker.gentoo.org>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
         <cf5a00449fa910daf1d1313d6b4d1df1e7a85a24.1270645413.git.wuzhangjin@gmail.com>
         <20100407171632.GA1137@woodpecker.gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 08 Apr 2010 16:47:51 +0800
Message-ID: <1270716471.5709.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-04-07 at 17:16 +0000, Zhang Le wrote:
[...]
> > +# enable the workarounds for loongson2f
> > +ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
> > +  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
> > +    $(error gcc does not support needed option -mfix-loongson2f-nop)
> 
>     Again, this is an as option. :)
>     So this error msg is a little miss leading.
>     Maybe we should tell user at least which version of binutils is needed.
> 

hmm, yeah, it's better to tell the users the exact tool here although
'as' is part of the integrated gcc toolchain ;)

Thanks & Regards,
	Wu Zhangjin
