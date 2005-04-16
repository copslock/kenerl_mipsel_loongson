Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2005 23:59:56 +0100 (BST)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:26528
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8226111AbVDPW7k>; Sat, 16 Apr 2005 23:59:40 +0100
Received: from fwd28.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1DMwGH-0001BB-00; Sun, 17 Apr 2005 00:59:37 +0200
Received: from denx.de (GiQXaTZSZeaW4SMdMrc4MKQooUrETCOudjwNTK8+NJO3qNM+HFmJE+@[84.150.88.129]) by fwd28.sul.t-online.de
	with esmtp id 1DMwGD-1rOUTI0; Sun, 17 Apr 2005 00:59:33 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id ED1F542BB0; Sun, 17 Apr 2005 00:59:32 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id D620AC108D; Sun, 17 Apr 2005 00:59:31 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id D3C5E13D94A; Sun, 17 Apr 2005 00:59:31 +0200 (MEST)
To:	cordova@uninet.com.br
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: Linux for RouterBoard532 - CPU MIPS32 4Kc - IDT 79RC32434. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sat, 16 Apr 2005 11:33:45 -0300."
             <42612249.1fb.7a40.2093672349@uninet.com.br> 
Date:	Sun, 17 Apr 2005 00:59:26 +0200
Message-Id: <20050416225931.D620AC108D@atlas.denx.de>
X-ID:	GiQXaTZSZeaW4SMdMrc4MKQooUrETCOudjwNTK8+NJO3qNM+HFmJE+@t-dialin.net
X-TOI-MSGID: e97210a2-b8df-4123-a062-a181e822e096
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <42612249.1fb.7a40.2093672349@uninet.com.br> you wrote:
> 
> I´d just bought Routerboard532 (
> http://www.routerboard.com/rb500.html ) and I want to port
> linux to this board. The vendor has just an linux image on
> the web site.

This is not correct. If you just scroll  down  the  page  you  listed
yoursself,   then   you   should   easily  find  the  section  titled
"RouterBOARD 500 GNU/Linux support files" which includes  a  link  to
"Patch for Linux 2.4.29 kernel".

> Anyone could help me we some info or "HOWTO" ?

Download the patch, download the corresponding  kernel  source  tree,
apply  patch,  copy  "config.mipsel"  to  ".config"  to get a default
configuration, build the kernel, download it, run it.

So far I haven't been able to find out how to pass  kernel  arguments
with their boot loader, so you may have to hack rc32434/rb500/prom.c

I used the mips_4KCle packages of the ELDK to build the kernel and to
provide a root filesystem over NFS - this worked fine. There are some
problems (like not being able to switch the CPU clock and NAND  flash
support not working at all), but it boots and runs.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
