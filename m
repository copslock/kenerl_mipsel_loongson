Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 01:39:41 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.149]:60928 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493926AbZKRAjf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2009 01:39:35 +0100
Received: by ey-out-1920.google.com with SMTP id 4so134946eyg.52
        for <linux-mips@linux-mips.org>; Tue, 17 Nov 2009 16:39:35 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=5dfwbG/OTJi+1ZHaTvMW9ivhHbmkVRiMuDKhV/Pv8RM=;
        b=N6slwfwBUhcBUCJ8ltSsSqsVRB3JaK+cH2j/04cq12MnlWrJ+/kEoP/oKrsHxYhS+4
         d1SmZq4wANSwenBHL1weK4Gw5sAHQJH+UBRijIne7C0qCZaXhLiH3yYHOMATbHqsvq9v
         EkLFsIRQh/YiKBx6j+01zvm7KrgRfZiYQb0hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=ZAc06oR4SjvYS9YgQ1I0OHuHfSz2mbhzi0X94pyeZCcf7LOhZzzl0uu3aL2SpIFtyv
         9bo2DEUtXqNs707NiSGv0WU9l25Zap69G5A9iWfjpbbXcVKfqgW2EcVGpUeg0r8APcw4
         YndgbME11jjsYYdpQcBo+Jf/m6KjXsh520fmo=
Received: by 10.213.104.78 with SMTP id n14mr2838851ebo.98.1258504775123;
        Tue, 17 Nov 2009 16:39:35 -0800 (PST)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id 28sm1015537eyg.6.2009.11.17.16.39.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 16:39:34 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:	myuboot@fastmail.fm
Subject: Re: problem bring up initramfs and busybox
Date:	Wed, 18 Nov 2009 01:39:28 +0100
User-Agent: KMail/1.12.1 (Linux/2.6.30-2-686; KDE/4.3.2; i686; ; )
Cc:	"Chris Dearman" <chris@mips.com>,
	"linux-mips" <linux-mips@linux-mips.org>
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <4B031B78.5030204@mips.com> <1258504293.3627.1345755107@webmail.messagingengine.com>
In-Reply-To: <1258504293.3627.1345755107@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200911180139.29283.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

Le mercredi 18 novembre 2009 01:31:33, myuboot@fastmail.fm a écrit :
> On Tue, 17 Nov 2009 13:54 -0800, "Chris Dearman" <chris@mips.com> wrote:
> > Kevin D. Kissell wrote:
> > > This looks like another boot file system setup problem to me.  Are you
> > > sure that there's an executable init image at /mnt/root/sbin/init?  I'm
> > > pretty sure that the path that you provide to your new init has to be
> > > relative to the new root.
> >
> > That sounds right.
> >
> > Andrew, my suggestion would be to change your initramfs /init script to
> > invoke "/bin/busybox sh" as the last command instead of "exec
> > switch_root". The "Kernel panic - not syncing: Attempted to kill init!"
> > says that switch_root is exiting for some reason. It could be anything
> > from missing files/devices on the /mnt/root file system to a bug in
> > busy_box.
> > By booting into the shell you can run the command by hand (maybe with
> > strace if you have it) to help identify where the problem is.
> >
> > Chris
> 
> Chris,
> 
> Thanks for your response. Now I changed my init file to the following -
> #!/bin/busybox sh
> mount -t proc proc /proc
> mount -t sysfs sysfs /sys
> mdev -s
> /bin/busybox sh
> 
> The Kernel panic is gone but the shell still does not come up. Somehow
> there is no printout on the screen.  Below is the error info.
> I have tried similar things previously. I also tried using a statically
> linked hello world in the place of init script. But the result is
> similar - no print out from either hello world or busybox.
> [  1.169000] TCP cubic registered
> [    1.173000] NET: Registered protocol family 17
> [   15.811000] Freeing unused kernel memory: 1032k freed
> [   33.978000] Algorithmics/MIPS FPU Emulator v1.5
> 
> And here is the trace on BDI -
> gdb) c
> Continuing.
> 
> Breakpoint 2, do_execve (filename=0x9780a000 "/init", argv=0x943dd2bc,
> envp=0x943dd230, regs=0x97819e30)
>     at fs/exec.c:1293
> 1293            retval = unshare_files(&displaced);
> (gdb) c
> Continuing.
> 
> Breakpoint 2, do_execve (filename=0x9780a000 "/bin/busybox",
> argv=0x4f73dc, envp=0x4f73ec, regs=0x97987f30)
>     at fs/exec.c:1293
> 1293            retval = unshare_files(&displaced);
> (gdb) c
> Continuing.
> ^C
> Program received signal SIGSTOP, Stopped (signal).
> r4k_wait () at arch/mips/kernel/genex.S:147
> 147             jr      ra
> Current language:  auto; currently asm
> 
> Let me provide some history about what I am trying to do here in case it
> is relevant to the issue. I have a MIPS32 board very similar to AR7.
> Previously it has working toolchain/u-boot/kernel. I changed the board
> from little endian to big endian mode and have been trying to upgrade
> the toolchain/u-boot/kernel (gcc 4.4.1/u-boot2009.08/kernel 2.6.31). I
> made some changes to the u-boot and kernel on console initialisation in
> order to bring up the console. Up to the point, the kernel comes up
> normally.
> 
> Since the time I start porting, I have been wondering if any change
> related to exception needs to be done due to the endianess change. But
> recently I found an AR7 patch for big endian mode(
> https://lists.openwrt.org/pipermail/openwrt-devel/2009-May/004262.html)
> and I did not see any change related to exception there. I hope the
> issue is not something related to exception that messes up the
> execution. Sorry if the above is a stupid question. I am trying to learn
> embedded system. Your suggestion will be appreciated.

If your board is similar to AR7, then you might need the following patch which 
allows you to cope with the different physical offsets on AR7: 
http://www.linux-mips.org/archives/linux-mips/2009-06/msg00004.html
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
