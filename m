Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08NLok04648
	for linux-mips-outgoing; Tue, 8 Jan 2002 15:21:50 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g08NLkg04645
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 15:21:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g08MLJ722305;
	Tue, 8 Jan 2002 20:21:19 -0200
Date: Tue, 8 Jan 2002 20:21:19 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Kevin Paul Herbert <kph@ayrnetworks.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Support for physical memory above 0x20000000
Message-ID: <20020108202119.B21992@dea.linux-mips.net>
References: <a05100303b860f1fff2dd@[192.168.1.5]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a05100303b860f1fff2dd@[192.168.1.5]>; from kph@ayrnetworks.com on Tue, Jan 08, 2002 at 11:07:53AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 08, 2002 at 11:07:53AM -0800, Kevin Paul Herbert wrote:

> I'm working with a somewhat dated kernel (2.4.2+patches) and have 
> discovered that there are problems with physical memory that does not 
> map into KSEG0/KSEG1. I looked over the list archives (manually, I 
> couldn't find a search interface) and it appears that this is still 
> the case for current kernels (at least as of a note from last summer, 
> the last time the issue seems to have come up.)
> 
> Obviously, phys_to_virt() is going to be a problem but besides this 
> I'm wondering what anybody may have done to support physical memory 
> that is not always mapped into the virtual address space, so that I 
> don't have to reinvent the wheel.
> 
> When I tell the kernel about the memory above 0x20000000, userland 
> fails to start; the kernel gets as far as execve()'ing init, but 
> nothing happens (interrupts are enabled; I get echo on the console, 
> but nothing from userland).

Correct.  There are two ways to solve this problem.  For the 32-bit kernel
I've got a highmem patch and the 64-bit kernel memory limits are the
hardware's memory limits.  I'll post the highmem patch soon.  I was
planning to have it ready by now but a flu sent me to bed instead ...

  Ralf
