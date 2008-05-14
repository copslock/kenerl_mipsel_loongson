Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 02:19:19 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.185]:35215 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20031458AbYENBTQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 02:19:16 +0100
Received: by ti-out-0910.google.com with SMTP id i7so1173308tid.20
        for <linux-mips@linux-mips.org>; Tue, 13 May 2008 18:19:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=3cgZK5KxHHqy95NxMzOKg/woigjMu24mY1zUrbRjuT8=;
        b=kANWUiKJA/WAhjEQZGdgPiqJaqch7ja0K2kQI70WmFC0E252gT2jx7Io/ZRawCCqGpRovTMai5wTCwE9lE1X1AZxW5M19dGfWm4WkMscUxTeIWyNd4ZIldmoYpDZrNyjWDu55q20Wx9J8h44ZzpOX/WbemgdRasEXOpkFkw/GOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=P5wzS/Ra2bmwi11uKvyIx2xv/Pnto5QEfF3brf7FXKAG4GLHE9fQz7sbTKlYblfc1NqiniPmAWlFU///MXeBtM8StBfkorA0DvSnvtJxB4EnSloiqbzrbBIlEAi+m89xmX+dDkXGe4ASrzFZsLUp7xl7Gz68euQLT4O6oR6lqr8=
Received: by 10.110.39.5 with SMTP id m5mr39964tim.55.1210727950469;
        Tue, 13 May 2008 18:19:10 -0700 (PDT)
Received: by 10.110.42.3 with HTTP; Tue, 13 May 2008 18:19:10 -0700 (PDT)
Message-ID: <50c9a2250805131819q41c6da0au1ae3ef9e833812a9@mail.gmail.com>
Date:	Wed, 14 May 2008 09:19:10 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20080513172300.GA9788@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16099_26535377.1210727950464"
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
	 <20080509095605.GB14450@linux-mips.org>
	 <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com>
	 <20080512112233.GA8843@linux-mips.org>
	 <50c9a2250805130444u4218654bw66f6158ba10b2b92@mail.gmail.com>
	 <20080513172300.GA9788@linux-mips.org>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_16099_26535377.1210727950464
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, May 14, 2008 at 1:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, May 13, 2008 at 07:44:06PM +0800, zhuzhenhua wrote:
>
> > thanks for your advice, i found in newest kernel version, in some arch ,
> the
> > dma_alloc_coherent will call split_page.
> > because my kernel version is 2.6.14, so i first patch a split_page patch
> as
> > follow:
> >
> http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch
> >
> > but it seemes that there is still no split_page in
> > dma_alloc_coherent/dma_alloc_noncoherent
> > so i copy from other arch code to arch/mips/mm/dma-noncoherent.c (attach
> at
> > the end of mail)
> > and now my driver just use dma_alloc_coherent malloc 3M directly, and it
> > seemes ok.
> > i just wonder why mips arch dma_alloc_coherent/dma_alloc_nocoherent do
> not
> > call split_page while other arch calling.
>
> I have not identified the waste of memory as a big problem for typical
> MIPS systems yet.
>
> The 3MB requirement of your device is sort of odd because it's not a power
> of two.  Have you considered splitting the allocation into a 2MB and a 1MB
> allocation or would that be undersirable?
>
>  Ralf
>

Thanks for your reply.
Our board is for embedded system , It only have 32M sdram and we don't want
to
 waste 1M sdram.  My sensor driver need about 2.5xM memory to capture a
picture
 by DMA (our DMA controller do not support scatter/gather).

I also can use bootargs "mem=29M" to keep 3M sdram.  but it's not flexible
as
passing a param to driver module(calling dma_alloc_coherent). maybe my
situation
is not common for MIPS arch. so that's is no split_page in
dma_alloc_coherent.
and now after patch,it seemes ok for me.

Best Regards

zzh

------=_Part_16099_26535377.1210727950464
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Wed, May 14, 2008 at 1:23 AM, Ralf Baechle &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, May 13, 2008 at 07:44:06PM +0800, zhuzhenhua wrote:<br>
<br>
&gt; thanks for your advice, i found in newest kernel version, in some arch , the<br>
&gt; dma_alloc_coherent will call split_page.<br>
&gt; because my kernel version is 2.6.14, so i first patch a split_page patch as<br>
&gt; follow:<br>
&gt; <a href="http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch" target="_blank">http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch</a><br>

&gt;<br>
&gt; but it seemes that there is still no split_page in<br>
&gt; dma_alloc_coherent/dma_alloc_noncoherent<br>
&gt; so i copy from other arch code to arch/mips/mm/dma-noncoherent.c (attach at<br>
&gt; the end of mail)<br>
&gt; and now my driver just use dma_alloc_coherent malloc 3M directly, and it<br>
&gt; seemes ok.<br>
&gt; i just wonder why mips arch dma_alloc_coherent/dma_alloc_nocoherent do not<br>
&gt; call split_page while other arch calling.<br>
<br>
</div>I have not identified the waste of memory as a big problem for typical<br>
MIPS systems yet.<br>
<br>
The 3MB requirement of your device is sort of odd because it&#39;s not a power<br>
of two. &nbsp;Have you considered splitting the allocation into a 2MB and a 1MB<br>
allocation or would that be undersirable?<br>
<font color="#888888"><br>
 &nbsp;Ralf<br>
</font></blockquote></div><br>Thanks for your reply.<br>Our board is for embedded system , It only have 32M sdram and we don&#39;t want to<br>&nbsp;waste 1M sdram.&nbsp; My sensor driver need about 2.5xM memory to capture a picture<br>
&nbsp;by DMA (our DMA controller do not support scatter/gather).<br><br>I also can use bootargs &quot;mem=29M&quot; to keep 3M sdram.&nbsp; but it&#39;s not flexible as <br>passing a param to driver module(calling dma_alloc_coherent). maybe my situation <br>
is not common for MIPS arch. so that&#39;s is no split_page in dma_alloc_coherent.<br>and now after patch,it seemes ok for me. <br><br>Best Regards<br><br>zzh<br><br><br>

------=_Part_16099_26535377.1210727950464--
