Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 05:57:16 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:43731 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491102Ab0KKE5L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 05:57:11 +0100
Received: by qyk2 with SMTP id 2so1499220qyk.15
        for <linux-mips@linux-mips.org>; Wed, 10 Nov 2010 20:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oiQ2Dtu4EYBW0WDzehrquzkiiNj++SZR0wsq885KmgY=;
        b=I5sr8MR5SK2Ts8MYif+ZPJRblRABXdwf+uOSKGeufmDbX1uaqpBzJr3Pqf6R2nyGnW
         WMQ9KxNQxwOVWmmWWWh9QOHG+1J6GFwZpYCC0SVnGv2NZnllpxzC3tCPQh+pL791k2Qt
         00Edb6lIRoYZTEVMTpEnMHzwv5xHuHcxFo9F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mkjUhVbd4Zp+eWZo/BCVbXETdmM3ePQVooxsGDRVoTXroCJRPLuZc5nEhlibgXrAUX
         1yzAHaTovnqOh29NVu881MGnrsSLcEr2OYCQoKacupNjIQFCgyO1FYv+n8+T7CUl2Ssg
         ulDPaEySZFpEhfLkHFHQVbSdqDcXOMRL4x4is=
MIME-Version: 1.0
Received: by 10.229.232.15 with SMTP id js15mr370275qcb.161.1289451425254;
 Wed, 10 Nov 2010 20:57:05 -0800 (PST)
Received: by 10.220.162.69 with HTTP; Wed, 10 Nov 2010 20:57:05 -0800 (PST)
In-Reply-To: <20101109140527.GA13041@infradead.org>
References: <AANLkTi=mLwQ0N_cErHzES1ZWvOa8jQspeYwKgn9sU4Jm@mail.gmail.com>
        <20101104125052.GA22429@infradead.org>
        <AANLkTinqK-HvuHPeaTgxJOJuWMfomP2C12G=uVcqhWdn@mail.gmail.com>
        <20101109140527.GA13041@infradead.org>
Date:   Thu, 11 Nov 2010 10:27:05 +0530
Message-ID: <AANLkTik09-0udnrpAJ-mTxMx8iKZ5UTq-ucduQJOZkws@mail.gmail.com>
Subject: Re: XFS mounting fails on MIPS
From:   Ajeet Yadav <ajeet.yadav.77@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "xfs@oss.sgi.com" <xfs@oss.sgi.com>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016363b90c42850810494bfce0f
Return-Path: <ajeet.yadav.77@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ajeet.yadav.77@gmail.com
Precedence: bulk
X-list: linux-mips

--0016363b90c42850810494bfce0f
Content-Type: text/plain; charset=ISO-8859-1

Coming back to problem, I wish to know about this problem
Linux XFS version : 2.6.34
Architecure: MIPS
I am getting the following error during mount.

XFS mounting filesystem sda2
Starting XFS recovery on filesystem: sda2 (logdev: internal)
XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1518 of file
fs/xfs/xfs_alloc.c.  Caller 0x801174a0
Call Trace:
[<800050bc>] dump_stack+0x8/0x34
[<80115254>] xfs_free_ag_extent+0x128/0x7a8
[<801174a0>] xfs_free_extent+0xa0/0xcc
[<80155278>] xlog_recover_process_efi+0x15c/0x210
[<801553cc>] xlog_recover_process_efis+0xa0/0x12c
[<8015590c>] xlog_recover_finish+0x28/0xcc
[<8015d4fc>] xfs_mountfs+0x4f0/0x5d0
[<801758d8>] xfs_fs_fill_super+0x158/0x360
[<8008b67c>] get_sb_bdev+0x11c/0x1c4
[<801734e0>] xfs_fs_get_sb+0x20/0x2c
[<80089cd0>] vfs_kern_mount+0x68/0xd0
[<80089d9c>] do_kern_mount+0x54/0x118
[<800a4e98>] do_mount+0x7f0/0x86c
[<800a4fb0>] sys_mount+0x9c/0xf8
[<80002124>] stack_done+0x20/0x3c

Filesystem "sda2": XFS internal error xfs_trans_cancel at line 1161 of file
fs/xfs/xfs_trans.c.  Caller 0x801552f8

