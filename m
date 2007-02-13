Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 20:06:16 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.227]:17995 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039293AbXBMUGM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 20:06:12 +0000
Received: by nz-out-0506.google.com with SMTP id x7so2139662nzc
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 12:05:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BqAUcNgq2NO2wJVqL8/IhAuLdnsZzvFWvChJAd5JafkQwU1MI1EWuhgJO2aDxToKAh5BoxoOxbpfgY9ag2Cn97C5OsywzENpGSnbhP9DDvoHG9HU9XzAYU+kzB/WDaMPJxtk8cw6EvHfqRP8bhXzb1S+C9nvKj+IIlnkGA5mOG8=
Received: by 10.114.161.11 with SMTP id j11mr8150370wae.1171397106616;
        Tue, 13 Feb 2007 12:05:06 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 13 Feb 2007 12:05:06 -0800 (PST)
Message-ID: <cda58cb80702131205n7ffbc73rfd26897f4bb99d74@mail.gmail.com>
Date:	Tue, 13 Feb 2007 21:05:06 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	macro@linux-mips.org
In-Reply-To: <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1171358289786-git-send-email-fbuihuu@gmail.com>
	 <11713582901742-git-send-email-fbuihuu@gmail.com>
	 <20070213161801.GA9700@linux-mips.org>
	 <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/13/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> On 2/13/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, Feb 13, 2007 at 10:18:08AM +0100, Franck Bui-Huu wrote:
> >
> > > +    cflags-y += -DCONFIG_BUILD_ELF64
> >                    ^^^^^^^^^^^^^^^^^^^^
> >
> > Preprocessor symbol names starting CONFIG_ are reserved for Kbuild.
> >
>
> Ok but keeping this name avoid to change all places where
> CONFIG_BUILD_ELF64 is used.
>
> It should be done by patch #3 instead where CONFIG_BUILD_ELF64 is
> renamed into CONFIG_64BIT_BUILD_ELF32. Any suggestions for a better
> name ?

What about KBUILD_64BIT_ELF32 with 'KBUILD' meaning that it comes from
Kbuild itself and not from any Kconfig files ?

-- 
               Franck
