Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 21:38:34 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:60187 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818452AbaFQTiausnNH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jun 2014 21:38:30 +0200
Received: by mail-wg0-f46.google.com with SMTP id y10so7627216wgg.29
        for <linux-mips@linux-mips.org>; Tue, 17 Jun 2014 12:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=HUWkXJByIdwnfXOoIooz3QaDwnyn4AfB3VV4v6M5Z5M=;
        b=T2qCm+lFSOIlVb0jIGornOBb5MomOi6N7lLB8tRp57lPUx4ddiSvHNlwQrGcjZqQ3j
         GH9j8AiqQU69NR5nS53PZ1a5WE2vhGs0gBlEuIe7A8fQCJ0MOib40NnrqEv1f+fawYlg
         o8AYJhjjy4qamcjzetM3nna6jmY58oYXId2rEvd1tWobouoQJ+VM8UkC60SKOUv4LGSY
         lTYoYsiJBeKj04KlDoYaCLd9+18Ic7Zmo40s0PgkBwCms++rNavypikdhmNP30mMm/It
         9yAhj31q+K8v8eQ4mMyyFuy8T+Al4RFxXE90rQTVW9slL/zUQqlKiDgZRs5hyqZbgO2a
         GXYQ==
X-Gm-Message-State: ALoCoQkYlMCAzt64L9cQIodH+zjPJiYhgZj/VV2V7NJ3jdW2zBecyu5Pw/V/LihlDcKASBH8lSPP
MIME-Version: 1.0
X-Received: by 10.194.122.169 with SMTP id lt9mr40878272wjb.16.1403033905343;
 Tue, 17 Jun 2014 12:38:25 -0700 (PDT)
Received: by 10.194.121.228 with HTTP; Tue, 17 Jun 2014 12:38:25 -0700 (PDT)
Date:   Tue, 17 Jun 2014 12:38:25 -0700
Message-ID: <CAMEtUuz=us+=ejHaOf+Mq19hZoNJ=-faB9y4f4NC90=9E6Ck7g@mail.gmail.com>
Subject: Re: mips:allmodconfig build failure in 3.16-rc1 due to bpf_jit code
From:   Alexei Starovoitov <ast@plumgrid.com>
To:     Daniel Borkmann <dborkman@redhat.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ast@plumgrid.com
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

On Tue, Jun 17, 2014 at 4:21 AM, Daniel Borkmann <dborkman@redhat.com> wrote:
> On 06/17/2014 01:09 PM, Markos Chandras wrote:
> ...
>>
>> Thanks for these instructions. I will try them myself once I find some
>>
>> time since I don't think bpf_jit for MIPS has ever been tested with all
>> the opcodes.
>
>
> Sounds great! If you find some tests are missing, please feel free to
> submit them as well via netdev.
>
> Best,
>
> Daniel

Daniel,

thank you for taking care of it so quickly :)
from the BPF perspective the fix looks good:
Acked-by: Alexei Starovoitov <ast@plumgrid.com>

Markos,

please do run the testsuite.
Doing quick code review of mips jit, it looks like:

- your version of pkt_type_offset() will work for little endian only.
  (we've recently fixed it in net/core/filter.c)

- vlan tag handling is incorrect, since it's missing shifts.
  classic BPF standard for vlan_tag_present has to return 1 or 0
  and not just emit_and(r_A, r_s0, VLAN_TAG_PRESENT, ctx);

- pr_warn("%s: Unhandled opcode: 0x%02x\n", __FILE__,
  is way too heavy, since when jit is on, unprivileged user can spam log.

- /* sa is 5-bits long */
  BUG_ON(sa >= BIT(5));
is wrong too. Malicious user can cause kernel crash…
Also shift A>>=33 was always allowed by classic BPF checker, so
JITs have to silently do C-equivalent version of such shift.

- /* Determine if immediate is within the 16-bit signed range */
static inline bool is_range16(s32 imm)
{
        if (imm >= SBIT(15) || imm < -SBIT(15))
                return true;
the function name and comment are doing the opposite of
actual code, which makes harder to follow.

- the rest looks pretty good!

Also you'll get a lot more mileage out of mips jit if you use eBPF
instruction set as a base for JITing. You wouldn't need to worry
about vlan, pkt_type and other classic extensions. You'll get all
extensions for free, plus seccomp, tracing, etc.

Thanks
Alexei
