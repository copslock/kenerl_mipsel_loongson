Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77Hf7s05109
	for linux-mips-outgoing; Tue, 7 Aug 2001 10:41:07 -0700
Received: from ex2k.pcs.psdc.com ([209.125.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77Hf6V05106
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 10:41:06 -0700
content-class: urn:content-classes:message
Subject: Could not find the source code for "/sbin/init".
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 7 Aug 2001 10:39:07 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A2257@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Could not find the source code for "/sbin/init".
Thread-Index: AcEfZ9sR8pfBso9zTOeZBYlOZk+QMQ==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f77Hf6V05107
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi ALL:

As we know, the function init( ) in main.c is 

static int init(void * unused)
{
	lock_kernel();
	do_basic_setup();
	free_initmem();
	unlock_kernel();

	if (open("/dev/console", O_RDWR, 0) < 0)
		printk("Warning: unable to open an initial console.\n");

	(void) dup(0);
	(void) dup(0);
	

	if (execute_command)
		execve(execute_command,argv_init,envp_init);

	execve("/sbin/init",argv_init,envp_init);    //<--- problem

	execve("/etc/init",argv_init,envp_init);
	execve("/bin/init",argv_init,envp_init);
	execve("/bin/sh",argv_init,envp_init);
	panic("No init found.  Try passing init= option to kernel.");
} 

The system call execve("/sbin/init",argv_init,envp_init) will start a
background process.
In my case, it could not start the process, that is, system hangs there
and 
execve("/etc/init",argv_init,envp_init) could not be executed.


Could you tell me where could I find the source code for the executable
/sbin/init? 

Thank you very much for your help.

Regards,

Steven Liu