Call Trace:
[<800050bc>] dump_stack+0x8/0x34
[<801601f0>] xfs_trans_cancel+0x88/0x118
[<801552f8>] xlog_recover_process_efi+0x1dc/0x210
[<801553cc>] xlog_recover_process_efis+0xa0/0x12c
[<8015590c>] xlog_recover_finish+0x28/0xcc
[<8015d4fc>] xfs_mountfs+0x4f0/0x5d0
[<801758d8>] xfs_fs_fill_super+0x158/0x360
[<8008b67c>] get_sb_bdev+0x11c/0x1c4
[<801734e0>] xfs_fs_get_sb+0x20/0x2c
[<80089cd0>] vfs_kern_mount+0x68/0xd0
[<80089d9c>] do_kern_mount+0x54/0x118
[<800a4e98>] do_mount+0x7f0/0x86c
[<800a4fb0>] sys_mount+0x9c/0xf8
[<80002124>] stack_done+0x20/0x3c

xfs_force_shutdown(sda2,0x8) called from line 1162 of file
fs/xfs/xfs_trans.c.  Return address = 0x80160204
Filesystem "sda2": Corruption of in-memory data detected.  Shutting down
filesystem: sda2
Please umount the filesystem, and rectify the problem(s)
Failed to recover EFIs on filesystem: sda2
XFS: log mount finish failed

With Regards
Ajeet Yadav

On Tue, Nov 9, 2010 at 7:35 PM, Christoph Hellwig <hch@infradead.org> wrote:

