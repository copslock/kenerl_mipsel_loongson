Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFAFI617866
	for linux-mips-outgoing; Sat, 15 Dec 2001 02:15:18 -0800
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFAFDo17863
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 02:15:14 -0800
Received: (qmail 1941 invoked from network); 15 Dec 2001 09:15:09 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 15 Dec 2001 09:15:09 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 06747300095; Sat, 15 Dec 2001 20:15:05 +1100 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 8C0DE96; Sat, 15 Dec 2001 20:15:05 +1100 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: No bzImage target for MIPS 
In-reply-to: Your message of "Sat, 15 Dec 2001 09:31:01 BST."
             <20011215093101.A256@excalibur.cologne.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 15 Dec 2001 20:14:59 +1100
Message-ID: <20472.1008407699@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 15 Dec 2001 09:31:01 +0100, 
Karsten Merker <karsten@excalibur.cologne.de> wrote:
>On Fri, Dec 14, 2001 at 10:52:57AM -0800, Geoffrey Espin wrote:
>> BTW, does any actually build 'vmlinux.ecoff'?
>
>Yes, it is (among other uses) the default target for DECstations,
>the DECstation firmware cannot tftp-boot anything else.

I am standardizing the list of supported formats for linux boot, as
part of the kbuild 2.5 rewrite, I will add vmlinux.ecoff to the master
list.

AFAICT ecoff is only used on mips but, since ecoff is not an arch
specific object format, it makes sense to make it a generic kbuild
target, like elf, srec and bin.  To that end, I looked at moving
elf2ecoff and addinitrd to an arch independent directory so everybody
could use those tools, alas both contain mips specific code.  Any idea
how much work is required to make elf2ecoff and addinitrd into generic
utilities?  Is it worth the effort or should they stay as mips only?
