Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 19:00:56 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:28634 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S32705264AbYGASAu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jul 2008 19:00:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id A879F2780D;
	Tue,  1 Jul 2008 20:00:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RtqeFE0FbOl5; Tue,  1 Jul 2008 20:00:40 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 9BA7943BE;
	Tue,  1 Jul 2008 20:00:40 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	kexec@lists.infradead.org
Subject: Re: kexec on mips - anyone has it working?
Date:	Tue, 1 Jul 2008 20:00:40 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>, linux-mips@linux-mips.org
References: <483BCB75.4050901@wpkg.org> <200807011542.29274.nschichan@freebox.fr> <486A6F0D.4070802@wpkg.org>
In-Reply-To: <486A6F0D.4070802@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200807012000.40421.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Tuesday 01 July 2008 19:53:17 Tomasz Chmielewski wrote:
> > Index: linux/arch/mips/kernel/machine_kexec.c
> > ===================================================================
> > --- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
> > +++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
> > @@ -49,6 +49,8 @@
> >  	unsigned long entry;
> >  	unsigned long *ptr;
> >
> > +	printk("image->start = %p", image->start);
> > +
> >  	reboot_code_buffer =
> >  	  (unsigned long)page_address(image->control_code_page);
>
> Umm?
>
>    CC      arch/mips/kernel/machine_kexec.o
> cc1: warnings being treated as errors
> arch/mips/kernel/machine_kexec.c: In function 'machine_kexec':
> arch/mips/kernel/machine_kexec.c:52: warning: format '%p' expects type
> 'void *', but argument 2 has type 'long unsigned int'
> make[6]: *** [arch/mips/kernel/machine_kexec.o] Error 1
> make[5]: *** [arch/mips/kernel] Error 2
> make[5]: Leaving directory
> `/home/tch-data/openwrt/11612/build_dir/linux-brcm47xx/linux-2.6.25.9'

-Werror is missing from my kernel cflags.

Try this one, %lx will accept unsigned long parameters without warnings:

Index: linux/arch/mips/kernel/machine_kexec.c
===================================================================
--- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
+++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
@@ -49,6 +49,8 @@
 	unsigned long entry;
 	unsigned long *ptr;
 
+	printk("image->start = %lx", image->start);
+
 	reboot_code_buffer =
 	  (unsigned long)page_address(image->control_code_page);
 

Regards,


-- 
Nicolas Schichan
