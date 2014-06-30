Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2014 22:32:47 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:44616 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860063AbaF3UcpIIm6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jun 2014 22:32:45 +0200
Received: by mail-ig0-f176.google.com with SMTP id c1so4752721igq.3
        for <multiple recipients>; Mon, 30 Jun 2014 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4kFKEbTz4C9meP7OZGgWFmbJtK5HaGEjbvSYsadOce0=;
        b=XbABI5n77t6h7XP27IG/J6WQWH5P6wUE5PSueoAvMP5y6B2kDD9EKdTn1/dzFYELbo
         MjgXvOBamzX9ANp7vhIUYr70IiHBtRg8Z+aFKlE8k1DaKAEy5T0JgveAI97SV207f4hZ
         4Ng7JvCykamMhPw39IJx4RNBKPvaM5Wxb2tl2iVJI0zXkl73Ix0XyO+58tcAAdPmVrdH
         pTaXTECS+oh06SbW91gDcb9bHFRjn0fssf4we48q7xYh4IFh1A3IXlCVPKRNuXP749Xn
         +lu3IwTnLpWF77Zk8M5jr5L2AVcCfCSszH5GnRF3PBrc/t6tOgNvh6zURhaIxz2P4RLC
         BiKA==
X-Received: by 10.50.7.39 with SMTP id g7mr35002927iga.15.1404160358745;
        Mon, 30 Jun 2014 13:32:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id u10sm27702654igz.21.2014.06.30.13.32.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 13:32:38 -0700 (PDT)
Message-ID: <53B1C965.6090904@gmail.com>
Date:   Mon, 30 Jun 2014 13:32:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi> <53B19B0E.8000702@gmail.com> <20140630191742.GA681@drone.musicnaut.iki.fi>
In-Reply-To: <20140630191742.GA681@drone.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40978
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

On 06/30/2014 12:17 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Jun 30, 2014 at 10:14:54AM -0700, David Daney wrote:
>> On 06/28/2014 01:34 PM, Aaro Koskinen wrote:
>>> The following patches add minimal support for D-Link DSR-1000N router.
>>
>> Which OCTEON chip does this device contain?
>
> [    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)
>
> # cat /proc/cpuinfo
> system type             : CUST_DSR1000N (CN5010p1.1-500-SCP)
> machine                 : Unknown
> processor               : 0
> cpu model               : Cavium Octeon+ V0.1
> BogoMIPS                : 1000.00
> wait instruction        : yes
> microsecond timers      : yes
> tlb_entries             : 64
> extra interrupt vector  : yes
> hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
> isa                     : mips1 mips2 mips3 mips4 mips5 mips64r2
> ASEs implemented        :
> shadow register sets    : 1
> kscratch registers      : 0
> core                    : 0
> VCED exceptions         : not available
> VCEI exceptions         : not available
>
>> Also what is the bootloader version on the board?
>
> D-Link DSR-1000N bootloader# version
>
> U-Boot 1.1.1 (Development build, svnversion: exported) (Build time: Mar 22 2010
> - 12:14:14)
>
> BTW, .notes segment from kernel needs to be removed for this bootloader
> with "strip -R .notes".
>

Too bad it doesn't have a modern bootloader that passes a device tree.

The whole series: Acked-by: David Daney <david.daney@cavium.com>
