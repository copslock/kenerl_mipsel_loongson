Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MKqZp30049
	for linux-mips-outgoing; Tue, 22 Jan 2002 12:52:35 -0800
Received: from banff.ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MKqOP30041
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 12:52:24 -0800
Received: from ayrnetworks.com (IDENT:chua@localhost.localdomain [127.0.0.1])
	by banff.ayrnetworks.com (8.11.2/8.11.2) with ESMTP id g0MJqF208870;
	Tue, 22 Jan 2002 11:52:15 -0800
Message-ID: <3C4DC2EE.9060702@ayrnetworks.com>
Date: Tue, 22 Jan 2002 11:52:14 -0800
From: Bryan Chua <chua@ayrnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/setup.c
References: <Pine.GSO.4.21.0201221016380.26741-100000@vervain.sonytel.be>
Content-Type: multipart/mixed;
 boundary="------------050203000506020609010103"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------050203000506020609010103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry , it is attached.

-- bryan

Geert Uytterhoeven wrote:

> On Mon, 21 Jan 2002, Bryan Chua wrote:
> 
>>I recall a bunch of disussion about changing arch/mips/setup.c to 
>>simplify adding vendor-specific platform code in setup_arch, but to date 
>>nothing has come of it.  So while this is a dramatic oversimplification 
>>of the various proposals, how about this for now --
>>
>>just a vendor-defined function "platform_setup (void)" and it is up to 
>>the vendor to figure out what to do from there.
>>
>>-- bryan
>>
>>
>>Index: arch/mips/kernel/setup.c
>>===================================================================
>>RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
>>retrieving revision 1.96.2.3
>>diff -u -r1.96.2.3 setup.c
>>--- arch/mips/kernel/setup.c	2001/12/26 23:27:02	1.96.2.3
>>+++ arch/mips/kernel/setup.c	2002/01/21 22:55:35
>>@@ -666,6 +666,7 @@
>>   	void it8172_setup(void);
>>  	void swarm_setup(void);
>>  	void hp_setup(void);
>>+ 
>>void platform_setup (void);
>>
>>  	unsigned long bootmap_size;
>>  	unsigned long start_pfn, max_pfn, first_usable_pfn;
>>@@ -793,7 +794,8 @@
>>                  break;
>>  #endif
>>  	default:
>>- 
>>	panic("Unsupported architecture");
>>+ 
>>         platform_setup ();
>>+ 
>>
> 
> At first I thought: he's adding code after a call to panic(), but it turns out
> your mailer screwed your patch...
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> 



--------------050203000506020609010103
Content-Type: text/plain;
 name="setup.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup.c"

Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96.2.3
diff -u -r1.96.2.3 setup.c
--- arch/mips/kernel/setup.c	2001/12/26 23:27:02	1.96.2.3
+++ arch/mips/kernel/setup.c	2002/01/22 20:52:05
@@ -666,6 +666,7 @@
  	void it8172_setup(void);
 	void swarm_setup(void);
 	void hp_setup(void);
+	void platform_setup (void);
 
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn, first_usable_pfn;
@@ -793,7 +794,8 @@
                 break;
 #endif
 	default:
-		panic("Unsupported architecture");
+	        platform_setup ();
+		break;
 	}
 
 	strncpy(command_line, arcs_cmdline, sizeof command_line);

--------------050203000506020609010103--
