Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 20:03:17 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:46816 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133438AbWG0TDI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 20:03:08 +0100
Received: by ug-out-1314.google.com with SMTP id o2so394331uge
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 12:03:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X6rTPwARg2edGpAAhLeq+Y3TGqOHqbN6X+SpcHjF0aR6W1kwIRmKReOZMStZj/0lfufYHpULzcv/oAfK9twJYUHxLinc8VjGaDRq9Qw+pFEjenrFJ4TGHf7kXQlt3BKE5UHpwuh8jStsfmqaj29K/NCdvbPALRwDbj2f8PwbghA=
Received: by 10.67.93.7 with SMTP id v7mr7589291ugl;
        Thu, 27 Jul 2006 12:03:07 -0700 (PDT)
Received: by 10.67.87.8 with HTTP; Thu, 27 Jul 2006 12:03:07 -0700 (PDT)
Message-ID: <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
Date:	Thu, 27 Jul 2006 21:03:07 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <44C8CEA4.20000@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
	 <44C8CEA4.20000@innova-card.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

one more comment,

2006/7/27, Franck Bui-Huu <vagabon.xyz@gmail.com>:
> Hi Atsushi ;)
>
> Atsushi Nemoto wrote:
> > +unsigned long unwind_stack(struct task_struct *task,
> > +                        unsigned long **sp, unsigned long pc)
> > +{
> > +     unsigned long stack_page;
> > +     struct mips_frame_info info;
> > +     char *modname;
> > +     char namebuf[KSYM_NAME_LEN + 1];
> > +     unsigned long size, ofs;
> > +
> > +     stack_page = (unsigned long)task_stack_page(task);
> > +     if (!stack_page)
> > +             return 0;
> > +
> > +     if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
> > +             return 0;
> > +     if (ofs == 0)
> > +             return 0;
> > +
> > +     info.func = (void *)(pc - ofs);
> > +     info.func_size = ofs;   /* analyze from start to ofs */

in get_frame_info(), there is the following condition to stop the
prologue analysis

		if (info->func_size && i >= info->func_size / 4)
			break;

Setting info.func_size = ofs may trigger this stop condition very
early, specially if "ofs" is small...I would simply remove this
condition since it's very empirical and IMHO not very usefull.

> > +     get_frame_info(&info);
> > +     if (info.pc_offset < 0 || !info.frame_size) {
> > +             /* leaf? */
>
> for leaf case, can't we simply do this test:
>
>         if (info.pc_offset < 0) {

-- 
               Franck
