Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93J94921745
	for linux-mips-outgoing; Wed, 3 Oct 2001 12:09:04 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93J8xD21741
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 12:08:59 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 3 Oct 2001 19:10:19 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id MAA16037
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 12:07:35 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id OAA18628; Wed, 3 Oct 2001 14:07:25 -0500
Message-ID: <3BBB62DE.3040003@esstech.com>
Date: Wed, 03 Oct 2001 14:11:26 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Remove ifdefs from setup_arch()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I have been modifying the linux kernel to support a custom hardware board of 
ours, and I'm trying to minimize additional changes and ifdefs in the kernel.
I noticed that the setup_arch function in arch/mips/kernel/setup.c has a new
ifdef for each board type that is supported, and it looks like this could be
simplified.  The code looks something like this:

-----------------
void __init setup_arch(char **cmdline_p)
{
	void boardname1_setup(void);
	void boardname1_setup(void);
	void boardname1_setup(void);

	...

	switch (mips_machgroup)
	{
#ifdef CONFIG_BOARDNAME1
	case: MACH_GROUP_WHATEVER1:
		boardname1_setup();
		break;
#endif

#ifdef CONFIG_BOARDNAME2
	case: MACH_GROUP_WHATEVER2:
		boardname2_setup();
		break;
#endif

#ifdef CONFIG_BOARDNAME3
	case: MACH_GROUP_WHATEVER3:
		boardname3_setup();
		break;
#endif

	default:
		panic("Unsupported architecture");
	}
	...
-----------------


For each configuration, only one case is compiled in.  Wouldn't it
be simpler to just give the board-specific setup function a common name
and consider it part of the board-specific api like all the other
board-specific functions.  Can this be changed to just this:

-----------------
void __init setup_arch(char **cmdline_p)
{
	void foo_setup(void);

	...

	foo_setup();  /* someone pick a name for this */
	...
-----------------

I'm trying to document an api for supporting an arbitrary board, and little
things like this make it more difficult to define something along the lines
of a bsp interface.  Any suggestions?  Any objections?

Thanks.

Gerald
