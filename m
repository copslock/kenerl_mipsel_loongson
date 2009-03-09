Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 15:45:24 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:19719 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S21367121AbZCIPpT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 15:45:19 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id PAA16671;
	Sun, 8 Mar 2009 15:23:08 -0600
Message-ID: <49B53987.8020206@paralogos.com>
Date:	Mon, 09 Mar 2009 10:45:11 -0500
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
CC:	linux-mips@linux-mips.org
Subject: Re: Ingenic JZ4730 - illegal instruction
References: <49B1510B.8020606@kernelconcepts.de> <49B4D5BC.5020203@paralogos.com> <49B4E8BB.8080704@kernelconcepts.de> <49B523B6.6090006@paralogos.com> <49B5302F.4070301@kernelconcepts.de>
In-Reply-To: <49B5302F.4070301@kernelconcepts.de>
Content-Type: multipart/alternative;
 boundary="------------050905060109090504070609"
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050905060109090504070609
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Nils Faerber wrote:
> Kevin D. Kissell schrieb:
>   
>> Are you sure that the JZ_RISC section is in fact the version of those
>> functions that's being built into your kernel?
>>     
>
> Well, there is CONFIG_JZRISC=y in the kernel .config and a
> switch(current_cpu_type) { case CPU_JZRISC: ...} so I would assume it is
> being used. But I will verify that the CONFIG_JZRISC=y is correctly
> translated into a current_cpu_type.
>   
Your assumption is reasonable.  But given that things aren't working, 
yes, it's good to verify.
> Oh, one last question, in order to rule out the cache as bug-spot would
> the kernel option "run uncached" "solve" the issue (and be darn slow)?
>   
It would certainly solve the issue, and would *probably* result in a 
system that would be fully functional but slow.  Very high end and very 
low end systems can be rendered unusable by forcing uncached operation, 
but it's certainly worth a try.  Also, if your cache control logic 
supports both write-back and write-through operation, if you set the 
default cache "attribute" for kernel and page tables (which is 
essentially what you're doing under-the-hood when you configure for 
uncached operation) to write-through, that should cure the problems with 
copying text pages, but *not* those with re-using them, with less 
performance impact.  I'd be a little surprised if the Ingenic part 
offered both modes, though.

          Regards,

          Kevin K.

--------------050905060109090504070609
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Nils Faerber wrote:
<blockquote cite="mid:49B5302F.4070301@kernelconcepts.de" type="cite">
  <pre wrap="">Kevin D. Kissell schrieb:
  </pre>
  <blockquote type="cite">
    <pre wrap="">
Are you sure that the JZ_RISC section is in fact the version of those
functions that's being built into your kernel?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, there is CONFIG_JZRISC=y in the kernel .config and a
switch(current_cpu_type) { case CPU_JZRISC: ...} so I would assume it is
being used. But I will verify that the CONFIG_JZRISC=y is correctly
translated into a current_cpu_type.
  </pre>
</blockquote>
Your assumption is reasonable.  But given that things aren't working,
yes, it's good to verify.<br>
<blockquote cite="mid:49B5302F.4070301@kernelconcepts.de" type="cite">
  <pre wrap="">
Oh, one last question, in order to rule out the cache as bug-spot would
the kernel option "run uncached" "solve" the issue (and be darn slow)?
  </pre>
</blockquote>
It would certainly solve the issue, and would *probably* result in a
system that would be fully functional but slow.  Very high end and very
low end systems can be rendered unusable by forcing uncached operation,
but it's certainly worth a try.  Also, if your cache control logic
supports both write-back and write-through operation, if you set the
default cache "attribute" for kernel and page tables (which is
essentially what you're doing under-the-hood when you configure for
uncached operation) to write-through, that should cure the problems
with copying text pages, but *not* those with re-using them, with less
performance impact.  I'd be a little surprised if the Ingenic part
offered both modes, though.<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
</body>
</html>

--------------050905060109090504070609--
