Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76ELRn02842
	for linux-mips-outgoing; Mon, 6 Aug 2001 07:21:27 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76ELQV02833
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 07:21:26 -0700
Received: from [192.168.1.168] (192.168.1.168 [192.168.1.168]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id QMJCNBAW; Mon, 6 Aug 2001 10:21:20 -0400
Subject: Re: Where is the first entry point for linux-mips boot?
From: Marc Karasek <marc_karasek@ivivity.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <000701c11c8b$77e039e0$8021690a@huawei.com>
References: <000701c11c8b$77e039e0$8021690a@huawei.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 06 Aug 2001 10:21:23 -0400
Message-Id: <997107690.1342.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The firmware or bootloader.  For some examples of this look at redboot
from RedHat or yamon (yet another monitor) from MIPS (I think).  

Keep in mind these will prob require a seperate cross-compiler.  I have
yet to test compiling a boot monitor with linux gcc cross compiler.  You
can get one from either MIPS or Algorythmics (www.algor.co.uk).  I have
used both of these to build both of the above monitors.  

Any other questions, email me..

/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/  

On 04 Aug 2001 10:16:27 +0800, machael thailer wrote:
> Hello,all:
> 
>     Now I plan to port linux on our mips-based board. Since it is the first
> time for me to work on linux-mips, I have several questions to ask:
> 
>     There are many many subdirectories in arch/mips, I don't know where is
> the FIRST entry point for embedded linux-mips boot process? I find that
> there is "kernel_entry" in arch/mips/kernel/head.S. I know this is the entry
> point for linux kernel ,but it is not the FIRST entry point for embedded
> linux-mips boot process. So my questions is :
>     After the board initializations finish, it should load linux kernel into
> RAM and jump there .  Just before it runs the linux kernel, who calls
> "kernel_entry"?
>     I don't know whether I have expressed my meaning apparently. Hope you
> can understand me.
> 
> Thank you very much.
> 
> machael thailer
> 
> 
-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
