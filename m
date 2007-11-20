Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 04:23:47 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.233]:57269 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021609AbXKTEXi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 04:23:38 +0000
Received: by wr-out-0506.google.com with SMTP id 67so821610wri
        for <linux-mips@linux-mips.org>; Mon, 19 Nov 2007 20:22:31 -0800 (PST)
Received: by 10.142.140.14 with SMTP id n14mr1383343wfd.1195532550378;
        Mon, 19 Nov 2007 20:22:30 -0800 (PST)
Received: by 10.142.169.11 with HTTP; Mon, 19 Nov 2007 20:22:30 -0800 (PST)
Message-ID: <fb2fec70711192022l5283ec9av4d3cc0a9c02f922e@mail.gmail.com>
Date:	Tue, 20 Nov 2007 12:22:30 +0800
From:	"David Kuk" <david.kuk@entone.com>
To:	"David Daney" <ddaney@avtrex.com>
Subject: Re: smp8634 add memory at dram1
Cc:	linux-mips@linux-mips.org
In-Reply-To: <473B1DD0.2090903@avtrex.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_17367_11062483.1195532550383"
References: <473AB56B.2070107@entone.com> <473B1DD0.2090903@avtrex.com>
Return-Path: <david.kuk@entone.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.kuk@entone.com
Precedence: bulk
X-list: linux-mips

------=_Part_17367_11062483.1195532550383
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks you all for helping.

AS Daney suggested, I have map the dram1's first 64 MB memory (total 128) to
remap register 3,
and add the remap register 3 into the BOOT_MEMROY_RAM use the method
add_memory_region.
When i bootup the linux kernel print out that it have totally 176MB ram ,
which is 06fe0000@10020000(dram0) and 04000000@08000000(64mb dram1 at remap
register3). How ever, This mapping shows that the total memory in the linux
kernel is not contiguous. the OS can run, but as i see the source code, when
the kernel divided these memory into pages, it did not consider  if the
memory is contiguous or not, is it ok ? and  how should i  allocate the
memories into ZONE[DMA] and ZONE[NORMAL], is it possible if I wish all the
176MB memory can be allocate as ZONE[DMA]?


Best wishes
David




On 11/15/07, David Daney <ddaney@avtrex.com> wrote:
>
> David Kuk wrote:
> > After study about the memory configuration of sigma smp8634, i found
> > some difficult to accomplish the task.
> >
> > so my question is if have two 128MB ram separately under dram0 and
> > dram1 controller, where dram0 for linux and dram1 for video decoding.
> > Now the situation is the memory for linux is not enough and video
> > decoding can not use all of it's 128MB at dram1, what we plan to do is
> > to share 64MB at dram1 to the linux kernel as high memory, and only
> > reserved 64MB at dram1 for the video decoding.
> >
> > first, in MIPS architecture, we found that the kseg0 and kseg1 are
> > mapped to 0x00000000-0x20000000, which include only dram0 controller,
> > so we wish to add the dram1 memory manually to the kernel using
> > function add_memory_region at setup.c , after booting up result the
> > warning that the memory larger than 512 need to configured the kernel
> > support high memory.
> >
> > then when we configure the kernel to support high memory at menu
> > configure, the kernel when booting up will remind us our CPU do not
> > support high memory due to cache aliases.
> >
> > Both way will lead the linux can not boot up normally, so what should
> > we do, is there any mis-understanding about the hardware
> > implementation or MIPS design?
>
> I think your understanding of the 8634 is at least close to correct.
>
> It may be possible (but I have not tried it yet) to use the remapping
> registers to move dram1 into the first 512MB of the memory space.  If it
> is possible, you would then have to modify the gbus access functions
> accordingly.  Also the 8634 media drivers would probably have to be
> changed as well.  I am not sure about the microcode for the media DSPs,
> but if it is dependent on the mapping of the DRAM, then you would
> probably have to get the vendor's help.
>
> Let me know if you are successful.
>
> Thanks,
> David Daney
>
>

------=_Part_17367_11062483.1195532550383
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks you all for helping.<br><br>AS Daney suggested, I have map the dram1&#39;s first 64 MB memory (total 128) to remap register 3,<br>and add the remap register 3 into the BOOT_MEMROY_RAM use the method add_memory_region.
<br>When i bootup the linux kernel print out that it have totally 176MB ram , which is 06fe0000@10020000(dram0) and 04000000@08000000(64mb dram1 at remap register3). How ever, This mapping shows that the total memory in the linux kernel is not contiguous. the OS can run, but as i see the source code, when the kernel divided these memory into pages, it did not consider&nbsp; if the memory is contiguous or not, is it ok ? and&nbsp; how should i&nbsp; allocate the memories into ZONE[DMA] and ZONE[NORMAL], is it possible if I wish all the 176MB memory can be allocate as ZONE[DMA]? 
<br><br><br>Best wishes<br>David <br><br><br><br><br><div><span class="gmail_quote">On 11/15/07, <b class="gmail_sendername">David Daney</b> &lt;<a href="mailto:ddaney@avtrex.com">ddaney@avtrex.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
David Kuk wrote:<br>&gt; After study about the memory configuration of sigma smp8634, i found<br>&gt; some difficult to accomplish the task.<br>&gt;<br>&gt; so my question is if have two 128MB ram separately under dram0 and
<br>&gt; dram1 controller, where dram0 for linux and dram1 for video decoding.<br>&gt; Now the situation is the memory for linux is not enough and video<br>&gt; decoding can not use all of it&#39;s 128MB at dram1, what we plan to do is
<br>&gt; to share 64MB at dram1 to the linux kernel as high memory, and only<br>&gt; reserved 64MB at dram1 for the video decoding.<br>&gt;<br>&gt; first, in MIPS architecture, we found that the kseg0 and kseg1 are<br>&gt; mapped to 0x00000000-0x20000000, which include only dram0 controller,
<br>&gt; so we wish to add the dram1 memory manually to the kernel using<br>&gt; function add_memory_region at setup.c , after booting up result the<br>&gt; warning that the memory larger than 512 need to configured the kernel
<br>&gt; support high memory.<br>&gt;<br>&gt; then when we configure the kernel to support high memory at menu<br>&gt; configure, the kernel when booting up will remind us our CPU do not<br>&gt; support high memory due to cache aliases.
<br>&gt;<br>&gt; Both way will lead the linux can not boot up normally, so what should<br>&gt; we do, is there any mis-understanding about the hardware<br>&gt; implementation or MIPS design?<br><br>I think your understanding of the 8634 is at least close to correct.
<br><br>It may be possible (but I have not tried it yet) to use the remapping<br>registers to move dram1 into the first 512MB of the memory space.&nbsp;&nbsp;If it<br>is possible, you would then have to modify the gbus access functions
<br>accordingly.&nbsp;&nbsp;Also the 8634 media drivers would probably have to be<br>changed as well.&nbsp;&nbsp;I am not sure about the microcode for the media DSPs,<br>but if it is dependent on the mapping of the DRAM, then you would<br>probably have to get the vendor&#39;s help.
<br><br>Let me know if you are successful.<br><br>Thanks,<br>David Daney<br><br></blockquote></div><br>

------=_Part_17367_11062483.1195532550383--
