Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 12:58:04 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:60340 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492607AbZJHK56 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 12:57:58 +0200
Received: by pxi17 with SMTP id 17so7289811pxi.21
        for <multiple recipients>; Thu, 08 Oct 2009 03:57:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=eHMSSzz9HjcZONNxzvPtn1yUimn+ys6pozSD64FXavQ=;
        b=QXrXIzvE0kcToTyZpKOk6QKyI/DFCt/FwZ92Q55NR5kmcTvs2fy6vmlVsPNKu7hnH0
         XJfhZfzEtfJnIi3tIEKoub7El9nLTLzvlgcqa7P2BFVf7oO65LOPanpKA+VzncHa3Tfl
         +2EZiFJ3Pzrgi9HUQW8jpFNHlJP1nJ9pxkgRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=aYuULraivpXenZPcLAGbFUQQPe3OP7t3O8rVURAYc2TpLUI7jzfm52ME/y4P7umVCk
         jU3fwwbovJb2wLzPTQCYyght/641pG45UrAJCCa2NzatQocv+GTIUgaArwxQiDMfvBBY
         i5A0T/Ub1tkZG5bzeBMvOeUkuzwb5nBSrXm4g=
Received: by 10.114.51.12 with SMTP id y12mr1978841way.33.1254999470696;
        Thu, 08 Oct 2009 03:57:50 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm294665pxi.12.2009.10.08.03.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 03:57:50 -0700 (PDT)
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Pavel Machek <pavel@ucw.cz>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20091008103614.GA27323@elf.ucw.cz>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
	 <20091008092903.GA27054@elf.ucw.cz> <1254998019.14496.21.camel@falcon>
	 <20091008103614.GA27323@elf.ucw.cz>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 08 Oct 2009 18:57:43 +0800
Message-Id: <1254999463.14496.29.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

> > > 
> > > Looks mostly ok, small comments below. 
> > > 
> > > > @@ -168,13 +168,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> > > >  
> > > >  #ifdef CONFIG_FLATMEM
> > > >  
> > > > -#define pfn_valid(pfn)							\
> > > > -({									\
> > > > -	unsigned long __pfn = (pfn);					\
> > > > -	/* avoid <linux/bootmem.h> include hell */			\
> > > > -	extern unsigned long min_low_pfn;				\
> > > > -									\
> > > > -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> > > > +#define pfn_valid(pfn)				\
> > > > +({						\
> > > > +	extern int is_pfn_valid(unsigned long); \
> > > > +	is_pfn_valid(pfn);			\
> > > >  })
> > > 
> > > "extern int pfn_valid here"
> > > 
> > > ...and get away without the ugly macro?
> > > 
> > 
> > Perhaps need to move the whole "#ifdef CONFIG_FLATMEM" to #ifndef
> > ASSEMBLY, otherwise,
> > 
> > "arch/mips/include/asm/page.h:170: Error: unrecognized opcode `extern
> > int pfn_valid(unsigned long)'". 
> 
> I guess so. pfn_valid() will not work from assembly, anywa, so...

Seems pfn_valid() is only called in non-ASSEMBLY source code, so, we are
safe to move it to "#ifndef ASSEMBLY", just tested it, works.

Regards,
	Wu Zhangjin
