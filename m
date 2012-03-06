Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 14:48:24 +0100 (CET)
Received: from mail-tul01m020-f177.google.com ([209.85.214.177]:64925 "EHLO
        mail-tul01m020-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903665Ab2CFNsK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2012 14:48:10 +0100
Received: by obbta2 with SMTP id ta2so7508429obb.36
        for <linux-mips@linux-mips.org>; Tue, 06 Mar 2012 05:48:04 -0800 (PST)
Received-SPF: pass (google.com: domain of miloody@gmail.com designates 10.182.15.70 as permitted sender) client-ip=10.182.15.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of miloody@gmail.com designates 10.182.15.70 as permitted sender) smtp.mail=miloody@gmail.com; dkim=pass header.i=miloody@gmail.com
Received: from mr.google.com ([10.182.15.70])
        by 10.182.15.70 with SMTP id v6mr10417190obc.13.1331041684527 (num_hops = 1);
        Tue, 06 Mar 2012 05:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ruY6QyM8qKEfKMjUXvooYdJHMNupAm8WNlkwEK6lVhw=;
        b=Lp5zOEz2ueDyqPCE3QYlLsXdJvgKosuHus9QM2XxMPpaanIviUiS2CooO991g1xNcg
         WiaJgWGfU6XZe2JVo4LV2OLrnPWDjoz3FN51dNh455NdX78RPFU7W1BtrXs6LkULo7k8
         AlMugHYLhnLqCHg6v9MbISsKN7hOOasHI0LI0tWVzZoIBaZOR4R/gOHgfmdktP+EafVk
         LcimFHgpD2kM8h96a5ZfnqR3Un1Y7kpuTWRW9OFyETjtvraUT5ZXK9ga+BgRyasr+11o
         FSjGaha4/6URunA4+hgy6QpMTy5uab3otUo+PmbLrYIoLJHtdOhH8mzlXQGD7GvYloER
         X4/Q==
MIME-Version: 1.0
Received: by 10.182.15.70 with SMTP id v6mr8946946obc.13.1331041684469; Tue,
 06 Mar 2012 05:48:04 -0800 (PST)
Received: by 10.60.141.201 with HTTP; Tue, 6 Mar 2012 05:48:04 -0800 (PST)
Date:   Tue, 6 Mar 2012 21:48:04 +0800
Message-ID: <CANudz+ugY7NfCSGh-_kS4pzC91p02ZtYpxXMdCOKsM+spAt37g@mail.gmail.com>
Subject: some questions about mips timer
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

hi all:
I have some questions about mips_hpt_frequency:
1. is mips_hpt_frequency == mips cpu frequency?
2. what does "hpt" mean?


-- 
Appreciate your help,
