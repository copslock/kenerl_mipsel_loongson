Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IF19h00379
	for linux-mips-outgoing; Tue, 18 Sep 2001 08:01:09 -0700
Received: from server3.toshibatv.com ([207.152.29.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IF15e00376
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 08:01:05 -0700
Received: by SERVER3 with Internet Mail Service (5.5.2650.21)
	id <RNJQKN7A>; Tue, 18 Sep 2001 10:00:39 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B72E5@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>
Cc: linux-mips@oss.sgi.com
Subject: RE: How to access kernel memory?
Date: Tue, 18 Sep 2001 09:59:07 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8IF15e00377
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have just the opposite requirement. I need to allow any running process
and its threads to be "hot-patched" with executable code. I know you're
thinking "why?". I can't tell you that. I can only say  it's a firm
requirement, and I could use some helpful ideas.

Keith 

-> -----Original Message-----
-> From: Zhang Fuxin [mailto:fxzhang@ict.ac.cn]
-> Sent: Tuesday, September 18, 2001 9:53 AM
-> To: han han
-> Cc: linux-mips@oss.sgi.com
-> Subject: Re: How to access kernel memory?
-> 
-> 
-> hi,han han£¬
->    There are several ways.For example:
->    1.You can create a character device , implement its mmap function
-> to map the memory block you allcated.This can be done in a little
-> kernel module.There are some sample code before.
->    2.via /dev/mem,/dev/kmem etc
->    
-> 
-> 
-> 
-> ÔÚ 2001-09-18 07:35:00 you wrote£º
-> >Hi, All,
-> >
-> >I allocated a block of memory in the kernel space. But
-> >I don't know how to directly access kernel space from
-> >user space. Anyone can help me?
-> >
-> >Thanks in advance.
-> >
-> >piggie
-> >
-> >
-> >__________________________________________________
-> >Terrorist Attacks on U.S. - How can you help?
-> >Donate cash, emergency relief information
-> >http://dailynews.yahoo.com/fc/US/Emergency_Information/
-> 
-> Regards
->             Zhang Fuxin
->             fxzhang@ict.ac.cn
-> 
