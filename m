Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8KCLwR21461
	for linux-mips-outgoing; Thu, 20 Sep 2001 05:21:58 -0700
Received: from bacchus-int.veritas.com (bacchus.veritas.com [204.177.156.37])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8KCLre21458
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 05:21:53 -0700
Received: from megami.veritas.com (megami-13.veritas.com [166.98.13.101])
	by bacchus-int.veritas.com (8.11.2/8.11.2) with SMTP id f8KCLaF14876;
	Thu, 20 Sep 2001 05:21:36 -0700 (PDT)
Received: from vxindia.veritas.com(vxindia.vxindia.veritas.com[202.41.69.5]) (3137 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <akale@veritas.com>) 
	id <m15k2pj-0003RnC@megami.veritas.com>
	for <gdb@sourceware.cygnus.com>; Thu, 20 Sep 2001 05:21:35 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Received: from veritas.com (hysteria.vxindia.veritas.com [10.212.2.46])
	by vxindia.veritas.com (8.9.3/8.9.3) with ESMTP id RAA13346;
	Thu, 20 Sep 2001 17:48:57 +0530 (IST)
Message-ID: <3BA9DC21.6E5FE0FA@veritas.com>
Date: Thu, 20 Sep 2001 17:38:01 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: sjhill@cotw.com
CC: binutils@sources.redhat.com, gdb@sourceware.cygnus.com,
   linux-mips@oss.sgi.com
Subject: Re: Continued MIPS kernel debugging symbols problem...
References: <3BA16CAA.6B4DF4A1@cotw.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

If you are debugging linux kernel modules, you may find
the loadmodule.sh script from http://kgdb.sourceforge.net/
useful to get a gdb script to load module object files.

"Steven J. Hill" wrote:
> 
> Greetings.
> 
> I have tried everything I can to get Linux kernel debugging
> symbols to work properly. I apologize for posting to so
> many lists too, but I really need to get this working. I
> traded a few emails with HJ Lu and he referred me to the
> following messages/threads:
> 
>    http://sources.redhat.com/ml/gdb/2001-08/msg00053.html
>    http://sources.redhat.com/ml/gdb/2001-08/msg00079.html
>    http://sources.redhat.com/ml/gdb/2001-08/msg00084.html
> 
> I did read them a few times and it appears that all the
> necessary changes are in the current gdb and insight CVS
> repositories. I checked out the latest sources a half
> hour ago and compiled both gdb and insight using the
> configuration line:
> 
>     configure --prefix=/opt/tools --target=mipsel-linux-elf
> 
> since my target is a NEC 5432 running in LE mode. I had
> also tried 'mips-linux-elf' targets earlier in the day
> with no difference. I am still getting the following
> mismatch in symbols:
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
> (gdb) c
> Continuing.
> --------------------------------------------------------------------
> 
> I compiled my kernel with a toolchain that used the following
> versions of tools:
> 
>     binutils-2.11.90.0.31 (HJLu patches applied)
>     gcc-3.0.1 (stock)
>     glibc-2.2.3 (minor build patches)
> 
> Things are still not working and I would greatly appreciate some
> direction. I've blown a whole day this and am a bit frazzled.
> Thanks a bunch in advance.
> 
> -Steve
> 
> --
>  Steven J. Hill - Embedded SW Engineer

-- 
Amit Kale
Veritas Software India ( http://www.veritasindia.com/ )
