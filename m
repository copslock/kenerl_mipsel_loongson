Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2010 04:53:45 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:40881 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490975Ab0IYCxl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Sep 2010 04:53:41 +0200
Received: by qwe4 with SMTP id 4so76142qwe.36
        for <multiple recipients>; Fri, 24 Sep 2010 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2k50RZZzSm+r2Nmcou6aEyagI7yhT71Bluuz3iVc2gI=;
        b=Wtr5Pv5Q5v43FzF9+Y9ibui/PTOnrsoDUoSGjFFf72DUtjiIXimtyNHFSvdpIxIn3M
         iVw1U/VYiqLoYKaq6bw5YUHiD4H5pisezK1hkzFwKLL0DP0WNdlGqpNoEUNaNawhT04+
         DkzA9afq3o9Y7upGNkLN0AD7ZSDCVLdhijxm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rSny/jN/eecfJO94r/zctSKiQTme6VzuY/owUC4cM56Y5/lG6KECnsS681ZuLAIYIN
         wJJyhHufgNcDTG9h5ZR9ZALOXdY3mcDNs2TEptZobBxr4l3INNIhSyx35eYEsxo7nbTI
         K8jztYRbaIKyWMblK+4VUzs7Hy7E/edxLdY5E=
MIME-Version: 1.0
Received: by 10.224.80.203 with SMTP id u11mr2998720qak.384.1285383214548;
 Fri, 24 Sep 2010 19:53:34 -0700 (PDT)
Received: by 10.229.25.208 with HTTP; Fri, 24 Sep 2010 19:53:34 -0700 (PDT)
In-Reply-To: <20100924083638.GA7503@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
        <1276058130-25851-5-git-send-email-dengcheng.zhu@gmail.com>
        <20100922122711.GB6392@console-pimps.org>
        <AANLkTinq+2LHgycDGyPgrEfkp3PSYxqagV1TfbjcQTwO@mail.gmail.com>
        <20100924083638.GA7503@console-pimps.org>
Date:   Sat, 25 Sep 2010 10:53:34 +0800
Message-ID: <AANLkTim16p2GNsUKcqX0JC-BQtaD0qdxvjCdZHy13w1m@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] MIPS: add support for hardware performance events (skeleton)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20042

2010/9/24 Matt Fleming <matt@console-pimps.org>:
> The potential problem with doing a cleanup patch after this series has
> been merged is that it will modify most of the code in this patch
> series - essentially rewriting it. I don't have a strong opinion
> either way but Ralf may.
[DC]: No, the situation is not that serious. The mips_pmu registration
mechanism had already been implemented. You may take a look at the
bottom of perf_event_mipsxx.c (patch #6). The ugly conditional code
(mips_pmu_irq) could be fixed easily, I suppose.


Deng-Cheng
