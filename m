Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 22:02:03 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:36342 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012329AbaJ3VCAZd5an (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Oct 2014 22:02:00 +0100
Received: from [IPv6:2001:470:7259:0:70bc:d27b:fe89:f234] (unknown [IPv6:2001:470:7259:0:70bc:d27b:fe89:f234])
        by hauke-m.de (Postfix) with ESMTPSA id 17E78200CA;
        Thu, 30 Oct 2014 22:02:00 +0100 (CET)
Message-ID: <5452A747.6000108@hauke-m.de>
Date:   Thu, 30 Oct 2014 22:01:59 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Clean up nvram header
References: <1414669803-15280-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1414669803-15280-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43795
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

On 10/30/2014 12:50 PM, Rafał Miłecki wrote:
> 1) Move private defines to the .c file
> 2) Move SPROM helper to the sprom.c
> 3) Drop unused code
> 4) Rename magic to the NVRAM_MAGIC
> 5) Add const to the char pointer we never modify
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> This is based on top of
> [PATCH] MIPS: BCM47XX: Use mtd as an alternative way/API to get NVRAM content

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
