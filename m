Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 19:18:52 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:33966 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023602AbZFHSSp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 19:18:45 +0100
Received: by pzk40 with SMTP id 40so193584pzk.22
        for <multiple recipients>; Mon, 08 Jun 2009 11:18:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=kYC2i0MeDWmir6GyER+hQ/Etd92vpw7aFQdV+t6o5yE=;
        b=wBlwhWXurkDlL5QqX0h1T/Z00RmG05IkER0xfLrfBCPsVVkHuv4vnvPyQ8QiSB3Jo9
         wyjccjXVR83dUC0ftxNlCRU8rmLvKQco+KBbt/DkFuA4gdP1XUXTJiedGom6dmCh27GF
         TzYIegth+AfnntveZY5Ycg5h2xazGiPrP4CXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wgObg2ZPjYTMj+JHCk1YxwHeZj9jqYddcMwcWDLUVr+ljoZU3rgTFNAK3VeUL4fLxc
         ze2wpRjYAbs5GExZKAqa9LKPaYytmQo2VHyw76hBV0QAU2iLTMcbRGmkGTbKryG/NJqC
         uLxzHRB80xjtEk6lQYIOw8CvdKolUWiSnQxUU=
Received: by 10.114.67.17 with SMTP id p17mr11194742waa.203.1244485115468;
        Mon, 08 Jun 2009 11:18:35 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id m6sm6182344wag.49.2009.06.08.11.18.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 11:18:34 -0700 (PDT)
Subject: Re: [loongson-PATCH-v3 00/25] loongson-based machines support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090608163821.GC16785@adriano.hkcable.com.hk>
References: <cover.1244119295.git.wuzj@lemote.com>
	 <20090608163821.GC16785@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 09 Jun 2009 02:18:27 +0800
Message-Id: <1244485107.26004.164.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 2009-06-09 at 00:38 +0800, Zhang Le wrote:
> First of all, sorry for late comment and thanks to Zhangjin for the great work.
> 
> However, I have some suggestions.
> 
> On 20:58 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> > Wu Zhangjin (25):
> >   add vmlinux.32 in .gitignore
> >   fix-warning: incompatible argument type of pci_fixup_irqs
> >   fix-warning: incompatible argument type of virt_to_phys
> 
> I think these 3 patch could be submitted separately, since they are not quite
> related to Loongson.
> 

Yeap, I will split all of the non-loongson-specific patches out in the
coming -v4 patch series and also split the immature ones out too.

> >   change the naming methods
> 
> In this patch, I found function get_system_type() still returns wrong name,
> "lemote-fulong". In later patches, I found this string was changed to a macro,
> MACH_NAME. Then, the function becomes more complicated and/or sophisticated,
> because of the addition of machname array.

the MACH_NAME macro method is originally picked from lm2e-fixes branch
of Philippe's git://git.linux-cisco.org/linux-mips.git, this method is
used to share the get_system_type() function between different machines.

and the machtype with machname array is only used to share the same
kernel image file between yeeloong-7inch(menglong?) and yeeloong-8.9inch
source code.

I think it will be "bad" to add a new kernel option named MENGLONG or
something else, and add a new yeeloong-7inch directory in
arch/mips/loongson/ for it, because the difference between
yeeloong-7inch and yeeloong-8.0 inch is very small(the shutdown logic
and screen size). and also, simply add two new kernel options like
YEELOONG-7INCH and YEELOONG-89INCH with #ifdef..#else...#endif is also
not that good, is that?

so, i just added a machtype kernel command line(perhaps we can use the
systype or machtype variable in pmon instead as Arnaud Patard
suggested). and perhaps this machtype can also be used to share the the
kernel image file among the future machines.

what about your suggestion here? is there another good solution? or just
keep it simple: just define the get_system_type() function for every
machine and add a new kernel option for yeeloong-7inch?

> I don't know if this is an established or widely accepted policy, but
> intuitively, at the very least IMHO, a series of patches should only provide
> one correct implementation of a particular function, not provide one wrong
> function then override it with a correct one.
> 
> If I were you, I would do a 'git reset' first.
> Then 'git add' and/or 'git rm' some files which contain similar changes.
> Then 'git commit'.
> Repeat the last two steps, until all the changes have been committed.
> 

I will try to rebase and merge some of the similar patches, if not work,
then did as you suggested, thanks a lot!

thanks!
Wu Zhangjin
