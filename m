Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jan 2003 00:27:47 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:17619 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225256AbTAaA1q>;
	Fri, 31 Jan 2003 00:27:46 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h0UNYRKp018044;
	Thu, 30 Jan 2003 15:34:28 -0800
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA13878; Fri, 31 Jan 2003 11:27:40 +1100
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 53B5A300087; Fri, 31 Jan 2003 11:27:40 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 2A63A8F; Fri, 31 Jan 2003 11:27:40 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How to get the c source code in disassembly? 
In-reply-to: Your message of "Thu, 30 Jan 2003 14:45:43 -0800."
             <20030130224543.7903.qmail@web40414.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Jan 2003 11:27:34 +1100
Message-ID: <27733.1043972854@kao2.melbourne.sgi.com>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Thu, 30 Jan 2003 14:45:43 -0800 (PST), 
Long Li <long21st@yahoo.com> wrote:
>I am having a problem with intermixing the C source
>code in the disassembly. I am using a MIPS
>crosscompiler on Redhat 7.1, gcc-3.0.4,
>binutils-2.11.2. When I compiled the C code, I added
>the -g option, and then use 'objdump -Sd' to get the
>disassembly. However, I did not see any C code mixed
>with the assembly, as said in the objdump manual when
>using -S option. Could you give me some help or
>suggestions? 

objdump -S only works when the code is compiled with -g.  And sometimes
not even then, objdump -S is flaky for ia64, although that could be the
old gcc/binutils I have to use :(.
