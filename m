Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 May 2009 10:24:47 +0100 (BST)
Received: from gateway05.websitewelcome.com ([67.18.15.4]:46469 "HELO
	gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20024084AbZECJYl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 May 2009 10:24:41 +0100
Received: (qmail 26216 invoked from network); 3 May 2009 09:26:28 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 3 May 2009 09:26:28 -0000
Received: from [217.109.65.213] (port=2140 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1M0Xw3-0002qS-V6; Sun, 03 May 2009 04:24:36 -0500
Message-ID: <49FD62D5.5000803@paralogos.com>
Date:	Sun, 03 May 2009 11:24:37 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: initramfs breakage with 64-bits kernels?
References: <200904302141.53025.florian@openwrt.org> <10f740e80905030119u6f196b6bqe63003d502f9f731@mail.gmail.com>
In-Reply-To: <10f740e80905030119u6f196b6bqe63003d502f9f731@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------080101070409010603030905"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080101070409010603030905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Geert Uytterhoeven wrote:
> On Thu, Apr 30, 2009 at 21:41, Florian Fainelli <florian@openwrt.org> wrote:
>   
>> I have been trying to get a 2.6.29 64-bits kernel for Cavium Octeon to work
>> with a 32-bits userland in an initramfs. While booting, the kernel does not
>> find the initramfs due to the check against initrd_start in populate_rootfs
>> (init/initramfs.c) failing.
>>     
>
> You mean the test for initrd_start being non-zero? Is your initramfs really at
> address zero?
I'm not set up to verify this, but I have a nagging suspicion that a
big-endian 64-bit kernel build could store an initrd_start address with
32 or fewer significant bits (i.e. it starts in the first 4GB) as a
64-bit pointer, but that the code in initramfs.c is testing the value as
a 32-bit scalar type.  I don't know about lmo but in kernel.org 2.6.29,
it's declared in include/linux/initrd.h as an extern unsigned long, not
a void *.  Little endian builds wouldn't see such a problem.

          Regards,

          Kevin K.

--------------080101070409010603030905
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Geert Uytterhoeven wrote:
<blockquote
 cite="mid:10f740e80905030119u6f196b6bqe63003d502f9f731@mail.gmail.com"
 type="cite">
  <pre wrap="">On Thu, Apr 30, 2009 at 21:41, Florian Fainelli <a class="moz-txt-link-rfc2396E" href="mailto:florian@openwrt.org">&lt;florian@openwrt.org&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have been trying to get a 2.6.29 64-bits kernel for Cavium Octeon to work
with a 32-bits userland in an initramfs. While booting, the kernel does not
find the initramfs due to the check against initrd_start in populate_rootfs
(init/initramfs.c) failing.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You mean the test for initrd_start being non-zero? Is your initramfs really at
address zero?</pre>
</blockquote>
I'm not set up to verify this, but I have a nagging suspicion that a
big-endian 64-bit kernel build could store an initrd_start address with
32 or fewer significant bits (i.e. it starts in the first 4GB) as a
64-bit pointer, but that the code in initramfs.c is testing the value
as a 32-bit scalar type.  I don't know about lmo but in kernel.org
2.6.29, it's declared in include/linux/initrd.h as an extern unsigned
long, not a void *.  Little endian builds wouldn't see such a problem.<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
</body>
</html>

--------------080101070409010603030905--
