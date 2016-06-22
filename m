Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 00:05:18 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33723 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27043559AbcFVWFQ2aXI4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 00:05:16 +0200
Received: by mail-pa0-f49.google.com with SMTP id b13so20559192pat.0;
        Wed, 22 Jun 2016 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=WqkKxxQPkOUZTuInEM/Xrs1Y298R8B+nRTQGPqj3rBk=;
        b=HED6fnqEknLz8UEjHi+0VNZuvoo4OQytNB6FQOcQbNtge7UkjQv0GIPuIcfAY9OiC5
         6JCmnTLJMo9ZXAek/7RBTNX+Dk1oDVIITRb9ceGvL+ZoE29VAUQ04YsLUSTZrBBmux4h
         slqEMAu5ExnjojrJIK+gh8uN2ok2+q/H3q9R13OexpzGF0d7cUZ4JTFNne5Z4mKZ8ucy
         Pa40nY1Gjty0PCHVHEOcnq/2lUUH+LIOzWTwJW+meL/HN8nO6GmThHvEV8czNLImR2yF
         s4nc0aQkivDzSp5iuBiJIVD/Drh45gflCzJGoiVGpkPnMPYyce4owEQ1Hc6AnIbpFPqQ
         /e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=WqkKxxQPkOUZTuInEM/Xrs1Y298R8B+nRTQGPqj3rBk=;
        b=IEESdhJhW4/YT7NwhvbvYE49MNfX0PW9ueYVc21IHioNr/GjAIGUpHQIz8kbH3nCMq
         0tvRCfTdTgrxJNCsh5loAg0gGsTAV4hK+Ak0cblXsXFvoX51mCQwXf/sbRrpEGzW9lgb
         8krcUM2GyjrSF7KowPx5a0CgHCXgGqLeFy4a5ULy8wL9xW4IvYASLY6BA+ZPi2i6zTE0
         WDCvJ0erW553gLR1p3EX0RPq131enax7EOZJDbWcS7Xq4+CWL+0m8PVBDgCKUr6rMEyo
         sfR63StTqcgPdpkt48hZqJuaJOYRFPQJbwQ8Ia1rmy+8U5DXiLUtdEY3iCQxUL6D7er3
         ACDQ==
X-Gm-Message-State: ALyK8tKDSptxgTANCJJKtaPxd8+nc4hduQjydAqmRgpjlkzPnoU1JdOt2HXvv6Jl4SAGMw==
X-Received: by 10.66.150.67 with SMTP id ug3mr24754612pab.41.1466633108406;
        Wed, 22 Jun 2016 15:05:08 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id 7sm1997831pfa.28.2016.06.22.15.05.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2016 15:05:07 -0700 (PDT)
Message-ID: <576B0B91.2020608@gmail.com>
Date:   Wed, 22 Jun 2016 15:05:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
In-Reply-To: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

This is caused by a config bug.

For THP to work you must have both:

CONFIG_TRANSPARENT_HUGEPAGE=y
and
CONFIG_HUGETLBFS=y

Please try testing with both of those set as well as applying:

https://www.linux-mips.org/archives/linux-mips/2016-06/msg00397.html

I will look into either a Kconfig fix, or fixing the code that currently 
depends on CONFIG_HUGETLBFS, but is needed for all huge pages.

The faults I saw are caused by:

    #define pmd_huge(x)	0

In include/linux/hugetlb.h

Really we need to replace all occurrences of pmd_huge() under arch/mips 
with something like pte_huge(), but I don't know if that is sufficient. 
  There may be other things gated by CONFIG_HUGETLBFS that I didn't see.

David.

