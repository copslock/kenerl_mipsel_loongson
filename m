Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g147t0031248
	for linux-mips-outgoing; Sun, 3 Feb 2002 23:55:00 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g147svA31223
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 23:54:57 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A7D26125C8; Sun,  3 Feb 2002 22:54:54 -0800 (PST)
Date: Sun, 3 Feb 2002 22:54:54 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: SNaN & QNaN on mips
Message-ID: <20020203225454.A5158@lucon.org>
References: <200202040746.g147k0A23002@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202040746.g147k0A23002@oss.sgi.com>; from fxzhang@ict.ac.cn on Mon, Feb 04, 2002 at 02:22:48PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 02:22:48PM +0800, Zhang Fuxin wrote:
> hi,
> 
> Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
> optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
> (maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
>  say so.And experiments confirm this.
> 
> Should we correct it?

Yes. Do you have a patch?

Thanks.


H.J.
