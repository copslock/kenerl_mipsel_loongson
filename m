Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2015 20:48:52 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52759 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007325AbbJTSslGHfy0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2015 20:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To; bh=CXKwR+Rp5tC4HMQfLvH3pT6WMdMPb6MaNZE81v2CwHI=;
        b=yACLnhZTJx7tCcAZ8PvG82Elwr1YASx+zJsKjfIEDzY3dtcH5rOYi7n23Dcq2C8ddE5naiEFMqTm1gfekaaKaCW7diUQ0Wqx6ioxfgNcyTxgGDLpmqV6L1vdV6I2EaZ4ADIqVrW0kc6QnOnbDXrLaDCUbSMzJiKGCjPYF6R++xM=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44430 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1Zobxa-000owM-7z; Tue, 20 Oct 2015 18:48:34 +0000
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Alex Smith <alex.smith@imgtec.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Mips build errors in next-20151020
Message-ID: <56268C80.5020903@roeck-us.net>
Date:   Tue, 20 Oct 2015 11:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Hi all,

all mips images fail to build for me in next-20151020 as follows.

Building mips:defconfig ... failed
--------------
Error log:
/tmp/cc9iCAqK.s: Assembler messages:
/tmp/cc9iCAqK.s:50: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}
/tmp/cc9iCAqK.s:374: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
make[1]: *** [arch/mips/vdso] Error 2

Toolchain is "mips-poky-linux-gcc (GCC) 4.7.2".

Do I need a new toolchain ?

Thanks,
Guenter
