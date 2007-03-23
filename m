Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:13:14 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:24956 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022402AbXCWPNN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 15:13:13 +0000
Received: by nf-out-0910.google.com with SMTP id q29so1314314nfc
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 08:12:12 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wzt8c/ubbz8PXxz4uoZaG7/NdjCmOg7rohikJFDCI1CrNbNRIUJEwsrjQx9AsOygcNFtL+GwiD5R34b5gb34pHMKFvTtVeZgRVbYekXKp5yTbisQ2ycpvW+FneRn8jVYJ8vixIlkzbYaS+Jv9eknDwCEsVHpJSJoVpa9ZD921ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PR9Gv9r+AC6EbG9Fy17Sb9dfu2/ZkO7UGqm0NovULBD6f/KFLvpIfbYY+re0jpjjvVVvt2YlrKwWX/v3NEqlsfRhUGwQL58//Fo9MCi96a5guWC6zSocUYfLCsVB4m65/OmLoP03rG4Xqna9HryWLfyOvXwk+LB9hDZhJTS6TKg=
Received: by 10.115.93.16 with SMTP id v16mr1224788wal.1174662731501;
        Fri, 23 Mar 2007 08:12:11 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Fri, 23 Mar 2007 08:12:10 -0700 (PDT)
Message-ID: <cda58cb80703230812l732aed7ej5b158c27a3c98c3@mail.gmail.com>
Date:	Fri, 23 Mar 2007 16:12:10 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"Arnaud Giersch" <arnaud.giersch@free.fr>
In-Reply-To: <45FFEB5A.707@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D8B070.7070405@gentoo.org>
	 <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
	 <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net>
	 <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>
	 <45FE9D22.1030407@gentoo.org>
	 <cda58cb80703191435u37ba4ed2se4cc150fcdb734a2@mail.gmail.com>
	 <45FFEB5A.707@gentoo.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Kumba wrote:
>
> After going through all the fun to get rid of CPHYSADDR, I see no
> point really to bring it back.

The patch restores CPHYSADDR() but in __pa()'s _implementation_. It
makes a huge difference.

I think CPHYSADDR() is not that bad for 64 bits kernels. With such
beasts we need to handle two PAGE_OFFSET values if we stick with the
current implementation of __pa(). Magically using CPHYSADDR() removes
this need. OTOH, CPHYSADDR() is quite bad for mapped kernels.

But do we really care in 64 bits world ?

>  Plus that patch unnecessarily complicates those defines.  As I
> highlighted in my original mail, O2 doesn't need CPHYSADDR added to
> __pa(), it just needs the conditional define for __pa_page_offset to
> be a little bit more flexible.
>

I don't see why the patch complicates those defines. It actually gets
rid of CONFIG_BUILD_ELF64 and __pa_page_offset(). OK I could have
written it a little bit more readable:

#ifdef CONFIG_64BIT
#define __pa(x)							\
({								\
	unsigned long __x = (unsigned long)(x);			\
	__x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);		\
})
#else
#define __pa(x)							\
	((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
#endif

Yes, it actually increases size code for CONFIG_64BIT because we
always test if the virtual address is from XKPHYS or CKSEG0. But how
much ? I would say not a lot, and it maybe worths it since we get rid
of an obscure config option.

		Franck

-- 
               Franck
