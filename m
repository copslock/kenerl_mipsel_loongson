Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 08:21:31 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.224]:16133 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20027704AbXBNIV1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Feb 2007 08:21:27 +0000
Received: by qb-out-0506.google.com with SMTP id e12so8404qba
        for <linux-mips@linux-mips.org>; Wed, 14 Feb 2007 00:20:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LjuOVenIWI9/X8r9nQmmnKtWmKzksdqGwlWWm3AjMp2ror15atUvzojlPzjjQOa57spN9MLZfJ8OXLJv5O0S/st4GOZ/OD9HcAJK+pqAPSZ4ZEYcddcu8DEx5kbzzqlpz1hq4JMmdoMErypxEA28mxqJ6rpuZnV5MLgfvo+9kSg=
Received: by 10.114.157.1 with SMTP id f1mr7050wae.1171441222699;
        Wed, 14 Feb 2007 00:20:22 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Wed, 14 Feb 2007 00:20:22 -0800 (PST)
Message-ID: <cda58cb80702140020l319b987agc88e87c3acaa5e07@mail.gmail.com>
Date:	Wed, 14 Feb 2007 09:20:22 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
In-Reply-To: <20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11713582901742-git-send-email-fbuihuu@gmail.com>
	 <20070213161801.GA9700@linux-mips.org>
	 <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
	 <20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/14/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue, 13 Feb 2007 18:09:32 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > It should be done by patch #3 instead where CONFIG_BUILD_ELF64 is
> > renamed into CONFIG_64BIT_BUILD_ELF32. Any suggestions for a better
> > name ?
>
> I think "ELF32" or "ELF64" word is improper while this is irrelevant
> to ELF format.  This makes confusion with CONFIG_BOOT_ELF32.
>
> How about simple BUILD_SYM32?  And replase BUILD_ELF32 with
> BUILD_SYM32 too?
>

That's a good point. What about replacing BUILD by KBUILD meaning this
macro is coming from Kbuild itsel ?

And maybe it would be interesting to make obvious that this macro
implies 64-bits kernel. What about something like KBUILD_64BIT_SYM32
and replace 'BUILD_ELF32=no' by 'KBUILD_SYM32=no' ?
-- 
               Franck
