Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47MWYwJ011295
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 15:32:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47MWYCd011294
	for linux-mips-outgoing; Tue, 7 May 2002 15:32:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47MWTwJ011291
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 15:32:29 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id PAA33770;
	Tue, 7 May 2002 15:33:51 -0700 (PDT)
Date: Tue, 7 May 2002 15:33:51 -0700
From: Geoffrey Espin <espin@idiom.com>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Debugging of embedded target applications
Message-ID: <20020507153351.B12509@idiom.com>
References: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX>; from Siders, Keith on Tue, May 07, 2002 at 05:05:36PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 05:05:36PM -0500, Siders, Keith wrote:
> I am using x86 Linux for host development to a MIPS Linux embedded target. I
> finally have a hardware debugger for my target board that works, but I have
> to get large application files downloaded in a timely fashion. The debugger
> must download to the target via JTAG, therefore downloads have lots of bits
> of overhead, i.e. downloads are slow. Is there anything like a gdb server
> that can I run on the target to connect to a remote client via ethernet? I

If you have a Linux Ethernet driver working, then most people
boot and mount with an NFS root disk.  Then you just cross-compile
additional apps and tools and adding to your NFS disk.  Presumably
including gdb (not tried it).  Then just debug "normally" -- with
the CLI.  The JTAG hardware debugger is not used (or maybe just
to initially bootstrap the kernel and trap certain exceptions).

RH7.1 fs at: ftp://ftp.linux.sgi.com/pub/linux/mips/mipsel-linux/root/
And see: http://www.linux.sgi.com/downloads.html

Once your basic apps are complete, then you can think about
creating a JFFS2 partition (after the MTD flash driver's debuggged)
and using that for standalone bootup.

Actually, my first approach was to flash the linux kernel with
just a cramfs'd busybox and then NFS mount my home directory from
a startup script.

To save (a lot of) space in applications checkout uclibc.org.
Shared libs support with uclibc is real close for MIPS, but for
now use static linking.

Geoff
-- 
Geoffrey Espin
espin@idiom.com
--
