Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2017 10:01:46 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34830 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdEQIBiKw0kA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 May 2017 10:01:38 +0200
Received: by mail-wm0-f65.google.com with SMTP id v4so1536533wmb.2;
        Wed, 17 May 2017 01:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v47gPsja80Gzc8LoofWVSouSiN0IcGQQ6vS4DVEatvs=;
        b=IK/OajSm0urrFvnAVLHDaX2rZ2o/CueVWINpawjzPnbx3Oy8PHC0MpH+ZSEooh2LHa
         1n/+HOnLWstow6QmosPqkL3ZbZj4XkzDlo13bB75lWynP9sDtCYd6L72PSZsQTdvS7bN
         j5/fv/SXnyDXg19mZ33wwrJYnPeW0Xtwa/yDYaMgNIos6f1i4iqyGd3/DgRt1CjBAvU1
         26OoneqJLYx3HDwQ7Dojx1f6iZrkb096M2Uz2CxRuEQ4HqXyJ5AVmwlIrW/94vpDZ4oD
         AtPT+74JCagF2aAOGTISIcElGL5/b9sHn5VGZuwIScarjooDuUnJvN/YV2YsaKgJtZQg
         V6yA==
X-Gm-Message-State: AODbwcDqD1rn0Zj+8uUHDOThpHO1hYi5e8B4uoGShqgHCYms2IuW0iV8
        UVQTzeOIIS7SqA==
X-Received: by 10.28.68.195 with SMTP id r186mr1429209wma.22.1495008092883;
        Wed, 17 May 2017 01:01:32 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id x9sm1621493wmb.21.2017.05.17.01.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2017 01:01:31 -0700 (PDT)
Subject: Re: [PATCH 1/1] futex: remove duplicated code
To:     Will Deacon <will.deacon@arm.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
References: <20170515130742.18357-1-jslaby@suse.cz>
 <20170515131644.GA3605@arm.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <14580dfc-9721-38ab-a1e0-6b4aba13b406@suse.cz>
Date:   Wed, 17 May 2017 10:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170515131644.GA3605@arm.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 05/15/2017, 03:16 PM, Will Deacon wrote:
> Whilst I think this is a good idea, the code in question actually results
> in undefined behaviour per the C spec and is reported by UBSAN.

Hi, yes, I know -- this patch was the 1st from the series of 3 which I
sent a long time ago to fix that up too. But I remember your patch, so I
sent only this one this time.

> See my
> patch fixing arm64 here (which I'd forgotten about):
> 
> https://www.spinics.net/lists/linux-arch/msg38564.html
> 
> But, as stated in the thread above, I think we should go a step further
> and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
> appear to be used by userspace, and this whole thing is a total mess.
> 
> Any thoughts?

Ok, I am all for that. I think the only question is who is going to do
the work and submit it :)? Do I understand correctly to eliminate all
these functions and the path into the kernel? But won't this break API
-- are there really no users of this interface?

thanks,
-- 
js
suse labs
