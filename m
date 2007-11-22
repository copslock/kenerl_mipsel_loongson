Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2007 07:35:33 +0000 (GMT)
Received: from rv-out-0910.google.com ([209.85.198.190]:51743 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024401AbXKVHfY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Nov 2007 07:35:24 +0000
Received: by rv-out-0910.google.com with SMTP id l15so2009034rvb
        for <linux-mips@linux-mips.org>; Wed, 21 Nov 2007 23:35:12 -0800 (PST)
Received: by 10.140.163.3 with SMTP id l3mr3773902rve.1195716911828;
        Wed, 21 Nov 2007 23:35:11 -0800 (PST)
Received: by 10.141.146.1 with HTTP; Wed, 21 Nov 2007 23:35:11 -0800 (PST)
Message-ID: <fb2fec70711212335k7747f338nc7eab6bf6604a010@mail.gmail.com>
Date:	Thu, 22 Nov 2007 15:35:11 +0800
From:	"David Kuk" <david.kuk@entone.com>
To:	"YH Lin" <YH_Lin@sdesigns.com>
Subject: Re: smp8634 add memory at dram1
Cc:	linux-mips@linux-mips.org
In-Reply-To: <5DF100B598199744B111FCEA5222E78A02D52DCE@sigma-exch1.sdesigns.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_323_21630688.1195716911803"
References: <5DF100B598199744B111FCEA5222E78A02D52DCE@sigma-exch1.sdesigns.com>
Return-Path: <david.kuk@entone.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.kuk@entone.com
Precedence: bulk
X-list: linux-mips

------=_Part_323_21630688.1195716911803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

thank you very much Lin, for your kindly reply. May I ask you some more
questions ?

1. about your answer 2, it's true that 0x10000000 to 0x10020000 are
reserved,
so what's the way i can sure no one use this area of memory ? because
em86xx_kmem_start is still the dram controller0's.

2. about your answer 3, if i need to enable the PCI host, you mean i will
have no chance to have greater than 112 MB DMA memory start from the
em86xx_kmem_start ? it's seems a dilemma here, I may describe it more
clearly. I have one ram size of 128 at dram0 controller and as well as
another 128 at dram1 controller. previously it's work very well, the
controller0's ram is for linux and controller1's memory is for video decode.
But recently because the grow of code size of grow of both linux as well as
middle ware, we really need more memory for for kernel run, so if in this
situation , what should i do ?

thx a lot for your help
David

On 11/21/07, YH Lin <YH_Lin@sdesigns.com> wrote:
>
>
>
> Hi David,
>
>
>
> We have not done so for SMP8634. But I think it is possible to do this:
>
>
>
>    1. Using remap register 4 instead, there you will have
>    0x0c000000-0x16fe0000 contiguous space, where 0x0c000000-0x0fffffff is
>    mapped to DRAM1 and 0x10000000-0x16fe0000 is in DRAM0.
>    2. You'd probably reserve the memory 0x10000000-0x10020000 since
>    this area is used by other things so it'd be better if no one else is using
>    this portion of memory.
>    3. As for DMA zone or normal zone, that depends. Do you have the
>    need to enable PCI host? If so, the max. size of DMA zone is 112MB, or else
>    it can all be DMA memory (provide that the address translation routines are
>    modified accordingly).
>
>
>
> Regards,
>
> YH
>
>
>  ------------------------------
>
> *From:* linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org]
> *On Behalf Of *David Kuk
> *Sent:* Monday, November 19, 2007 8:23 PM
> *To:* David Daney
> *Cc:* linux-mips@linux-mips.org
> *Subject:* Re: smp8634 add memory at dram1
>
>
>
> Thanks you all for helping.
>
> AS Daney suggested, I have map the dram1's first 64 MB memory (total 128)
> to remap register 3,
> and add the remap register 3 into the BOOT_MEMROY_RAM use the method
> add_memory_region.
> When i bootup the linux kernel print out that it have totally 176MB ram ,
> which is 06fe0000@10020000(dram0) and 04000000@08000000(64mb dram1 at
> remap register3). How ever, This mapping shows that the total memory in the
> linux kernel is not contiguous. the OS can run, but as i see the source
> code, when the kernel divided these memory into pages, it did not consider
> if the memory is contiguous or not, is it ok ? and  how should i  allocate
> the memories into ZONE[DMA] and ZONE[NORMAL], is it possible if I wish all
> the 176MB memory can be allocate as ZONE[DMA]?
>
>
> Best wishes
> David
>
>
>
>  On 11/15/07, *David Daney* <ddaney@avtrex.com> wrote:
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
>

