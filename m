Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAJHJp609099
	for linux-mips-outgoing; Mon, 19 Nov 2001 09:19:51 -0800
Received: from server3.toshibatv.com ([207.152.29.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAJHJiW09085
	for <linux-mips@oss.sgi.com>; Mon, 19 Nov 2001 09:19:44 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <VJ2W6XMC>; Mon, 19 Nov 2001 10:19:23 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B743F@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Memory mapping
Date: Mon, 19 Nov 2001 10:18:23 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

OK, now that I've spent a couple weeks looking at Linux memory management,
can someone please help me straighten this out. First, I have a requirement
to "unobtrusively" hot-patch instruction code ( and probably data also )
segments in memory. I've decided that the best way to do this is to mmap
device memory of a pseudo-device module to both the patching process and the
target process. To the patching process it can be viewed as just RW data
memory, but to the target process it must look like read-only executable. In
addition I have found the find_task_by_pid() for getting the process
descriptor for the target process. So...

1. Can I copy off the current task pointer and substitute the task pointer
returned by find_task_by_pid() (in the pseudo-device mmap() call), and do
remap_page_range() to map the memory to the target process?

2. Do I need to set task->has_cpu or any other controls to have the remap
work?

3. The book "Understanding the Linux Kernel" has so many references to
vm_area_struct that I'm confused as to when this memory area gets allocated,
let alone who it belongs to in the mmap() call. I had thought I'd just do
get_free_page() and mmap that address, but everything seems very convoluted
with so many references in the API's to vm_area_struct: I can't seem to keep
straight just what VM is supposed to be passed in the mmap() call, where it
comes from, etc. Is this the [task]->active_mm->mmap vm_area_struct or
should I look for another? 

HELP! Code deadline was supposed to be noon today ( I'm screwed ) and this
is the main hitch holding me back. BTW, I can't tell why I'm doing this, so
please don't ask...

Keith Siders
Software Engineer
 Toshiba America Consumer Products, Inc.
Advanced Television Technology Center
801 Royal Parkway, Suite 100
Nashville, Tennessee 37214
Phone: (615) 257-4050
Fax:   (615) 453-7880
