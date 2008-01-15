Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 06:50:50 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.238]:6669 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023237AbYAOGuk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 06:50:40 +0000
Received: by nz-out-0506.google.com with SMTP id n1so1471175nzf.24
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 22:50:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        bh=xo6OcaZODmayU9zSeRaUjxzaOS4SNecEQuDXDW+smxI=;
        b=DWAMMoVbXLKbd/yqN8n0GJyiq4stduASeWltslpVDOrurogZ/hPjewd+G7l5BxMP7uOG//OBLfKNBWhS9ivZd/puTxKGujZ9P0zAZmIwexcgTAh6doWOJAg2gET//VMa8ggi9RFD7bpH1bZz7j9HRYZJynrTzIIRxmJmZFKTY90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=LKfwhhW1Lc944d723NNBfJRwo0U2dg1nj6C2u0RPjxEVemcgbOsZ1etoIjneoPCdWUDZYveiDuRMrHL/LhutGLsHzNMd0pI6YMd7DvO0ncYEHv/MQYHunp+SzOxFYkm/nRFBCDQupQhT2rF5F2JHkNtYuGeV8XA0XMrK5GRZD0U=
Received: by 10.142.203.13 with SMTP id a13mr2931933wfg.148.1200379838902;
        Mon, 14 Jan 2008 22:50:38 -0800 (PST)
Received: by 10.142.140.11 with HTTP; Mon, 14 Jan 2008 22:50:38 -0800 (PST)
Message-ID: <1a18fe6d0801142250h7ce58675i2bce7cb2e2db2669@mail.gmail.com>
Date:	Tue, 15 Jan 2008 07:50:38 +0100
From:	"Luc Perneel" <lper.home@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Cache aliasing issues using 4K pages.
In-Reply-To: <20080115015814.GF9693@networkno.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4614_2788155.1200379838899"
References: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
	 <20080115015814.GF9693@networkno.de>
Return-Path: <lper.home@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lper.home@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_4614_2788155.1200379838899
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Jan 15, 2008 2:58 AM, Thiemo Seufer <ths@networkno.de> wrote:

> The Engineer wrote:
> > We are working with a 2.6.12 kernel on a dual-core mips architecture.
> > In this dual-core system, one core is running the linux kernel and the
> > other is used for some real-time handling (not directly controlled by
> > Linux)
> > We had different stability issues, which could be pinpointed to be
> > related with cache aliasing problems.
> > Cache aliasing happens when the same physical memory can be cached
> > twice as it is accessed by two different virtual addresses.
> > Indeed, for the index to select the correct cache line the virtual
> > address is used. If some bits of the virtual page address are used in
> > the cache index, aliasing can occur.
> >
> >
> > As there is no hardware solution in the mips to recover from this
> > (which would provide some cache coherency, even for one core), the
> > only intrinsic safe solution is to enlarge the page size, so that
> > cache indexing is only done by the offset address in the page (thus
> > the physical part of the address).
> > Another solution is to flush the cache if a page is being remapped to
> > an aliased address (but in our case linux does not has control on the
> > second core, which can cause issues with shared data between both
> > cores).
> > Currently the second solution is used in the kernel, but we found
> > different issues with it (for instance: we had to merge more recent
> > mips kernels, to get a reliable copy-on-write behaviour after
> > forks...).
> >
> > Therefore some questions:
> > - Are there still some known issues with cache aliasing in the MIPS
> kernel?
> > - Are there known issues when using 16KB pages (8KB pages seems not be
> > possible due to tlb issues).
>
> With recent kernels and toolchains 16k pages work ok IME. With a 2.6.12
> kernel however you'll have to backport a serious amount of bugfixes
> before 16k pages can work. Upgrading the kernel is probably less work.
>
> Thiemo
>
Thanks for the info, any idea from which kernel this works ok?
Luc

------=_Part_4614_2788155.1200379838899
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Jan 15, 2008 2:58 AM, Thiemo Seufer &lt;<a href="mailto:ths@networkno.de" target="_blank">ths@networkno.de</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div><div></div><div>The Engineer wrote:<br>&gt; We are working with a 2.6.12 kernel on a dual-core mips architecture.<br>&gt; In this dual-core system, one core is running the linux kernel and the<br>&gt; other is used for some real-time handling (not directly controlled by
<br>&gt; Linux)<br>&gt; We had different stability issues, which could be pinpointed to be<br>&gt; related with cache aliasing problems.<br>&gt; Cache aliasing happens when the same physical memory can be cached<br>&gt; twice as it is accessed by two different virtual addresses.
<br>&gt; Indeed, for the index to select the correct cache line the virtual<br>&gt; address is used. If some bits of the virtual page address are used in<br>&gt; the cache index, aliasing can occur.<br>&gt;<br>&gt;<br>&gt; As there is no hardware solution in the mips to recover from this
<br>&gt; (which would provide some cache coherency, even for one core), the<br>&gt; only intrinsic safe solution is to enlarge the page size, so that<br>&gt; cache indexing is only done by the offset address in the page (thus
<br>&gt; the physical part of the address).<br>&gt; Another solution is to flush the cache if a page is being remapped to<br>&gt; an aliased address (but in our case linux does not has control on the<br>&gt; second core, which can cause issues with shared data between both
<br>&gt; cores).<br>&gt; Currently the second solution is used in the kernel, but we found<br>&gt; different issues with it (for instance: we had to merge more recent<br>&gt; mips kernels, to get a reliable copy-on-write behaviour after
<br>&gt; forks...).<br>&gt;<br>&gt; Therefore some questions:<br>&gt; - Are there still some known issues with cache aliasing in the MIPS kernel?<br>&gt; - Are there known issues when using 16KB pages (8KB pages seems not be
<br>&gt; possible due to tlb issues).<br><br></div></div>With recent kernels and toolchains 16k pages work ok IME. With a 2.6.12<br>kernel however you&#39;ll have to backport a serious amount of bugfixes<br>before 16k pages can work. Upgrading the kernel is probably less work.
<br><font color="#888888"><br>Thiemo<br></font></blockquote></div>Thanks for the info, any idea from which kernel this works ok?<br>Luc<br>

------=_Part_4614_2788155.1200379838899--
