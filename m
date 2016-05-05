Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 19:14:13 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35084 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027844AbcEEROJtaOr5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 May 2016 19:14:09 +0200
Received: by mail-pa0-f50.google.com with SMTP id iv1so37896354pac.2;
        Thu, 05 May 2016 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UnKcE+j2KFN/DZvb2cbUR/IrEuuE99aR88rxlH75a5M=;
        b=vwgFFn9yAVs6WuEWwvMmVnTC8/L2wWWmWhs1OYyS1NedIzUZz0ZXdb8TdLBKYkKn+3
         wYvqsXycY3OzJ+yZKtY4BfzMWRgcN3vfLqVOPXNF78/8P53f6TbVmDRlL2Y9gtKhcuMB
         InAV/5Lp7kmxSydrkYmUKcK0b1fEOZ740Y5SIgsEsLBmWZDMmYWSAf3xvzQY5Oe/1hdl
         ovTpSFZVtLyxY1ZT9TGAIBZewP4NQ4ivlr29a3VBDSU0XbWWJBbNu9PUZXE12E/Ts/5C
         0Wi30oTe5JRs5cvuyaQLY91LfXEUHnFhYe+5pvOwrJvyXX/zwSYZEvoIDPaeQPggylXF
         596g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UnKcE+j2KFN/DZvb2cbUR/IrEuuE99aR88rxlH75a5M=;
        b=EThJauvKSZ3CTjiKrpAj5yDNSvJ6eKszIGfl38KRrsyJCWtL2O+9lGP+G1U6SNjO/H
         wYxzKH8trcNn7wepcCF/nGi/gyhQIdbIIPS64txr6ml+Gtkbh2lXvSxL9tjvlfVvS62b
         5SJNsTGvxsfiKtykG/p8hVaZjh+RGu8uL5wDumTIxq27N07O3BBUPCQobLu2zaddPsjX
         nAxpkc/YCnbaXhWJhQT+wM2jHFhgILETgrZJQNgtjpx0IaJckQhPw1qk1ulhF0U2Sqgs
         XbW5t6/HDGuW1ZX2Xstmq4S6WvgJuBmRc0N9SWRs4d8sNHeKG74czJRgaCMKdGV6JzBE
         ePPA==
X-Gm-Message-State: AOPr4FXXlDujB4UDRQK0SGOrEQcUR3DLvpF6UDgpA/xDufc4eyz/h8DBStSdWLCghFytpg==
X-Received: by 10.66.89.228 with SMTP id br4mr22066813pab.110.1462468443661;
        Thu, 05 May 2016 10:14:03 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id m184sm15046944pfb.22.2016.05.05.10.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 May 2016 10:14:02 -0700 (PDT)
Subject: Re: [PATCH v2 03/15] MIPS: PCI: Compatibility with ARM-like PCI host
 drivers
To:     Paul Burton <paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
 <56FB0D90.8000200@gmail.com> <20160404100940.GA21568@NP-P-BURTON>
 <572AA3A0.5080201@gmail.com> <20160505110230.GA8303@NP-P-BURTON>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        Yijing Wang <wangyijing@huawei.com>,
        John Crispin <blogic@openwrt.org>,
        Yinghai Lu <yinghai@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <572B7F56.20104@gmail.com>
Date:   Thu, 5 May 2016 10:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160505110230.GA8303@NP-P-BURTON>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 05/05/16 04:02, Paul Burton wrote:
> On Wed, May 04, 2016 at 06:36:32PM -0700, Florian Fainelli wrote:
>> Hi Paul,
>>
>> On 04/04/16 03:09, Paul Burton wrote:
>>> Hi Florian,
>>>
>>> Just an FYI, the pcie-xilinx driver I wrote this for has since been
>>> converted away from the ARM-like pci_common_init_dev & struct hw_pci to
>>> use only functions provided by the core PCI subsystem[1]. As a result
>>> I've stopped using this patch & don't plan to continue work on it.
>>> Perhaps it would be cleanest to do a similar conversion for the driver
>>> you're using?
>>
>> Yes, I did just that, but as of v4.6-rc6, I am seeing a bunch of
>> undefined references while doing so:
>>
>> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
>> (.text+0x550): undefined reference to `pcibios_plat_dev_init'
>> arch/mips/pci/built-in.o: In function `pcibios_init':
>> pci.c:(.init.text+0x6c): undefined reference to `pcibios_map_irq'
>> pci.c:(.init.text+0x78): undefined reference to `pcibios_map_irq'
>>
>> and this makes perfect sense because arch/mips/pci/pci.c is referencing
>> those functions, while I did not add anything for BMIPS_GENERIC.
>>
>> At this point, I would very much prefer that the MIPS/Linux kernel did
>> not rely on the different machines to provide those implementations
>> (though it definitively is not a big deal to add them, it just feels
>> unnecessary), I will try to cook a patch for that and provide dummy
>> fallbacks.
> 
> Hi Florian,
> 
> I've done much the same for Boston already - do these patches work for
> you?

Yep, that's exactly what I needed, this worked great with the
pcie-brcmstb.c driver, thanks!

I can re-test them once you make a formal submission for the Boston board.

Cheers!
-- 
Florian
