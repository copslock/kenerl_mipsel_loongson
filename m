Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 02:21:58 +0200 (CEST)
Received: from wx-out-0102.google.com ([66.249.82.195]:32787 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133896AbWE0AVp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 May 2006 02:21:45 +0200
Received: by wx-out-0102.google.com with SMTP id t5so131051wxc
        for <linux-mips@linux-mips.org>; Fri, 26 May 2006 17:21:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IRINFfAqAb2DomRa+vVY8Cwrf278vqeotU8075W35by46id/Ukc7s3ipvsF6nWb7RmW3VD34NKQzEowWCZ7GhwAvVmUICjQiOUGV2nOI0ZHihCwjMgnJq80dQtCfqEZX7MWmAoCfnAcOpZQlRxOw1VzEvzLGGTfo+8WqgL7+eRk=
Received: by 10.70.74.1 with SMTP id w1mr29686wxa;
        Fri, 26 May 2006 17:21:44 -0700 (PDT)
Received: by 10.70.22.11 with HTTP; Fri, 26 May 2006 17:21:44 -0700 (PDT)
Message-ID: <404548f40605261721r411b8321gdda239d82feace18@mail.gmail.com>
Date:	Fri, 26 May 2006 17:21:44 -0700
From:	"Tony Lin" <lin.tony@gmail.com>
To:	"Johannes Stezenbach" <js@linuxtv.org>
Subject: Re: Can't debug core files with GDB
Cc:	"Daniel Jacobowitz" <dan@debian.org>,
	"ashley jones" <ashley_jones_2000@yahoo.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20060526113943.GB14036@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com>
	 <20060524081406.90333.qmail@web38407.mail.mud.yahoo.com>
	 <404548f40605241844y41b897b6sb8a7512feb8655f6@mail.gmail.com>
	 <20060525133529.GA31379@nevyn.them.org>
	 <404548f40605251750s2708df73td50a4e9db755408f@mail.gmail.com>
	 <20060526024540.GA16815@nevyn.them.org>
	 <20060526113943.GB14036@linuxtv.org>
Return-Path: <lin.tony@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lin.tony@gmail.com
Precedence: bulk
X-list: linux-mips

Finally found the place in gdb to change the register values to read
the coredump correctly. However I have a nagging feeling that I may
not have configured gdb correctly , and my fix may not be the right
one. But oh wells, at least it works!

cross-compiled on: i386-linux
configured gdb using: ../gdb/configure --target=mips-linux
gdb-6.4, kernel 2.6.6-rc3, gcc-3.4.3

*** mips-linux-tdep.c   2006-05-26 17:14:00.577339000 -0700
--- mips-linux.tdep.c~  2006-05-26 17:15:53.723372000 -0700
***************
*** 54,65 ****
--- 54,76 ----
+
+ /* NEW 2.6 style */
+ #define EF_CP0_STATUS         38
+ #define EF_LO                 39
+ #define EF_HI                 40
+ #define EF_CP0_BADVADDR               41
+ #define EF_CP0_CAUSE          42
+ #define EF_CP0_EPC            43
+
+ /* OLD 2.4 style
  #define EF_LO                 38
  #define EF_HI                 39
  #define EF_CP0_EPC            40
  #define EF_CP0_BADVADDR               41
  #define EF_CP0_STATUS         42
  #define EF_CP0_CAUSE          43
+ */

Is it possible that since I cross-compiled gdb on an i386, it used the
local gcc/libc to compile and didn't have the right registers header
file? I know during configuration it was complaining that it didn't
find greg_t definitions etc. I suppose this why you guys can compile
it correctly on the native mips-linux while I have issues
cross-compiling on i386-linux.

Thanks for all your help!
- Tony
