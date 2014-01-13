Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 13:16:04 +0100 (CET)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:61967 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825722AbaAMMQAXpnNO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jan 2014 13:16:00 +0100
Received: by mail-bk0-f51.google.com with SMTP id w10so432308bkz.24
        for <multiple recipients>; Mon, 13 Jan 2014 04:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wBrqIQkHY/dWPCBS9sAopsJGgOVVp41x03VAxXLqEqw=;
        b=tJYV92WhjMKzdFvXCXiJOA9EEFNUR8DzmI4FwbBwEvn7gCllbQrP3UCFDmPdM/oi03
         OHqjRNZAVlCKyirQgdB6hx0H7wX2hEyD2wsHXE5KZjlw/1ajHv6pnvYRNNLm8SgUVjYA
         7SSAQUChlP9uR5xW0V+RVET6tqSrwhxmkrC6I+4Kw/s4GHmgr2x1+Tia7rPdS7ax/aQ3
         hQspcwUUTnjh7UgXFrQTWKZINEJDgNnU+fdOC/LjrRhZ9pLFIK3BJb7ob/whY0xHD1Qv
         vTbG/yfwbp+cDzeZ+TOGmiKFEQZiHpmLsHcLWh+zwk9CHFw6nDHaieMk5DdSNZHcWTs+
         HpBg==
MIME-Version: 1.0
X-Received: by 10.204.230.7 with SMTP id jk7mr1042778bkb.48.1389615354817;
 Mon, 13 Jan 2014 04:15:54 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Mon, 13 Jan 2014 04:15:54 -0800 (PST)
In-Reply-To: <20140113103837.GA24361@hall.aurel32.net>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
        <1389149068-24376-10-git-send-email-chenhc@lemote.com>
        <52CE9F12.3080205@imgtec.com>
        <20140111152407.GA20223@ohm.rr44.fr>
        <CAAhV-H6kbF2YkzdS9e_A6rYOkWiKi5Tr3jwPr+PQrQvQ12-h0w@mail.gmail.com>
        <20140113043026.GA3987@ohm.rr44.fr>
        <CAAhV-H5cXM9-Mcu1=ojc=NRmD_z-u5AaTJNkUOYbXLUtPY9Xvg@mail.gmail.com>
        <20140113103837.GA24361@hall.aurel32.net>
Date:   Mon, 13 Jan 2014 20:15:54 +0800
X-Google-Sender-Auth: KyuLrWuF_RvTIBxQi0mtZlmo0rg
Message-ID: <CAAhV-H7yjhsmESXUZrRzO3d7S-gpqiga0Za=Hasy6NcJzJ2nWQ@mail.gmail.com>
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
X-archive-position: 38954
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

