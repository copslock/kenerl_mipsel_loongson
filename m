Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 17:27:59 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.192]:59791 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465612AbWA0R1l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 17:27:41 +0000
Received: by zproxy.gmail.com with SMTP id l8so662386nzf
        for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 09:32:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/KvfDdn4FjWho2bEJmwP4AVCGcssJpOQZ01NULzDlx9LCNQpTr07InuzFXt2p/ekeQvfoLgmnrzO8mXnctohD/iJCx1IuIN/L+cp5gV97h2ksly/siGr+xuBjR62mmjTcPxhWb2mGRya11WnBCUUpImMsSEdc0oyVCAjthILWI=
Received: by 10.36.38.7 with SMTP id l7mr2597210nzl;
        Fri, 27 Jan 2006 09:32:15 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Fri, 27 Jan 2006 09:32:15 -0800 (PST)
Message-ID: <cda58cb80601270932x323e4923j@mail.gmail.com>
Date:	Fri, 27 Jan 2006 18:32:15 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <00df01c62357$ef9a1fa0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <43D8F000.9010106@mips.com>
	 <cda58cb80601260831i61167787g@mail.gmail.com>
	 <43D8FF16.40107@mips.com>
	 <cda58cb80601261002w6eb02249k@mail.gmail.com>
	 <43D93025.9040800@mips.com>
	 <cda58cb80601270103t1419117cq@mail.gmail.com>
	 <43DA240F.5070301@mips.com>
	 <cda58cb80601270654jf779622w@mail.gmail.com>
	 <00df01c62357$ef9a1fa0$10eca8c0@grendel>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/27, Kevin D. Kissell <kevink@mips.com>:
>
> ifdef CONFIG_CPU_SMARTMIPS
> cflags-$(CONFIG_CPU_MIPS32R1)   += \
>                         $(call set_gccflags,mips32,smartmips,4kec,mips3,mips2)\
>                         -Os, -Wa,--trap
>
> cflags-$(CONFIG_CPU_MIPS32R2)   += \
>                         $(call set_gccflags,4ksd,mips32r2,4kec,mips3,mips2) \
>                         -Wa,--trap
> else
> cflags-$(CONFIG_CPU_MIPS32R1)   += \
>                         $(call set_gccflags,mips32,mips32,r4600,mips3,mips2) \
>                         -Wa,--trap
>
> cflags-$(CONFIG_CPU_MIPS32R2)   += \
>                         $(call set_gccflags,mips32r2,mips32r2,r4600,mips3,mips2)
>  \
>                         -Wa,--trap
> endif
>
>
> That's almost certainly not the cleanest way to do it (and I really don't know
> if the values I threw in for the MIPS32R1+SmartMIPS (e.g. 4KSc) combination
> would actually work.  I just want to point out that it isn't that hard to do.

I agree it's not hard to do. But it becomes more tricky if you want
something clean that gives best results for every cpus...Moreover I
don't think your solution avoids maintenence problems IMHO.

Ralf, could you give your opinion ?

Thanks
--
               Franck
