Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 May 2009 10:42:54 +0100 (BST)
Received: from gateway05.websitewelcome.com ([64.5.52.8]:56353 "HELO
	gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20024100AbZECJms (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 May 2009 10:42:48 +0100
Received: (qmail 18296 invoked from network); 3 May 2009 09:44:36 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 3 May 2009 09:44:36 -0000
Received: from [217.109.65.213] (port=2204 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1M0YDc-0006kw-RQ; Sun, 03 May 2009 04:42:45 -0500
Message-ID: <49FD6716.9080309@paralogos.com>
Date:	Sun, 03 May 2009 11:42:46 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: initramfs breakage with 64-bits kernels?
References: <200904302141.53025.florian@openwrt.org> <10f740e80905030119u6f196b6bqe63003d502f9f731@mail.gmail.com> <49FD62D5.5000803@paralogos.com>
In-Reply-To: <49FD62D5.5000803@paralogos.com>
Content-Type: multipart/alternative;
 boundary="------------060909060201010000060503"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060909060201010000060503
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kevin D. Kissell wrote:
> Geert Uytterhoeven wrote:
>> You mean the test for initrd_start being non-zero? Is your initramfs
>> really at address zero? 
> I'm not set up to verify this, but I have a nagging suspicion that a
> big-endian 64-bit kernel build could store an initrd_start address
> with 32 or fewer significant bits (i.e. it starts in the first 4GB) as
> a 64-bit pointer, but that the code in initramfs.c is testing the
> value as a 32-bit scalar type.  I don't know about lmo but in
> kernel.org 2.6.29, it's declared in include/linux/initrd.h as an
> extern unsigned long, not a void *.
And yes, I know that MIPS64 builds *should* have data type equivalence
for longs and pointers, but this behavior just smells like a data typing
mismatch problem, at some level.

          Kevin K.

--------------060909060201010000060503
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Kevin D. Kissell wrote:
<blockquote cite="mid:49FD62D5.5000803@paralogos.com" type="cite">
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
Geert Uytterhoeven wrote:
  <blockquote
 cite="mid:10f740e80905030119u6f196b6bqe63003d502f9f731@mail.gmail.com"
 type="cite">You mean the test for initrd_start being non-zero? Is your
initramfs really at address zero?
  </blockquote>
I'm not set up to verify this, but I have a nagging suspicion that a
big-endian 64-bit kernel build could store an initrd_start address with
32 or fewer significant bits (i.e. it starts in the first 4GB) as a
64-bit pointer, but that the code in initramfs.c is testing the value
as a 32-bit scalar type.  I don't know about lmo but in kernel.org
2.6.29, it's declared in include/linux/initrd.h as an extern unsigned
long, not a void *. <br>
</blockquote>
And yes, I know that MIPS64 builds *should* have data type equivalence
for longs and pointers, but this behavior just smells like a data
typing mismatch problem, at some level.<br>
<br>
          Kevin K.<br>
</body>
</html>

--------------060909060201010000060503--
