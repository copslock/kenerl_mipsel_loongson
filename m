Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 18:17:02 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:33060 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903656Ab2FTQQy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 18:16:54 +0200
Received: by ggcs5 with SMTP id s5so6273100ggc.36
        for <multiple recipients>; Wed, 20 Jun 2012 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VqE18D2dV2aexgofzeg0uwQj4BF8x4a3+MdJ8QWx7ac=;
        b=U5U0868p3zBHo+OWBhhpI/QdlG0t9nKd9YcpTIEiiVEqan8zWDwHgVK2ej69ot33oW
         KAeRSPmNpYSu9NGaXZqPYsFu3f441XT6uZKezNilkyhJIVWJOIrSvuER8PyNKfbTHyi6
         Py0XjxUETVJFrMu8wRk0PMBvDYnufCKK65+0Na/7gqdnY4um3Vh4Ryz7sppsxsnUM5TO
         zEsxfTAZkeSSExwcpDy8Ue35YDMsuM6MnFkgKms/UVIit8GlgbrHemn0CC+gXzNdFpLf
         8Z4sl4B8xiiCp8EO0O3inBRqt0Vw29bDrzS/FIfM+Godloq+OnneNLrireivN7uOJzyL
         JzhQ==
MIME-Version: 1.0
Received: by 10.42.197.197 with SMTP id el5mr11335981icb.35.1340209007983;
 Wed, 20 Jun 2012 09:16:47 -0700 (PDT)
Received: by 10.231.24.2 with HTTP; Wed, 20 Jun 2012 09:16:47 -0700 (PDT)
In-Reply-To: <CAAhV-H5Mv9nmvukh4+ZOqZ0tHr2yZu0185C13TYEXSP1fGExOQ@mail.gmail.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-13-git-send-email-chenhc@lemote.com>
        <20120619135703.GA1979@gmail.com>
        <CADnq5_NdqE0w6eN7V1aToH=wOr-DXMGVvy_GuaUtg4QS=H1wGA@mail.gmail.com>
        <CAAhV-H5Mv9nmvukh4+ZOqZ0tHr2yZu0185C13TYEXSP1fGExOQ@mail.gmail.com>
Date:   Wed, 20 Jun 2012 12:16:47 -0400
Message-ID: <CADnq5_Nr7YR95XHhHgqaSJWj+KtWrR7vwn_rQv4+5MOzwDF9Hw@mail.gmail.com>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for Loongson.
From:   Alex Deucher <alexdeucher@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     "j.glisse" <j.glisse@gmail.com>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexdeucher@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jun 20, 2012 at 4:28 AM, Huacai Chen <chenhuacai@gmail.com> wrote:
> On Wed, Jun 20, 2012 at 9:26 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Tue, Jun 19, 2012 at 9:57 AM, j.glisse <j.glisse@gmail.com> wrote:
>>> On Tue, Jun 19, 2012 at 02:50:20PM +0800, Huacai Chen wrote:
>>>> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>>>>    doesn't support DMA address above 4GB).
>>>> 2, Read vga bios offered by system firmware.
>>>> 3, Handle io prot correctly for MIPS.
>>>> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
>>>>    occurs at resume from suspend).
>>>>
>>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>>>> Signed-off-by: Hua Yan <yanh@lemote.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> ---
>>>>  drivers/gpu/drm/drm_vm.c               |    2 +-
>>>>  drivers/gpu/drm/radeon/radeon_bios.c   |   32 ++++++++++++++++++++++++++++++++
>>>>  drivers/gpu/drm/radeon/radeon_device.c |    5 +++++
>>>>  drivers/gpu/drm/radeon/radeon_ttm.c    |    6 +++---
>>>>  drivers/gpu/drm/ttm/ttm_bo_util.c      |    2 +-
>>>>  include/drm/drm_sarea.h                |    2 ++
>>>>  6 files changed, 44 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
>>>> index 961ee08..3f06166 100644
>>>> --- a/drivers/gpu/drm/drm_vm.c
>>>> +++ b/drivers/gpu/drm/drm_vm.c
>>>> @@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
>>>>               tmp = pgprot_writecombine(tmp);
>>>>       else
>>>>               tmp = pgprot_noncached(tmp);
>>>> -#elif defined(__sparc__) || defined(__arm__)
>>>> +#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
>>>>       tmp = pgprot_noncached(tmp);
>>>>  #endif
>>>>       return tmp;
>>>> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
>>>> index 501f488..2630e22 100644
>>>> --- a/drivers/gpu/drm/radeon/radeon_bios.c
>>>> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
>>>> @@ -29,6 +29,7 @@
>>>>  #include "radeon_reg.h"
>>>>  #include "radeon.h"
>>>>  #include "atom.h"
>>>> +#include <asm/bootinfo.h>
>>>>
>>>>  #include <linux/vga_switcheroo.h>
>>>>  #include <linux/slab.h>
>>>> @@ -73,6 +74,32 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
>>>>       return true;
>>>>  }
>>>>
>>>> +#ifdef CONFIG_CPU_LOONGSON3
>>>> +extern u64 vgabios_addr;
>>>
>>> Ugly, is this how platform specific stuff are handled usualy ? I hope not,
>>> i would rather see a platform specific function such as loongson3_get_vga_bios.
>>
>> It could be hooked in as a pci quirk similar to how we read the vbios
>> from the legacy vga location on x86.
> Hi, Alex, the method you said is pci_fixup_video() in arch/x86/pci/fixup.c?

Correct, although you will probably need it in arch/mips/pci for your
platform.  You may want to make your quirk specific to this pci device
unless you need it for all vga chips on your platform.

Alex
