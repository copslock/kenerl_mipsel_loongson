Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DK3uI12688
	for linux-mips-outgoing; Thu, 13 Sep 2001 13:03:56 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DK3te12685
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 13:03:55 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2C025125C3; Thu, 13 Sep 2001 13:03:54 -0700 (PDT)
Date: Thu, 13 Sep 2001 13:03:54 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: Corrupted symbols for MIPS debugging...
Message-ID: <20010913130354.A29649@lucon.org>
References: <3BA10C29.713DB745@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA10C29.713DB745@cotw.com>; from sjhill@cotw.com on Thu, Sep 13, 2001 at 02:42:33PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 13, 2001 at 02:42:33PM -0500, Steven J. Hill wrote:
> 
> --------------------------------------------------------------------
> (gdb) target remote /dev/ttyS1
> Remote debugging using /dev/ttyS1
> 0x80012828 in breakinst () at af_packet.c:1879
> 1879            sock_unregister(PF_PACKET);
> (gdb) bt
> #0  0x80012828 in breakinst () at af_packet.c:1879
> #1  0x8001a0d4 in sys_create_module (name_user=0x10001dc8 "cfi_probe", 
>     size=8176) at module.c:305

Please provide

(gdb) list breakinst
(gdb) print breakinst


H.J.