> Hi Ajeet,
>
> On Tue, Nov 09, 2010 at 04:43:04PM +0530, Ajeet Yadav wrote:
> > True, its the same system and you were right it was cache VIPT cache
> problem
> > the cache hold the stale value even after xlog_bread() update the buffer.
> > I do not know whether its correct ways to resolve the problem, but the
> > problem no longer occur.
>
> It seems like you more less re-implemented the vmap coherency hooks
> inside XFS, hardcoded to the mips implementation.
>
> The actual helpers would looks something like:
>
> static inline void flush_kernel_vmap_range(void *addr, int size)
> {
>        dma_cache_inv(addr, size);
> }
>
> static inline void invalidate_kernel_vmap_range(void *addr, int size)
> {
>        dma_cache_inv(addr, size);
> }
>
> For some reason the kernel also expects flush_dcache_page to be
> implemented by an architecture if we want to implement these two
> (it's keyed off ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE).
>
> Can someone of the mips folks helps with this?
>
> The testcase is easy, mounting an xfs filesystem after an unclean
> shutdown on a machine with virtually indexed caches.
>
>

--0016363b90c42850810494bfce0f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Coming back to problem, I wish to know about this problem<div><span class=
=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; font-size: 1=
3px; border-collapse: collapse; "><div>Linux XFS version : 2.6.34</div><div=
>Architecure: MIPS</div>
<div>I am getting the following error during mount.</div><div>=A0</div><div=
>XFS mounting filesystem sda2<br>Starting XFS recovery on filesystem: sda2 =
(logdev: internal)<br>XFS internal error XFS_WANT_CORRUPTED_GOTO at line 15=
18 of file fs/xfs/xfs_alloc.c.=A0 Caller 0x801174a0<br>
Call Trace:<br>[&lt;800050bc&gt;] dump_stack+0x8/0x34<br>[&lt;80115254&gt;]=
 xfs_free_ag_extent+0x128/0x7a8<br>[&lt;801174a0&gt;] xfs_free_extent+0xa0/=
0xcc<br>[&lt;80155278&gt;] xlog_recover_process_efi+0x15c/0x210<br>[&lt;801=
553cc&gt;] xlog_recover_process_efis+0xa0/0x12c<br>
[&lt;8015590c&gt;] xlog_recover_finish+0x28/0xcc<br>[&lt;8015d4fc&gt;] xfs_=
mountfs+0x4f0/0x5d0<br>[&lt;801758d8&gt;] xfs_fs_fill_super+0x158/0x360<br>=
[&lt;8008b67c&gt;] get_sb_bdev+0x11c/0x1c4<br>[&lt;801734e0&gt;] xfs_fs_get=
_sb+0x20/0x2c<br>
[&lt;80089cd0&gt;] vfs_kern_mount+0x68/0xd0<br>[&lt;80089d9c&gt;] do_kern_m=
ount+0x54/0x118<br>[&lt;800a4e98&gt;] do_mount+0x7f0/0x86c<br>[&lt;800a4fb0=
&gt;] sys_mount+0x9c/0xf8<br>[&lt;80002124&gt;] stack_done+0x20/0x3c<br>
=A0<br>Filesystem &quot;sda2&quot;: XFS internal error xfs_trans_cancel at =
line 1161 of file fs/xfs/xfs_trans.c.=A0 Caller 0x801552f8<br>=A0<br>Call T=
race:<br>[&lt;800050bc&gt;] dump_stack+0x8/0x34<br>[&lt;801601f0&gt;] xfs_t=
rans_cancel+0x88/0x118<br>
[&lt;801552f8&gt;] xlog_recover_process_efi+0x1dc/0x210<br>[&lt;801553cc&gt=
;] xlog_recover_process_efis+0xa0/0x12c<br>[&lt;8015590c&gt;] xlog_recover_=
finish+0x28/0xcc<br>[&lt;8015d4fc&gt;] xfs_mountfs+0x4f0/0x5d0<br>[&lt;8017=
58d8&gt;] xfs_fs_fill_super+0x158/0x360<br>
[&lt;8008b67c&gt;] get_sb_bdev+0x11c/0x1c4<br>[&lt;801734e0&gt;] xfs_fs_get=
_sb+0x20/0x2c<br>[&lt;80089cd0&gt;] vfs_kern_mount+0x68/0xd0<br>[&lt;80089d=
9c&gt;] do_kern_mount+0x54/0x118<br>[&lt;800a4e98&gt;] do_mount+0x7f0/0x86c=
<br>
[&lt;800a4fb0&gt;] sys_mount+0x9c/0xf8<br>[&lt;80002124&gt;] stack_done+0x2=
0/0x3c<br>=A0<br>xfs_force_shutdown(sda2,0x8) called from line 1162 of file=
 fs/xfs/xfs_trans.c.=A0 Return address =3D 0x80160204<br>Filesystem &quot;s=
da2&quot;: Corruption of in-memory data detected.=A0 Shutting down filesyst=
em: sda2<br>
Please umount the filesystem, and rectify the problem(s)<br>Failed to recov=
er EFIs on filesystem: sda2<br>XFS: log mount finish failed</div><div>=A0</=
div><div>With Regards</div><div>Ajeet Yadav</div></span><br><div class=3D"g=
mail_quote">
On Tue, Nov 9, 2010 at 7:35 PM, Christoph Hellwig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:hch@infradead.org">hch@infradead.org</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex;">
Hi Ajeet,<br>
<div class=3D"im"><br>
On Tue, Nov 09, 2010 at 04:43:04PM +0530, Ajeet Yadav wrote:<br>
&gt; True, its the same system and you were right it was cache VIPT cache p=
roblem<br>
&gt; the cache hold the stale value even after xlog_bread() update the buff=
er.<br>
&gt; I do not know whether its correct ways to resolve the problem, but the=
<br>
&gt; problem no longer occur.<br>
<br>
</div>It seems like you more less re-implemented the vmap coherency hooks<b=
r>
inside XFS, hardcoded to the mips implementation.<br>
<br>
The actual helpers would looks something like:<br>
<br>
static inline void flush_kernel_vmap_range(void *addr, int size)<br>
{<br>
 =A0 =A0 =A0 =A0dma_cache_inv(addr, size);<br>
}<br>
<br>
static inline void invalidate_kernel_vmap_range(void *addr, int size)<br>
{<br>
 =A0 =A0 =A0 =A0dma_cache_inv(addr, size);<br>
}<br>
<br>
For some reason the kernel also expects flush_dcache_page to be<br>
implemented by an architecture if we want to implement these two<br>
(it&#39;s keyed off ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE).<br>
<br>
Can someone of the mips folks helps with this?<br>
<br>
The testcase is easy, mounting an xfs filesystem after an unclean<br>
shutdown on a machine with virtually indexed caches.<br>
<br>
</blockquote></div><br></div>

--0016363b90c42850810494bfce0f--
