Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2018 02:15:02 +0200 (CEST)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:40701
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994611AbeDEAOzPs7Ur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Apr 2018 02:14:55 +0200
Received: by mail-pl0-x243.google.com with SMTP id x4-v6so16553001pln.7
        for <linux-mips@linux-mips.org>; Wed, 04 Apr 2018 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mfi1Nbnv+To2+vsQQf8T3KagcLUnhnxqJ7evTv6Z/Jk=;
        b=RzCMwahTop/BpRMfnXRbvZxHF8K2p6wyUabb6f15GsilGYCQZPM9togEkIKsd1mvns
         JscFgs7yxSIA2BxGe64eQSJMKF77rHqVHKQeh3aDm3Y+kRSYf2jwvMeEJ2562JEHcRo2
         3OaGzUV1uFHVG2SrxFtjp8w9Hp9tanu7VAOIJ4D7Tya2NRE5uu4er+PRKlkNhrMV6mHi
         HwesTQd1uTrrYBEZ8z9u+kRUAyq4FcrSzIreSDbIDDfhxSiAJckz7w6Mv95SZ88dp/l7
         MYoeTVDTY6g18gvMr48l5mvP0WuLzAvxNjXRNNJTn3us/+4hpStEUJtm0oiXPN4xTxWd
         /dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mfi1Nbnv+To2+vsQQf8T3KagcLUnhnxqJ7evTv6Z/Jk=;
        b=s5xLrDgfxaFy5yyxy8aKzmWtWLn0MG6ngXZchQ9DvFtGMTREJySjvQdE7rITxTh7i2
         C30oR4khAR+8AfiK0nDuBFV893VDs31GdLYlPzZI5KAi1x/B1Pit/vpbh1CJjcqiEGYw
         izWz6Ti/Tm7eouGGJoqx85Zw2afz+LIB/USvx/ZMpXZh8SKqJ3BcOWaqF1LjX2V2DNlo
         kn5MoEitUQ2Oe1On/vUy4wo70wCBV6QMU/ZzTDB3zkdaUAwxFeS7ZKg71facL50hcgU+
         o0b26yTeJRxoY5P7b6lzOnyaiYWkyPmiF0q5wSIRK0yFaMVwtbTnr/ZZrEwuEKfOcXAO
         Co8w==
X-Gm-Message-State: AElRT7FylbtJ1iswWbHSnIlVFKqYNhupnKgOv6HJVpEf1IEQD13fE9LR
        AEbvu5Q8w9hBM/ssxF0mKhxiVg==
X-Google-Smtp-Source: AIpwx48ilORCOzWnd+xrbgAl5Z+1nZwEAFnyNNk2OdE2vKAFjrJ3ngAcvqfeQGpgFntLvOqBDLF2BA==
X-Received: by 2002:a17:902:b682:: with SMTP id c2-v6mr20310527pls.40.1522887287576;
        Wed, 04 Apr 2018 17:14:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g23sm11235437pfi.171.2018.04.04.17.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 17:14:46 -0700 (PDT)
Date:   Wed, 04 Apr 2018 17:14:46 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Apr 2018 17:12:22 PDT (-0700)
Subject:     Re: [PATCH v5 2/3] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <20180404220258.GA9347@saruman>
CC:     matt.redfearn@mips.com, antonynpavlov@gmail.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org, mcgrof@kernel.org,
        robin.murphy@arm.com, geert@linux-m68k.org,
        linux-riscv@lists.infradead.org, clm@fb.com,
        ynorov@caviumnetworks.com, jk@ozlabs.org, f.fainelli@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, bart.vanassche@wdc.com, robh@kernel.org,
        terrelln@fb.com, dan.j.williams@intel.com, albert@sifive.com,
        viro@zeniv.linux.org.uk, tom@quantonium.net,
        linux-kernel@vger.kernel.org, richard@nod.at,
        paulmck@linux.vnet.ibm.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     jhogan@kernel.org
Message-ID: <mhng-80bc3ae8-ec63-4482-ad4e-1dddec475753@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Wed, 04 Apr 2018 15:02:58 PDT (-0700), jhogan@kernel.org wrote:
> On Tue, Apr 03, 2018 at 03:39:34PM -0700, Palmer Dabbelt wrote:
>> Sorry, I'm not sure if this is the right patch -- someone suggested acking 
>> this, but it's already Review-By me and if I understand correctly it's going 
>> through your tree.  I'm a bit new to this, but if it helps then here's a
>> 
>> Acked-By: Palmer Dabbelt <palmer@sifive.com>
>
> Thanks Palmer.
>
> No worries. FYI Documentation/process/submitting-patches.rst appears to
> now contain lots of gory detail about what Acked-by and Reviewed-by are
> supposed to mean.
>
> In this case an acked-by is needed to show your approval of the parts of
> the patch which touch the subsystem you are responsible for (and/or code
> which you have authored) so that the patch can go via another tree. It
> usually indicates that you've reviewed those parts of the patch too, but
> not necessarily the whole thing.

Thanks!
