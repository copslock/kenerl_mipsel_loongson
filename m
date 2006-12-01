Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:47:59 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.178]:53315 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20038415AbWLAPrz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 15:47:55 +0000
Received: by py-out-1112.google.com with SMTP id u52so1930106pyb
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 07:47:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7WdJGHKAWSp3qAl5lgSYBESzqkUrz80GXjL04++DQvz5vEFWdFHMdTWY16jw9X1vSFIOI6d4eVdZGQ23WiRqhscEjM/wy/tOwHGSk8LWY/L4vx/DcGwNWI7Ft8ydYBgrOPeX8Tanne9ocJPEXh8qWecXzcoJj7EN0uvLvBwosI=
Received: by 10.78.139.1 with SMTP id m1mr4921709hud.1164988073016;
        Fri, 01 Dec 2006 07:47:53 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 07:47:52 -0800 (PST)
Message-ID: <cda58cb80612010747t70d2d32au1debb4b5b8c4e6ec@mail.gmail.com>
Date:	Fri, 1 Dec 2006 16:47:52 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
Cc:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
In-Reply-To: <20061202002937.7b4cb749.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457042FF.2060908@innova-card.com>
	 <20061202002937.7b4cb749.yoichi_yuasa@tripeaks.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 12/1/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Hi,
>
> On Fri, 01 Dec 2006 15:58:07 +0100
> Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>
> >  config MACH_VR41XX
> >       bool "NEC VR41XX-based machines"
> >       select SYS_HAS_CPU_VR41XX
> > +     select GENERIC_HARDIRQS_NO__DO_IRQ
>
> NEC CMBVR4133 has i8259.
> The other vr41xx boards have no problem.
>

Thanks for testing.
-- 
               Franck
