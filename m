Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 17:08:03 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43952 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815858Ab3HIPH7oJTqb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 17:07:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 7284542192D;
        Fri,  9 Aug 2013 17:07:53 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PfJ1-vTidfKO; Fri,  9 Aug 2013 17:07:53 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 6909142192C;
        Fri,  9 Aug 2013 17:07:51 +0200 (CEST)
Message-ID: <520505E6.3070204@openwrt.org>
Date:   Fri, 09 Aug 2013 17:08:22 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
References: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37495
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

2013.08.08. 11:31 keltezéssel, John Crispin írta:
> Add a driver for the watchdog timer found on Ralink SoC
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
