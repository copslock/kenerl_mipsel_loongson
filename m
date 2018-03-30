Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 11:08:15 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:43079
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeC3JIID5TsQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 11:08:08 +0200
Received: by mail-lf0-x242.google.com with SMTP id v207-v6so11786096lfa.10;
        Fri, 30 Mar 2018 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZTjxoqKaoobJFUevSLgPJQU741b1iW8H0MvOHx0z9s8=;
        b=RouoAPahIBeHWmIgnH+8/cn6AMZFJbZqrK40ZUVYzW79JDPzZE8r5ASWUNWmrwduLD
         8f3shx1rqIvJjr0jRdyDRmGnKNyvMEC0a5YCVSM/NCLq5b0xvwFWnNt1pRQUr5hsByYi
         xFtAKpsQZ1g1tu0/giU7BNmHi4ujjdm/+NVAbpbkcN9w2p8xRMD9DyxZynXNAC92a5pM
         N864y0bNKHpK5NT3AJ2ToR0BksDVFur6bU7r6BRX0jkeT08EVsrQVtnfbBkcgmVziYks
         aN45ncRS6DPb0rwCzGp5TJWCA0WgpNitY6WmXPnb6XKnwFIencXwlyj+9q35Cb55NJIC
         d3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZTjxoqKaoobJFUevSLgPJQU741b1iW8H0MvOHx0z9s8=;
        b=PUAXqie8Np//ctLb+WdPDIq6ySz6tCYujQ7/gY5G3DcDFlYE7ZmKW0eXlhc2P412tY
         Vudigzvn4CItDxN/kbENhJLvC1YNdwp0zIqintxMmSxVpoIHN3+6uFFYrRLzR3Dq7XLR
         j3q/09CWNeAgIAVbKpZXngEw+m2M6uerjfUd27DnS5u3rH925S5qkFQ3shVEsrP2I2Nw
         qJNr5vcTuj3B22FG3/J54T8po9mVMc+I6U1HS5/j2ue4ljb/RdvJwxHQyaKMIra03Spr
         8G743jMHv5z0HD+WR2dDnQ4xOdnuwkVVNX8AUWnB5a/oySWswWvBiTW0M8H65901walZ
         Mc5w==
X-Gm-Message-State: AElRT7GKFY+Og5f32CxC0pToRNEH8AUITU6ay+dkH0L1O1zjQRFn9Xjv
        5zle7C791hDaMCxcMxU7kdu8yAb95aw=
X-Google-Smtp-Source: AIpwx4819IvCDJg/mTs2Ax4OcWGaODCSYvKwRadsg1AoBjgPwzfi7Txju4VQpU86PWklyO824cjPiA==
X-Received: by 10.46.57.19 with SMTP id g19mr7397119lja.127.1522400881844;
        Fri, 30 Mar 2018 02:08:01 -0700 (PDT)
Received: from [10.0.36.208] ([31.44.93.2])
        by smtp.gmail.com with ESMTPSA id q18sm1396174ljg.35.2018.03.30.02.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 02:08:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180330075508.GA21798@amd>
Date:   Fri, 30 Mar 2018 12:07:58 +0300
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk,
        arnd@arndb.de, gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Michal Hocko <mhocko@suse.com>, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <95EECC28-7349-4FB4-88BF-26E4CF087A0B@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180330075508.GA21798@amd>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63358
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

Hi

> On 30 Mar 2018, at 10:55, Pavel Machek <pavel@ucw.cz> wrote:
> 
> Hi!
> 
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases. This patch make
>> randomization of address on any mmap call.
> 
> How will this interact with people debugging their application, and
> getting different behaviours based on memory layout?
> 
> strace, strace again, get different results?
> 

Honestly I’m confused about your question. If the only one way for debugging 
application is to use predictable mmap behaviour, then something went wrong in 
this live and we should stop using computers at all.

Thanks,
Ilya
