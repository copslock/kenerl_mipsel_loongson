Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2Q3eJk01698
	for linux-mips-outgoing; Sun, 25 Mar 2001 19:40:19 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2Q3eGM01691;
	Sun, 25 Mar 2001 19:40:16 -0800
Received: from sydney.sydney.sgi.com (sydney.sydney.sgi.com [134.14.48.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id TAA02549; Sun, 25 Mar 2001 19:39:01 -0800 (PST)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com by sydney.sydney.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id NAA17825; Mon, 26 Mar 2001 13:38:55 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: jbglaw@lug-owl.de, linux-mips@oss.sgi.com,
   Harald Koerfgen <hkoerfg@web.de>
Subject: Re: elf2ecoff problem 
In-reply-to: Your message of "Sun, 25 Mar 2001 05:35:54 +0200."
             <20010325053554.A18589@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 13:38:56 +1000
Message-ID: <20271.985577936@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 25 Mar 2001 05:35:54 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>The .modinfo section gets into vmlinux through drivers/tc/tc.o where it
>gets created because include/asm-mips/dec/tcmodule.h defines the cpp
>symbol MODULE; <linux/module.h> gets included after that and believing
>this is a module compilation puts some stuff into .modinfo.

tc will have to use a name other than MODULE, say TC_MODULE.
