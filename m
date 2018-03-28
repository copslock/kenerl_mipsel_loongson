Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:07:55 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:40066
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994646AbeC1VHnWjrgC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 23:07:43 +0200
Received: by mail-lf0-x241.google.com with SMTP id e5-v6so5450336lfb.7;
        Wed, 28 Mar 2018 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gSdQ8bDJLYxkIO2LyMkuzz2AhJ5BbuKQbcUo1PkL9uY=;
        b=u/S518fjnCaX6ouRyq2F6i1toimymrPzbTSCmatqcxyrVEnt53oy8+2lukgMfn/Blo
         FPneh8uOWLD8lG/0OP+uO1BhON1La5k/dX/Wcin5kRciFoe4vpqWv9350c6X9zoP2HtU
         AZznvK6iHhvu8DA4VS2mPo6inRWz72jnqMtEaZZjcmkVRd41PnSk/YamKq58h9OxiIHQ
         Fbst7mykA451FlY+KrId7K25jPzJQPTU3pDV9GiNBO2uL69vqujwlEG+csgu4wnput22
         VCLztps3Qy3rSiC9zrFs0COGoETqSRq/YepKSnn+76BgOHthSOog0MNzhsuV8TVIH1Tg
         ew6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gSdQ8bDJLYxkIO2LyMkuzz2AhJ5BbuKQbcUo1PkL9uY=;
        b=IickkGqldXytkDYrOpJXFuW9ZOytUD1EeUSqHJyo6eWe8fFP85ippxZkLz+0iWYRPp
         cMg7KHHGhCIYA3OwXCbFpVrjNMHJyZzAWO+tPwdBECJQfQdvg8sWEyIPplLi2geMpCk3
         MuehoJdTUH3k1lEe4Iyna7yPglEUGM9skb8zlp2GytoZkAST2qIbADkWte9A138fyHxI
         NOxAR3RFvygB0JouNyc36QsLY36lFn8zy9+D+1OFHccJGiAerHmFvGkFRgobfpQ1Dsvw
         cm5ufim5MBOGCmZw1cnC/NqxQAZAIhai8Fv0A6klc39KIzKuG/H/WmEZKfJA6fqAg8+8
         5zfw==
X-Gm-Message-State: ALQs6tAbDQ03d//yPcjEDSXj4lUQmb5a0wWPfG2JOkOmokD7gnEDcAV4
        17ke2qnRwpK4AO10ToXNRAY=
X-Google-Smtp-Source: AIpwx4/0JxPIzdyUgfGRtAIsGVbq+iLSCXKyhprvdig4GawcLZ87AtQu2mueObpWLwig0ZMmDsnS5w==
X-Received: by 10.46.156.207 with SMTP id g15mr1023532ljj.95.1522271257773;
        Wed, 28 Mar 2018 14:07:37 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id p22sm749663ljg.39.2018.03.28.14.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 14:07:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180327234904.GA27734@bombadil.infradead.org>
Date:   Thu, 29 Mar 2018 00:07:35 +0300
Cc:     Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        nyc@holomorphy.com, Al Viro <viro@zeniv.linux.org.uk>,
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
        Rik van Riel <riel@redhat.com>, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B26CA69E-B804-4607-9697-853DFE24C616@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
 <20180327234904.GA27734@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63320
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


> On 28 Mar 2018, at 02:49, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Tue, Mar 27, 2018 at 03:53:53PM -0700, Kees Cook wrote:
>> I agree: pushing this off to libc leaves a lot of things unprotected.
>> I think this should live in the kernel. The question I have is about
>> making it maintainable/readable/etc.
>> 
>> The state-of-the-art for ASLR is moving to finer granularity (over
>> just base-address offset), so I'd really like to see this supported in
>> the kernel. We'll be getting there for other things in the future, and
>> I'd like to have a working production example for researchers to
>> study, etc.
> 
> One thing we need is to limit the fragmentation of this approach.
> Even on 64-bit systems, we can easily get into a situation where there isn't
> space to map a contiguous terabyte.

As I wrote before, shift_random is introduced to be fragmentation limit. Even 
without it, the main question here is ‘if we can’t allocate memory with N size 
bytes, how many bytes we already allocated?’. From these point of view I 
already showed in previous version of patch that if application uses not so big 
memory allocations, it will have enough memory to use. If it uses XX Gigabytes 
or Terabytes memory, this application has all chances to be exploited with 
fully randomization or without. Since it is much easier to find(or guess) any 
usable pointer, etc. For the instance you have only 128 terabytes of memory for 
user space, so probability to exploit this application is 1/128 what is not 
secure at all. This is very rough estimate but I try to make things easier to 
understand.

Best regards,
Ilya
