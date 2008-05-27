Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 13:49:49 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:46006 "HELO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with SMTP
	id S20044076AbYE0Mtr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 May 2008 13:49:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 807A916586;
	Tue, 27 May 2008 14:49:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U6O4-c5-g8bx; Tue, 27 May 2008 14:49:45 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 46763F232;
	Tue, 27 May 2008 14:49:45 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: kexec on mips - anyone has it working?
Date:	Tue, 27 May 2008 14:49:44 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <483BCB75.4050901@wpkg.org> <200805271405.55346.nschichan@freebox.fr> <483C0135.9070203@wpkg.org>
In-Reply-To: <483C0135.9070203@wpkg.org>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805271449.45124.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Tuesday 27 May 2008 14:40:21 you wrote:
> > Could you try to add the following line in machine_kexec.c, just before
> > jumping to the trampoline:
> >
> >        change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
>
> And machine_kexec.c file is in where? It's not in the above one, it's
> not in kexec-tools-testing-20080324?


machine_kexec.c is in the kernel not in the kexec userland tools.

it's in arch/mips/kernel/machine_kexec.c, just apply the following patch:

--- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
+++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
@@ -81,5 +81,6 @@
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
 	__flush_cache_all();
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
 	((noretfun_t) reboot_code_buffer)();
 }



-- 
Nicolas Schichan
