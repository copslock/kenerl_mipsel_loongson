Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q5mlN01068
	for linux-mips-outgoing; Mon, 25 Feb 2002 21:48:47 -0800
Received: from chmls05.mediaone.net (chmls05.ne.ipsvc.net [24.147.1.143])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q5mZ901061;
	Mon, 25 Feb 2002 21:48:36 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls05.mediaone.net (8.11.1/8.11.1) with ESMTP id g1Q4lWu06551;
	Mon, 25 Feb 2002 23:47:32 -0500 (EST)
Date: Mon, 25 Feb 2002 23:47:44 -0500
Subject: Re: Problems compiling . soft-float
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Jay Carlson <nop@nop.com>, Carlo Agostini <carlo.agostini@yacme.com>,
   linux-mips@oss.sgi.com
To: Ralf Baechle <ralf@oss.sgi.com>, mad-dev@lists.mars.org
From: Jay Carlson <nop@nop.com>
In-Reply-To: <20020225132559.A3500@dea.linux-mips.net>
Message-Id: <F91731D8-2A73-11D6-AB38-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



On Monday, February 25, 2002, at 07:25 AM, Ralf Baechle wrote:

> On Mon, Feb 25, 2002 at 08:19:36AM +0100, Carlo Agostini wrote:

[link fails due to missing "dpmul", "dpadd", etc.]

>
>> Then, I tried to pass explicitly -msoft-float to gcc as an argument
>> .....
>
> Not supported.  Use the kernel fp emulation.

This works fine if you undo the mistake in gcc/config/mips/t-linux, or 
in elf.h, your choice.

The default on MIPS is for gcc to use the GOFAST style of soft-float 
calls.  gcc/config/mips/elf.h sets this up via #include "gofast.h".

Now, t-linux *does* include the right goo to get all the software 
floating point emulation code compiled into libgcc.a.  But it's 
defaulting not to the GNU style but to the GOFAST style calls:

         echo '#undef US_SOFTWARE_GOFAST' >> dp-bit.c

So everything works if we just make the two consistent.   The old(er) 
Agenda toolchain takes the position that "every other gcc MIPS target 
uses GOFAST, so should we"; you can just change that #undef to #define.

But I (now) think the better path is to stick to the GNU-style softfloat 
calls,  Unless you want to modify elf.h, the best you can do is undo the 
#include "gofast.h" damage in linux.h.  Near the end:

+/* undo the effects of elf.h including gofast.h */
+#undef US_SOFTWARE_GOFAST
+#undef INIT_GOFAST_OPTABS
+#define INIT_GOFAST_OPTABS
+
+#undef GOFAST_CLEAR_NEG_FLOAT_OPTAB
+#undef GOFAST_RENAME_LIBCALLS

This of course requires knowledge of what exactly gofast.h did, so it's 
not optimal either.

Ralf is right that the kernel emulator is the supported route.  But if 
you're willing to go to the trouble of building everything from scratch, 
this does work.

Jay
