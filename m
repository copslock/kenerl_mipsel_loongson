Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HGQtnC025418
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 09:26:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HGQtxU025417
	for linux-mips-outgoing; Mon, 17 Jun 2002 09:26:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HGQonC025414
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 09:26:51 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b8a7632e48947197216d@nwd2mime2.analog.com>;
 Mon, 17 Jun 2002 12:30:26 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb1.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id MAA06968; Mon, 17 Jun 2002 12:29:17 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id JAA02224;
	Mon, 17 Jun 2002 09:29:15 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id JAA02742;
	Mon, 17 Jun 2002 09:29:15 -0700 (PDT)
Message-ID: <3D0E0E5B.C41AC2DF@analog.com>
Date: Mon, 17 Jun 2002 09:29:15 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Balakrishnan Ananthanarayanan <balakris_ananth@email.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Code error - why?
References: <20020617094851.30730.qmail@email.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Balakrishnan Ananthanarayanan wrote:
> 
> I wrote a SAMPLE CODE - Hello.S to work for a cross-assembler mips-linux-as - but this is giving me an error message:
>    ".data
>          quest: .asciiz "Hello World!"
>     .text
>     _start:
>          la $a0, quest
>          li $v0, 4
>          syscall   "
> 
> The error messages are:
>   " Hello.S line 5: illegal operands 'la'
>     Hello.S line 6: illegal operands 'li'"
> 
> Can anyone help? What is wrong?
> 

$a0 and $v0 are what's probably giving you grief. Are you relying on
the assembler to know these symbols or are you including a file that
defines them. 

Just to be sure, try replacing $a0 with $4 and $v0 with $2 and see if
the code builds.

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
