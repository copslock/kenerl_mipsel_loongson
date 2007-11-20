Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 09:40:59 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.239]:13863 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023798AbXKTJkv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 09:40:51 +0000
Received: by nz-out-0506.google.com with SMTP id n1so1520782nzf
        for <linux-mips@linux-mips.org>; Tue, 20 Nov 2007 01:40:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=m78fUfcuddF2cykoHWIbV7X2MMthHNtq6MfkAvm/ZLc=;
        b=howHKGq4CSlVslL9XMHrEc6edlbaLCPSiEPoQWOZWGDzAqCHlQGz3ttFFm4IeVepXe4Yv25ouYok7ZtBLuCX1A3HE65KQrCzkTKMLLE7r7MaArk+l/ZVKjzHz8BCeodWzYBFN9XFEB8k6MCO+m1QJ30G4IADATUmKKKT+RlBB0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JsIWxAy1eeCox2yjTxcZtETVc0oI6zj9mGlYU+NTuVCYi45oRV4PzMMYRspWmT66H8FbgN4erlXZjfjsi6ujrYSkbTvtVaSlBkuX1tzcUhH4TdkcPYRCKJ3UnbfU8J8/3UJg4DMCf+rFrA5twA6Teh4vGzb7VBYFemXVYwkQzkY=
Received: by 10.114.75.1 with SMTP id x1mr639150waa.1195551637161;
        Tue, 20 Nov 2007 01:40:37 -0800 (PST)
Received: by 10.114.158.17 with HTTP; Tue, 20 Nov 2007 01:40:36 -0800 (PST)
Message-ID: <eea8a9c90711200140w46bda8cek6ee1a1817db9ae0d@mail.gmail.com>
Date:	Tue, 20 Nov 2007 15:10:36 +0530
From:	kaka <share.kt@gmail.com>
To:	"Denis Oliver Kropp" <dok@directfb.org>
Subject: Usage of mmap command
Cc:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org
In-Reply-To: <47429AEF.3010403@directfb.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21958_9268475.1195551637153"
References: <eea8a9c90711192239q6009cbb8y76790fa73bc4a5b7@mail.gmail.com>
	 <47429AEF.3010403@directfb.org>
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_21958_9268475.1195551637153
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Denis,

Thanks for the reply.
I am writing gfxdriver for directFB library for broadcom chip.
I have also written a frambuffer driver for broadcom chip.
In directFB code,

static volatile void *
system_map_mmio( unsigned int    offset,
                 int             length )
{
     void *addr;

     if (length <= 0)
          length = dfb_fbdev->shared->fix.mmio_len;

     addr = mmap( NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED,
                  dfb_fbdev->fd, dfb_fbdev->shared->fix.smem_len + offset );
     if ((int)(addr) == -1) {
          D_PERROR( "DirectFB/FBDev: Could not mmap MMIO region "
                     "(offset %d, length %d)!\n", offset, length );
          return NULL;
     }

     return(volatile void*) ((u8*) addr + (dfb_fbdev->shared->fix.mmio_start&
                                           dfb_fbdev->shared->page_mask));
}


the length and offset i am providing as 0 and -1.
It is throwing me error as Could not mmap MMIO region.
length coming from dfb_fbdev->shared->fix.smem_len is 16,00,000.
When i change the code to  addr = mmap( NULL, 900000, PROT_READ |
PROT_WRITE, MAP_SHARED, dfb_fbdev->fd, dfb_fbdev->shared->fix.smem_len +
offset );
Then it works fine but it is not allowing me to write to addresses with
offset greater than 900000.

My requirement is to write in to the MMIO registers with offset between
900000 and 16 00 000.

Could you please help me in htis regard?

Thanks in Advance.