------=_Part_323_21630688.1195716911803
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>thank you very much Lin, for your kindly reply. May I ask you some more questions ?<br><br>1. about your answer 2, it&#39;s true that 0x10000000 to 0x10020000 are reserved, <br>so what&#39;s the way i can sure no one use this area of memory ?
because em86xx_kmem_start is still the dram controller0&#39;s.<br><br>2. about your answer 3, if i need to enable the PCI host, you mean i will have no chance to have greater than 112 MB DMA memory start from the em86xx_kmem_start ? it&#39;s seems a dilemma here, I may describe it more clearly. I have one ram size of 128 at dram0 controller and as well as another 128 at dram1 controller. previously it&#39;s work very well, the controller0&#39;s ram is for linux and controller1&#39;s memory is for video decode. But recently because the grow of code size of grow of both linux as well as middle ware, we really need more memory for for kernel run,
so if in this situation , what should i do ?<br><br>thx a lot for your help <br>David<br><br><div><span class="gmail_quote">On 11/21/07, <b class="gmail_sendername">YH Lin</b> &lt;<a href="mailto:YH_Lin@sdesigns.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
YH_Lin@sdesigns.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">










<div link="blue" vlink="blue" lang="EN-US">

<div>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">Hi David,</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">We have not done so for SMP8634. But I
think it is possible to do this:</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<ol style="margin-top: 0in;" start="1" type="1">
 <li style="color: navy;"><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial;">Using
     remap register 4 instead, there you will have 0x0c000000-0x16fe0000
     contiguous space, where 0x0c000000-0x0fffffff is mapped to DRAM1 and
     0x10000000-0x16fe0000 is in DRAM0.</span></font></li>
 <li style="color: navy;"><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial;">You&#39;d
     probably reserve the memory 0x10000000-0x10020000 since this area is used
     by other things so it&#39;d be better if no one else is using this
     portion of memory.</span></font></li>
 <li style="color: navy;"><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial;">As
     for DMA zone or normal zone, that depends. Do you have the need to enable
     PCI host? If so, the max. size of DMA zone is 112MB, or else it can all be
     DMA memory (provide that the address translation routines are modified
     accordingly).</span></font></li>
</ol>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">Regards,</span></font></p>

<div>

<p><font color="#333399" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: rgb(51, 51, 153);">YH</span></font></p>

</div>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<div>

<div style="text-align: center;" align="center"><font face="Times New Roman" size="3"><span style="font-size: 12pt;">

<hr align="center" size="2" width="100%">

</span></font></div>

<p><b><font face="Tahoma" size="2"><span style="font-size: 10pt; font-family: Tahoma; font-weight: bold;">From:</span></font></b><font face="Tahoma" size="2"><span style="font-size: 10pt; font-family: Tahoma;">
<a href="mailto:linux-mips-bounce@linux-mips.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">linux-mips-bounce@linux-mips.org</a> [mailto:<a href="mailto:linux-mips-bounce@linux-mips.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

linux-mips-bounce@linux-mips.org</a>] <b><span style="font-weight: bold;">On Behalf Of </span></b>David Kuk<br>
<b><span style="font-weight: bold;">Sent:</span></b> Monday, November 19, 2007
8:23 PM<br>
<b><span style="font-weight: bold;">To:</span></b> David Daney<br>
<b><span style="font-weight: bold;">Cc:</span></b> <a href="mailto:linux-mips@linux-mips.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">linux-mips@linux-mips.org</a><br>
<b><span style="font-weight: bold;">Subject:</span></b> Re: smp8634 add memory at
dram1</span></font></p>

