Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8GGGxQ13401
	for linux-mips-outgoing; Sun, 16 Sep 2001 09:16:59 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8GGGue13398
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 09:16:56 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 76C93125C6; Sun, 16 Sep 2001 09:16:55 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 79309EBA4; Sun, 16 Sep 2001 09:16:54 -0700 (PDT)
Date: Sun, 16 Sep 2001 09:16:54 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Petter Reinholdtsen <pere@hungry.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010916091654.C1812@lucon.org>
References: <E15iary-0002nW-00@minerva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15iary-0002nW-00@minerva>; from pere@hungry.com on Sun, Sep 16, 2001 at 02:17:54PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 16, 2001 at 02:17:54PM +0200, Petter Reinholdtsen wrote:
> 
> Hello
> 
> I'm using debian/mips (sid) on an SGI Indy with 256 MB RAM.  It is as
> far as I know up to date with the latest packages.
> 
> When I try to compile and link a huge C++ program using Qt and various
> other libraries, I get strange error message like this during linking:
> 
>   libopera.a(registerdialog.o): In function
>     `RegisterDialog::RegisterDialog(QWidget *, char const *, bool)':
>   linux/ui/registerdialog.cpp(.text+0xd08): relocation truncated to
>     fit: R_MIPS_GOT16 RegisterDialog virtual table
>   libopera.a(registerdialog.o): In function
>     `RegisterDialog::slotOk(void)':
>   linux/ui/registerdialog.cpp(.text+0xdd8): relocation truncated to
>     fit: R_MIPS_CALL16 RegisterWidget::verifySettings(void)
>   libopera.a(registerdialog.o): In function `onceinalifetime(void)':
>   regkey/regver.h(.text+0x10d8): relocation truncated to fit:
>     R_MIPS_CALL16 regkey_init(void)
> 

This may be a MIPS linker bug/limitation. But I don't use Qt on mips
and have no plan to do so. If you can provide a complete testcase,
in this case, every single file used for the final linking, I will
take a look.


H.J.
