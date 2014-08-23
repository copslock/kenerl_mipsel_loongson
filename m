Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2014 02:24:54 +0200 (CEST)
Received: from mail-vc0-x22e.google.com ([IPv6:2607:f8b0:400c:c03::22e]:41179
        "EHLO mail-vc0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaHWAYxdJwOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 02:24:53 +0200
Received: by mail-vc0-f174.google.com with SMTP id la4so13060725vcb.19
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mvLOuHkszdZbg40OVX98FqzM2jV2IEUpJo8Elkscwz8=;
        b=Od61fNmWI2TQdZApdYpQi8mQYepw/9lLdDiNgqd3aMHBrYUrTkCzkaJaZKpLu4/ZoD
         xs3Ru0CRo5kQubtyxiMByRlX8bISle0f/9fUOBIca5sy+LoyoGV2mdDrmc6w6NzVr+h2
         Htxftj9qg8Tt9ZsNKkvq9sna12BV02AC8ldskTOFWhWqPHQcgd8RTgr4NirP8PRXxT1f
         Bnz3yk7SbbQ7vieWB9foyNhHjBa+xvsYO0g07DJRekyWo4X219NJ3bNy5nbcdIlJ2GGT
         PyPF2pjx4xyQIwqYr16wYI46bSkAsyW2IaYnsdVO2CVzsAfCtcAui1uQAnh7FbcYFEsI
         8t/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mvLOuHkszdZbg40OVX98FqzM2jV2IEUpJo8Elkscwz8=;
        b=DqWCPnMIYGStdZtempl5AVdVIyH0UkfUxLWouX4jz0gIyFTPiB/8y7MSDhxBj7PWAg
         ciSwYBHybYE1JLLYLtsfOHknPBAqyylol9E/aYFydt9DWjvntLf7Oo07c/VPss2YL5Aw
         S0hG0BhRmKC53X2p6YN/r5mncTnQlMkCiobDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mvLOuHkszdZbg40OVX98FqzM2jV2IEUpJo8Elkscwz8=;
        b=eH41ceODcUPzKeyN1aZLLbBEInIxzm9MmNXmd7FHOwk/wtc2PoCMHBeA0nWVXCfEt0
         ChTHED7y6cs6eS9eQ1rFlSG6OZt/ciTS9shZUm+rKCOmhQI2t0MOgxqSpMz7O+fZSgjI
         JXrtXVso/gNyxu0Z+1EGegAY8sje/Rm2JLpCXjeNLqhuIstHbbJcS5HPrFKhjFGFWDYY
         lTot+S+c3Jyg03OqyMqSRdAHCKcooh4dErDUzwq75kwDWZFM+V1IYkodUvJVmyeBigoJ
         if3NcpRK5CUtHmFPAockT1hFq1GeTCNUbfCs7i78pNjQOtWHU9vUAj0af8iAVfrrkExO
         EVxg==
X-Gm-Message-State: ALoCoQma6f+JQBRXLEpHK8qWPmK8i9AvIAc8F74oBuRPaJbGY0gKQCAn5SDbAKeDso1zzWusq3uX
MIME-Version: 1.0
X-Received: by 10.52.190.71 with SMTP id go7mr5201564vdc.28.1408753492490;
 Fri, 22 Aug 2014 17:24:52 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Fri, 22 Aug 2014 17:24:52 -0700 (PDT)
In-Reply-To: <CAOiHx=kLfKLZA2Nv+dn87S50209DBXRj8OgZsywXQ0MoqTVA8A@mail.gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
        <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
        <53F7AEAC.90303@gmail.com>
        <CAL1qeaEaZx0KpMpTSGqZVMZZj1VrzGY3ffRbzEdy4Aks2yHciA@mail.gmail.com>
        <CAOiHx=kLfKLZA2Nv+dn87S50209DBXRj8OgZsywXQ0MoqTVA8A@mail.gmail.com>
Date:   Fri, 22 Aug 2014 17:24:52 -0700
X-Google-Sender-Auth: JmWPpn5Oywm97Ej1OUNd6XoTeWQ
Message-ID: <CAL1qeaE4F8cN-8DPaq70AriZwRP+BM=Ekw7hr5z3kJU_6GwLzg@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Fri, Aug 22, 2014 at 4:16 PM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Sat, Aug 23, 2014 at 12:10 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> On Fri, Aug 22, 2014 at 1:57 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>>> On 08/22/2014 01:42 PM, Florian Fainelli wrote:
>>>>
>>>> On Aug 21, 2014 3:05 PM, "Andrew Bresticker" <abrestic@chromium.org
>>>> <mailto:abrestic@chromium.org>> wrote:
>>>>  >
>>>>  > To be consistent with other architectures and to avoid unnecessary
>>>>  > makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
>>>>  > and build them with a common makefile.
>>>>
>>>> I recall reading that the ARM organization for DTS files was a bit
>>>> unfortunate and should have been something like:
>>>>
>>>> arch/arm/boot/dts/<vendor>/
>>>>
>>>> Is this something we should do for the MIPS and update the other
>>>> architectures to follow that scheme?
>>>
>>>
>>> If we choose not to intermingle .dts files from all the vendors in a single
>>> directory, why do anything at all?  Currently the .dts files for a vendor
>>> are nicely segregated with the rest of the vendors code under a single
>>> directory.
>>>
>>> Personally I think things are fine as they are.  Any common code remaining
>>> in the Makefiles could be moved to the scripts directory for a smaller
>>> change.
>>
>> Assuming we don't move them to a common location just to segregate
>> them again, it makes MIPS consistent with every other architecture
>> (not just ARM!) using DT.  It also makes it easier to introduce common
>> changes later on, like the 'dtbs' or 'dtbs_install' make targets.
>
> I think having dts files under a predictable location is a good idea,
> especially if it allows common code/targets as "dtbs".
>
> Maybe a totally insane idea, but how this for having the cake and eating it too:
>
> arch/mips/boot/dts/*.dts => dts files to be built along side the kernel as .dtbs
>
> arch/mips/<mach>/*.dts => dts files built into the kernel
>
> (the ../*.dts isn't meant as they should be in the top directory, just
> somewhere in that sub tree)
>
> Because I can see a use case where you want both. For example octeon
> uses generic device tree boards to use as a basis if the bootloader
> did not provide one/is too old, but maybe also provide dts files for
> known boards, which shouldn't be included in the kernel binary itself.

I'm not sure I like having DTs in both the common and per-platform
directories, but this is a use case I've been think about as well.
What I'm thinking is: have "make dtbs" build all applicable DTBs for
the selected platform and, based on other config options, build some
subset of those DTBs in the kernel.  For example: if CONFIG_RALINK,
"make dtbs" builds all the {mt,rt}*_eval.dtb's and, when building the
kernel, one of those dtbs may be built into the kernel based on which
CONFIG_DTB_RT* option is selected (if any).  I'm not sure yet what the
cleanest way to do that is though.
