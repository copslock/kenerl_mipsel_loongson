Received:  by oss.sgi.com id <S553837AbRB1WzX>;
	Wed, 28 Feb 2001 14:55:23 -0800
Received: from erebus.lineo.com ([64.50.107.39]:26240 "HELO erebus.lineo.com")
	by oss.sgi.com with SMTP id <S553663AbRB1Wy5>;
	Wed, 28 Feb 2001 14:54:57 -0800
Received: by erebus.lineo.com (Postfix, from userid 441)
	id 3949038C58; Wed, 28 Feb 2001 15:53:37 -0700 (MST)
Date:   Wed, 28 Feb 2001 15:53:37 -0700
From:   Curtis Veit <curtisv@lineo.com>
To:     ldavies@oz.agile.tv
Cc:     linux-mips@oss.sgi.com
Subject: Re: Small remote debug kernels??
Message-ID: <20010228155337.A1136@lineo.com>
Reply-To: curtisv@lineo.com
References: <3A95E682.982AC529@agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3A95E682.982AC529@agile.tv>; from ldavies@agile.tv on Fri, Feb 23, 2001 at 02:26:42PM +1000
X-No-Junk-Mail: Beware - Local law allows collection of damages for spam.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi Liam,

On Fri, Feb 23, 2001 at 02:26:42PM +1000, Liam Davies wrote:
> I would like to remote debug my kernel.
> On the Cobalt box I have there is (allegedly) a bootloader bug that
> stops the
> kernel being any larger than 1M/2.5M, compressed/uncompressed.
> I have stripped the kernel bare but can't get much lower than 6M
> uncompressed.
> 
> Is there any way I can have a mini-remote debugging kernel??

It sounds like the kernel on the target system still has the
debug symbols in it. The symbols are actually only needed 
in the kernel on the host end.  (present on the same machine
as gdb.)

You can strip the kernel you put on your target with
	strip --strip-unneeded vmlinux
This should allow you to use more then a bare kernel.

It seems that you have fallen prey to a common misconception
about remote debugging.  Hope this helps.

Regards,

Curtis Veit
curtisv@lineo.com
