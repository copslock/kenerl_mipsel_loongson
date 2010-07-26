Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 23:54:52 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:46364 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492363Ab0GZVys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jul 2010 23:54:48 +0200
Received: by vws11 with SMTP id 11so3202376vws.36
        for <multiple recipients>; Mon, 26 Jul 2010 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=DydwOVXDprX2Cc9q6bwTR688qOYxKHt35jG1B3SsvSA=;
        b=S+KJjbC8+89samHIiL3zHZdUeS/BiT5RI1Nl3p997EOD9KMcI62/kt/b0yBGeoWTRD
         Ew17ZcpCvCr1uwELmRGAZu1PlbGlr5xCGK6IcTe+K0m9FdaHbj+mUIOpkceHqk5gje0e
         PyWZ3zk86g2tffjr56qd9qBsK/43xE7IQeZiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=W/Ca5OKkiPHWtJC8/nVnBQI4wZ9Fu4KR9Eaoqf4c40ZgCuqJWRJD1f1oB9NcEfCLGw
         dWC0/OvSllkjDy7jNDw1cPK9E7d18OqtXd2MXxM+sB5lNhIek+J6alyapzOv2mL3Essp
         KfZTrbVKBvcP7LHw8URsPNQFC/Y03OSnSJv/Y=
MIME-Version: 1.0
Received: by 10.220.161.201 with SMTP id s9mr4477545vcx.277.1280181282264; 
        Mon, 26 Jul 2010 14:54:42 -0700 (PDT)
Received: by 10.220.85.211 with HTTP; Mon, 26 Jul 2010 14:54:42 -0700 (PDT)
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400D013F9D97@XMB-RCD-208.cisco.com>
References: <AANLkTinBb3SN1DRL9Zt8Mu1fAYgsx9VRm4FwBz4oNfdq@mail.gmail.com>
        <7A9214B0DEB2074FBCA688B30B04400D013F9D97@XMB-RCD-208.cisco.com>
Date:   Mon, 26 Jul 2010 14:54:42 -0700
Message-ID: <AANLkTikRzR+a1cymXNkbLJ0Gca+BxtvdNeUJU-gsc0MD@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Apply kmap_high_get on DMA functions.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Jul 26, 2010 at 1:44 PM, Dezhong Diao (dediao) <dediao@cisco.com> wrote:
> It is not a problem our hardware supports DMA directly to high memory.

Mine too.  The existing dma-default.c does not handle high pages at
all, but applying your patch did not completely solve the problem on
my setup so I think something else is still going wrong.  If I figure
it out I'll post a fix.

In the meantime could you please consider adding BUG() to the else clause, e.g.

+               if (addr) {
+                       addr += offset;
+                       __dma_sync_virtual(addr, size, direction);
+                       kunmap_high(page);
+               } else
+                       BUG()

Thanks.
