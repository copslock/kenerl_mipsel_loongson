Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2BNTMB16742
	for linux-mips-outgoing; Mon, 11 Mar 2002 15:29:22 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2BNTH916739
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 15:29:17 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05703
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 14:29:18 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id WAA05296;
	Mon, 11 Mar 2002 22:36:12 -0800
Message-ID: <3C8D2E89.10001@mvista.com>
Date: Mon, 11 Mar 2002 14:24:09 -0800
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Gerald Champagne <gerald.champagne@esstech.com>
CC: linux-mips@oss.sgi.com
Subject: Re: pci config cycles on VRC-5477
References: <3C8D26C8.2060903@esstech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gerald Champagne wrote:

> 
> I'm studying the VRC-5477 code and I'm trying to understand how pci config
> cycles can work reliably with the current code.  It looks like the pci
> config code must execute with interrupts disabled, but I can't find code
> that disables interrupts.  Can someone offer a few pointers?  Here's why
> I ask...
> 
> All pci io, memory, and config accesses on the 5477 are performed through
> two windows in the cpu address space.  Normally these two windows are 
> configured
> to perform pci memory and io accesses, and any driver can access pci io and
> memory at any time.  In order to perform a pci config access, one of the 
> two
> windows must be remapped to perform pci config cycles.  The code in
> read_config_dword() looks something like this:
> 
> - Call ddb_access_config_base() to reconfigure the window into pci 
> memory space
>   to access pci config space instead.
> 
> - Read from pci config space by reading from an offset into the window.
> 
> - Call ddb_close_config_base to restore the registers to the original 
> values.
> 
> It looks like anything can interrupt this an try to perform a pci memory
> access while the window is programmed to perfom config cycles.
> 
> Did I miss something, or is this a bug?
> 


Your understanding is correct.  I think this is a bug.

Do you actually see the bug happening?  So far it has never hit me, but maybe 
due to the drivers that are loaded on my configuration.

Jun
