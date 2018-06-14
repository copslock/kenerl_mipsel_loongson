Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2018 16:09:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994674AbeFNOJmFMI5y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jun 2018 16:09:42 +0200
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D71A208DB
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2018 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985375;
        bh=FO48a2zJQFE3s5ew5+6pO930bfZJRPJk+gTs/h5A5tI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NRYzIZF9oErkXIq1D4HJPZJfl+qwZKCVwKKhILM5Hlh9oUVYjyyLEWcqL9PHlwlDi
         nNFQ2IDBDLdjOQJwdqLQcEbrN6iUkfVB/qRoKsnV+3Lgz6kWMJ10Iv7fOo1PTeTEU5
         3GwNCo3txoRVNO+VYk3nSmzYLwSXxBlzheU2LKQs=
Received: by mail-it0-f50.google.com with SMTP id u4-v6so8526636itg.0
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2018 07:09:35 -0700 (PDT)
X-Gm-Message-State: APt69E1dgSoOaDugGwGtF6lgjEcZjiscu0h8YffNCaZNWtJrileyt5o/
        vlmOxv4S+ytdH37+tlfAeNZ6h64mfMCiU3cPyg==
X-Google-Smtp-Source: ADUXVKLj6YUS3cdZa9WfyRpgtMeXDgikRwomzuRyYj8Ue/UXGVE5KjYG6CPGRj0n53s0lv/zN2AM0u+RwTu3aqL7Whs=
X-Received: by 2002:a24:ec44:: with SMTP id g65-v6mr2515174ith.18.1528985374889;
 Thu, 14 Jun 2018 07:09:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:09:14
 -0700 (PDT)
In-Reply-To: <41163f48-ce5c-efae-2b6d-b93d75e422e5@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-3-songjun.wu@linux.intel.com> <20180612223725.GC2197@rob-hp-laptop>
 <41163f48-ce5c-efae-2b6d-b93d75e422e5@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Jun 2018 08:09:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJVcKPexrVrnGnr-zga1n6n00nYdUmKZWOz2VQJ7BV-oA@mail.gmail.com>
Message-ID: <CAL_JsqJVcKPexrVrnGnr-zga1n6n00nYdUmKZWOz2VQJ7BV-oA@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
To:     yixin zhu <yixin.zhu@linux.intel.com>
Cc:     Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
        chuanhua.lei@linux.intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>, qi-ming.wu@intel.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Thu, Jun 14, 2018 at 2:40 AM, yixin zhu <yixin.zhu@linux.intel.com> wrote:
>
>
> On 6/13/2018 6:37 AM, Rob Herring wrote:
>>
>> On Tue, Jun 12, 2018 at 01:40:29PM +0800, Songjun Wu wrote:
>>>
>>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>>
>>> PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below

[...]

>>> +Example:
>>> +       clkgate0: clkgate0 {
>>> +               #clock-cells = <1>;
>>> +               compatible = "intel,grx500-gate0-clk";
>>> +               reg = <0x114>;
>>> +               clock-output-names = "gate_xbar0", "gate_xbar1",
>>> "gate_xbar2",
>>> +               "gate_xbar3", "gate_xbar6", "gate_xbar7";
>>> +       };
>>
>>
>> We generally don't do a clock node per clock or few clocks but rather 1
>> clock node per clock controller block. See any recent clock bindings.
>>
>> Rob
>
> Do you mean only one example is needed per clock controller block?
> cpuclk is not needed in the document?

No, I mean generally we have 1 DT node for the h/w block with all the
clock control registers rather than nodes with a single register and 1
or a couple of clocks. Sometimes the clock registers are mixed with
other functions which complicates things a bit. But I can't tell that
here because you haven't documented what's in the rest of the register
space.

Rob