On 05/23/2016 08:13 AM, Aaro Koskinen wrote:
> Hi,
>
> I'm getting kernel crashes (see below) reliably when building Perl in
> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> Linux 4.6.
>
> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> issue - disabling it makes build go through fine.
>
> Any ideas?
>
> A.
>
> [ 2457.467155] Got mcheck at 00000001200a82b4
> [ 2457.479447] CPU: 6 PID: 15916 Comm: lib/unicore/mkt Not tainted 4.6.0-octeon-distro.git-v2.16-1-gfc3b10e-dirty-00001-g16a7aa0 #1
> [ 2457.514121] task: 80000000eccf2b80 ti: 80000000ecda4000 task.ti: 80000000ecda4000
> [ 2457.536551] $ 0   : 0000000000000000 3e000000105bc006 0000000000000000 ffffffff957e4728
> [ 2457.560686] $ 4   : 00000000000000f2 0000000000000067 000000012015e8ab 00000000332295cf
> [ 2457.584822] $ 8   : 0000000000000000 0000000000000000 0000000000000001 0000000000000003
> [ 2457.608957] $12   : 00000001204e04d8 0000000000000008 0000000000000001 ffffffffffffffff
> [ 2457.633093] $16   : 0000000120383d60 00000001203a3828 00000000332295cf 000000000000000b
> [ 2457.657228] $20   : 000000012015e8a0 0000000000000000 000000000000000c 0000000000000000
> [ 2457.681363] $24   : 0000000000000010 00000001200a80e8
> [ 2457.705496] $28   : 00000001201a0300 000000ffffda82a0 000000012019b9b8 0000000120039f5c
> [ 2457.729631] Hi    : 0000000000000000
> [ 2457.740341] Lo    : 0000000000000008
> [ 2457.751055] epc   : 00000001200a82b4 0x1200a82b4
> [ 2457.764891] ra    : 0000000120039f5c 0x120039f5c
> [ 2457.778726] Status: 00308cf3	KX SX UX USER EXL IE
> [ 2457.793284] Cause : 00800060 (ExcCode 18)
> [ 2457.805296] PrId  : 000d0409 (Cavium Octeon+)
> [ 2457.818350] Index    : 80000000
> [ 2457.827759] PageMask : 1fe000
> [ 2457.836646] EntryHi  : 00000001203820f4
> [ 2457.848136] EntryLo0 : 00000000105b8006
> [ 2457.859628] EntryLo1 : 00000000105bc006
> [ 2457.871119] Wired    : 0
> [ 2457.878704] PageGrain: e0000000
> [ 2457.888111]
> [ 2457.892573] Index: 25 pgmask=4kb va=00120456000 asid=f4
> [ 2457.908256] 	[ri=0 xi=0 pa=000e47d3000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000c31bc000 c=0 d=1 v=1 g=0]
> [ 2457.935230] Index: 26 pgmask=4kb va=001200a8000 asid=f4
> [ 2457.950915] 	[ri=0 xi=0 pa=000e0e1c000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000c50ed000 c=0 d=0 v=1 g=0]
> [ 2457.977888] Index: 27 pgmask=4kb va=001203a2000 asid=f4
> [ 2457.993574] 	[ri=0 xi=0 pa=00000000000 c=0 d=0 v=0 g=0] [ri=0 xi=1 pa=0009005a000 c=1 d=0 v=1 g=0]
> [ 2458.020548]
> [ 2458.025008]
> Code: de100000  1200001c  00000000 <de110008> 8e220000  1452fffa  00000000  8e220004  1453fff7
> [ 2458.054470] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
> [ 2458.087614] ---[ end Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
> [ 2458.122835]
> do_page_fault(): sending SIGSEGV to make for invalid write access to 0000000000000012[ 2458.149565]
> [ 2458.149565] do_page_fault(): sending SIGSEGV to miniperl for invalid write access to 0000000000000010epc = 0000000120089500 in miniperl[120000000+181000]ra  = 00000001200c18a4 in miniperl[120000000+181000][ 2458.149590]
>
> [ 2458.212999] epc = 0000000120015400 in make[120000000+35000]
> [ 2458.229780] ra  = 000000ffeca7f570 in[ 2458.240797]
>
> *** NMI Watchdog interrupt on Core 0x0 ***
>
> A.
>
>
