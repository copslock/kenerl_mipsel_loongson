Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 11:40:29 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51646 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903590Ab2EVJk0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 11:40:26 +0200
Received: by wibhm14 with SMTP id hm14so3001986wib.6
        for <linux-mips@linux-mips.org>; Tue, 22 May 2012 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=TBYNpwEIMbWRTjMcQGdmKACOWOqQMz4Ykr8l776IVMg=;
        b=MjMG+mVnBWk9q+LlBxSHB4IAJ4BlPsR3DRvXOvHuoVBmIzmqJTyozD/I+ruvuHja/G
         bS+2mMI/KO3wWdxPPnlm/iWMpAOj+J7ICTWL7QSDHpjiJWmCOBnwtx/KLZAIRchJC4UY
         cWoKQLyRuu/wR3njsFLvJmycQcQ5x8X8f0SRdYbpcUGy2yQ5DK/6MFuAUDVwBa1TYPkV
         DX2QPT9SCl5l9w1AyGIzyj8OIA01ey5SGqS54W7hCAfpLFrn9/et/6zL2KzXTAKklTeZ
         8/d50NTFGnNtLcKYPtjqZeP5zCa8hBuiWo+YHr/B1C83kaYjD4In6hpOl/nIJzQ7waRp
         c63Q==
MIME-Version: 1.0
Received: by 10.180.109.229 with SMTP id hv5mr47241273wib.0.1337679620884;
 Tue, 22 May 2012 02:40:20 -0700 (PDT)
Received: by 10.216.135.148 with HTTP; Tue, 22 May 2012 02:40:20 -0700 (PDT)
Date:   Tue, 22 May 2012 17:40:20 +0800
Message-ID: <CADSewLWvfVsQob-y5Q9mc31JpecHFd6=5dRhKxdH3VvT0HXJZQ@mail.gmail.com>
Subject: handle_sys question
From:   Songmao Tian <kingkongmao@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=e89a8f2354bda048c204c09cce6b
X-archive-position: 33412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kingkongmao@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--e89a8f2354bda048c204c09cce6b
Content-Type: text/plain; charset=ISO-8859-1

Hello all:
   In handle_sys there's a
50<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/kernel/scall32-o32.S;h=a632bc144efa1b9ca977a582864530e33ee039cb;hb=72c04af9a2d57b7945cf3de8e71461bd80695d50#l50>
       sw      a3, PT_R26(sp)          # save a3 for syscall
restarting

I woner why it need to save  a3 in R26(k0) slot in the stack?

Thanks,
songmao

--e89a8f2354bda048c204c09cce6b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all:<br>=A0=A0 In handle_sys there&#39;s a <br><a id=3D"l50" href=3D"=
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
;f=3Darch/mips/kernel/scall32-o32.S;h=3Da632bc144efa1b9ca977a582864530e33ee=
039cb;hb=3D72c04af9a2d57b7945cf3de8e71461bd80695d50#l50" class=3D"linenr"> =
 50</a> =A0=A0=A0=A0=A0=A0=A0=A0sw=A0=A0=A0=A0=A0=A0a3,=A0PT_R26(sp)=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0#=A0save=A0a3=A0for=A0syscall=A0restarting<br>
<br>I woner why it need to save=A0 a3 in R26(k0) slot in the stack?<br><br>=
Thanks,<br>songmao<br>

--e89a8f2354bda048c204c09cce6b--
