Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 20:46:31 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:36155 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011693AbaJ2TqZqCesL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Oct 2014 20:46:25 +0100
Received: from [IPv6:2001:470:7259:0:a135:a211:da1b:a5e0] (unknown [IPv6:2001:470:7259:0:a135:a211:da1b:a5e0])
        by hauke-m.de (Postfix) with ESMTPSA id 6DEAC200CA;
        Wed, 29 Oct 2014 20:46:25 +0100 (CET)
Message-ID: <54514410.1080707@hauke-m.de>
Date:   Wed, 29 Oct 2014 20:46:24 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Use mtd as an alternative way/API to get
 NVRAM content
References: <1414573506-10395-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1414573506-10395-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 10/29/2014 10:05 AM, Rafał Miłecki wrote:
> NVRAM can be read using magic memory offset, but after all it's just a
> flash partition. On platforms where NVRAM isn't needed early we can get
> it using mtd subsystem.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
