Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 12:48:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19720 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991977AbcJYKrw2Z0w5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 12:47:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 708C266BEDCBF;
        Tue, 25 Oct 2016 11:47:43 +0100 (IST)
Received: from [10.20.78.214] (10.20.78.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 25 Oct 2016
 11:47:45 +0100
Date:   Tue, 25 Oct 2016 11:47:36 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] mfd: syscon: Support native-endian regmaps
In-Reply-To: <20161014091732.27536-1-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1610251147060.31859@tp.orcam.me.uk>
References: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net> <20161014091732.27536-1-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.214]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 14 Oct 2016, Paul Burton wrote:

> The regmap devicetree binding documentation states that a native-endian
> property should be supported as well as big-endian & little-endian,
> however syscon in its duplication of the parsing of these properties
> omits support for native-endian. Fix this by setting
> REGMAP_ENDIAN_NATIVE when a native-endian property is found.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---

Tested-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
