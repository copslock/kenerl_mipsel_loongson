Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 12:43:52 +0200 (CEST)
Received: from mail-vb0-f51.google.com ([209.85.212.51]:46616 "EHLO
        mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815858Ab3HIKnqrVm8l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 12:43:46 +0200
Received: by mail-vb0-f51.google.com with SMTP id x16so3927763vbf.24
        for <linux-mips@linux-mips.org>; Fri, 09 Aug 2013 03:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=LoHdTNtnPGynKScB9poIXfxPCNDsE/J3ua37SbCGXWU=;
        b=Ip5owo+V9hfSGp/du1FIU+jlMnE9FFEqLtX8LFSbDu+eK1UMf9rUvZZqPbXrlyQpXg
         nnSAosCtoLp04akRF/wyMrieECvR0OuGVONJS9gq7kTHiycg7j65IVeklkO4qmQWfm3W
         7NdHKbp7X0h5Q73AN2hlqWG/iSlxyZfG4e+gT/xaOlkJfHhm+m2GaTeC88o3bksKHXrl
         F9GZAh50v6bm0n2TXYNoeDfVsFvE/m9nxg00VHYlXGhf84Z3ndY3NJO5vcqSo0yajBFl
         joQh3xCc6lrfsdO4xL2UOk6RDdmiB9G5yoSoVBX2RNyzvh+h99CimEzzgNctT3SP9sg7
         d1OQ==
X-Gm-Message-State: ALoCoQk0QikhBNZxNglAEgh8ec3Nq2Ldw7I7ldzJm7GVWag2WcsZ1k+AnTCOpdFM34zBjJteIktI
MIME-Version: 1.0
X-Received: by 10.220.74.69 with SMTP id t5mr37575vcj.18.1376045020066; Fri,
 09 Aug 2013 03:43:40 -0700 (PDT)
Received: by 10.58.249.145 with HTTP; Fri, 9 Aug 2013 03:43:40 -0700 (PDT)
X-Originating-IP: [92.28.210.78]
Date:   Fri, 9 Aug 2013 11:43:40 +0100
Message-ID: <CAPcvp5HYxPeBp9HAQ4hNFrpWMc_ADkfbvZnYeWXvOaACt5VSAg@mail.gmail.com>
Subject: Status of mips 'of/pci: Use of_pci_range_parser' patch
From:   Andrew Murray <amurray@embedded-bits.co.uk>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <amurray@embedded-bits.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amurray@embedded-bits.co.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Ralf,

What is the status of this patch?  http://patchwork.linux-mips.org/patch/5625/

I'm not sure if you've missed this. Are you able to apply this to your tree?

Thanks,

Andrew Murray
