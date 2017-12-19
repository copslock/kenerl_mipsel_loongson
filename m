Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2017 21:14:13 +0100 (CET)
Received: from mail-lf0-x22e.google.com ([IPv6:2a00:1450:4010:c07::22e]:36936
        "EHLO mail-lf0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994649AbdLSUOGiUT5u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2017 21:14:06 +0100
Received: by mail-lf0-x22e.google.com with SMTP id a12so21547573lfe.4;
        Tue, 19 Dec 2017 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+beTybNu7Xs+GND2ywGeTowqNGQkD5EZ4/uvmMJe3Rs=;
        b=uMEJChFwXbLCDwE2lma5rR27nhmQmsS+sU1AOHbeWjLIskjgG5YluOM2KHGIGtHZND
         S/F5AzwJzwiktKnASMN5ookBPmtc7CzF78oDib1qUMQMRZ2azwYYCFl2Kve6fqqSH+ht
         GR77R6wuZz7otFaQc6eNt58dOzAVs9FAm1sKzB5T9e+K0YfkhEBi06dxEUZowmlH/ZGp
         xBYjb65mflIoR442iW2BON9npLnu4m08CO9KLHhn0q4ho4qbp0K7jw+ioJEOjmyw5tAm
         2NXmZ4lZpis9oDk07BzRZSlTJkTWYFqXtqld9f4Km2jyz53pOsSDKpnl9XDg1oYZyo8k
         M62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+beTybNu7Xs+GND2ywGeTowqNGQkD5EZ4/uvmMJe3Rs=;
        b=Yy/WErntSb8c0QF9LiWzZuGkKIYgFkJvswqRPpP+kTzGvvyc6Cpow7MjAk2M8hUecy
         JOKJW0P1XFgwynHEkbgv7ZxTlXIFG7LJm/hHgO/ZgVZXO92lZUwtYdD5Igx63WcFE4uu
         PXBVVbf0h1tnhETyQ8lOAC6dpXisnQSyKMxES4Uj8XWCSfMlzPJdDqhTgG73PMQx2TA2
         i87lJvbXeDvj+9Pbrynp2wgJS9hlHD4bB83ApRwxbDTOxbjz8p0agLbgIUtLbw20g3N4
         qgkrDLBVAfhvDwhqelTBx8XoW1lHmdqcXm1J0uCMcOiiK6ePV68Gyt+dGK4JAxqshV6h
         hAAQ==
X-Gm-Message-State: AKGB3mLT5sJz/fNUxIURwX2L9zuCdlneE+cuwRBKTsZSOdiJVZYJ9zzB
        i5AUypWWcdKMOfRsqMcgP2mIpb4A+aw=
X-Google-Smtp-Source: ACJfBov5YJQ9qkjKopxEPZ4YMPLvVhzjpwIjkNlmBDppTD0eE4+vVXVhBM7l0jSwa4FFEhGe5RxSmA==
X-Received: by 10.46.22.1 with SMTP id w1mr2947426ljd.69.1513714440487;
        Tue, 19 Dec 2017 12:14:00 -0800 (PST)
Received: from mobilestation ([176.59.48.245])
        by smtp.gmail.com with ESMTPSA id w29sm2525437lfc.30.2017.12.19.12.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2017 12:13:59 -0800 (PST)
Date:   Tue, 19 Dec 2017 23:14:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, marcin.nowakowski@imgtec.com,
        f.fainelli@gmail.com, kumba@gentoo.org
Cc:     Sergey.Semin@t-platforms.ru, fancer.lancer@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS memblock: Remove bootmem code and switch to NO_BOOTMEM
Message-ID: <20171219201400.GA10185@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Hello folks,

Almost a year ago I sent a patchset to the Linux MIPS community. The main target of the patchset
was to get rid from the old bootmem allocator usage at the MIPS architecture. Additionally I had
a problem with CMA usage on my MIPS machine due to some struct page-related issue. Moving to the
memblock allocator fixed the problem and gave us benefits like smaller memory consumption,
powerful memblock API to be used within the arch code.

Sorry for the delay. I promised to get back to this work within two months since my last post, but
there are more over five months passed. Now when some free time finally available at my schedule
I am ready to go on with this patchset and finally finish it up. After a short glance at the old
code I suppose there should be some refactoring made. Particularly:
- completely get rid from the boot_mem_map[] array usage. After the memblock code utilization
  is added, the boot_mem_map array will be excessive.
- unpin memblock/bootmem unrelated changes to a separate series so the patchset wouldn't be
  that big.
- take into account all the comments the community users posted on my initial patchset.

Still there are several questions, I need to have answered before the development is started.

Question to the community in general. Are you still interested in this work to be done and the
patchset to be submitted for review?

@ralf@linux-mips.org. Last time you moved the patchset to the RFC status for some reason. I asked
you twice to send to me your comments about the patches, but obviously you didn't have time for
this, then you might have just forgotten. Could you please confirm whether you are interested in
these alterations and will be ready to review them?

@marcin.nowakowski@imgtec.com. Could you confirm if you are still interested in the patchset and
ready to update the Loongson64 platform code so one would be compatible with it?

@kumba@gentoo.org. Will you still be able to update the SGI IP27 code so one would work on top
of the patches?

@alexander.sverdlin@nokia.com. Do you still possess the Octeon MIPS64 platform to test the patchset?

Thanks folks for you willingness to help

Regards,
-Sergey
