Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IHv7R03526
	for linux-mips-outgoing; Tue, 18 Sep 2001 10:57:07 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IHv4e03523
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 10:57:04 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 18 Sep 2001 17:58:11 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id KAA05124
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 10:55:44 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id MAA04165; Tue, 18 Sep 2001 12:56:10 -0500
Message-ID: <3BA78B3B.6090602@esstech.com>
Date: Tue, 18 Sep 2001 12:58:19 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Freeing global memory used only by __init functions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I noticed that several global buffers are used by a few functions marked
as __init functions.  I assume that the code space used by these functions
will be freed up when kernel initialization is completed, but can the
associated global memory be freed up as well?

An example can be found in arch/mips/mips-boards/generic/cmdline.c:

char arcs_cmdline[COMMAND_LINE_SIZE];
char * __init prom_getcmdline(void);
void  __init prom_init_cmdline(void);

arcs_cmdline is only used by these two functions and one other function
marked as __init.

This buffer is small, but it can apply to larger buffers as well.  For
example, in arch/mips/mips-boards/generic/printf.c, I think the functions
putPromChar and getPromChar should be marked as __init functions, and the
1k buffer "buf" is never used after initialization.  Can this 1k be recovered?

I know kmalloc could normally be used in kernel code, but that won't work on
initialization code used before kmalloc is initialized.

Thanks.

Gerald
