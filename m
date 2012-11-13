Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 18:57:08 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37122 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823394Ab2KMR5Hsq50n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 18:57:07 +0100
Received: by mail-pb0-f49.google.com with SMTP id un15so1914363pbc.36
        for <multiple recipients>; Tue, 13 Nov 2012 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=olVNZvVUflr+i7KopeOgg1CTdH4i/jJVZWiCWvCTll0=;
        b=jnOsqPmkQDX34fiM3B8yQYMxtkgbu4uscMr+z+ebfLCjUGfd52de4OViTEB9iWsEzk
         RDw85DoU21qr9kOcGasJO8irKbAlVPfATq6J7DzP42676CVO7XWRAp1YOQYreSHcLakF
         VZJvGhexKDCipxYo2Dul3QsyfSLS4rlgA3Ynz9XeuOgYIVN8TjgsWFfWdmFawshJstEh
         mKc5NY0pYspjhUnecoGsTyA+4qd+jkQGFiY3xzQE7+jsrIQapDA27zLc+TcjhUj2Ijnq
         6dYLHyonLsWHKdHvNmaNlttLpZ4EKYAMhVqglPvLuz24+m3jMluZBKVrltwBMAgshkx8
         Jf7g==
Received: by 10.66.73.226 with SMTP id o2mr44966pav.83.1352829421048;
        Tue, 13 Nov 2012 09:57:01 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id hc4sm6279957pbc.30.2012.11.13.09.56.56
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 09:56:57 -0800 (PST)
Message-ID: <50A289E8.4030407@gmail.com>
Date:   Tue, 13 Nov 2012 09:56:56 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Stephen Warren <swarren@wwwdotorg.org>
CC:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [RFC] MIPS: BCM63XX: add simple Device Tree includes for all
 SoCs
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-3-git-send-email-jonas.gorski@gmail.com> <50A1D290.3050409@wwwdotorg.org>
In-Reply-To: <50A1D290.3050409@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/12/2012 08:54 PM, Stephen Warren wrote:
> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>> Add simple Device Tree include files for all currently supported SoCs.
>> These will be populated with device definitions as driver support
>> gets added.
>
>>   arch/mips/bcm63xx/dts/bcm6328.dtsi |   30 ++++++++++++++++++++++++++++++
>>   arch/mips/bcm63xx/dts/bcm6338.dtsi |   30 ++++++++++++++++++++++++++++++
>>   arch/mips/bcm63xx/dts/bcm6345.dtsi |   30 ++++++++++++++++++++++++++++++
>>   arch/mips/bcm63xx/dts/bcm6348.dtsi |   30 ++++++++++++++++++++++++++++++
>>   arch/mips/bcm63xx/dts/bcm6358.dtsi |   33 +++++++++++++++++++++++++++++++++
>>   arch/mips/bcm63xx/dts/bcm6368.dtsi |   33 +++++++++++++++++++++++++++++++++
>
> All of ARM, c6x, microblaze, openrisc, powerpc put device tree files
> into arch/${arch}/boot/dts/ - should MIPS follow the same layout?

At this point, I don't see what the benefit of centralizing all of these 
would be.  Currently there is no concept of a single kernel image that 
would work across multiple MIPS system implementations.  So keeping the 
DTS files with their users makes some organizational sense.

Similar arguments could be made for moving all the files in `find . 
-name \*.dts\*` to a top level dts/ directory.

David Daney
