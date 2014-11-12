Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 06:41:59 +0100 (CET)
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:48450 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012552AbaKLFl53zTnT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 06:41:57 +0100
Received: from resomta-po-04v.sys.comcast.net ([96.114.154.228])
        by resqmta-po-01v.sys.comcast.net with comcast
        id EVhr1p0014vw8ds01Vhrpg; Wed, 12 Nov 2014 05:41:51 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-04v.sys.comcast.net with comcast
        id EVhp1p00L0gJalY01Vhqt6; Wed, 12 Nov 2014 05:41:51 +0000
Message-ID: <5462F316.3010004@gentoo.org>
Date:   Wed, 12 Nov 2014 00:41:42 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: R14000: Add missing CPU_R14000 reference in cpu_needs_post_dma_flush()
References: <543490B9.7070302@gentoo.org> <20141111212253.GA11943@linux-mips.org>
In-Reply-To: <20141111212253.GA11943@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415770911;
        bh=INtriNI6aKyG9mGjOKwKwP571HeyBcS+A9rHSBjVfKU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=YO6ZAr52bcnOBNTyJJpW5U4SCfcWw2kD+Y2/XLODlolK91pS/TAXFupoH+olefmGi
         mzFb8aNdl+gEhRF6GzkRuxb2QTKWocjbeY0Mu+OFGVQEGHtplr8kRrj+vnPBBaV4/Y
         sX3gq1CLVyVDnn1Wjw7OzVpnQuON0DLTTZGCawPeZXhG81iQPYADQ/Udj5TYCw4DcV
         5jj46MQ7CN6otal7o/LJxc9q9GKwmGzhZTisWenbqKyYmqKUWkFZIZhFmP1duZNweb
         jzGTgvaanmXj2HejDdn2taKeTdgU2tsb6UDSSgT1ObhNXq5Hkr3CWjI61PcVyM8utG
         9rpRKZg7bLfcA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44026
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

On 11/11/2014 16:22, Ralf Baechle wrote:
> On Tue, Oct 07, 2014 at 09:17:45PM -0400, Joshua Kinard wrote:
> 
>> cpu_needs_post_dma_flush() in arch/mips/mm/dma-default.c is missing a check for
>> CPU_R14000, where it already has checks for CPU_R10000 and CPU_R12000.  This
>> patch adds the missing CPU_R14000 check.
> 
> Patch is entirely correct.  Except.
> 
> This is only used on systems which don't have DMA cache coherency.  Those
> systems are the IP28 and IP22 which featured an R10000 rsp.  R10000 or
> R12000 processor which is why the R14000 is intentionally not listed in
> this if().  Saves a few bytes and cycles.  And probably deserves a
> comment in the code!
> 
>   Ralf

A comment in the code sounds great in that case then!  I'll drop this locally,
then.  Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
