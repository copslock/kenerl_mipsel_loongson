Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 13:32:32 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:51444 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491915Ab1ABMc3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 13:32:29 +0100
Received: by iwn38 with SMTP id 38so13759885iwn.36
        for <linux-mips@linux-mips.org>; Sun, 02 Jan 2011 04:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=HAr1kLxwjh0BSZy2euVDBKqLV2XrVe19WO7MzqBQopk=;
        b=cHaMkgVTnyCkXRZW8CAsNiueD8ytgyMbLMEBXobe/ozHomyN76+SaHI+lF7eq30WxA
         w5wFppsb1je7X4vGqlhvHAj8nnN1jU4DTfruk3dUanRl/90LG2qwhQzeZbmdr7PeXnav
         gQSBx1E2b2QovPX7o2GaZsrCJjouaqoLkHi5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=BrcCScy8yqLeJEGwvjp8Tixqc+NUdfyMAoxW2rSEvFYuq3NKx4s6/wvYakp/oRyq2m
         SDzA8dcuQfqkcVhTFP9NvFp53pTei7BLAlK+KhWWBjmDd6eQp2hQgiymkd9FB1DISr/n
         CHwKhjix16Z56FWT/OB8SIyiMKk5V7+WxMn0o=
MIME-Version: 1.0
Received: by 10.42.177.137 with SMTP id bi9mr19748573icb.194.1293971546455;
 Sun, 02 Jan 2011 04:32:26 -0800 (PST)
Received: by 10.42.174.131 with HTTP; Sun, 2 Jan 2011 04:32:26 -0800 (PST)
Date:   Sun, 2 Jan 2011 20:32:26 +0800
Message-ID: <AANLkTinBYUHdsaz40216BRadvU3mx2H5F4Hfp1J0NibB@mail.gmail.com>
Subject: is there dummy r/w in mips kernel API
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
I am trying porting usb on mips platform.
Due to hw limitation, I have to do the dummy read to make sure data
has been written to the memory, so I announce an volatile parameter,
tmp, such that cpu will read the same address back to me.

Below is what I try to do in usb driver:
                        wmb ();
    389c:       0000000f        sync
                        dummy->hw_token = token;
    38a0:       ae740008        sw      s4,8(s3)
                        tmp = dummy->hw_token;
    38a4:       afb40010        sw      s4,16(sp)
as you can see, the compiler is so smart that he read the register
content instead of re-read the memory for accelerating the read speed.
unfortunately, that isn't I want. Is there already exist kernel API can help me?
appreciate your help,
miloody
