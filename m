Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 05:17:19 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:34325
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdCIERMVFE4X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Mar 2017 05:17:12 +0100
Received: by mail-pg0-x244.google.com with SMTP id b5so5432858pgg.1
        for <linux-mips@linux-mips.org>; Wed, 08 Mar 2017 20:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OhUHJSE5xU6QMGVnJZxnedbXx+uYtbUUiw2eHUGexbc=;
        b=x9/eJRzZHDDBHbBVNWBBuWp935tC5GuX3kZhgkgijhR3tsRQ7L5dU/NpbpAI5N04pM
         460Vjh3374vT3oKaXYqfPQfOv6TAldpV4sSM59MZOB59MsA4JcxcmrsJJieDM7Fmt16e
         U0vwgft7qcoWC4PHgXDPogNvAFGk/RsyUf4OUC6E0qMSJBzeMiLaMoFIb9GMGTILExoA
         znpddWFZ16MaDxZUGU1MtE0pWckaRcAMGeD/4ncjPMWJ182IMuWUfNMv8iQQRgf3JyFJ
         bvynm4ZslcpaenqeG5vkypNLlB1MmiRDM1pI3+Ls+ncPb7bubCed+bpolfsmg1SJD08k
         IZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OhUHJSE5xU6QMGVnJZxnedbXx+uYtbUUiw2eHUGexbc=;
        b=hK06zOb9u6gUPAa7g5Mw4iSj7pgNIgKnvkZs8+sVwTzqcVwtZyqkt1xzDEjFkJJYJW
         j1JtUT2zgNNVmOeQIyJKTnyNqiKjJtjC4jgG0pZ+8uqdI0vrA6ruywKOTt4qFCSxLdR6
         qJx0Uj6seD4jA+gmZsHFbt6Kj5EzCj02IFVdOowbxTkPvPjMlKlyfdCkqu9TuhmJGgYU
         qcwJJO8vTvbRJNGk6gIlvAffdxsxE/LxRlA77aALJQCI7zDEFpxChkkqWZtgeBze5gKD
         csUQDoQ/Q7FPeQ/4zXX+uV871qpRp9oMJCzu9s5Lkeu375EERPip/3w4uy7MO5DgExTM
         q4aw==
X-Gm-Message-State: AMke39k/Tq7navPkxqqcykfd1GxOQjusVaFg8Xv4uxiv60UExQBiKHPZIsCS32UW8ieY4g==
X-Received: by 10.99.133.195 with SMTP id u186mr11217397pgd.97.1489033026175;
        Wed, 08 Mar 2017 20:17:06 -0800 (PST)
Received: from [192.168.42.40] (p76119-ipngnfx01marunouchi.tokyo.ocn.ne.jp. [153.142.246.119])
        by smtp.googlemail.com with ESMTPSA id i15sm8924786pfj.0.2017.03.08.20.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 20:17:05 -0800 (PST)
Subject: Re: [PATCH 1/3] futex: remove duplicated code
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.cz>
References: <20170303122712.13353-1-jslaby@suse.cz>
 <20170304130550.GT21222@n2100.armlinux.org.uk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
From:   Rob Landley <rob@landley.net>
Message-ID: <23e5808b-2a20-518d-b49a-4d95dd23cfde@landley.net>
Date:   Wed, 8 Mar 2017 22:16:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170304130550.GT21222@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 03/04/2017 07:05 AM, Russell King - ARM Linux wrote:
> On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
>> diff --git a/kernel/futex.c b/kernel/futex.c
>> index b687cb22301c..c5ff9850952f 100644
>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -1457,6 +1457,42 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
>>  	return ret;
>>  }
>>  
>> +static int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
>> +{
>> +	int op = (encoded_op >> 28) & 7;
>> +	int cmp = (encoded_op >> 24) & 15;
>> +	int oparg = (encoded_op << 8) >> 20;
>> +	int cmparg = (encoded_op << 20) >> 20;
> 
> Hmm.  oparg and cmparg look like they're doing these shifts to get sign
> extension of the 12-bit values by assuming that "int" is 32-bit -
> probably worth a comment, or for safety, they should be "s32" so it's
> not dependent on the bit-width of "int".

I thought Linux depended on the LP64 standard for all architectures?

Standard: http://www.unix.org/whitepapers/64bit.html
Rationale: http://www.unix.org/version2/whatsnew/lp64_wp.html

So int has a defined bit width (32) on linux?

Rob
