Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1480Vb03985
	for linux-mips-outgoing; Mon, 4 Feb 2002 00:00:31 -0800
Received: from coplin19.mips.com ([80.63.7.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1480NA03910
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 00:00:24 -0800
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g146x6U03946;
	Mon, 4 Feb 2002 07:59:06 +0100
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Mon, 4 Feb 2002 07:59:06 +0100 (CET)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: SNaN & QNaN on mips
In-Reply-To: <200202040746.g147k0A23002@oss.sgi.com>
Message-ID: <Pine.LNX.4.33.0202040752490.3812-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 4 Feb 2002, Zhang Fuxin wrote:

> hi,
> 
> Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
> optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
> (maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
>  say so.And experiments confirm this.

MIPS interprets Signalling NaN's different than e.g. Intel. According to 
IEEE754 it _is_ a matter of interpretation. 0x7fc00000 is an SNaN while 
0x7fbfffff is an QNaN. It would be great if you could fix it.

/Kjeld

> Should we correct it?
> 
> >
> >Regards
> >            Zhang Fuxin
> >            fxzhang@ict.ac.cn
> 
> Regards
>             Zhang Fuxin
>             fxzhang@ict.ac.cn
> 

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
