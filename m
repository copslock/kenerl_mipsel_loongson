Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 14:26:46 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.201]:42460 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133555AbWA3O02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 14:26:28 +0000
Received: by zproxy.gmail.com with SMTP id l8so263158nzf
        for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 06:31:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=krXtCR7QgW5t/iL8YoaLjtYDRlMTcnsCDWOBpZEVNqw+ifpBilp1E8l/ol7EatcUXjvSFQ1j6Edy28ADX59uHmcdVvxsV91+LRf+mS6YXzP62sS3lPSgmE7lxBytg2Iypl/ZvCs4fM+P58ddQMCnlGG4dTgRxED4xi34VehpaVM=
Received: by 10.37.22.73 with SMTP id z73mr4757329nzi;
        Mon, 30 Jan 2006 06:31:21 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Mon, 30 Jan 2006 06:31:21 -0800 (PST)
Message-ID: <cda58cb80601300631y71c6c18dg@mail.gmail.com>
Date:	Mon, 30 Jan 2006 15:31:21 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20060129150747.GC3420@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <43D8F000.9010106@mips.com> <43D8FF16.40107@mips.com>
	 <cda58cb80601261002w6eb02249k@mail.gmail.com>
	 <43D93025.9040800@mips.com>
	 <cda58cb80601270103t1419117cq@mail.gmail.com>
	 <43DA240F.5070301@mips.com>
	 <cda58cb80601270654jf779622w@mail.gmail.com>
	 <00df01c62357$ef9a1fa0$10eca8c0@grendel>
	 <cda58cb80601270932x323e4923j@mail.gmail.com>
	 <20060129150747.GC3420@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/29, Ralf Baechle <ralf@linux-mips.org>:
> On Fri, Jan 27, 2006 at 06:32:15PM +0100, Franck wrote:
>
> > > ifdef CONFIG_CPU_SMARTMIPS
> > > cflags-$(CONFIG_CPU_MIPS32R1)   += \
> > >                         $(call set_gccflags,mips32,smartmips,4kec,mips3,mips2)\
> > >                         -Os, -Wa,--trap
>
> -Os has no business here.  That's what CONFIG_CC_OPTIMIZE_FOR_SIZE is for.
>
> > > if the values I threw in for the MIPS32R1+SmartMIPS (e.g. 4KSc) combination
> > > would actually work.  I just want to point out that it isn't that hard to do.
> >
> > I agree it's not hard to do. But it becomes more tricky if you want
> > something clean that gives best results for every cpus...Moreover I
> > don't think your solution avoids maintenence problems IMHO.
> >
> > Ralf, could you give your opinion ?
>
> I think I'm going to start by throwing the insane option selection
> complexity which was needed for support of gcc 2.95 ... 3.1; a few days
> gcc 3.2 became the minimum required to build a 2.6 kernel, then see what
> can nicely be implemented.

Could you keep me informed on this ? When are you planning to start it ?

Thanks
--
               Franck
