Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2016 16:31:01 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:40445 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992992AbcJROayQXgEy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Oct 2016 16:30:54 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 7A5CD946B3EDF;
        Tue, 18 Oct 2016 15:30:44 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 18 Oct 2016
 15:30:47 +0100
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 18 Oct
 2016 15:30:46 +0100
Subject: Re: [PATCH v3 0/4] MIPS: Remote processor driver
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1476193356-1350-1-git-send-email-matt.redfearn@imgtec.com>
 <1a12d041-b49c-3412-c867-9bbe47d040fc@hauke-m.de>
CC:     <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <8eb30f99-c7b9-49e5-7354-c99fee6f437e@imgtec.com>
Date:   Tue, 18 Oct 2016 15:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1a12d041-b49c-3412-c867-9bbe47d040fc@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Hauke,


On 17/10/16 22:13, Hauke Mehrtens wrote:
> On 10/11/2016 03:42 PM, Matt Redfearn wrote:
>> The MIPS remote processor driver allows non-Linux firmware to take
>> control of and execute on one of the systems VPEs. The CPU must be
>> offlined from Linux first. A sysfs interface is created which allows
>> firmware to be loaded and changed at runtime. A full description is
>> available at [1]. An example firmware that can be used with this driver
>> is available at [2].
>>
>> This is useful to allow running bare metal code, or an RTOS, on one or
>> more CPUs while allowing Linux to continue running on those remaining.
>>
>> The remote processor framework allows for firmwares to provide any
>> virtio device for communication between the firmware running on the
>> remote VP and Linux. For example [1] demonstrates a simple firmware
>> which provides a virtual serial port. Any string sent to the port is
>> case inverted and returned.
>>
>> This is conceptually similar to the VPE loader functionality, but is
>> more standard as it fits into the remoteproc subsystem.
>>
>> The first patches in this series lay the groundwork for the driver
>> before it is added. The last series deprecates the VPE loader.
>>
>> This functionality is supported on:
>> - MIPS32r2 devices implementing the MIPS MT ASE for multithreading, such
>>    as interAptiv.
>> - MIPS32r6 devices implementing VPs, such as I6400.
>>
>> Limitations:
>> - The remoteproc core supports only 32bit ELFs. Therefore it is only
>>    possible to run 32bit firmware on the remote processor. Also, for
>>    virtio communication, pointers are passed from the kernel to firmware.
>>    There can be no mismatch in pointer sizes between the kernel and
>>    firmware, so this limits the host kernel to 32bit as well.
>>
>> The functionality has been tested on the Ci40 board which has a 2 core 2
>> thread interAptiv.
>>
> Does this also work with big firmware binaries, like 2 MB firmware size?
> It looks like dma_alloc_coherent() is used in rproc_handle_carveout() to
> allocate the memory which will probably not work after full boot.

In my testing, a 2Mb firmware carveout does work fine on a Creator Ci40 
with 256Mb RAM. But like you say, using the DMA api will limit the size 
of the firmware. In our driver's case, we end up setting up wired TLB 
entries mapping the carveout into the offline CPUs virtual memory, so in 
principle there is no reason (for our driver) that the memory has to be 
contiguous since we could map smaller pages. But this is code in the 
generic remoteproc framework so must work for other processors which 
could not deal with that.

>
> Is it possible to configure the cache line in a way that it will not be
> removed from the cache to avoid high latency loads from main memory?
> This is only needed for small firmware binaries, but allows even shorter
> reaction times and better real time behavior.

The firmware running on the offline CPU has full access to the hardware 
so could do whatever it likes with it's cache lines - it's not something 
that the remote processor driver ought to do as a matter of course 
though I don't think.

>
> In general I am in favor of having this as a standard Linux interface.

Great :-)

Thanks,
Matt

> Hauke