On 11/20/07, Denis Oliver Kropp <dok@directfb.org> wrote:
>
> kaka wrote:
> > Hi All,
> >
> > void *mmap(void *start, size_t length, int prot, int flags,
> int
> > fd, off_t offset);
> >
> > I am providing 16,00,000 as length parameter in mmap command.
> > It is giving me error as Can't mmap region. on the other hand when i am
> > providing 9,00,000 as length parameter in mmap command.
> > It is successful.
> > This mmap command is being issued from User space.
> >
> > On the other hand in the framebuffer driver in the kernel spce i have
> > specified the length of mmio in the ioremap as 16,00,000.
>
> The ioremap() is independent of the values propagated to user space
> and fbmem.c via fix.mmio_start and fix.mmio_len, please check these.
>
> --
> Best regards,
> Denis Oliver Kropp
>
> .------------------------------------------.
> | DirectFB - Hardware accelerated graphics |
> | http://www.directfb.org/                 |
> "------------------------------------------"
>



-- 
Thanks & Regards,
kaka

------=_Part_21958_9268475.1195551637153
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Denis,</div>
<div>&nbsp;</div>
<div>Thanks for the reply.</div>
<div>I am writing gfxdriver for directFB library for broadcom chip.</div>
<div>I have also written a frambuffer driver for broadcom chip.</div>
<div>In directFB code,</div>
<p>static volatile void *<br>system_map_mmio( unsigned int&nbsp;&nbsp;&nbsp; offset,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; length )<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp; void *addr;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; if (length &lt;= 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; length = dfb_fbdev-&gt;shared-&gt;fix.mmio_len;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; addr = mmap( NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dfb_fbdev-&gt;fd, dfb_fbdev-&gt;shared-&gt;fix.smem_len + offset );<br>&nbsp;&nbsp;&nbsp;&nbsp; if ((int)(addr) == -1) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D_PERROR( &quot;DirectFB/FBDev: Could not mmap MMIO region &quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;(offset %d, length %d)!\n&quot;, offset, length );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; return(volatile void*) ((u8*) addr + (dfb_fbdev-&gt;shared-&gt;fix.mmio_start &amp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dfb_fbdev-&gt;shared-&gt;page_mask));<br>}<br></p>
<p>&nbsp;</p>
<div>the length and offset i am providing as 0 and -1.</div>
<div>It is throwing me error as Could not mmap MMIO region.</div>
<div>length coming from dfb_fbdev-&gt;shared-&gt;fix.smem_len is 16,00,000.</div>
<div>When i change the code to&nbsp;&nbsp;addr = mmap( NULL, 900000, PROT_READ | PROT_WRITE, MAP_SHARED,&nbsp;dfb_fbdev-&gt;fd, dfb_fbdev-&gt;shared-&gt;fix.smem_len + offset );</div>
<div>Then it works fine but it is not allowing me to write to addresses with offset greater than 900000.</div>
<div>&nbsp;</div>
<div>My requirement is to write in to the MMIO registers with offset between 900000 and 16 00 000.</div>
<div>&nbsp;</div>
<div>Could you please help me in htis regard?</div>
<div>&nbsp;</div>
<div>Thanks in Advance.<br>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/20/07, <b class="gmail_sendername">Denis Oliver Kropp</b> &lt;<a href="mailto:dok@directfb.org">dok@directfb.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">kaka wrote:<br>&gt; Hi All,<br>&gt;<br>&gt; void *mmap(void *start, size_t length, int prot, int flags,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int
<br>&gt; fd, off_t offset);<br>&gt;<br>&gt; I am providing 16,00,000 as length parameter in mmap command.<br>&gt; It is giving me error as Can&#39;t mmap region. on the other hand when i am<br>&gt; providing 9,00,000 as length parameter in mmap command.
<br>&gt; It is successful.<br>&gt; This mmap command is being issued from User space.<br>&gt;<br>&gt; On the other hand in the framebuffer driver in the kernel spce i have<br>&gt; specified the length of mmio in the ioremap as 16,00,000.
<br><br>The ioremap() is independent of the values propagated to user space<br>and fbmem.c via fix.mmio_start and fix.mmio_len, please check these.<br><br>--<br>Best regards,<br>Denis Oliver Kropp<br><br>.------------------------------------------.
<br>| DirectFB - Hardware accelerated graphics |<br>| <a href="http://www.directfb.org/">http://www.directfb.org/</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&quot;------------------------------------------&quot;<br></blockquote></div><br><br clear="all">
<br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_21958_9268475.1195551637153--
