Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 13:34:24 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:61499 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab0IGLeV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Sep 2010 13:34:21 +0200
Received: by wyb38 with SMTP id 38so6391879wyb.36
        for <multiple recipients>; Tue, 07 Sep 2010 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=lDmUtaW36SPyzY862UeLMWwJzpR740yTX32Vlb3q3PY=;
        b=bKZhaD34xz7NHSTGBHWDP6gAO4r+qNom365FRKncbVLh9J6U9JBkuETaRBwJ2z5JEJ
         DbPdeGEg/DDLzqbTT2zUtBD//Ask+9xZRlo+3YQcSYC/tNBGLWU/EK5XH5+Ts76u8fFq
         g5RjW6MjEvy1GMCnczMLoBecU0h+ZZzQaH0Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=sGB/+Gdmb2UPeM7URlZL+mkZcOGZUjdlt7Yy6et71JGJluCB+mC03D2/e9wbM54rgx
         Vmkqts8wDu71AxwLtBM2x5ztXGVORNW+T6af/UslLmOHNmvbWgcCxX9XSflpmZF5WqyJ
         Rs70pOJdczQIrr/hNRe7aF7xLpI3ileKPFzVY=
MIME-Version: 1.0
Received: by 10.216.59.131 with SMTP id s3mr1304000wec.71.1283859255791; Tue,
 07 Sep 2010 04:34:15 -0700 (PDT)
Received: by 10.216.29.148 with HTTP; Tue, 7 Sep 2010 04:34:15 -0700 (PDT)
Date:   Tue, 7 Sep 2010 17:04:15 +0530
Message-ID: <AANLkTikya-sDVRLpPisSWs15EU_zphm==z0hEB45tLH5@mail.gmail.com>
Subject: Memory regression test tool on MIPS needed
From:   naren.mehra@gmail.com
To:     msundius@cisco.com, dvomlehn@cisco.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, sshtylyov@mvista.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: naren.mehra@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5173

Hi,

I have recently applied the sparsemem patch on my mips board.
Now I intend to write a detail analysis with its performance before
and after the patch and whether it has broken anything in the memory
management system.
For that I need a memory regression tool that works on mips board.
Can anybody help me with that ?

Regards,
Naren
