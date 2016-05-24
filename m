Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 19:01:05 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33613 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033622AbcEXRBDchF2j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 19:01:03 +0200
Received: by mail-pf0-f196.google.com with SMTP id b124so2237271pfb.0
        for <linux-mips@linux-mips.org>; Tue, 24 May 2016 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ph65GnWxnQfcCbnmXw1L6ZeS5siZ0wRRR0sHFV7sDpE=;
        b=jlynTIXG1hqV6W+pAzuJBQqOLURNfz/W4D/xIaO8CdGAhiNnfVrnAYHS4afq/Rnx72
         jEKxdXaWgtLyTYd6KOPsKr/C8OI7qhqb3LCqVNftsW2kdCaMNUROfzJ4g5pPITgxXe1g
         CJ+HIoZ8uPAKj2G792qWjKSL45J+OtS91Vb32Apo2xZlJw+mr7qZ8SuzvTnCv1PrPKio
         nWdQnrV8lCFxPmwoxQSPDm4v7zTYQ8DlqQne3wY2Rw4I4DdWLCVuYObgJk/tfHnd7SYK
         bv1sfbY261BrMCXRJKe1Ip1MsMpP7wUdCtqL6dyX4q7tAbmk+8KRIWqTHR8DrOWEwLNs
         gycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ph65GnWxnQfcCbnmXw1L6ZeS5siZ0wRRR0sHFV7sDpE=;
        b=bNGAwWuueIM93jacykbt37YdXXzXyz+j81Hyb91g6CR81L8IJKDzc2J00HHTvXctQQ
         yJGaSUL2eXEeyapYhI9Fp2uQEB+7EDM0gd8yVUUheYiZVEM5H1K1k36gabZvKGo8DSh2
         zx1vuMUl8tUoXFcH6p6yF6UDTX6ubwtP0jsl/gmBVPl4wBX/j5tHpy2zCJZxyVliM4QO
         /J+aSvEMDaMzLYrMwRxquXzYrFhCxaoUGtuVnp6Z3cWGeKZafkL6texr6zO2zDxJq9Yw
         AvXgqrU+fRETUA3lU/R2RBXFzWhRlgkhGT1JdPgsQwhpL+iDM4YxHDL7ZJgJIE//jWmK
         O5lw==
X-Gm-Message-State: ALyK8tJDN8CMiPmZnHJGsrLh5eXKA0y0cUkpCxk07EFxSFSu45vZ0OGYm7rsPrBE/hNMKw==
X-Received: by 10.98.24.68 with SMTP id 65mr8361652pfy.160.1464109255321;
        Tue, 24 May 2016 10:00:55 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:f573:6891:973c:b422? ([2601:645:c200:33:f573:6891:973c:b422])
        by smtp.gmail.com with ESMTPSA id vy8sm6558814pab.22.2016.05.24.10.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 10:00:54 -0700 (PDT)
Message-ID: <1464109249.27173.27.camel@chimera>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Tue, 24 May 2016 10:00:49 -0700
In-Reply-To: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
         <1464041521.5475.18.camel@chimera> <1464067930.27173.7.camel@chimera>
         <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
         <1464102907.27173.23.camel@chimera> <1464103650.27173.26.camel@chimera>
         <20160524194818.9e8399a56669134de4baee1e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Tue, 2016-05-24 at 19:48 +0300, Antony Pavlov wrote:
> Also we can drop '#if defined(CONFIG_*' in favour of 'if
> (IS_ENABLED(CONFIG_*'.
> 
> -- 
> Best regards,
>   Antony Pavlov

OK. Anything else?
