Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 14:42:44 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:20421 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S30613934AbYGANmh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jul 2008 14:42:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id CE5302AE93;
	Tue,  1 Jul 2008 15:42:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wyuBsemcEl1S; Tue,  1 Jul 2008 15:42:29 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id A42192AE47;
	Tue,  1 Jul 2008 15:42:29 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: kexec on mips - anyone has it working?
Date:	Tue, 1 Jul 2008 15:42:28 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>,
	openwrt-devel@lists.openwrt.org
References: <483BCB75.4050901@wpkg.org> <200805301327.11925.nschichan@freebox.fr> <483FE764.1090901@wpkg.org>
In-Reply-To: <483FE764.1090901@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200807011542.29274.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Friday 30 May 2008 13:39:16 Tomasz Chmielewski wrote:

Hello,

> Nicolas Schichan schrieb:
> > On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
> >> Will call new kernel at 00305000
> >
> > The calling address of the kernel looks quite wrong, it should clearly
> > be inside the KSEG0 zone. could  you please indicate the output of the
> > command "mips-linux-readelf -l vmlinux" ?
>
> # uname -m
> mips
> # readelf -l vmlinux
>
> Elf file type is EXEC (Executable file)
> Entry point 0x80251b50

This is  quite surprising.   The jump address  that kexec will  use is
cleary not what  I expected. I would have expected it  to be the Entry
point address given by readelf.

could  you try  the  following patch  to  make sure  that the  kimage*
structure is not corrupted by the code in machine_kexec() ?

Index: linux/arch/mips/kernel/machine_kexec.c
===================================================================
--- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
+++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
@@ -49,6 +49,8 @@
 	unsigned long entry;
 	unsigned long *ptr;
 
+	printk("image->start = %p", image->start);
+
 	reboot_code_buffer =
 	  (unsigned long)page_address(image->control_code_page);
 


Regards,

-- 
Nicolas Schichan
