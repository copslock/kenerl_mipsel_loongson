Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2016 14:05:14 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33457 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008135AbcCXNFNl4S0Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2016 14:05:13 +0100
Received: by mail-wm0-f68.google.com with SMTP id u125so12069799wmg.0;
        Thu, 24 Mar 2016 06:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w0gDGECLY4N91SQmlmzxK8ngAWehyw5/nDp8z02mnP4=;
        b=iCiLOrFSV8S1L9Zkm8sS7gDqAIy5d03RrK459cjMkELR/LZ/xslvc1LL2rAM0AF75T
         1dIOBuKiQWxxM3WRWC0h1WqW5QwG0G97AbhAAPegRT72s4HwCcZFL2Xi58GQZg4xuW1C
         FxHfkdx/2gH3TVrrVYKAtAH/xCCGe0xLIJbSfZwGdz0cP5au+vhkShmSdmiXxbirsO4V
         6MMQwxGFoEpRb5vxHXGrtGmVuju59gq460YsWXr+PKWmky8X3Azpm3BjzWJ0lfjSffxV
         r+YlB7sfP12g+JoGKKa2Af9HgX84nzh5Hpl89715ks/v9XgveNTMsc/7ci0mCma1K/rv
         kcxA==
X-Gm-Message-State: AD7BkJJOkt85OQBH1bbG3Mf9MbFD7bJiqo7QPlZFpMXcWnu+SOFlCO1qFG4wtpKG/86YZQ==
X-Received: by 10.28.150.4 with SMTP id y4mr10010374wmd.43.1458824708430;
        Thu, 24 Mar 2016 06:05:08 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id e25sm26947397wmi.21.2016.03.24.06.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 06:05:07 -0700 (PDT)
Subject: Re: [PATCH 3/4] exit_thread: accept a task parameter to be exited
To:     Peter Zijlstra <peterz@infradead.org>
References: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
 <20160324130303.GS6356@twins.programming.kicks-ass.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <56F3E5FF.9030105@suse.cz>
Date:   Thu, 24 Mar 2016 14:05:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160324130303.GS6356@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52696
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

On 03/24/2016, 02:03 PM, Peter Zijlstra wrote:
> On Thu, Mar 24, 2016 at 01:58:13PM +0100, Jiri Slaby wrote:
>>  void
>> -exit_thread(void)
>> +exit_thread(struct task_struct *me)
>>  {
>>  }
> 
> task_struct arguments are called: tsk, task, p
> 'me' seems very wrong, as that could only mean 'current', and its
> clearly not that.

Ah, OK. I will wait for more feedback and will fix this.

thanks,
-- 
js
suse labs
