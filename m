Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2015 10:52:52 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34179 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008429AbbFYIwuw4RHo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2015 10:52:50 +0200
Received: by pabvl15 with SMTP id vl15so46160714pab.1;
        Thu, 25 Jun 2015 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TI+hwZhLraoVU4yjfONfgODi4FBgavxiHm1RGEAE9gU=;
        b=U+DUkZP19JIweZNjnbjzqfK2Qh2/hu2vVrY6Nmu1sAokvbrhZIRKHrGVPOucJ55jJf
         YZy2gtiD8+CQ/IQkTT3V6AyJzJX+Cj9eKle+UG+SzLK9L92QXpyxP4wI7WkWeQn/j98g
         vDS+efGoB+m6LqQAPiSjq2rzszfdc0jChfdaCEy26uYM2wuTJPzVigo5/yJZ74/dWsnn
         +ow53Q/07ed22YPGx46EVYK/37MyFYNahVQn0b/4WG8/x8fg5OG6OzHGwThl+WUlS29U
         88QcjTv+m4rtpXOU24X74tkb3BpuDqjxBTMO5ZiU+zRdk3C6zaazvlFxZpxIePDe8UsE
         vG5g==
X-Received: by 10.70.93.36 with SMTP id cr4mr87642746pdb.68.1435222363377;
        Thu, 25 Jun 2015 01:52:43 -0700 (PDT)
Received: from [192.168.10.56] ([121.169.200.32])
        by mx.google.com with ESMTPSA id ho10sm29225882pbc.27.2015.06.25.01.52.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 01:52:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 1/4] MIPS: BMIPS: bcm7346: add nodes for NAND
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <558B05B7.8010401@gmail.com>
Date:   Thu, 25 Jun 2015 17:52:37 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, computersforpeace@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <EFAFA0BE-CC2F-4342-9C89-DED8EC6CF377@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com> <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com> <558B05B7.8010401@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.2102)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48026
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


> On Jun 25, 2015, at 4:32 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> +Brian,
> 
> On 23/06/15 23:08, Jaedon Shin wrote:
>> Add NAND device nodes to BMIPS based BCM7346 platform.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
> 
> [snip]
> 
>> +
>> +&nand0 {
>> +	status = "okay";
>> +
>> +	nandcs@1 {
>> +		compatible = "brcm,nandcs";
>> +		reg = <1>;
>> +		nand-ecc-step-size = <512>;
>> +		nand-ecc-strength = <8>;
>> +		nand-on-flash-bbt;
>> +
>> +		#size-cells = <2>;
>> +		#address-cells = <2>;
>> +
>> +		flash1.rootfs0@0 {
>> +			reg = <0x0 0x0 0x0 0x80000000>;
>> +		};
>> +
>> +		flash1.rootfs1@80000000 {
>> +			reg = <0x0 0x80000000 0x0 0x80000000>;
>> +		};
>> +	};
>> +};
> 
> Should we create something like brcmnand-cs1-512-8 to reduce the amount
> of duplication between DTS files?
> -- 
> Florian

I Think that is not duplication.

I have no reference boards, but this node is maybe explaining for hardware
description of the BCM97346DBSMB reference board. The nodes are changed by
EBI CS and ECC capabilities of NAND flash. I used brcmnand-cs2-512-4 and
brcmnand-cs1-512-4 for others.
