Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OKmW704210
	for linux-mips-outgoing; Wed, 24 Oct 2001 13:48:32 -0700
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OKmTD04203
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 13:48:29 -0700
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id QAA26555;
	Wed, 24 Oct 2001 16:48:13 -0400
Date: Wed, 24 Oct 2001 16:48:13 -0400 (EDT)
From: <nick@snowman.net>
X-Sender: nick@ns
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200
In-Reply-To: <20011024224008.A2045@mail.muni.cz>
Message-ID: <Pine.LNX.4.21.0110241647490.25602-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id f9OKmUD04205
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I had very similar problems, where does it oops?  I lost access to the
origin that was haveing problems before tracking it down :(.
	Nick

On Wed, 24 Oct 2001, Lukas Hejtmanek wrote:

> 
> Is someone here who succesfully booted up an 1 processor Origin 200? I've tried
> to boot some kernels -- result freeze without oops or oops result. Kernel 2.4.10
> is configured with defconfig-ip27, with or without SMP support. Everything seems
> to get the same result.
> 
> Is there any remote gdb howto? Especially for origin where serial port is used
> as serial console. (I think gdb must connect to kernel before oops or freeze)
> 
> -- 
> Luká¹ Hejtmánek
> 
