Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 14:19:17 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35406 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991859AbcHLMTKc5tlI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 14:19:10 +0200
Received: by mail-pf0-f196.google.com with SMTP id h186so1484488pfg.2;
        Fri, 12 Aug 2016 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2aXj68HsIeGF+7IfOj1UIb2N+BinTp4CoYAGdmU4kJ0=;
        b=USpTOJ+XVyU04sYbSsTwfvmOc/R0jK13UdSVRnp0jRbawe8n1mntX9jH24rNJL/Uay
         XLARsWHBtpyMpbxnrOUPyTQ/V6N5+DK3Vrc33HSvOH+o6iT5qdmLmhWUn0OGykvdWaLe
         QKIXHF5FSWqAH2gKvF3cmGInZSBCukZA6tfTFSq1J1yD0SAP5kJJTrytP48BR+0mBp8H
         1brNk6dKJbxI+VQuSo5stsrARAJ/3pyVnJNXedktzw0RTkFVy8ap76FIF6pmgH5oc8bj
         0P/k/6Df25UoBhxPM5B4r11VXcy8C6EH2Vze7F7NOMSTLfpqB3XdrZPlS2DbnpNuR62d
         HF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2aXj68HsIeGF+7IfOj1UIb2N+BinTp4CoYAGdmU4kJ0=;
        b=eMgCXb4pzZGCGpZr1AeC1kGaCVMvWNTsfL+zVqmauJoz09LvaouA7OkwaXgTlQPcWy
         y6FgaN2hVLSPFm+4ZNcdSy7yF/f66yS2O0158obpMMukEXPfP2bweCqI9zXD133dfyUK
         2VjVAYyg0U6l+Ys/hSDS1ZZVLiJXwqNp3nDkvxV93bIS8IuMuJH/0FWw5JmpB9anX8yz
         04VmXX7AlOMs3e8G6+DjsmB1cpPPY7fqmI+tZ9E5Pj10vIlpZSAci+h9ZvTUnBvqWT+U
         bFeX0e/tHorPNWjd3fU/9aWOw+9oKyKE5qZx4jnvUBAhtC7FBWUcoFe7EQX5HV2GrAkg
         3gdg==
X-Gm-Message-State: AEkooutVSQQZ4wFHNzcTDeMPzsJu55CsHCkLI/zyZUqRRKV6ctI96BQa4QWYS4tRPi7gVQ==
X-Received: by 10.98.71.91 with SMTP id u88mr26629313pfa.145.1471004344552;
        Fri, 12 Aug 2016 05:19:04 -0700 (PDT)
Received: from [192.168.0.100] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id i137sm12747354pfe.64.2016.08.12.05.19.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 05:19:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [v3 0/5] Add device nodes for BCM7xxx SoCs
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAOiHx=ke2CC9tm6Rn01A5UAGRscb1QJGWq-som74r5UO5_g9EA@mail.gmail.com>
Date:   Fri, 12 Aug 2016 21:19:00 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 7bit
Message-Id: <293A0898-C1DE-4275-9293-5BE29FC61018@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com> <CAOiHx=ke2CC9tm6Rn01A5UAGRscb1QJGWq-som74r5UO5_g9EA@mail.gmail.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Jonas,

On Aug 12, 2016, at 7:51 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> 
> Hi,
> 
> On 12 August 2016 at 10:52, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.
>> 
>> The NAND device nodes have common file including chip select, BCH
>> and partitions for the reference board with the same properties.
>> 
>> Changes in v3:
>> - Fixed incorrect interrupt number in aon_pm_l2_intc.
>> 
>> Changes in v2:
>> - Removed status properties in always enabled GPIO nodes.
>> - Removed NAND nodes for v3.3 brcmnand controller.
>> - Renamed interrupt-controller instead of lable string.
>> - Renamed bcm97xxx-nand-cs1-bch8.dtsi
>> 
>> Jaedon Shin (5):
>>  MIPS: BMIPS: Add support PWM device nodes
>>  MIPS: BMIPS: Add support GPIO device nodes
>>  MIPS: BMIPS: Add support SDHCI device nodes
>>  MIPS: BMIPS: Add support NAND device nodes
>>  MIPS: BMIPS: Use interrupt-controller node name
> 
> Please directly add the interrupt controller names with the correct
> name instead of fixing them up later.
> 
> Also please CC devicetree@vger for device tree related patches.
> 
> 
> Regards
> Jonas

The last commit "MIPS: BMIPS: Use interrupt-controller node name" has 
on all changes about interrupt-controller@ not only your comments.
I think it is needed for consistency and historicity.

Thanks,
Jaedon
