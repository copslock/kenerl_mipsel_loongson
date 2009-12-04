Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 18:52:12 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:54767 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493554AbZLDRwJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 18:52:09 +0100
Received: by ewy24 with SMTP id 24so3080820ewy.26
        for <linux-mips@linux-mips.org>; Fri, 04 Dec 2009 09:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=uD/1LGam3sEYdOqwV9fy57iswMHxH+9QYr37ksAUfWE=;
        b=WQDiggAhJH54rtpBcx7V1VkKQCylckM+F/q4njEvyW8lDnpA5NMaBJYkcVemWYlj7P
         V7yTy6GcnQqTrrs9AiA2NS5Ady1yM0Hb96zxOOKlDENBbv/Iejp9UxQHsUTA36Ba23tm
         eDtaPiCzDd543dAe9fIzXkxwIy6Le8Dr4zzFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=n/AM1gNbeWluynaU1WRKD/M1dGvuTGgjT53umAGFUljhPOsl6GRfqnzobLMW31JWPC
         jop2H6lp/gMypP6mtbCJmKy6VG1cssLNE043r25LVkPtTYA8Gh+EkSWq5dXb7qEyjq1Y
         Z8kiotEqv4mODaPLbRMkivkdlsasHRIy+KeWI=
MIME-Version: 1.0
Received: by 10.216.88.144 with SMTP id a16mr1148039wef.208.1259949123901; 
        Fri, 04 Dec 2009 09:52:03 -0800 (PST)
Date:   Fri, 4 Dec 2009 11:52:03 -0600
Message-ID: <83f0348b0912040952h40d4d151n79ca5fc33a830ee2@mail.gmail.com>
Subject: mmap KSEG1
From:   Ed Okerson <ed.okerson@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ed.okerson@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed.okerson@gmail.com
Precedence: bulk
X-list: linux-mips

Is it possible to mmap an address in KSEG1 so a user space app can
read/write to an IO device uncached?

Ed
