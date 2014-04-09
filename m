Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 01:45:03 +0200 (CEST)
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:33728
        "EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816543AbaDIXo7oV3X0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 01:44:59 +0200
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
        by qmta12.westchester.pa.mail.comcast.net with comcast
        id nyPP1n0051HzFnQ5Czktmp; Wed, 09 Apr 2014 23:44:53 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta14.westchester.pa.mail.comcast.net with comcast
        id nzks1n00f0JZ7Re3azktve; Wed, 09 Apr 2014 23:44:53 +0000
Message-ID: <5345DB6A.7060004@gentoo.org>
Date:   Wed, 09 Apr 2014 19:44:42 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com> <20140409051929.GA29246@localhost> <20140409082445.GC1438@pax.zz.de> <20140409133229.GA22315@alpha.franken.de> <20140409231345.GC8370@localhost>
In-Reply-To: <20140409231345.GC8370@localhost>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1397087093;
        bh=qfQUSBvV6d0pKgNgzkC8lp2v4TL0iHzYMSzJPD+LYSk=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=sPLl6bom8cKazDcP3Tc5kbEjpn96XOdp9JE9eSphkJfMzC+7Db0PBo6jImS0FX5JZ
         z3Y7CWG65AvQao1jzjVdUZ+2gLEkY6gRo2macXhIGCzcwXVCJkqhKb6r8HqCw0W/0J
         EGK8NL00lA8C0Z4cMt+1pw4CdJOzPjmHRQX2YzekQO2SGSK7eFjnAHlW5MXEZ6mA8J
         tkbuAURDHuHYaNV+pHCWxSTYtinOaRKE7f3Udsr2NiQaDogBOz/WqzFMwfFPJyAh10
         fcggMUZBy90WfAi4ADoas6hi+EjH/UFbkSHpFYOIXVWwmf6IJQiUkfr44Ary+UXLYC
         NjzPJ6nVRugDg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39753
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

On 04/09/2014 19:13, Fengguang Wu wrote:
> On Wed, Apr 09, 2014 at 03:32:29PM +0200, Thomas Bogendoerfer wrote:
>> On Wed, Apr 09, 2014 at 10:24:45AM +0200, Florian Lohoff wrote:
>>> Most likely they never made it into gcc upstream but they are
>>> necessary working around the r10k speculative stores on non
>>> cache coherent machines like the IP28.
>>
>> IMHO the patch went upstream judging from the incremental patches
>> here http://gcc.gnu.org/ml/gcc-patches/2012-12/msg01371.html.
>>
>> Iirc it went into 4.4.0.
> 
> That's interesting. I'm using the cross compiler
> 
>         gcc-4.6.3-nolibc/mips-linux
> 
> downloaded from
> 
>         https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/
> 
> I notice there is also a mips64 compiler. Should I use that?

If you weren't using a mips64 compiler, that's probably the issue.  R10000
processors are 64-bit only, so a 'mips' toolchain probably doesn't include
the R10K cache-barrier code, causing that option to fail.

Are you configuring for IP22 (Indy, Indigo2 R4x00), or IP28 (R10000)?  Note,
IP26 (R8000) is not supported in Linux.  I think OpenBSD got it working, though.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
