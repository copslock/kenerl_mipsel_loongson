Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jun 2004 09:01:04 +0100 (BST)
Received: from apollo.nbase.co.il ([IPv6:::ffff:194.90.137.2]:28434 "EHLO
	apollo.nbase.co.il") by linux-mips.org with ESMTP
	id <S8224986AbUF0IA7>; Sun, 27 Jun 2004 09:00:59 +0100
Received: from mrv.com ([194.90.136.133]) by apollo.nbase.co.il
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 0-44418U200L2S100) with ESMTP id AAA1631;
          Sun, 27 Jun 2004 11:08:52 +0200
Message-ID: <40DE7FF2.2030801@mrv.com>
Date: Sun, 27 Jun 2004 11:06:10 +0300
From: ypresente@mrv.com (Yaron Presente)
Organization: MRV International
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: non-contiguous physical memory
References: <40DACD33.60801@mrv.com> <20040624233130.GA15158@linux-mips.org>
Content-Type: multipart/alternative;
 boundary="------------020000080504060009010609"
Return-Path: <ypresente@mrv.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ypresente@mrv.com
Precedence: bulk
X-list: linux-mips


--------------020000080504060009010609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ralf,
Thanks for your help.
We've found out that the board can address more then 32MB in the lower 
bank, so for simplicity reasons,
I think that we just won't use the higher bank.
Yaron

Ralf Baechle wrote:

>On Thu, Jun 24, 2004 at 03:46:43PM +0300, Yaron Presente wrote:
>
>  
>
>>I'm running montavista linux (2.4.18_mvl30-malta-mips_fp_le) on a board 
>>that has 2 memory banks of physical memory.
>>1. 32MB from physical address 0x00000000
>>2. 16MB from physical address 0x20000000
>>
>>Currently I can only access the first bank (by add_memory_region(0, 32 
>><< 20, BOOT_MEM_RAM) in prom_init() ).
>>I tried the obvious solution of adding another region at 0x20000000 
>>(add_memory_region(0x20000000, 16 << 20, BOOT_MEM_RAM))
>>but that didn't seem to work. I've also tried to add a BOOT_MEM_RESERVED 
>>region in between the regions in order to create a seemingly contiguous 
>>memory, with no success.
>>My questions are:
>>Is it possible to access the second bank as well under MIPS ?
>>Is there a way to define a "hole" in the physical memory?
>>Do I have to use CONFIG_DISCONTIGMEM ? is it fully supported ?
>>Thanks for your help,
>>    
>>
>
>Your initial approach was nearly right - you can solve the problem of
>holes in the memory map as long as they're small enough by only adding
>the available regions with add_memory_region().  Typically uses for
>this are small holes due to memory in use by firmware, for example.
>
>Now, in your case the whole isn't small.  In fact, with 480MB it's big ;-)
>What Linux will try to do is to allocate the mem_map array for the
>entire memory range from 0x0 - 0x21000000, that's 528MB.  mem_map contains
>one page per 4k page; each entry is 64 bytes in size for 32-bit kernels
>so that makes a total size for mem_map[] of 8.25MB of which just 768kB are
>actually being used.
>
>Just to make life a little bit more misserable memory 32-bit kernels can
>only use memory above the 512MB boundary as highmem.
>
>CONFIG_DISCONTIGMEM can solve this problem - but Linux/MIPS really doesn't
>much an attempt to make that easy to use.  Right now only a single MIPS
>system is using CONFIG_DISCONTIGMEM and that system is using it in
>combination with CONFIG_NUMA which is quite an additional complication.
>
>With CONFIG_DISCONTIGMEM there will be no more mem_map[] array. Instead
>there will be one such array for each memory region which means you'll
>loose a bit of performance due to additional complexity but you'll save
>all the wasted memory.
>
>  Ralf
> This mail arrived via mail.mrv.com
>
> 
>************************************************************************************
>This footnote confirms that this email message has been scanned by
>PineApp Mail-SeCure for the presence of malicious code, vandals & computer viruses.
>************************************************************************************
>
>  
>




--------------020000080504060009010609
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Ralf,<br>
Thanks for your help. <br>
We've found out that the board can address more then 32MB in the lower bank,
so for simplicity reasons,<br>
I think that we just won't use the higher bank.<br>
Yaron<br>
<br>
Ralf Baechle wrote:<br>
<blockquote type="cite" cite="mid20040624233130.GA15158@linux-mips.org">
  <pre wrap="">On Thu, Jun 24, 2004 at 03:46:43PM +0300, Yaron Presente wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">I'm running montavista linux (2.4.18_mvl30-malta-mips_fp_le) on a board 
that has 2 memory banks of physical memory.
1. 32MB from physical address 0x00000000
2. 16MB from physical address 0x20000000

Currently I can only access the first bank (by add_memory_region(0, 32 
&lt;&lt; 20, BOOT_MEM_RAM) in prom_init() ).
I tried the obvious solution of adding another region at 0x20000000 
(add_memory_region(0x20000000, 16 &lt;&lt; 20, BOOT_MEM_RAM))
but that didn't seem to work. I've also tried to add a BOOT_MEM_RESERVED 
region in between the regions in order to create a seemingly contiguous 
memory, with no success.
My questions are:
Is it possible to access the second bank as well under MIPS ?
Is there a way to define a "hole" in the physical memory?
Do I have to use CONFIG_DISCONTIGMEM ? is it fully supported ?
Thanks for your help,
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Your initial approach was nearly right - you can solve the problem of
holes in the memory map as long as they're small enough by only adding
the available regions with add_memory_region().  Typically uses for
this are small holes due to memory in use by firmware, for example.

Now, in your case the whole isn't small.  In fact, with 480MB it's big ;-)
What Linux will try to do is to allocate the mem_map array for the
entire memory range from 0x0 - 0x21000000, that's 528MB.  mem_map contains
one page per 4k page; each entry is 64 bytes in size for 32-bit kernels
so that makes a total size for mem_map[] of 8.25MB of which just 768kB are
actually being used.

Just to make life a little bit more misserable memory 32-bit kernels can
only use memory above the 512MB boundary as highmem.

CONFIG_DISCONTIGMEM can solve this problem - but Linux/MIPS really doesn't
much an attempt to make that easy to use.  Right now only a single MIPS
system is using CONFIG_DISCONTIGMEM and that system is using it in
combination with CONFIG_NUMA which is quite an additional complication.

With CONFIG_DISCONTIGMEM there will be no more mem_map[] array. Instead
there will be one such array for each memory region which means you'll
loose a bit of performance due to additional complexity but you'll save
all the wasted memory.

  Ralf
 This mail arrived via mail.mrv.com

 
************************************************************************************
This footnote confirms that this email message has been scanned by
PineApp Mail-SeCure for the presence of malicious code, vandals &amp; computer viruses.
************************************************************************************

  </pre>
</blockquote>
<pre class="moz-signature" cols="$mailwrapcol">


</pre>
<br>
</body>
</html>

--------------020000080504060009010609--
