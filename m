Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QME5U12281
	for linux-mips-outgoing; Fri, 26 Oct 2001 15:14:05 -0700
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QMDq012275;
	Fri, 26 Oct 2001 15:13:53 -0700
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id SAA18068;
	Fri, 26 Oct 2001 18:13:24 -0400
Date: Fri, 26 Oct 2001 18:13:24 -0400 (EDT)
From: <nick@snowman.net>
X-Sender: nick@ns
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Origin 200
In-Reply-To: <20011026163117.B27258@mail.muni.cz>
Message-ID: <Pine.LNX.4.21.0110261813050.17972-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id f9QMDu012277
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

That was the same "fix" I came across.  I'm still not sure why though.
	Nick

On Fri, 26 Oct 2001, Lukas Hejtmanek wrote:

> On Thu, Oct 25, 2001 at 12:14:50PM +0200, Ralf Baechle wrote:
> > Btw, Origin UP kernel is definately broken ...
> 
> I think I've tracked down what makes freeze. If I use default config but
> network card driver and scsi driver (seems to be generic PCI device) kernel
> boots up to message I have no root (any time and not freezes I've changed little
> bit sources to print '... waiting ...' every 2 seconds in infinite loop before
> it does panic -- no root).
> 
> So I think there is some deadlock after some PCI device driver init that does
> not occur in SMP mode.
> 
> -- 
> Luká¹ Hejtmánek
> 
