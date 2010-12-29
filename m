Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 21:21:15 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:55853 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491039Ab0L2UVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Dec 2010 21:21:12 +0100
Received: by iwn38 with SMTP id 38so11403440iwn.36
        for <multiple recipients>; Wed, 29 Dec 2010 12:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Ke0n9BJ/mBllEfTtvEXg2nfNCX0NqrPmeN/0ybrqlxs=;
        b=sl1ESztGiiEcu3Qbgv2O+ZC2pF2v1MOZuzM5+Me9Rzy9I7EVNtRfrZAch/erP1Yqaq
         tZaJkH4KeuPKjrdKeO313BImHeL2LxdDGWMwZTYZLYc8YUat1pRQTGsuSAdJ3etk6yMt
         Iv7PMyGZc8Bwn0wD4JR/MxwCTFFCjd59O3CN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wHCYQFUbfgniNREo0/4VtqDleCxVY+YhSfEk+zyLP5AEuR4UThm965jQOuzFaBv5Rz
         WhcKBD+DZge1znOla2CCRzvpGlHIEZGRnoGrnV5v0seqKpHZ6nexPkDfXxQ2g+7xWqMP
         EfDk0UEqFvwBl1HgGxusP3Tr8Pv7rTA0K9psY=
MIME-Version: 1.0
Received: by 10.231.191.4 with SMTP id dk4mr15239176ibb.31.1293654070072; Wed,
 29 Dec 2010 12:21:10 -0800 (PST)
Received: by 10.231.161.84 with HTTP; Wed, 29 Dec 2010 12:21:10 -0800 (PST)
Date:   Wed, 29 Dec 2010 12:21:10 -0800
Message-ID: <AANLkTi=_2aqFiB4Qgez8f-tiiqv19+VHDzX2TJ7jZ2Ha@mail.gmail.com>
Subject: [PATCH RESEND] MIPS: Add local_flush_tlb_all_mm to clear all mm
 contexts on calling cpu
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

I hope this one does not get mangled. The thing is I do not know how
to control it in gmail web client.
