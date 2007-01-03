Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2007 00:21:19 +0000 (GMT)
Received: from web7905.mail.in.yahoo.com ([202.86.4.81]:38555 "HELO
	web7905.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28646597AbXACAVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jan 2007 00:21:14 +0000
Received: (qmail 83987 invoked by uid 60001); 3 Jan 2007 00:21:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=eKvB5M37DTtVxzxHgm26uyI2l5SA3XSdn2Pdp+B/ukOF1ujSpNektYknc+tk4xSkAY8bThpIwzAldpdboe+3LLrLHueQ5vQVvlNdeCCbCWMfKa/ak2O3m/Z+Hwvemnj9kvfflVG2wOviExXcNZodsMbUxl+CTlAsW9aTHNbs3fM=;
X-YMail-OSG: Y.ZplSEVM1nPhaHC6TsrcqjDkxC6faX7XzBMdzeH0UM85mcdDaZfzdoDk61AlztWWhGgWGc8pT.TCKaPphSZsvqUesbOtQ7Twx36TTBvCcVhpYzeBqOyslzljXeb_hrdmCiMtun_Em2EE4U-
Received: from [206.40.46.114] by web7905.mail.in.yahoo.com via HTTP; Wed, 03 Jan 2007 00:21:06 GMT
Date:	Wed, 3 Jan 2007 00:21:06 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Re: Running linux-2.6.18 kernel in uncache area
To:	mlachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <459ACCF2.5000500@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1963923944-1167783666=:81528"
Content-Transfer-Encoding: 8bit
Message-ID: <506196.81528.qm@web7905.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1963923944-1167783666=:81528
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Mlachwani,
   I tried by enabling Uncache option.
  But how do i know kernel runs from the uncache area.
   
  During the boot process , i checked the boot up message and observed that kernel  still calling cache initilization routines.
   
  I did quick test :
    - Read the  10 words of uncached area start from 0xa0800000
   
    - Read the 10 word of cached area start ftom 0x80800000
   
  I checked the contents in the both areas and are same.
   
  That means  cache is not disabled properly.
   
  Is there anyway i can check the kernel is running from cache or uncached area?
   
  Any other options should i enable/disable to run kernel from uncached area.
   
   Regards,
  Sathesh
   
  BOOTUP MESSAGES:
  --------------------------------------------------------------------
Determined physical RAM map:
 memory: 02000000 @ 00000000 (usable)
Initial ramdisk at: 0x80000000 (0 bytes)
Built 1 zonelists.  Total pages: 8192
Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2 myfs_start=0xbfA800
00 rootfstype=jffs2
Primary instruction cache 16kB, linesize 32 bytes.
Primary data cache 8kB, linesize 32 bytes.
Fusiv LX4189 CACHES
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
th (25 instructions).
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28864k/32768k available (2367k kernel code, 3888k reserved, 401k data, 1
56k init, 0k highmem)
Mount-cache hash table entries: 512
  ---------------------------------------------------------------------
mlachwani <mlachwani@mvista.com> wrote:
  sathesh babu wrote:
> Hi,
> I would like to know is there any configuration option ( using make 
> menuconfig) to turn off cache in linux-2.6.18 kernel.
> 
> Basically i would like to run kernel in uncache area.
> 
> I see there is an option in the in the menuconfig under 
> Kernel hacking
> [ ] Run uncached (NEW)
> Sould i need to enable this option to run in the uncahe area?
> 
> Could you please tell me how to disable cache and run the kernel in 
> uncache area.
> 
> 
> 
> Regards,
> Sathesh
>
> Send free SMS to your Friends on Mobile from your Yahoo! Messenger. 
> Download Now! http://messenger.yahoo.com/download.php
>
That should be it. Did you try with that option MIPS_UNCACHED enabled?

thanks,
Manish Lachwani



 Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
--0-1963923944-1167783666=:81528
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Mlachwani,</div>  <div>&nbsp;I tried by enabling Uncache option.</div>  <div>But how do i know&nbsp;kernel runs from the uncache area.</div>  <div>&nbsp;</div>  <div>During the boot process , i checked the boot up message&nbsp;and observed that&nbsp;kernel &nbsp;still calling cache initilization routines.</div>  <div>&nbsp;</div>  <div>I did quick test :</div>  <div>&nbsp;&nbsp;- Read the &nbsp;10 words of uncached area start&nbsp;from 0xa0800000</div>  <div>&nbsp;</div>  <div>&nbsp; - Read the 10 word of cached area start ftom 0x80800000</div>  <div>&nbsp;</div>  <div>I checked the contents in the both areas and are same.</div>  <div>&nbsp;</div>  <div>That means&nbsp; cache is not disabled properly.</div>  <div>&nbsp;</div>  <div>Is there anyway i can check the kernel is running from cache or uncached area?</div>  <div>&nbsp;</div>  <div>Any other options should i enable/disable to run kernel from uncached area.</div>  <div>&nbsp;</div>  <div>&nbsp;Regards,</div> 
 <div>Sathesh</div>  <div>&nbsp;</div>  <div>BOOTUP MESSAGES:</div>  <div>--------------------------------------------------------------------<BR>Determined physical RAM map:<BR>&nbsp;memory: 02000000 @ 00000000 (usable)<BR>Initial ramdisk at: 0x80000000 (0 bytes)<BR>Built 1 zonelists.&nbsp; Total pages: 8192<BR>Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2 myfs_start=0xbfA800<BR>00 rootfstype=jffs2<BR>Primary instruction cache 16kB, linesize 32 bytes.<BR>Primary data cache 8kB, linesize 32 bytes.<BR>Fusiv LX4189 CACHES<BR>Synthesized TLB refill handler (17 instructions).<BR>Synthesized TLB load handler fastpath (31 instructions).<BR>Synthesized TLB store handler fastpath (31 instructions).<BR>th (25 instructions).<BR>PID hash table entries: 256 (order: 8, 1024 bytes)<BR>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)<BR>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>Memory: 28864k/32768k available (2367k kernel code, 3888k
 reserved, 401k data, 1<BR>56k init, 0k highmem)<BR>Mount-cache hash table entries: 512</div>  <div>---------------------------------------------------------------------<BR><B><I>mlachwani &lt;mlachwani@mvista.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">sathesh babu wrote:<BR>&gt; Hi,<BR>&gt; I would like to know is there any configuration option ( using make <BR>&gt; menuconfig) to turn off cache in linux-2.6.18 kernel.<BR>&gt; <BR>&gt; Basically i would like to run kernel in uncache area.<BR>&gt; <BR>&gt; I see there is an option in the in the menuconfig under <BR>&gt; Kernel hacking<BR>&gt; [ ] Run uncached (NEW)<BR>&gt; Sould i need to enable this option to run in the uncahe area?<BR>&gt; <BR>&gt; Could you please tell me how to disable cache and run the kernel in <BR>&gt; uncache area.<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; Regards,<BR>&gt; Sathesh<BR>&gt;<BR>&gt; Send free SMS to your
 Friends on Mobile from your Yahoo! Messenger. <BR>&gt; Download Now! http://messenger.yahoo.com/download.php<BR>&gt;<BR>That should be it. Did you try with that option MIPS_UNCACHED enabled?<BR><BR>thanks,<BR>Manish Lachwani<BR><BR></BLOCKQUOTE><BR><p>&#32;Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
--0-1963923944-1167783666=:81528--
