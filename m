Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 11:05:19 +0200 (CEST)
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:36660
        "EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822276AbaEUJFOVxxub (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 11:05:14 +0200
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
        by qmta04.westchester.pa.mail.comcast.net with comcast
        id 4Z581o0030QuhwU54Z58P9; Wed, 21 May 2014 09:05:08 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta02.westchester.pa.mail.comcast.net with comcast
        id 4Z581o00D0JZ7Re3NZ58Ys; Wed, 21 May 2014 09:05:08 +0000
Message-ID: <537C6C3C.5000009@gentoo.org>
Date:   Wed, 21 May 2014 05:05:00 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: remove checks for CONFIG_SGI_IP35
References: <1400584909.4912.35.camel@x220>
In-Reply-To: <1400584909.4912.35.camel@x220>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1400663108;
        bh=8o+k7UFpR5MDWWjWNFZFDv1lOCaihUItBF8qz3zEl7c=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=BPJoWnvIn5ttacnB7JOeiwXYoZYRNDfS2oEF6TBREpWY1Cz88pQK9G9KGCD2O2Mbt
         makNb9dLo2cysvDJFPl+SVwgQIqi9iFfjH/EewyyCZ4WnFJNOsscFaS5YYxvVDDdXd
         4EQ6BMmAZkwmRCkfV6nxTiM8hDJG9keLmzijDjHq0+Jhs+bWktjkUDTMfTxPObW7F2
         1CJIlqDRweyoM5B3M8Psuh3cN3a/3aQ1yqL1E/z/1gaKWH5W1rZyKDm1PMRnp1Fznq
         bDvZcyQR4DKTpJkddKqjHNkbg+E+/+yeDckyjVFik0XxNErxy/mlTWv3bh0pAo9YWM
         ibquo+sOy6Z6Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 05/20/2014 07:21, Paul Bolle wrote:
> Ever since (shortly before) v2.4.0 there have been checks for
> CONFIG_SGI_IP35. But a Kconfig symbol SGI_IP35 was never added to the
> tree. Remove these checks.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> For some reason CONFIG_SGI_IP35 was heavily used in arch/ia64 too.
> Anyhow, IA64 has dropped that macro years ago.
[snip]

IP35, on the MIPS side, refers to the SGI Origin 300/3000 family and its
derivatives, including Fuel and Tezro.  Altix is basically just the ia64
version of an Origin 300/3000.

An experimental tree based on 2.6.34, which was a start on booting Linux on
these machines, is here:
http://git.linux-mips.org/?p=ralf/linux-ip35.git;a=summary

However, progress halted when the MAC address couldn't be properly found by
probing the machine.  I think OpenBSD figured this bit out, though, so maybe
IP35 support can get another look at some point.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
