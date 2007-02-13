Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 17:10:39 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.228]:52150 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038483AbXBMRKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 17:10:34 +0000
Received: by qb-out-0506.google.com with SMTP id e12so788230qba
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 09:09:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YQTs4VhWP/xfYwxfG+safdxqoprLogHvwHTuk/exRgYGRlAzVbJnv6QSOev16Nma8qiRdnHUTHFicdAUg1Q1A+ToCDeznVDuxwBcsHw6nkUnmyemhfVVgkLsZxuoDIbEcHFVzxyHV/d02m3gcaGB4qx1tp5w2NUJ0LyB4dV/uJI=
Received: by 10.114.152.17 with SMTP id z17mr7920896wad.1171386572964;
        Tue, 13 Feb 2007 09:09:32 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 13 Feb 2007 09:09:32 -0800 (PST)
Message-ID: <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
Date:	Tue, 13 Feb 2007 18:09:32 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	macro@linux-mips.org
In-Reply-To: <20070213161801.GA9700@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1171358289786-git-send-email-fbuihuu@gmail.com>
	 <11713582901742-git-send-email-fbuihuu@gmail.com>
	 <20070213161801.GA9700@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/13/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Feb 13, 2007 at 10:18:08AM +0100, Franck Bui-Huu wrote:
>
> > +    cflags-y += -DCONFIG_BUILD_ELF64
>                    ^^^^^^^^^^^^^^^^^^^^
>
> Preprocessor symbol names starting CONFIG_ are reserved for Kbuild.
>

Ok but keeping this name avoid to change all places where
CONFIG_BUILD_ELF64 is used.

It should be done by patch #3 instead where CONFIG_BUILD_ELF64 is
renamed into CONFIG_64BIT_BUILD_ELF32. Any suggestions for a better
name ?
-- 
               Franck
