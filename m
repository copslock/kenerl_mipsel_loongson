Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 03:32:45 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:48916 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492162Ab0G2Bcm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jul 2010 03:32:42 +0200
Received: by pxi13 with SMTP id 13so2537pxi.36
        for <multiple recipients>; Wed, 28 Jul 2010 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LcOQmI+3pp8CFRqx0vwglC3YCVZHMj2kPoBWInoT3CQ=;
        b=qMM3UwffAxC2/3bIV+FBPUydbdiSxxIbIUxkJ5I1/2jN0yoeQDBTyhqaWXN7KP4Tqu
         bAWtiIss0lT4OeVLDrwIYfVqUO28g9wFxM3g75OSQdx90L+A8ewB+J5CPBTLXkcPMhZb
         bGWbwvCCMQie6qemGsSRgJMlXFhhGlGkg5C2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bvcrvzP2lHkAholIXOwZXKVPHVDtv7EbUbak0JnFxFTTQppI5mGm5cKWoL0V2Bh0lb
         UWuTtzrjobxSLoMrEnSXR09A20nx38XBRlx+uHaBTO62lOyiYk6Cafsb8l6wSJ8t+fbx
         KoNHxmKjhDSrRdfOydUD5fyCDXncaGUohaWzo=
MIME-Version: 1.0
Received: by 10.142.79.1 with SMTP id c1mr12527093wfb.279.1280367155364; Wed, 
        28 Jul 2010 18:32:35 -0700 (PDT)
Received: by 10.142.232.14 with HTTP; Wed, 28 Jul 2010 18:32:35 -0700 (PDT)
In-Reply-To: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com>
References: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com>
Date:   Thu, 29 Jul 2010 09:32:35 +0800
Message-ID: <AANLkTi=QT+GXLEQ39LvVPyEG9ETRJEho1owr3J5-mjck@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Unify the suffix of compressed vmlinux.bin
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: multipart/alternative; boundary=001636e0b2fa7a43c2048c7cb59f
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

--001636e0b2fa7a43c2048c7cb59f
Content-Type: text/plain; charset=ISO-8859-1

Hi, Ralf

ping ...

Is it possible to queue the following several cleanups of the compressed
kernel support to 2.6.36?

1. [v2] MIPS: Unify the suffix of compressed vmlinux.bin
http://patchwork.linux-mips.org/patch/1323/
2. [v4] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
http://patchwork.linux-mips.org/patch/1324/
3. MIPS: Clean up arch/mips/boot/compressed/ld.script
http://patchwork.linux-mips.org/patch/1381/
4. MIPS: Clean up arch/mips/boot/compressed/decompress.c
http://patchwork.linux-mips.org/patch/1382/
5. MIPS: strip the un-needed sections of vmlinuz
http://patchwork.linux-mips.org/patch/1383/

All of them only include cleanups, no functional changes.

Seems you need to apply them one by one as the above order.

Best Regards,
Wu Zhangjin

