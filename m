Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 03:45:33 +0100 (CET)
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:34173 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011878AbbAUCpaOhHsn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 03:45:30 +0100
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-06v.sys.comcast.net with comcast
        id iSkX1p0034xDoy801SlPZu; Wed, 21 Jan 2015 02:45:23 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-po-05v.sys.comcast.net with comcast
        id iSlN1p0070uk1nt01SlNFe; Wed, 21 Jan 2015 02:45:23 +0000
Message-ID: <54BF12B9.8000507@gentoo.org>
Date:   Tue, 20 Jan 2015 21:45:13 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com>
In-Reply-To: <54BEDF3C.6040105@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421808323;
        bh=TjdVbDK4liOZm8MoTIIUKexHkXmVXEtQJ9zra5M9WKY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=TZRbjrvTz5Eyg/MVdhQ2VwUQAKKgncJ+SEw03SQvgXQafJIjkwL7RD2EoOMRzlknB
         wFRWx6r8++9lHS8daxfQdTrgA1Pv7xpm676E3nXps5wcPLspUVLk+TSg98oAL0Qdxw
         6CmYEbrx2wAxHqa9awPJzJszpZi+zZWzFONLyKvaa2zrrhSfiTxJewrIROiMr01Zzt
         75gGRd0caJdnjQLbsG9J6FJbFFFwU6UDjMA4gKaPmFtKas8OqdMi1LbNwdfsiNHGqu
         CeAPWuVjA/6POWoB+grynzbDX964izjONL3/ITUi4Jj6fvmBL2V/qfMpnHzDXbCYVl
         aBQhZUE4Ygp4g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45388
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

On 01/20/2015 18:05, David Daney wrote:
> On 01/19/2015 01:02 AM, Joshua Kinard wrote:
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> This is a small patch to display the CPU byteorder that the kernel was compiled
>> with in /proc/cpuinfo.
> 
> What would use this?  Or in other words, why is this needed?

It was a patch I started including years ago in Gentoo's mips-sources, and just
never thought much about.  I know it was submitted several times in the past,
but I can't recall what, if any objection was ever made.  No harm in sending it
in again...


> Userspace C code doesn't need this as it has its own standard ways of
> determining endianness.
> 
> If you need to know as a user you can do:
> 
>    readelf -h /bin/sh | grep Data | cut -d, -f2

This would only tell you the endianness of the userland binary, not of the
kernel.  While they should be one and the same (otherwise, you're not going to
get very far anyways), they are, technically, distinctly different properties.

--J


>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>   arch/mips/kernel/proc.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> This patch has been submitted several times prior over the years (I think), but
>> I don't recall what, if any, objections there were to it.
>>
>> linux-mips-proc-cpuinfo-byteorder.patch
>> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
>> index 097fc8d..75e6a62 100644
>> --- a/arch/mips/kernel/proc.c
>> +++ b/arch/mips/kernel/proc.c
>> @@ -65,6 +65,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>       seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
>>                 cpu_data[n].udelay_val / (500000/HZ),
>>                 (cpu_data[n].udelay_val / (5000/HZ)) % 100);
>> +#ifdef __MIPSEB__
>> +    seq_printf(m, "byteorder\t\t: big endian\n");
>> +#else
>> +    seq_printf(m, "byteorder\t\t: little endian\n");
>> +#endif
>>       seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
>>       seq_printf(m, "microsecond timers\t: %s\n",
>>                 cpu_has_counter ? "yes" : "no");
