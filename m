Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2013 17:47:28 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46495 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822318Ab3IPPr0oxQiK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Sep 2013 17:47:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 67BE1462342
        for <linux-mips@linux-mips.org>; Mon, 16 Sep 2013 17:47:21 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pfg6vedH3z4H for <linux-mips@linux-mips.org>;
        Mon, 16 Sep 2013 17:47:21 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 4AB0846233D
        for <linux-mips@linux-mips.org>; Mon, 16 Sep 2013 17:47:21 +0200 (CEST)
Message-ID: <5237280B.5070503@openwrt.org>
Date:   Mon, 16 Sep 2013 17:47:23 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ZBOOT: support LZ4 compression scheme
References: <1379346199-8462-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1379346199-8462-1-git-send-email-f.fainelli@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.09.16. 17:43 keltezéssel, Florian Fainelli írta:
> Add support for the XZ compression scheme in the ZBOOT decompression

s/XZ/LZ4/ ?

-Gabor
