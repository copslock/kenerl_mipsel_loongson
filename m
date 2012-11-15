Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 11:33:24 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:50017 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824769Ab2KOKdXE8uQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2012 11:33:23 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so581871daj.36
        for <linux-mips@linux-mips.org>; Thu, 15 Nov 2012 02:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=foA4bnW/jpycJnL7TJ5mobJzFCMHC1GQ3Skhsgnq9Zg=;
        b=auAw5TH64+yjQS3O1YALZAh58cr8M9hCuRlX3plRp+5WIiQ2E075mj67/PLmENdOMB
         KJW/Y6WGx8aiiTyt9pu4UZ2zget5dRra+ZW5Z4SLEi7AIHXKDM6YEFBjNvlYgjRbog8s
         mRS6obbVh10K6C/t/Vshp8YDEGB+jPzJliTFct/RWqg92jxarSdRT3fuLRbAEmmeKgnp
         DHUFXTqQ1NjltNRcX23IfLkWEFOpNeb4eRTjpzqX9Gb/VLJ99+aAf9XD7NUM88mwUYJC
         OZbR0jMpwXcqClhH0pOEH1Ik6yFzSeZiDjhcDxodkh3sNpBadzyLcrdPrS5xLGVdQetE
         hlaQ==
Received: by 10.68.242.9 with SMTP id wm9mr3490924pbc.7.1352975596629; Thu, 15
 Nov 2012 02:33:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.241.201 with HTTP; Thu, 15 Nov 2012 02:32:56 -0800 (PST)
In-Reply-To: <CACxGe6vUGaRG-c3Vr5Zuuohhct6hEM-AhrZ6fmFfd6nyNZdo=Q@mail.gmail.com>
References: <1351721431-26220-1-git-send-email-swarren@wwwdotorg.org>
 <20121102095801.GC17860@linux-mips.org> <20121102102335.GF2905@linux-mips.org>
 <CACxGe6vUGaRG-c3Vr5Zuuohhct6hEM-AhrZ6fmFfd6nyNZdo=Q@mail.gmail.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 15 Nov 2012 10:32:56 +0000
X-Google-Sender-Auth: YWeb62tD22qAD65bEgUigr_QRlg
Message-ID: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Stephen Warren <swarren@wwwdotorg.org>,
        Michal Marek <mmarek@suse.cz>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>,
        Rob Herring <rob.herring@calxeda.com>,
        Scott Wood <scottwood@freescale.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, linux-arch@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkO4r3baxcsig8bM8C9ezc+Cxj/YhscCmip8J93QAVkewn1q75ZX/i/TpGqlu1SZjGoUFab
X-archive-position: 35010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Thu, Nov 15, 2012 at 10:15 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, Nov 2, 2012 at 10:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Nov 02, 2012 at 10:58:01AM +0100, Ralf Baechle wrote:
>>
>>> Can you fold these MIPS bits into your patch?
>>
>> I missed Lantiq.
>>
>>   Ralf
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>>  arch/mips/cavium-octeon/Makefile | 3 ---
>>  arch/mips/lantiq/dts/Makefile    | 3 ---
>>  arch/mips/netlogic/dts/Makefile  | 3 ---
>>  3 files changed, 9 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
>> index bc96e29..6e927cf 100644
>> --- a/arch/mips/cavium-octeon/Makefile
>> +++ b/arch/mips/cavium-octeon/Makefile
>> @@ -24,9 +24,6 @@ DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
>>
>>  obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
>>
>> -$(obj)/%.dtb: $(src)/%.dts FORCE
>> -       $(call if_changed_dep,dtc)
>> -
>>  # Let's keep the .dtb files around in case we want to look at them.
>>  .SECONDARY:  $(addprefix $(obj)/, $(DTB_FILES))
>>
>> diff --git a/arch/mips/lantiq/dts/Makefile b/arch/mips/lantiq/dts/Makefile
>> index 674fca4..6fa72dd 100644
>> --- a/arch/mips/lantiq/dts/Makefile
>> +++ b/arch/mips/lantiq/dts/Makefile
>> @@ -1,4 +1 @@
>>  obj-$(CONFIG_DT_EASY50712) := easy50712.dtb.o
>> -
>> -$(obj)/%.dtb: $(obj)/%.dts
>> -       $(call if_changed,dtc)
>> diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
>> index 67ae3fe2..d117d46 100644
>> --- a/arch/mips/netlogic/dts/Makefile
>> +++ b/arch/mips/netlogic/dts/Makefile
>> @@ -1,4 +1 @@
>>  obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
>> -
>> -$(obj)/%.dtb: $(obj)/%.dts
>> -       $(call if_changed,dtc)
>
> This actually breaks MIPS builds. MIPS builds the .dtbs in the same
> directory as the .dts files. Everyone else has a dts/ subdirectory,
> which is admittedly a bit insane, but until things are resolved I've
> dropped the above MIPS hunks.
>
> MIPS /could/ be changed to also use a dts directory, but I'd actually
> rather if someone could make all the other platforms build the dtbs in
> the same directory. I've looked at it briefly, but I haven't figured
> out all the make magic needed to do it nicely.

On second thought. I'm dropping this patch entirely for now. I don't
want to put in a generic rule that expects files in weird locations.
If we can fix up all the architectures to build dtb in the dts
directory, then it is better for each architecture to have a separate
fixup patch instead of changing everyone at once.

Or how about: I could pick up the patch with only the MIPS hunk and
every other user can be fixed up independently to use the new rule.

g.
