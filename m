Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LN2MU17001
	for linux-mips-outgoing; Mon, 21 Jan 2002 15:02:22 -0800
Received: from banff.ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LN2IP16998
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 15:02:18 -0800
Received: from ayrnetworks.com (IDENT:chua@localhost.localdomain [127.0.0.1])
	by banff.ayrnetworks.com (8.11.2/8.11.2) with ESMTP id g0LM2B221276
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 14:02:11 -0800
Message-ID: <3C4C8FE2.9090800@ayrnetworks.com>
Date: Mon, 21 Jan 2002 14:02:10 -0800
From: Bryan Chua <chua@ayrnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: arch/mips/setup.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I recall a bunch of disussion about changing arch/mips/setup.c to 
simplify adding vendor-specific platform code in setup_arch, but to date 
nothing has come of it.  So while this is a dramatic oversimplification 
of the various proposals, how about this for now --

just a vendor-defined function "platform_setup (void)" and it is up to 
the vendor to figure out what to do from there.

-- bryan


Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96.2.3
diff -u -r1.96.2.3 setup.c
--- arch/mips/kernel/setup.c	2001/12/26 23:27:02	1.96.2.3
+++ arch/mips/kernel/setup.c	2002/01/21 22:55:35
@@ -666,6 +666,7 @@
   	void it8172_setup(void);
  	void swarm_setup(void);
  	void hp_setup(void);
+ 
void platform_setup (void);

  	unsigned long bootmap_size;
  	unsigned long start_pfn, max_pfn, first_usable_pfn;
@@ -793,7 +794,8 @@
                  break;
  #endif
  	default:
- 
	panic("Unsupported architecture");
+ 
         platform_setup ();
+ 
	break;
  	}

  	strncpy(command_line, arcs_cmdline, sizeof command_line);
