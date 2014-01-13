Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 11:15:38 +0100 (CET)
Received: from mail-bk0-f42.google.com ([209.85.214.42]:38872 "EHLO
        mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825722AbaAMKPcLmFUs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jan 2014 11:15:32 +0100
Received: by mail-bk0-f42.google.com with SMTP id my12so122576bkb.15
        for <multiple recipients>; Mon, 13 Jan 2014 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Cl2iib48QIyV7vS8gIVRE3D6WbrF4mQEUwu3114qeDw=;
        b=0zB/k6g0vsN9VURg2Q0x89Q+YfCYTTVQP6EQIOSIGF7/E1YtjvV0KB5ayp8VX6qQXy
         IwP4y+8R7IQWS05xdorTDQF4ZNWW2A/ciHcp9wbzMGXM7xIIOagLCLNqw53b/qDne3Fb
         Z0bX+zXIcGLRAzzGwlOrGk3WHBKmll9PTz3IjIOjcx95bezl011qyz8/D8xa1ojx904y
         P82F1/sS+rchV5eDK/0lelwwCG/wc91X5lt4gTB5mE4rCiuc5PqY5l+VdPx7515FJjqq
         Kd/8hD+au47AAAEkcaEROvdyhn77fvk8fKa6BdCSAcrdGfDco2+w3F0mgg1M3O33TKlu
         lHDQ==
MIME-Version: 1.0
X-Received: by 10.204.172.3 with SMTP id j3mr156045bkz.173.1389608126789; Mon,
 13 Jan 2014 02:15:26 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Mon, 13 Jan 2014 02:15:26 -0800 (PST)
In-Reply-To: <20140113043026.GA3987@ohm.rr44.fr>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
        <1389149068-24376-10-git-send-email-chenhc@lemote.com>
        <52CE9F12.3080205@imgtec.com>
        <20140111152407.GA20223@ohm.rr44.fr>
        <CAAhV-H6kbF2YkzdS9e_A6rYOkWiKi5Tr3jwPr+PQrQvQ12-h0w@mail.gmail.com>
        <20140113043026.GA3987@ohm.rr44.fr>
Date:   Mon, 13 Jan 2014 18:15:26 +0800
X-Google-Sender-Auth: NuYvNmvZGo_3FFZsK0RD_zBZKi8
Message-ID: <CAAhV-H5cXM9-Mcu1=ojc=NRmD_z-u5AaTJNkUOYbXLUtPY9Xvg@mail.gmail.com>
Subject: Re: [PATCH V16 09/12] MIPS: Loongson: Add Loongson-3 Kconfig options
From:   Huacai Chen <chenhc@lemote.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Mon, Jan 13, 2014 at 12:30 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On Mon, Jan 13, 2014 at 11:02:19AM +0800, Huacai Chen wrote:
>> On Sat, Jan 11, 2014 at 11:24 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
>> > On Thu, Jan 09, 2014 at 01:07:30PM +0000, Alex Smith wrote:
>> >> On 08/01/14 02:44, Huacai Chen wrote:
>> >> >Added Kconfig options include: Loongson-3 CPU and machine definition,
>> >> >CPU cache features, UEFI-like firmware interface (LEFI), HT-linked PCI,
>> >> >and big memory support.
>> >> >
>> >> >Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> >> >Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> >> >Signed-off-by: Hua Yan <yanh@lemote.com>
>> >> >---
>> >> >  arch/mips/Kconfig           |   29 +++++++++++++++++++++++++++-
>> >> >  arch/mips/loongson/Kconfig  |   44 +++++++++++++++++++++++++++++++++++++++++++
>> >> >  arch/mips/loongson/Platform |    1 +
>> >> >  3 files changed, 73 insertions(+), 1 deletions(-)
>> >> >
>> >> >diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> >> >index 17cc7ff..513e941 100644
>> >> >--- a/arch/mips/Kconfig
>> >> >+++ b/arch/mips/Kconfig
>> >> >@@ -1487,6 +1487,18 @@ config CPU_LOONGSON2
>> >> >     select CPU_SUPPORTS_HIGHMEM
>> >> >     select CPU_SUPPORTS_HUGEPAGES
>> >> >
>> >> >+config CPU_LOONGSON3
>> >> >+    bool "Loongson 3 CPU"
>> >> >+    depends on SYS_HAS_CPU_LOONGSON3
>> >> >+    select CPU_SUPPORTS_64BIT_KERNEL
>> >> >+    select CPU_SUPPORTS_HIGHMEM
>> >> >+    select CPU_SUPPORTS_HUGEPAGES
>> >> >+    select WEAK_ORDERING
>> >> >+    select WEAK_REORDERING_BEYOND_LLSC
>> >> >+    help
>> >> >+            The Loongson 3 processor implements the MIPS III instruction set
>> >> >+            with many extensions.
>> >> >+
>> >>
>> >> This should be moved into the "CPU type" choice block. Currently
>> >> this appears as an option outside of that choice, and so it is
>> >> possible to build a kernel without any CPU type selected.
>> >>
>> >> Also, as Aurelien said on the previous version, shouldn't the
>> >> comment be changed to MIPS64R2 rather than MIPS III even if you
>> >> aren't selecting the MIPS64 CPU types for the time being? Note, if
>> >> you replied to that comment I may not have seen it - I think the
>> >> list is filtering your replies because they're HTML emails.
>> >>
>> >> >  config CPU_LOONGSON1
>> >> >     bool
>> >> >     select CPU_MIPS32
>> >> >@@ -1513,6 +1526,10 @@ config SYS_HAS_CPU_LOONGSON2F
>> >> >     select CPU_SUPPORTS_ADDRWINCFG if 64BIT
>> >> >     select CPU_SUPPORTS_UNCACHED_ACCELERATED
>> >> >
>> >> >+config SYS_HAS_CPU_LOONGSON3
>> >> >+    bool
>> >> >+    select CPU_SUPPORTS_CPUFREQ
>> >> >+
>> >> >  config SYS_HAS_CPU_LOONGSON1B
>> >> >     bool
>> >> >
>> >> >@@ -1703,7 +1720,7 @@ choice
>> >> >
>> >> >  config PAGE_SIZE_4KB
>> >> >     bool "4kB"
>> >> >-    depends on !CPU_LOONGSON2
>> >> >+    depends on !CPU_LOONGSON2 && !CPU_LOONGSON3
>> >> >     help
>> >> >      This option select the standard 4kB Linux page size.  On some
>> >> >      R3000-family processors this is the only available page size.  Using
>> >> >@@ -2373,6 +2390,16 @@ config PCI
>> >> >       your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
>> >> >       say Y, otherwise N.
>> >> >
>> >> >+config HT_PCI
>> >> >+    bool "Support for HT-linked PCI"
>> >> >+    depends on CPU_LOONGSON3
>> >> >+    select PCI_DOMAINS
>> >> >+    help
>> >> >+      Loongson family machines use Hyper-Transport bus for inter-core
>> >> >+      connection and device connection. The PCI bus is a subordinate
>> >> >+      linked at HT. Choose Y unless you are using Loongson 2E/2F based
>> >> >+      machines.
>> >> >+
>> >>
>> >> Should this default to y, given that it is selected in the
>> >> defconfig? Also, the comment referring to 2E/2F is redundant given
>> >> that it depends on CPU_LOONGSON3 and cannot be selected on those
>> >> machines.
>> >
>> > I am still not sure we need such an option. This option only changes an
>> > address in arch/mips/include/asm/mach-loongson/loongson.h:
>> >
>> > | #if defined(CONFIG_HT_PCI)
>> > | #define LOONGSON_PCIIO_BASE     loongson_sysconf.pci_io_base
>> > | #else
>> > | #define LOONGSON_PCIIO_BASE     0x1fd00000
>> > | #endif
>> >
>> > If both options are working on a Loongson 3 machine, it's definitely a
>> > good idea to leave the choice to the user. That said if only the address
>> > from loongson_sysconf.pci_io_base works on a Loongson 3 machine, this
>> > option must always be selected and is therefore useless.
>> HT_PCI is needed, because Loongson-3 device structure looks like this:
>> Loongson3-Core -----　　　　　  ---- MEM
>>　　　　　　　　　 |--- Cache ---|
>> HT1-controller  -------　　　　　  ---- PCI-Controller --- PCI-Devices (PATH-B)
>>     |
>>     |
>>  PCI-Controller
>>     |
>>     |
>>  PCI-Devices (PATH-A)
>>
>> If PCI devices are linked via PATH-A, we should select HT_PCI;
>> otherwise we should unselected HT_PCI.
>
> Thanks for the explanation, it looks now more clear why we need this
> option. Both cases are valid, it just depends on where the PCI
> controller is connected.
>
> That said it means that we won't be able to use the same kernel on
> machines using the PATH-A and on machines using the PATH-B. Is there
> a way to determine this at runtime through LEFI?
At present we can't determine PATH-A/B through LEFI, and LEFI is
surely need to extend at some time. Most of machines use PATH-A, since
in this way DMA coherency is maintained by hardware. If use PATH-B,
both HT_PCI and LEFI should be disabled.

>
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 1024D/F1BCDB73
> aurelien@aurel32.net                 http://www.aurel32.net
>