</div><div><span>

<p><font face="Times New Roman" size="3"><span style="font-size: 12pt;">&nbsp;</span></font></p>

<p style="margin-bottom: 12pt;"><font face="Times New Roman" size="3"><span style="font-size: 12pt;">Thanks you all for
helping.<br>
<br>
AS Daney suggested, I have map the dram1&#39;s first 64 MB memory (total 128) to
remap register 3,<br>
and add the remap register 3 into the BOOT_MEMROY_RAM use the method
add_memory_region. <br>
When i bootup the linux kernel print out that it have totally 176MB ram , which
is 06fe0000@10020000(dram0) and 04000000@08000000(64mb dram1 at remap
register3). How ever, This mapping shows that the total memory in the linux
kernel is not contiguous. the OS can run, but as i see the source code, when
the kernel divided these memory into pages, it did not consider&nbsp; if the
memory is contiguous or not, is it ok ? and&nbsp; how should i&nbsp; allocate
the memories into ZONE[DMA] and ZONE[NORMAL], is it possible if I wish all the
176MB memory can be allocate as ZONE[DMA]? <br>
<br>
<br>
Best wishes<br>
David <br>
<br>
<br>
<br>
</span></font></p>

<div>

<p><span><font face="Times New Roman" size="3"><span style="font-size: 12pt;">On 11/15/07, <b><span style="font-weight: bold;">David
Daney</span></b> &lt;<a href="mailto:ddaney@avtrex.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">ddaney@avtrex.com</a>&gt;
wrote:</span></font></span></p>

<p style="margin-bottom: 12pt;"><font face="Times New Roman" size="3"><span style="font-size: 12pt;">David Kuk wrote:<br>
&gt; After study about the memory configuration of sigma smp8634, i found<br>
&gt; some difficult to accomplish the task.<br>
&gt;<br>
&gt; so my question is if have two 128MB ram separately under dram0 and <br>
&gt; dram1 controller, where dram0 for linux and dram1 for video decoding.<br>
&gt; Now the situation is the memory for linux is not enough and video<br>
&gt; decoding can not use all of it&#39;s 128MB at dram1, what we plan to do is <br>
&gt; to share 64MB at dram1 to the linux kernel as high memory, and only<br>
&gt; reserved 64MB at dram1 for the video decoding.<br>
&gt;<br>
&gt; first, in MIPS architecture, we found that the kseg0 and kseg1 are<br>
&gt; mapped to 0x00000000-0x20000000, which include only dram0 controller, <br>
&gt; so we wish to add the dram1 memory manually to the kernel using<br>
&gt; function add_memory_region at setup.c , after booting up result the<br>
&gt; warning that the memory larger than 512 need to configured the kernel <br>
&gt; support high memory.<br>
&gt;<br>
&gt; then when we configure the kernel to support high memory at menu<br>
&gt; configure, the kernel when booting up will remind us our CPU do not<br>
&gt; support high memory due to cache aliases. <br>
&gt;<br>
&gt; Both way will lead the linux can not boot up normally, so what should<br>
&gt; we do, is there any mis-understanding about the hardware<br>
&gt; implementation or MIPS design?<br>
<br>
I think your understanding of the 8634 is at least close to correct. <br>
<br>
It may be possible (but I have not tried it yet) to use the remapping<br>
registers to move dram1 into the first 512MB of the memory space.&nbsp;&nbsp;If
it<br>
is possible, you would then have to modify the gbus access functions <br>
accordingly.&nbsp;&nbsp;Also the 8634 media drivers would probably have to be<br>
changed as well.&nbsp;&nbsp;I am not sure about the microcode for the media
DSPs,<br>
but if it is dependent on the mapping of the DRAM, then you would<br>
probably have to get the vendor&#39;s help. <br>
<br>
Let me know if you are successful.<br>
<br>
Thanks,<br>
David Daney</span></font></p>

</div>

<p><font face="Times New Roman" size="3"><span style="font-size: 12pt;">&nbsp;</span></font></p>

</span></div></div>

</div>


</blockquote></div><br>

------=_Part_323_21630688.1195716911803--
