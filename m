Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 20:35:33 +0000 (GMT)
Received: from web7902.mail.in.yahoo.com ([202.86.4.78]:51366 "HELO
	web7902.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28578495AbXAJUf2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 20:35:28 +0000
Received: (qmail 52651 invoked by uid 60001); 10 Jan 2007 20:35:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=zuC85f9DU/81nAtcUbuu98hagA63Djev/agx7SOQ9MKTjr1DQLvGPYY4W4mmpYUMNxfOdMQuLSJSnO/V71vOM7qWNBWvfwS7iYwtwWOU9ndxAF03YpZ2PxUHJXWeAJju3um8yqrTWCIwXEZ3ieyj4VqX6zSQRMnyEhGT7xqqu7k=;
X-YMail-OSG: mKHTII0VM1kgaA2ucyMvgFyfXoqJZLo5XWO.e_454V2Cq3P.q135MHlNqf98lMSRWtvnI1NGPKgkzctlal8dr0J7uFa_RVEZfrfZt.rmtha_h_d4E5Am173ln4fCKVQ1lU6Dz9MSnbu.d_jaWe_g13YFcg--
Received: from [206.40.46.114] by web7902.mail.in.yahoo.com via HTTP; Wed, 10 Jan 2007 20:35:20 GMT
Date:	Wed, 10 Jan 2007 20:35:20 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Re: Running linux-2.6.18 kernel in uncache area
To:	mlachwani <mlachwani@mvista.com>, macro@ds2.pg.gda.pl,
	jsun@mvista.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <506196.81528.qm@web7905.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1737839988-1168461320=:50036"
Content-Transfer-Encoding: 8bit
Message-ID: <78203.50036.qm@web7902.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1737839988-1168461320=:50036
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
    I would like to runlinux-2.6.18 kernel in uncached area.I tried it by enabling CONFIG_UNCACHE.But still i am doubting it is running in cache area.
   
  Is there a way to know the kernel is running in cache or uncache area?
   
  While going thru mailing list i read that there is a patch to run the kernel in uncache area.
   
  If you have could you please pass to me.
   
  Regards,
  Sathesh
   
  

sathesh babu <sathesh_edara2003@yahoo.co.in> wrote:
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


 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-1737839988-1168461320=:50036
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp; I would like to runlinux-2.6.18 kernel in uncached area.I tried it by enabling CONFIG_UNCACHE.But still i am doubting it is running in cache area.</div>  <div>&nbsp;</div>  <div>Is there a way to know the kernel is running in cache or uncache area?</div>  <div>&nbsp;</div>  <div>While going thru mailing list i read that there is a patch to run the kernel in uncache area.</div>  <div>&nbsp;</div>  <div>If you have could you please pass to me.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Sathesh</div>  <div>&nbsp;</div>  <div><BR><BR><B><I>sathesh babu &lt;sathesh_edara2003@yahoo.co.in&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <DIV>Hi Mlachwani,</DIV>  <DIV>&nbsp;I tried by enabling Uncache option.</DIV>  <DIV>But how do i know&nbsp;kernel runs from the uncache area.</DIV>  <DIV>&nbsp;</DIV>  <DIV>During the boot process , i checked the boot up
 message&nbsp;and observed that&nbsp;kernel &nbsp;still calling cache initilization routines.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I did quick test :</DIV>  <DIV>&nbsp;&nbsp;- Read the &nbsp;10 words of uncached area start&nbsp;from 0xa0800000</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp; - Read the 10 word of cached area start ftom 0x80800000</DIV>  <DIV>&nbsp;</DIV>  <DIV>I checked the contents in the both areas and are same.</DIV>  <DIV>&nbsp;</DIV>  <DIV>That means&nbsp; cache is not disabled properly.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Is there anyway i can check the kernel is running from cache or uncached area?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Any other options should i enable/disable to run kernel from uncached area.</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;Regards,</DIV>  <DIV>Sathesh</DIV>  <DIV>&nbsp;</DIV>  <DIV>BOOTUP MESSAGES:</DIV>  <DIV>--------------------------------------------------------------------<BR>Determined physical RAM map:<BR>&nbsp;memory: 02000000 @ 00000000
 (usable)<BR>Initial ramdisk at: 0x80000000 (0 bytes)<BR>Built 1 zonelists.&nbsp; Total pages: 8192<BR>Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2 myfs_start=0xbfA800<BR>00 rootfstype=jffs2<BR>Primary instruction cache 16kB, linesize 32 bytes.<BR>Primary data cache 8kB, linesize 32 bytes.<BR>Fusiv LX4189 CACHES<BR>Synthesized TLB refill handler (17 instructions).<BR>Synthesized TLB load handler fastpath (31 instructions).<BR>Synthesized TLB store handler fastpath (31 instructions).<BR>th (25 instructions).<BR>PID hash table entries: 256 (order: 8, 1024 bytes)<BR>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)<BR>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>Memory: 28864k/32768k available (2367k kernel code, 3888k reserved, 401k data, 1<BR>56k init, 0k highmem)<BR>Mount-cache hash table entries: 512</DIV>  <DIV>---------------------------------------------------------------------<BR><B><I>mlachwani
 &lt;mlachwani@mvista.com&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">sathesh babu wrote:<BR>&gt; Hi,<BR>&gt; I would like to know is there any configuration option ( using make <BR>&gt; menuconfig) to turn off cache in linux-2.6.18 kernel.<BR>&gt; <BR>&gt; Basically i would like to run kernel in uncache area.<BR>&gt; <BR>&gt; I see there is an option in the in the menuconfig under <BR>&gt; Kernel hacking<BR>&gt; [ ] Run uncached (NEW)<BR>&gt; Sould i need to enable this option to run in the uncahe area?<BR>&gt; <BR>&gt; Could you please tell me how to disable cache and run the kernel in <BR>&gt; uncache area.<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; Regards,<BR>&gt; Sathesh<BR>&gt;<BR>&gt; Send free SMS to your Friends on Mobile from your Yahoo! Messenger. <BR>&gt; Download Now! http://messenger.yahoo.com/download.php<BR>&gt;<BR>That should be it. Did you try with that option MIPS_UNCACHED
 enabled?<BR><BR>thanks,<BR>Manish Lachwani<BR><BR></BLOCKQUOTE><BR>  <div>Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php</div></BLOCKQUOTE><BR><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-1737839988-1168461320=:50036--
