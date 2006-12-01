Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 17:12:40 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:57235 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038452AbWLARMf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 17:12:35 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2683846uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 09:12:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J9daMnbe9jMh9lNlj1ZDW+EGhPCaIKS1+z9HFE84ZEYD/mfzCDziEEKCvnfIEWFnlQQUHFwzpk4odsrreU8fCmDP7uUDAyXVlAyyjCV8K70P5Hw+Zc24dD1DxiP8kC1w1cuFp1vvDJqt/uI3fGEd6OoAkD44N5oPFprvX+vzBVg=
Received: by 10.78.166.7 with SMTP id o7mr5005861hue.1164993154925;
        Fri, 01 Dec 2006 09:12:34 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 09:12:34 -0800 (PST)
Message-ID: <cda58cb80612010912k10dfca1ag4dc4743d0be647dc@mail.gmail.com>
Date:	Fri, 1 Dec 2006 18:12:34 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20061202.020544.89039198.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457042FF.2060908@innova-card.com>
	 <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
	 <cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
	 <20061202.020544.89039198.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 1 Dec 2006 17:47:29 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > > @@ -468,6 +473,7 @@ config DDB5477
> > > >  config MACH_VR41XX
> > > >       bool "NEC VR41XX-based machines"
> > > >       select SYS_HAS_CPU_VR41XX
> > > > +     select GENERIC_HARDIRQS_NO__DO_IRQ
> > > >
> > > >  config PMC_YOSEMITE
> > > >       bool "PMC-Sierra Yosemite eval board"
> > >
> > > Same here.
> > >
> >
> > are you sure ? I don't see any traces of i8259 selection.
> > Moreover, Yoichi's vr41xx boards seem to have no problem
>
> Oh I was wrong.  I had misread VR41XX as DDB5477...
>

No you were not ;) take a look to Sergei reply.

-- 
               Franck
