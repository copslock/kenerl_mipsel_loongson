Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2011 08:45:09 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:54249 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490958Ab1DLGpF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2011 08:45:05 +0200
Received: by pzk5 with SMTP id 5so2725546pzk.36
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2011 23:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=F5MaIqWVrDA/lUXai7iti8FnaKSDWXvpc71W70VETdw=;
        b=lA9S1Xpe5NH5MSu9sFKhe2aafMZSN6Uv4SmTEYzL1PRrsVRp1DNq5bRxrnACFau/yo
         NTisKrA5XngJgXiA7a/9Bh5xUdl3GqzOeg535hUXigNGZbJxwDyvMeyfsIqvLRs4B5KT
         8kDim+3l/DLGWB/A8+IOfX9zEiZaPBWjiPWZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=qAfVSt0LgaValEC1ZfguuoLJSJtPQ/cAsFfvVLvI5zHpnvxZ9VWJTX1xWS0JOWYqf6
         vnXbyorAD6PrxAlV0h2ryBTtds9wlrVMAvAbFATFYih1hwc3O5ly3o+Ox1Tk5nyNdrad
         9q/OUleEYwwgwKLutbtQqQlEwxofy8e5+WENA=
MIME-Version: 1.0
Received: by 10.142.178.17 with SMTP id a17mr895806wff.64.1302590698121; Mon,
 11 Apr 2011 23:44:58 -0700 (PDT)
Received: by 10.68.43.106 with HTTP; Mon, 11 Apr 2011 23:44:58 -0700 (PDT)
Date:   Tue, 12 Apr 2011 02:44:58 -0400
X-Google-Sender-Auth: PBUBfxprRCuHUL-1-NJtreJ9n68
Message-ID: <BANLkTikTDQgwHtK1V4AqRAALw_HrSTuvnQ@mail.gmail.com>
Subject: [PATCH] Notifier chain called twice
From:   Yury Polyanskiy <ypolyans@princeton.edu>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=000e0cd2df94d9696604a0b3078a
Return-Path: <polyanskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ypolyans@princeton.edu
Precedence: bulk
X-list: linux-mips

--000e0cd2df94d9696604a0b3078a
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

The notifier chain is currently called twice on OOPS. Patch below.

Best,
Yury




diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4e00f9b..fdc6773 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -375,8 +375,6 @@ void __noreturn die(const char *str, str
        unsigned long dvpret = dvpe();
 #endif /* CONFIG_MIPS_MT_SMTC */

-       notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV);
-
        console_verbose();
        spin_lock_irq(&die_lock);
        bust_spinlocks(1);

--000e0cd2df94d9696604a0b3078a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>The notifier chain is currently called twice on OOPS. Patc=
h below.<br><br>Best,<br>Yury<br><br><br><br><br>diff --git a/arch/mips/ker=
nel/traps.c b/arch/mips/kernel/traps.c<br>index 4e00f9b..fdc6773 100644<br>
--- a/arch/mips/kernel/traps.c<br>+++ b/arch/mips/kernel/traps.c<br>@@ -375=
,8 +375,6 @@ void __noreturn die(const char *str, str<br>=A0=A0=A0=A0=A0=A0=
=A0 unsigned long dvpret =3D dvpe();<br>=A0#endif /* CONFIG_MIPS_MT_SMTC */=
<br>=A0<br>-=A0=A0=A0=A0=A0=A0 notify_die(DIE_OOPS, str, regs, 0, regs_to_t=
rapnr(regs), SIGSEGV);<br>
-<br>=A0=A0=A0=A0=A0=A0=A0 console_verbose();<br>=A0=A0=A0=A0=A0=A0=A0 spin=
_lock_irq(&amp;die_lock);<br>=A0=A0=A0=A0=A0=A0=A0 bust_spinlocks(1);<br><b=
r>

--000e0cd2df94d9696604a0b3078a--
