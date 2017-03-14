Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 21:22:41 +0100 (CET)
Received: from resqmta-po-09v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:168]:46400
        "EHLO resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdCNUWd2Gqmi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 21:22:33 +0100
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-09v.sys.comcast.net with SMTP
        id nsvqcPXyiODBvnsxjcgin1; Tue, 14 Mar 2017 20:22:31 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-po-05v.sys.comcast.net with SMTP
        id nsxgc58RGLHEwnsxhcDXYo; Tue, 14 Mar 2017 20:22:31 +0000
Subject: Re: [PATCH 0/2] cpu-features.h rename
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        ralf@linux-mips.org
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
 <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <a868cad2-a129-167b-69ad-8fb1163f4fc2@gentoo.org>
Date:   Tue, 14 Mar 2017 16:22:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCmPaJtfBQeC4UK/JJSMXnpVimNvxSx3STQCNzNT5RiXQppnwsWtc3yoE+KqjKrzbFVtfrcfIJ8a0z8n7i5tqbtnn/63XBxzRY3Yj8Vsbj0QYbH+KG//
 +6CvkQ8h2C7UZbnuykwlzI9ZDwAciUZ+GsIqZa7KUsIUR16gqiMSlq0SHYvqdm7lRuoLlrb4+LwWmvzJ773DtOy81trXBTCZg3HvnLPkkx/QwiK8CxeN3w2c
 KanW5wg/XSPq+Awou9+MQjIxjaukZDcqDWz+t8aZmJQ=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57260
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

On 03/13/2017 13:08, Florian Fainelli wrote:
> On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
>> Since the introduction of GENERIC_CPU_AUTOPROBE
>> (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very similarily
>> named headers: cpu-features.h and cpufeature.h.
>> Since the latter is used by all platforms that implement
>> GENERIC_CPU_AUTOPROBE functionality, it's better to rename the MIPS-specific
>> cpu-features.h.
>>
>> Marcin Nowakowski (2):
>>   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
>>   MIPS: rename cpu-features.h -> cpucaps.h
> 
> That's a lot of churn that could cause some good headaches in
> backporting stable changes affecting cpu-feature-overrides.h.
> 
> Can we just do the cpu-features.h -> cpucaps.h rename and keep
> cpu-feature-overrides.h around?

Instead of "cpucaps.h", which is somewhat short of a filename and doesn't
clearly convey its purpose, can we instead go with something more descriptive
like "cpu-capabilities.h"?  This would, however, make the overrides file have a
bit of a long name at "cpu-capabilities-overrides.h".

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
