Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 16:24:04 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:44262 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492399AbZKDPX6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 16:23:58 +0100
Received: by ewy12 with SMTP id 12so1828128ewy.0
        for <multiple recipients>; Wed, 04 Nov 2009 07:23:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=AnNvKBXmPjvwrqfCK9AAwLHT4O9zTlbdBN+2pifycIk=;
        b=Orzm4My4bypcuEN7i4emLg1S1rf9cTz9Ll1TaXVOyFfqBaZI6hSoYhlYDFghq2ZMMc
         Aqjzk0seHdVNxuJ1IgCEdl9ilpVlJLQA8kdcjww9Y/2LAMmbunwLUoyt0+SnmQDnTnHx
         7qRkEXyWqGB6G+4k+FCNCCeMACBmMBK49UsYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=NqOSNuxSMdZbf2gusNnmuDT0GMnoyrNV3EvMWchzzwJdLpicGVP18r5H0/CIbp8eJU
         scwY6fTaqoiQag+jEsk4IzqkcrR+eku0zOyarcz3viY9GWg0IEIP25pa5DfcHJf8/qGD
         NmTD3kc4TNdf/XFFgV9+OfEl4UrrFSaJ5aviA=
Received: by 10.216.90.21 with SMTP id d21mr504493wef.85.1257348228015;
        Wed, 04 Nov 2009 07:23:48 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id t2sm3468832gve.27.2009.11.04.07.23.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 07:23:47 -0800 (PST)
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <20091104111957.GA13549@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com>
	 <m3iqdqtwgk.fsf@anduin.mandriva.com>
	 <1257332652.8716.5.camel@falcon.domain.org>
	 <20091104111957.GA13549@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 04 Nov 2009 23:23:46 +0800
Message-ID: <1257348226.16033.4.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-04 at 12:19 +0100, Ralf Baechle wrote:
> On Wed, Nov 04, 2009 at 07:04:12PM +0800, Wu Zhangjin wrote:
> 
> > > Small question : Why don't you restrict to 64bit kernels only ? From
> > > what I remember from some discussions with ST, trying to use a 32-bit
> > > kernel on 2f is a nice way to get troubles. It would be better imho to
> > > forbid such a configuration. As a side effect, this will remove all
> > > 'defined(CONFIG_64BIT)' parts of your #ifdef tests. 
> > > 
> > 
> > It's hard to make such a decision ;) Perhaps some guys want to play with
> > the 32bit version.
> 
> We have other systems where 32-bit kernel support is just remarkably ugly.
> We've dropped 32-bit support for the SGI IP32 aka O2 - nobody seems to even
> have really noticed that.  The Sibyte systems would be good candidates to do
> the same as accesses to outside the 32-bit address space are needed very
> frequently.
> 

So, we really remove the 32bit support?

1312 config CPU_LOONGSON2
1313         bool
1314         select CPU_SUPPORTS_32BIT_KERNEL  --> remove it?
1315         select CPU_SUPPORTS_64BIT_KERNEL
1316         select CPU_SUPPORTS_HIGHMEM

If you all agree, I will send a new patch to remove the above line and
resend the corresponding patches without 32bit support, and removed the
relative CONFIG_64BIT lines in the patches too.

Regards,
	Wu Zhangjin