On Mon, Jan 13, 2014 at 6:38 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On Mon, Jan 13, 2014 at 06:15:26PM +0800, Huacai Chen wrote:
>> On Mon, Jan 13, 2014 at 12:30 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
>> > On Mon, Jan 13, 2014 at 11:02:19AM +0800, Huacai Chen wrote:
>> >> On Sat, Jan 11, 2014 at 11:24 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
>> >> > On Thu, Jan 09, 2014 at 01:07:30PM +0000, Alex Smith wrote:
>> >> >> On 08/01/14 02:44, Huacai Chen wrote:
>> >> >> >Added Kconfig options include: Loongson-3 CPU and machine definition,
>> >> >> >CPU cache features, UEFI-like firmware interface (LEFI), HT-linked PCI,
>> >> >> >and big memory support.
>> >> >> >
>> >> >> >Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> >> >> >Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> >> >> >Signed-off-by: Hua Yan <yanh@lemote.com>
>> >> >> >---
>> >> >> >  arch/mips/Kconfig           |   29 +++++++++++++++++++++++++++-
>> >> >> >  arch/mips/loongson/Kconfig  |   44 +++++++++++++++++++++++++++++++++++++++++++
>> >> >> >  arch/mips/loongson/Platform |    1 +
>> >> >> >  3 files changed, 73 insertions(+), 1 deletions(-)
>> >> >> >
>> >> >> >diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> >> >> >index 17cc7ff..513e941 100644
>> >> >> >--- a/arch/mips/Kconfig
>> >> >> >+++ b/arch/mips/Kconfig
>> >> >> >@@ -1487,6 +1487,18 @@ config CPU_LOONGSON2
>> >> >> >     select CPU_SUPPORTS_HIGHMEM
>> >> >> >     select CPU_SUPPORTS_HUGEPAGES
>> >> >> >
>> >> >> >+config CPU_LOONGSON3
>> >> >> >+    bool "Loongson 3 CPU"
>> >> >> >+    depends on SYS_HAS_CPU_LOONGSON3
>> >> >> >+    select CPU_SUPPORTS_64BIT_KERNEL
>> >> >> >+    select CPU_SUPPORTS_HIGHMEM
>> >> >> >+    select CPU_SUPPORTS_HUGEPAGES
>> >> >> >+    select WEAK_ORDERING
>> >> >> >+    select WEAK_REORDERING_BEYOND_LLSC
>> >> >> >+    help
>> >> >> >+            The Loongson 3 processor implements the MIPS III instruction set
>> >> >> >+            with many extensions.
>> >> >> >+
>> >> >>
>> >> >> This should be moved into the "CPU type" choice block. Currently
>> >> >> this appears as an option outside of that choice, and so it is
>> >> >> possible to build a kernel without any CPU type selected.
>> >> >>
>> >> >> Also, as Aurelien said on the previous version, shouldn't the
>> >> >> comment be changed to MIPS64R2 rather than MIPS III even if you
>> >> >> aren't selecting the MIPS64 CPU types for the time being? Note, if
>> >> >> you replied to that comment I may not have seen it - I think the
>> >> >> list is filtering your replies because they're HTML emails.
>> >> >>
>> >> >> >  config CPU_LOONGSON1
>> >> >> >     bool
>> >> >> >     select CPU_MIPS32
>> >> >> >@@ -1513,6 +1526,10 @@ config SYS_HAS_CPU_LOONGSON2F
>> >> >> >     select CPU_SUPPORTS_ADDRWINCFG if 64BIT
>> >> >> >     select CPU_SUPPORTS_UNCACHED_ACCELERATED
>> >> >> >
>> >> >> >+config SYS_HAS_CPU_LOONGSON3
>> >> >> >+    bool
>> >> >> >+    select CPU_SUPPORTS_CPUFREQ
>> >> >> >+
>> >> >> >  config SYS_HAS_CPU_LOONGSON1B
>> >> >> >     bool
>> >> >> >
>> >> >> >@@ -1703,7 +1720,7 @@ choice
>> >> >> >
>> >> >> >  config PAGE_SIZE_4KB
>> >> >> >     bool "4kB"
>> >> >> >-    depends on !CPU_LOONGSON2
>> >> >> >+    depends on !CPU_LOONGSON2 && !CPU_LOONGSON3
>> >> >> >     help
>> >> >> >      This option select the standard 4kB Linux page size.  On some
>> >> >> >      R3000-family processors this is the only available page size.  Using
>> >> >> >@@ -2373,6 +2390,16 @@ config PCI
>> >> >> >       your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
>> >> >> >       say Y, otherwise N.
>> >> >> >
>> >> >> >+config HT_PCI
>> >> >> >+    bool "Support for HT-linked PCI"
>> >> >> >+    depends on CPU_LOONGSON3
>> >> >> >+    select PCI_DOMAINS
>> >> >> >+    help
>> >> >> >+      Loongson family machines use Hyper-Transport bus for inter-core
>> >> >> >+      connection and device connection. The PCI bus is a subordinate
>> >> >> >+      linked at HT. Choose Y unless you are using Loongson 2E/2F based
>> >> >> >+      machines.
>> >> >> >+
>> >> >>
>> >> >> Should this default to y, given that it is selected in the
>> >> >> defconfig? Also, the comment referring to 2E/2F is redundant given
>> >> >> that it depends on CPU_LOONGSON3 and cannot be selected on those
>> >> >> machines.
>> >> >
>> >> > I am still not sure we need such an option. This option only changes an
>> >> > address in arch/mips/include/asm/mach-loongson/loongson.h:
>> >> >
>> >> > | #if defined(CONFIG_HT_PCI)
>> >> > | #define LOONGSON_PCIIO_BASE     loongson_sysconf.pci_io_base
>> >> > | #else
>> >> > | #define LOONGSON_PCIIO_BASE     0x1fd00000
>> >> > | #endif
>> >> >
>> >> > If both options are working on a Loongson 3 machine, it's definitely a
>> >> > good idea to leave the choice to the user. That said if only the address
>> >> > from loongson_sysconf.pci_io_base works on a Loongson 3 machine, this
>> >> > option must always be selected and is therefore useless.
>> >> HT_PCI is needed, because Loongson-3 device structure looks like this:
>> >> Loongson3-Core -----　　　　　  ---- MEM
>> >>　　　　　　　　　 |--- Cache ---|
>> >> HT1-controller  -------　　　　　  ---- PCI-Controller --- PCI-Devices (PATH-B)
>> >>     |
>> >>     |
>> >>  PCI-Controller
>> >>     |
>> >>     |
>> >>  PCI-Devices (PATH-A)
>> >>
>> >> If PCI devices are linked via PATH-A, we should select HT_PCI;
>> >> otherwise we should unselected HT_PCI.
>> >
>> > Thanks for the explanation, it looks now more clear why we need this
>> > option. Both cases are valid, it just depends on where the PCI
>> > controller is connected.
>> >
>> > That said it means that we won't be able to use the same kernel on
>> > machines using the PATH-A and on machines using the PATH-B. Is there
>> > a way to determine this at runtime through LEFI?
>> At present we can't determine PATH-A/B through LEFI, and LEFI is
>> surely need to extend at some time. Most of machines use PATH-A, since
>> in this way DMA coherency is maintained by hardware. If use PATH-B,
>> both HT_PCI and LEFI should be disabled.
>
> As far as I understand, the current patchset assumes DMA coherency in
> all the patches. It means that even if this option is disabled to use
> the PATH-B instead, it won't work correctly.
>
> Therefore I think that this option should not be given to the user,
> either LEMOTE_MACH3A should automatically select it, or it should simply
> be removed. Of course it could be reintroduced in a later patchset
> adding full support for machines having their PCI connected through
> PATH-B.
OK, I'll make LEMOTE_MACH3A select HT_PCI automatically.

>
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 1024D/F1BCDB73
> aurelien@aurel32.net                 http://www.aurel32.net
>
