Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 02:13:02 +0200 (CEST)
Received: from mail-wm0-x230.google.com ([IPv6:2a00:1450:400c:c09::230]:52191
        "EHLO mail-wm0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992827AbeDCAMzugDpF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Apr 2018 02:12:55 +0200
Received: by mail-wm0-x230.google.com with SMTP id v21so29357157wmc.1;
        Mon, 02 Apr 2018 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J1d8GZtrK4hY+JTjitzp/6IX1SAUit8cEPdA71kilVA=;
        b=EuGazHaJzfISFZPcaALS46j4L2SWOQSJr2G0H6JQggNgAP3jOI/Z1miZU0cLVtfS+D
         XQHKKNOuaR0G4aP4sVgBxJCb5pGMX9v5HTG2Xo/kSfMUrBs+Z+LqpNIVRFRgKtpEwcyJ
         Tw8Fwdp0WRulT0LU7BkFCv/X2cVbfO0Kz7bbrnptgTn/8O6unYV6Tt1Epoj8qtwwGSpq
         dO3Q5AxB4ASt322rkDh94EeraoMfNW10dAwylgtAQnTo9bSGgQOlZGxR4ifxFyhfrWyZ
         Og5c8OJc0VsU+yZA5lE987aGBBu0mgSoCKczbI5z9eo8v2VK2G+mckRss/zkON29ss6+
         9UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J1d8GZtrK4hY+JTjitzp/6IX1SAUit8cEPdA71kilVA=;
        b=m9sIBFbwX0KpzFPsqbyOB1oGw+nKNgMsbHqDAEanZLiVlVpxjsaCafmIm28pcd25WO
         DOTW95A/sQJwTBEfs6PDEy3ftPq5MClyyc05aWPqqnISYrcUhWj7DuCJfEu1bwIxay8H
         lmM68+SADoMNkup0nDORbxhcaOkL17jBHnKJPxhaWnxr9BnD78k2eUfCrGcJHgzEQIQm
         UmkbwooK+vPXZluJsGuj7LuIuNUSe8kGKTjNiKGj0FfOrnE25/LiecdwaC4TdWDMywT1
         qL6rgKZCha7Y0gn7vRadgZ3AOCyBxwHk+m3M4OHdv/apaIA9KsIP3yCaQ/PbU3RxMy+u
         m6vQ==
X-Gm-Message-State: AElRT7HbrrnjkhdBXH29y53pKnjdlDWpfIfEjA7Lb9H79QAVKR7g2fyn
        FC6Q/MPSwplxI8Jrjh1RdJg=
X-Google-Smtp-Source: AIpwx49ClP02AGgxiYwZoPDHz8HxKYxZ15sE72H7Zj1waosYFFtzDGDuzQQRgJhpA6TX5qvHmOQxOA==
X-Received: by 10.46.16.1 with SMTP id j1mr7300865lje.102.1522714370429;
        Mon, 02 Apr 2018 17:12:50 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id 93-v6sm272506lfy.5.2018.04.02.17.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 17:12:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B3B8BC5@ORSMSX110.amr.corp.intel.com>
Date:   Tue, 3 Apr 2018 03:11:50 +0300
Cc:     Rich Felker <dalias@libc.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "nyc@holomorphy.com" <nyc@holomorphy.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        "nitin.m.gupta@oracle.com" <nitin.m.gupta@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D9173B50-39D6-4EE5-AF8B-3EB50D0C9A3B@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
 <20180327234904.GA27734@bombadil.infradead.org>
 <20180328000025.GM1436@brightrain.aerifal.cx>
 <3908561D78D1C84285E8C5FCA982C28F7B3B8BC5@ORSMSX110.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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

> On 29 Mar 2018, at 00:07, Luck, Tony <tony.luck@intel.com> wrote:
> 
>> The default limit of only 65536 VMAs will also quickly come into play
>> if consecutive anon mmaps don't get merged. Of course this can be
>> raised, but it has significant resource and performance (fork) costs.
> 
> Could the random mmap address chooser look for how many existing
> VMAs have space before/after and the right attributes to merge with the
> new one you want to create? If this is above some threshold (100?) then
> pick one of them randomly and allocate the new address so that it will
> merge from below/above with an existing one.
> 
> That should still give you a very high degree of randomness, but prevent
> out of control numbers of VMAs from being created.

I think this wouldn’t work. For example these 100 allocation may happened on 
process initialization. But when attacker come to the server all his 
allocations would be made on the predictable offsets from each other. So in 
result we did nothing just decrease performance of first 100 allocations. I 
think I can make ioctl to turn off this randomization per process and it could 
be used if needed. For example if application going to allocate big chunk or 
make big memory pressure, etc.

Best regards,
Ilya
