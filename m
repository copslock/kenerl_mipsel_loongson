Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 17:27:45 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36751 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033594AbcEXP1ntdtxt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 17:27:43 +0200
Received: by mail-pf0-f195.google.com with SMTP id g132so2509583pfb.3
        for <linux-mips@linux-mips.org>; Tue, 24 May 2016 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TO7jjD+iOzEyS6qStx7QIC9EDsMN9r7zOPqaKpf5OiM=;
        b=qM382wa9BO7uaTj8BWt9OTzE6f0LE9dR2kMTG3yw4PeIOJBizwKbHyEXwdH9+9BKIe
         C6nM39Ij+wNbIS19r74Q/kmPM/NcZDSNjaEzDMolQNhblxVSCJNHrLkMbq5k65SxI+CY
         vIKbrv5XraHq4Yofi+F2j7AfrcRxs5pKaYq0LQWKr3IN3BDlNYRdXSpLdOe9tgXiw6Tn
         hLlvgNahr0HAXjKSa5UDqxjNb7smrVySbolBoX4HEMW1ZOsvI+Vul1Y5diPYOPCuitg4
         KXDghTV4rFsTyyzRLQUc1x6JgCY6zeLSTID3b3txU/kGaw0D86GwmmuXDuYjVEfpcPuV
         DmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TO7jjD+iOzEyS6qStx7QIC9EDsMN9r7zOPqaKpf5OiM=;
        b=MAjbOFcyTU3bspGD30u5rc315y7NXJwz6ez2UNKbzcLS9+0OQF8ClPClntX97vznY5
         QR+A6OVCpzytLQZK14bNatY6bHP1h8Jax98YokuAOcAXPC7t1E+e3Ld2LgviFXYwmcpr
         Bsy8iqyvRFx4W+oxhTNRy3p4sQZXqK9L2j6Gy5kDM7P+RlB/7Ns35Axd2QCsfcBQqg5o
         p3T6DGcRerBWeaXK4SzBWGVN5CFpI/NpBAN1SrLUmKi8k3j168OE90HFoiov+aepaiw3
         BGIzlrY0larUDuQaYN0KTuvXhyLu3094Arcxp64Crz0AvmoHF5eDLUULi8RnVf9cqyrk
         m6cQ==
X-Gm-Message-State: ALyK8tKfGpSQlg/qF+EMqwGUDFZqvbHNAyZYaRQuDeAT1i9G5CNCyiqsOe5s1jDcoKzOnA==
X-Received: by 10.98.8.91 with SMTP id c88mr1699132pfd.57.1464103657638;
        Tue, 24 May 2016 08:27:37 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:f573:6891:973c:b422? ([2601:645:c200:33:f573:6891:973c:b422])
        by smtp.gmail.com with ESMTPSA id y72sm55219075pfa.73.2016.05.24.08.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 08:27:37 -0700 (PDT)
Message-ID: <1464103650.27173.26.camel@chimera>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Tue, 24 May 2016 08:27:30 -0700
In-Reply-To: <1464102907.27173.23.camel@chimera>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
         <1464041521.5475.18.camel@chimera> <1464067930.27173.7.camel@chimera>
         <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
         <1464102907.27173.23.camel@chimera>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53642
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

On Tue, 2016-05-24 at 08:15 -0700, Daniel Gimpelevich wrote:
> On Tue, 2016-05-24 at 14:27 +0300, Antony Pavlov wrote:
> > We have too many 0xd00dfeed.
> > Can we introduce some macro aliases, like
> > arch/arm/kernel/head-common.S does?
> > Something like this
> > 
> > #define OF_DT_MAGIC 0xd00dfeed
> 
> And exactly where would you propose to put that? Having the same #define
> in multiple places is no better than just using the value…

Never mind. It's already in <linux/of_fdt.h>. I will supersede this
after making any additional requested changes. What else needs to
change?
