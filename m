Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77HlVI05346
	for linux-mips-outgoing; Tue, 7 Aug 2001 10:47:31 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77HlTV05343
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 10:47:29 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f77HqRA26776;
	Tue, 7 Aug 2001 10:52:33 -0700
Message-ID: <3B702A28.5020002@pacbell.net>
Date: Tue, 07 Aug 2001 10:49:28 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steven Liu <stevenliu@psdc.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Could not find the source code for "/sbin/init".
References: <84CE342693F11946B9F54B18C1AB837B0A2257@ex2k.pcs.psdc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven Liu wrote:
> Hi ALL:
> 
> As we know, the function init( ) in main.c is 
> 
> static int init(void * unused)
> {
> 	lock_kernel();
> 	do_basic_setup();
> 	free_initmem();
> 	unlock_kernel();
> 
> 	if (open("/dev/console", O_RDWR, 0) < 0)
> 		printk("Warning: unable to open an initial console.\n");
> 
> 	(void) dup(0);
> 	(void) dup(0);
> 	
> 
> 	if (execute_command)
> 		execve(execute_command,argv_init,envp_init);
> 
> 	execve("/sbin/init",argv_init,envp_init);    //<--- problem
> 
> 	execve("/etc/init",argv_init,envp_init);
> 	execve("/bin/init",argv_init,envp_init);
> 	execve("/bin/sh",argv_init,envp_init);
> 	panic("No init found.  Try passing init= option to kernel.");
> } 
> 
> The system call execve("/sbin/init",argv_init,envp_init) will start a
> background process.
> In my case, it could not start the process, that is, system hangs there
> and 
> execve("/etc/init",argv_init,envp_init) could not be executed.
> 
> 
> Could you tell me where could I find the source code for the executable
> /sbin/init? 
> 
> Thank you very much for your help.

/sbin/init is part of the SysVInit package.

Your problem is most likely NOT with /sbin/init itself. I would start by loading 
sash first; if that works, try a static bash; if that works, try a dynamically 
linked bash.

Pete
