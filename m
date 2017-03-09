Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 05:54:03 +0100 (CET)
Received: from [IPv6:2001:1868:a000:17::138] ([IPv6:2001:1868:a000:17::138]:48924
        "EHLO mail.zytor.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991957AbdCIExyuNrBw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Mar 2017 05:53:54 +0100
Received: from nexus6.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id v294b0RE021699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Mar 2017 20:37:17 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <201703090437.v294b0RE021699@mail.zytor.com>
Date:   Wed, 08 Mar 2017 20:36:30 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <23e5808b-2a20-518d-b49a-4d95dd23cfde@landley.net>
References: <20170303122712.13353-1-jslaby@suse.cz> <20170304130550.GT21222@n2100.armlinux.org.uk> <23e5808b-2a20-518d-b49a-4d95dd23cfde@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/3] futex: remove duplicated code
To:     Rob Landley <rob@landley.net>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.cz>
CC:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
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
        "David S. Miller" <davem@davemloft.net>, Chris.Metcalf@zytor.com
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

<cmetcalf@mellanox.com>,Thomas Gleixner <tglx@linutronix.de>,Ingo Molnar <mingo@redhat.com>,Chris Zankel <chris@zankel.net>,Max Filippov <jcmvbkbc@gmail.com>,Arnd Bergmann <arnd@arndb.de>,x86@kernel.org,linux-alpha@vger.kernel.org,linux-snps-arc@lists.infradead.org,linux-arm-kernel@lists.infradead.org,linux-hexagon@vger.kernel.org,linux-ia64@vger.kernel.org,linux-mips@linux-mips.org,openrisc@lists.librecores.org,linux-parisc@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-s390@vger.kernel.org,linux-sh@vger.kernel.org,sparclinux@vger.kernel.org,linux-xtensa@linux-xtensa.org,linux-arch@vger.kernel.org
From: hpa@zytor.com
Message-ID: <83324528-AAA1-4BED-B0C7-48426ECBA261@zytor.com>

On March 8, 2017 8:16:49 PM PST, Rob Landley <rob@landley.net> wrote:
>On 03/04/2017 07:05 AM, Russell King - ARM Linux wrote:
>> On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
>>> diff --git a/kernel/futex.c b/kernel/futex.c
>>> index b687cb22301c..c5ff9850952f 100644
>>> --- a/kernel/futex.c
>>> +++ b/kernel/futex.c
>>> @@ -1457,6 +1457,42 @@ futex_wake(u32 __user *uaddr, unsigned int
>flags, int nr_wake, u32 bitset)
>>>  	return ret;
>>>  }
>>>  
>>> +static int futex_atomic_op_inuser(int encoded_op, u32 __user
>*uaddr)
>>> +{
>>> +	int op = (encoded_op >> 28) & 7;
>>> +	int cmp = (encoded_op >> 24) & 15;
>>> +	int oparg = (encoded_op << 8) >> 20;
>>> +	int cmparg = (encoded_op << 20) >> 20;
>> 
>> Hmm.  oparg and cmparg look like they're doing these shifts to get
>sign
>> extension of the 12-bit values by assuming that "int" is 32-bit -
>> probably worth a comment, or for safety, they should be "s32" so it's
>> not dependent on the bit-width of "int".
>
>I thought Linux depended on the LP64 standard for all architectures?
>
>Standard: http://www.unix.org/whitepapers/64bit.html
>Rationale: http://www.unix.org/version2/whatsnew/lp64_wp.html
>
>So int has a defined bit width (32) on linux?
>
>Rob

Linux is ILP32 on 32-bit architectures and LP64 on 64-bit architectures, but that doesn't inherently make this stuff clear.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
