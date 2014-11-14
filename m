Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 19:38:17 +0100 (CET)
Received: from www.sr71.net ([198.145.64.142]:39801 "EHLO blackbird.sr71.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013680AbaKNSiQJpV35 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 19:38:16 +0100
Received: from [127.0.0.1] (c-76-115-204-134.hsd1.or.comcast.net [76.115.204.134])
        (Authenticated sender: dave)
        by blackbird.sr71.net (Postfix) with ESMTPSA id A8F25FA893;
        Fri, 14 Nov 2014 10:38:04 -0800 (PST)
Message-ID: <54664C0B.6070604@sr71.net>
Date:   Fri, 14 Nov 2014 10:38:03 -0800
From:   Dave Hansen <dave@sr71.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, hpa@zytor.com
CC:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 05/11] x86, mpx: add MPX to disaabled features
References: <20141114151816.F56A3072@viggo.jf.intel.com> <20141114151823.B358EAD2@viggo.jf.intel.com> <5466425D.1060100@cogentembedded.com>
In-Reply-To: <5466425D.1060100@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@sr71.net
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

On 11/14/2014 09:56 AM, Sergei Shtylyov wrote:
>>   #define DISABLED_MASK6    0
>>   #define DISABLED_MASK7    0
>>   #define DISABLED_MASK8    0
>> -#define DISABLED_MASK9    0
>> +#define DISABLED_MASK9    (DISABLE_MPX)
> 
>    These parens are not really needed. Sorry to be a PITA and not saying
> this before.

One goal of the disabled features patch was to maintain parity with
required-features.h.  It declares things this way:

> #define REQUIRED_MASK3  (NEED_NOPL)
> #define REQUIRED_MASK4  (NEED_MOVBE)

So, no, those aren't strictly needed, but there is precedent for them
and they do no harm.  I think I'll leave them as-is.