On Wed, Jun 2, 2010 at 4:35 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> The compressed vmlinux.bin is only a temp file, we can use the same
> suffix(.z)
> for them(.gz,.lzo,.lzma...) to remove several lines and simpify the
> maintaining(no need to add the "suffix_$(xxx) := suffix" line).
>
> Changes:
>
>  v1 -> v2:
>    o Rename vmlinux.z to vmlinux.bin.z for vmlinux.z here is the compressed
>    vmlinux.bin, not compressed vmlinux.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/compressed/Makefile |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/boot/compressed/Makefile
> b/arch/mips/boot/compressed/Makefile
> index 74a52d7..a517f58 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -48,23 +48,19 @@ OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary
> -R .comment -S
>  $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
>        $(call if_changed,objcopy)
>
> -suffix_$(CONFIG_KERNEL_GZIP)  = gz
> -suffix_$(CONFIG_KERNEL_BZIP2) = bz2
> -suffix_$(CONFIG_KERNEL_LZMA)  = lzma
> -suffix_$(CONFIG_KERNEL_LZO)   = lzo
>  tool_$(CONFIG_KERNEL_GZIP)    = gzip
>  tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
>  tool_$(CONFIG_KERNEL_LZMA)    = lzma
>  tool_$(CONFIG_KERNEL_LZO)     = lzo
>
> -targets += vmlinux.gz vmlinux.bz2 vmlinux.lzma vmlinux.lzo
> -$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin FORCE
> +targets += vmlinux.bin.z
> +$(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
>        $(call if_changed,$(tool_y))
>
>  targets += piggy.o
> -OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.$(suffix_y) \
> +OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.bin.z \
>
> --set-section-flags=.image=contents,alloc,load,readonly,data
> -$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.$(suffix_y) FORCE
> +$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
>        $(call if_changed,objcopy)
>
>  LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
> --
> 1.6.5
>
>


-- 
MSN+Gtalk: wuzhangjin@gmail.com
Blog: http://falcon.oss.lzu.edu.cn
Tel:+86-18710032278

--001636e0b2fa7a43c2048c7cb59f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, Ralf<br><br>ping ...<br><br>Is it possible to queue the following sever=
al cleanups of the compressed kernel support to 2.6.36?<br><br>1. [v2] MIPS=
: Unify the suffix of compressed vmlinux.bin<br><a href=3D"http://patchwork=
.linux-mips.org/patch/1323/">http://patchwork.linux-mips.org/patch/1323/</a=
><br>
2. [v4] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS<br><a href=
=3D"http://patchwork.linux-mips.org/patch/1324/">http://patchwork.linux-mip=
s.org/patch/1324/</a><br>3. MIPS: Clean up arch/mips/boot/compressed/ld.scr=
ipt<br>
<a href=3D"http://patchwork.linux-mips.org/patch/1381/">http://patchwork.li=
nux-mips.org/patch/1381/</a><br>4. MIPS: Clean up arch/mips/boot/compressed=
/decompress.c<br><a href=3D"http://patchwork.linux-mips.org/patch/1382/">ht=
tp://patchwork.linux-mips.org/patch/1382/</a><br>
5. MIPS: strip the un-needed sections of vmlinuz<br><a href=3D"http://patch=
work.linux-mips.org/patch/1383/">http://patchwork.linux-mips.org/patch/1383=
/</a><br><br>All of them only include cleanups, no functional changes.<br>
<br>Seems you need to apply them one by one as the above order.<br><br>Best=
 Regards,<br>Wu Zhangjin<br><br><div class=3D"gmail_quote">On Wed, Jun 2, 2=
010 at 4:35 PM, Wu Zhangjin <span dir=3D"ltr">&lt;<a href=3D"mailto:wuzhang=
jin@gmail.com">wuzhangjin@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">The compressed vm=
linux.bin is only a temp file, we can use the same suffix(.z)<br>
for them(.gz,.lzo,.lzma...) to remove several lines and simpify the<br>
maintaining(no need to add the &quot;suffix_$(xxx) :=3D suffix&quot; line).=
<br>
<br>
Changes:<br>
<br>
 =A0v1 -&gt; v2:<br>
 =A0 =A0o Rename vmlinux.z to vmlinux.bin.z for vmlinux.z here is the compr=
essed<br>
 =A0 =A0vmlinux.bin, not compressed vmlinux.<br>
<br>
Signed-off-by: Wu Zhangjin &lt;<a href=3D"mailto:wuzhangjin@gmail.com">wuzh=
angjin@gmail.com</a>&gt;<br>
---<br>
=A0arch/mips/boot/compressed/Makefile | =A0 12 ++++--------<br>
=A01 files changed, 4 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed=
/Makefile<br>
index 74a52d7..a517f58 100644<br>
--- a/arch/mips/boot/compressed/Makefile<br>
+++ b/arch/mips/boot/compressed/Makefile<br>
@@ -48,23 +48,19 @@ OBJCOPYFLAGS_vmlinux.bin :=3D $(OBJCOPYFLAGS) -O binary=
 -R .comment -S<br>
=A0$(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE<br>
 =A0 =A0 =A0 =A0$(call if_changed,objcopy)<br>
<br>
-suffix_$(CONFIG_KERNEL_GZIP) =A0=3D gz<br>
-suffix_$(CONFIG_KERNEL_BZIP2) =3D bz2<br>
-suffix_$(CONFIG_KERNEL_LZMA) =A0=3D lzma<br>
-suffix_$(CONFIG_KERNEL_LZO) =A0 =3D lzo<br>
=A0tool_$(CONFIG_KERNEL_GZIP) =A0 =A0=3D gzip<br>
=A0tool_$(CONFIG_KERNEL_BZIP2) =A0 =3D bzip2<br>
=A0tool_$(CONFIG_KERNEL_LZMA) =A0 =A0=3D lzma<br>
=A0tool_$(CONFIG_KERNEL_LZO) =A0 =A0 =3D lzo<br>
<br>
-targets +=3D vmlinux.gz vmlinux.bz2 vmlinux.lzma vmlinux.lzo<br>
-$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin FORCE<br>
+targets +=3D vmlinux.bin.z<br>
+$(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE<br>
 =A0 =A0 =A0 =A0$(call if_changed,$(tool_y))<br>
<br>
=A0targets +=3D piggy.o<br>
-OBJCOPYFLAGS_piggy.o :=3D --add-section=3D.image=3D$(obj)/vmlinux.$(suffix=
_y) \<br>
+OBJCOPYFLAGS_piggy.o :=3D --add-section=3D.image=3D$(obj)/vmlinux.bin.z \<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --set-section-flags=3D.ima=
ge=3Dcontents,alloc,load,readonly,data<br>
-$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.$(suffix_y) FORCE<br>
+$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE<br>
 =A0 =A0 =A0 =A0$(call if_changed,objcopy)<br>
<br>
=A0LDFLAGS_vmlinuz :=3D $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T<br>
<font color=3D"#888888">--<br>
1.6.5<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>MSN+Gtalk: <a hr=
ef=3D"mailto:wuzhangjin@gmail.com">wuzhangjin@gmail.com</a><br>Blog: <a hre=
f=3D"http://falcon.oss.lzu.edu.cn">http://falcon.oss.lzu.edu.cn</a><br>Tel:=
+86-18710032278<br>


--001636e0b2fa7a43c2048c7cb59f--
