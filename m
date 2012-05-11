Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 21:34:29 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:57693 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903563Ab2EKTeZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 21:34:25 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 243006412;
        Fri, 11 May 2012 13:36:09 -0600 (MDT)
Received: from [10.20.204.51] (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 773B6E461C;
        Fri, 11 May 2012 13:34:21 -0600 (MDT)
Message-ID: <4FAD69BC.20204@wwwdotorg.org>
Date:   Fri, 11 May 2012 13:34:20 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
References: <1336652846-31871-1-git-send-email-blogic@openwrt.org> <1336652846-31871-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1336652846-31871-2-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5pre
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 33271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/10/2012 06:27 AM, John Crispin wrote:
> Implement support for pinctrl on lantiq/xway socs. The IO core found on these
> socs has the registers for pinctrl, pinconf and gpio mixed up in the same
> register range. As the gpio_chip handling is only a few lines, the driver also
> implements the gpio functionality. This obseletes the old gpio driver that was
> located in the arch/ folder.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>

I think this is OK, so
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
