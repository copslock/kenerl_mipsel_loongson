Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 00:19:26 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:33534
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994735AbeCGXTTtHhEz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Mar 2018 00:19:19 +0100
Received: by mail-pf0-x243.google.com with SMTP id q13so1585014pff.0;
        Wed, 07 Mar 2018 15:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ShNWCl2dpmJtgpAaL3gr3WYKQQAQ9XTrwgYXR690Ph8=;
        b=hNnJ4ScSh6E7TwM4oRY9vewLesBJG2GhWnMxvxZMBwhaZJlu+8dcolFqH5+xQppX2J
         kIHYbQ+qAw70Fh7gdZpb7qUH2Ts526Z2AitaRkAggBY30NpxaAiDGlevx5kOODkmjODv
         erQ+nCqmrYeaGKrk6Nea7FVsZEBaOsJKOHZ75Rqx2u6NuJOLCjpa97FEmePce7qFYMId
         ZoIHw5nkgzA8niHud7bMkIW91UI+G/XKsRaRWQeSP+5tsbbXsJM4yMODSPFVoo1gvpOK
         HJBs0s7vlk7EfFnhmgKzyc1VGWMpMTrVTyCnu2CfgR9crvCKKYWSznhSqemWG6hEiwx9
         UYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ShNWCl2dpmJtgpAaL3gr3WYKQQAQ9XTrwgYXR690Ph8=;
        b=Ih/VAo+kQP9bDwhBDPrXBkYu41GNgrk9iwHbF4n3Y61Hr3rgbpCOwWzDdpSLlaBAQr
         K2m14lVRdoG1zHuUMC/hWr0IBzM+XWtgbrgkEQLUOu9+zHf30+bN3YY8O5nVJGufoqiQ
         8kgyvFXJEuiJCcN19ZiNGl7pj7fTG4zEHVpMlvxbFMPrxN9Mrge4Nwjligw7+kNdJego
         sKPuY/jUsgGxpAXWIF70lUqOef4rf55PdWoia82hySS6RTAthC8pgymq/0GvxQeQIOIE
         0DJdBjQGQzK8cY+7ryoVlM0zmqCrAOQ2/h8N2gpakYyRaCZNFeYiHwUCw2+/tyxeBKk+
         hxmQ==
X-Gm-Message-State: APf1xPAMll0iG+jP9qOsLt6ZmZaQAWjUT4IuUp/Cptrej1nqgXyskY2C
        bztH1TGdcV9Pttr45g4thJ0=
X-Google-Smtp-Source: AG47ELuLhU87mYeICmSaH3y5DLHm1mFD08qweygGcR2Zc/WIv63BAqlPlQQtAzWCg1wFe0RUkKffQg==
X-Received: by 10.98.137.147 with SMTP id n19mr24491056pfk.193.1520464753087;
        Wed, 07 Mar 2018 15:19:13 -0800 (PST)
Received: from [192.168.1.70] (c-73-93-215-6.hsd1.ca.comcast.net. [73.93.215.6])
        by smtp.gmail.com with ESMTPSA id z128sm27263893pfb.98.2018.03.07.15.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Mar 2018 15:19:12 -0800 (PST)
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20180307140633.26182-1-jhogan@kernel.org>
 <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
 <20180307202511.GT4197@saruman>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a6c448df-c026-dafe-6d34-801f69ca64fe@gmail.com>
Date:   Wed, 7 Mar 2018 15:19:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307202511.GT4197@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <frowand.list@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frowand.list@gmail.com
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

On 03/07/18 12:25, James Hogan wrote:
> On Wed, Mar 07, 2018 at 12:11:41PM -0800, Frank Rowand wrote:
>> I initially misread the patch description (and imagined an entirely
>> different problem).
>>
>>
>> On 03/07/18 06:06, James Hogan wrote:
>>> On dtb files which contain hyphens, the dt_S_dtb command to build the> dtb.S files (which allow DTB files to be built into the kernel) results> in errors like the following:> > bcm3368-netgear-cvg834g.dtb.S: Assembler messages:> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'> bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'> bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'
>> Please replace the following section:
>>
>>> This is due to the hyphen being used in symbol names. Replace all
>>> hyphens 
>>> with underscores in the dt_S_dtb command to avoid this problem.
>>>
>>> Quite a lot of dts files have hyphens, but its only a problem on MIPS
>>> where such files can be built into the kernel. For example when
>>> CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
>>> used (in the latter case it admitedly shouldn't really build all the
>>> dtb.o files, but thats a separate issue).
>>
>> with:
>>
>>    cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
>>    FDT (that is, the .dtb file) as binary data in the kernel image.
>>    This assembly source contains labels before and after the binary data.
>>    The label names incorporate the file name of the corresponding .dtb
>>    file.  Hyphens are not legal characters in labels, so transform all
>>    hyphens from the file name to underscores when constructing the labels.
> 
> Thanks, that is clearer.
> 
> I'll keep the paragraph about MIPS and the example configuration though,
> as I think its important information to reproduce the problem, and to
> justify why it wouldn't be appropriate to just rename the files (which
> was my first reaction).

Other than the part that says "its only a problem on MIPS".  That is
pedantically correct because no other architecture (that I am aware
of, not that I searched) currently has a devicetree source file name
with a hyphen in it, where that file is compiled into the kernel as
an asm file.  But it is potentially a problem on any architecture
to it is misleading to label it as MIPS only.


> 
>> Reviewed-by: Frank Rowand <frowand.list@gmail.com>
> 
> Thanks
> James
> 
