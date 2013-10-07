Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 18:10:21 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:54727 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868730Ab3JGQKTQhykM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 18:10:19 +0200
Message-ID: <5252DCEB.8070909@imgtec.com>
Date:   Mon, 7 Oct 2013 17:10:19 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix mapstart when using initrd
References: <1379945426-32205-1-git-send-email-ashoks@broadcom.com> <20131007160821.GA1615@linux-mips.org>
In-Reply-To: <20131007160821.GA1615@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_07_17_10_13
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 10/07/13 17:08, Ralf Baechle wrote:
> On Mon, Sep 23, 2013 at 07:40:26PM +0530, Ashok Kumar wrote:
>> Date:   Mon, 23 Sep 2013 19:40:26 +0530
>> From: Ashok Kumar <ashoks@broadcom.com>
>> To: linux-mips@linux-mips.org, gerg@uclinux.org
>> cc: ralf@linux-mips.org, Ashok Kumar <ashoks@broadcom.com>
>> Subject: [PATCH] MIPS: fix mapstart when using initrd
>> Content-Type: text/plain
>>
>> When initrd is present in the PFN right after the _end, bootmem
>> bitmap(mapstart) overwrites it. So check for initrd_end in
>> mapstart calculation.
>>
>> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
>> ---
>> This is seen after the commit
>> "mips: fix start of free memory when using initrd"
>> in git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git branch
>>
>> Tested the image on MIPS platform creating the above
>> said scenario and initrd was corrupted.
>
> And it gloriously breaks the build if CONFIG_BLK_DEV_INITRD is disabled.
> Now most configurations will fail with something like:
>
> [...]
>    LD      vmlinux
> arch/mips/built-in.o: In function `setup_arch':
> (.init.text+0xff8): undefined reference to `initrd_end'
> arch/mips/built-in.o: In function `setup_arch':
> (.init.text+0xffc): undefined reference to `initrd_end'
> make[2]: *** [vmlinux] Error 1
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> make: Leaving directory `/home/ralf/src/linux/obj/lasat-build'
>
>    Ralf
>
Hi Ralf,

I just sent a patch for that

http://patchwork.linux-mips.org/patch/6028/
