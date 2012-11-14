Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 13:15:53 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35552 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823910Ab2KNMPwsoiz9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 13:15:52 +0100
Received: by mail-ob0-f177.google.com with SMTP id eh20so297216obb.36
        for <multiple recipients>; Wed, 14 Nov 2012 04:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Rh2I+Tu8YrLnCPNUJiN0iWBTbsHF3GzinhsgPTznUuQ=;
        b=SmnO9/Cxrq1zjxwEV4VPOexajAUCPt/0Ch4SI85xXh1iz+T7dJiLTaDPZwDFcH1Jvm
         5kZuSakz7H47+ly+tZVk+i6p8ecgu30bWB3H+1PLdTDlO8v+k8fcIDQb9hqoEe6u7OPn
         hri0OpYZf3qjNmEK7+w+Uhqjz0WA1Xgp6ZYNlMfIWHJyz6SdYa7ceyawZ0J0DNk7tlOy
         PoEmuGovmErIS5JhXhh8eMYxC4oYAO75UHdzrhjQhCaNw8iFv1O0u+0sfpeDg+yOewVm
         8Gz3Rw9acY5HH035lICssUK1Ek+Upm0Tbjzy0jPN6M4V3W92mjOpwzuQF7+rwW6uAMWx
         LRhQ==
Received: by 10.60.11.105 with SMTP id p9mr20352625oeb.128.1352895346392; Wed,
 14 Nov 2012 04:15:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Wed, 14 Nov 2012 04:15:26 -0800 (PST)
In-Reply-To: <50A1D6C3.2010108@wwwdotorg.org>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
 <1352638249-29298-15-git-send-email-jonas.gorski@gmail.com> <50A1D6C3.2010108@wwwdotorg.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 14 Nov 2012 13:15:26 +0100
Message-ID: <CAOiHx=mJ70_DAzJOHHc_h04Ut7NXtXcwuHS4GYfQqJsrjt=mCA@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: add empty Device Trees for all supported boards
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 13 November 2012 06:12, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>> Add empty board files for all boards supported by the legacy board
>> support.
>
>> diff --git a/arch/mips/bcm63xx/dts/96328avng.dts b/arch/mips/bcm63xx/dts/96328avng.dts
>
>> +/ {
>> +     model = "96328avng";
>> +     compatible = "96328avng";
>
> The board should be compatible with both the board name and the SoC on
> the board. I know that right now the MIPS code is choosing the DT to use
> based on the board name, but I think it's more typical to pass an
> explicit DT to the kernel, and then choose the kernel support to execute
> based on the compatible value (certainly this is the case on ARM and I
> assume other architectures too). That would require the DT content to
> include the SoC name in the compatible property, so that the kernel
> support didn't then need to contain a table of all supported board names.

I'll add the SoC name to the compatible line.

>> +     ubus@10000000 {
>> +
>> +     };
>
> Do you need to include this empty node in each file? I guess it gets
> added to in the next patch so it's not a big deal though.

It's just there so it is already present when adding blocks to it. It
is/was mainly for making reordering patches easier.

>
>> diff --git a/arch/mips/bcm63xx/dts/Kconfig b/arch/mips/bcm63xx/dts/Kconfig
>
>> +config BOARD_96328AVNG
>> +     bool "96328avng reference board"
>> +     select BCM63XX_CPU_6328
>
> Why not simply compile all DTs whenever the SoC support is enabled? I
> suppose you're trying to avoid packing all the DTs into the kernel
> image. Does it make more sense to amend the MIPS kernel boot process so
> that a single user-/firmware-selected DT is passed to the kernel, rather
> than packing the DTs into the kernel and selecting one?

The plan is to add support for an externally attached DT (but not
present yet), and eventually add support for a bootloader passed DT,
but since I don't know yet how these will work, I didn't want to add
something based on guesses.

My reasoning for allowing (de-)selecting each board is to dampen the
bloat from the dtbs - after these few blocks the combined dtbs are
already four times as large as the old board setup code including all
boards. Especially older devices are constrained to 4 or even 2 MB
flash, so every kB counts there.


Jonas
