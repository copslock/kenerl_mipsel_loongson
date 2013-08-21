Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 14:58:49 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:37897 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827299Ab3HUM6rlKqzw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 14:58:47 +0200
Received: from [10.18.106.34] (c-5eeaaa2e-74736162.cust.telenor.se [94.234.170.46])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id r7LCwFSu025914
        (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
        Wed, 21 Aug 2013 05:58:18 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC] Get rid of SUBARCH
From:   "H. Peter Anvin" <hpa@zytor.com>
Date:   Wed, 21 Aug 2013 14:58:04 +0200
To:     Thorsten Glaser <t.glaser@tarent.de>,
        Richard Weinberger <richard@nod.at>
CC:     linux-arch@vger.kernel.org, mmarek@suse.cz, geert@linux-m68k.org,
        ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com,
        gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Message-ID: <7813eeb3-8f96-4d3d-87ec-f2a880122804@email.android.com>
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37622
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

If ARCH doesn't match uname for some definition of match?

Thorsten Glaser <t.glaser@tarent.de> wrote:
>On Wed, 21 Aug 2013, Richard Weinberger wrote:
>
>> The series touches also m68k, sh, mips and unicore32.
>> These architectures magically select a cross compiler if ARCH !=
>SUBARCH.
>> Do really need that behavior?
>
>Not precisely that, but it’s very common in m68k land
>to just cross-build kernels with
>
>$ make ARCH=m68k menuconfig
>$ make ARCH=m68k
>
>Maybe a generalising of that feature, and making it
>independent of SUBARCH (which can then die)?
>
>bye,
>//mirabilos

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
