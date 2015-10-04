Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2015 07:06:39 +0200 (CEST)
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:33777 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006648AbbJDFGcvCHMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2015 07:06:32 +0200
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-11v.sys.comcast.net with comcast
        id Qt6V1r00256HXL001t6VMG; Sun, 04 Oct 2015 05:06:29 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-12v.sys.comcast.net with comcast
        id Qt6T1r0020w5D3801t6TFa; Sun, 04 Oct 2015 05:06:29 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: Random IP27 Tests on 4.3.0-rc3
X-Enigmail-Draft-Status: N1110
Message-ID: <5610B3BB.6090406@gentoo.org>
Date:   Sun, 4 Oct 2015 01:06:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1443935189;
        bh=IwHzKrin6N2sJPY/Yh4EFuRp1ZGliABUeDhyzPYanCk=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=A7zb0KbXMcFqdeHYzTZtAAuVdK1vSpuyhbDZMheVE1Ed2auIw6jitCanKTIg0cn0o
         5U24all5vpcqYKunjse2RBG8BN2hKViMfMJXZAn37yNWQZdCor1bCxlKwilBd2qcfQ
         9o/89fHN4N4xSYtQjaZd9l0Zn4jEIlKohm1JVqzREzRlEMLEJzcDT7O6bDWuHFiXQe
         9jwC2FQ4pW7xUl+FF7VZNwn5CWmxEe4q/+hJ7lixElIxdNIzZM0hO/aMgaY3LSB3KM
         ABt7z7koh9G0X331hWoJqtYysmlSddgIWLxXk0RBeqmsziTX4qIdsg640owT/WXiDg
         VPJAIFpp5rJIg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Has anyone else tested the below various kernel modes on IP27 hardware?  Same
observations?

CONFIG_SGI_SN_M_MODE=y
- Boots, works, until the hardlock bug bites.

CONFIG_SGI_SN_N_MODE=y
- Appears to boot, but crashes early.  This message is left on the MSC console:
    2A 000: *** TLB Refill Exception on node 0
    2A 000: *** EPC: 0xa80000000001d890 (0xa80000000001d890)
    2A 000: *** Press ENTER to continue.

CONFIG_MAPPED_KERNEL=y
CONFIG_REPLICATE_KTEXT=y
- Does not boot, give this classic (and annoying) error:
    Cannot load bootp():.
    Text start 0x1c000, size 0x1965a70 doesn't fit in a FreeMemory area.
    Unable to execute bootp()::  not enough space

CONFIG_REPLICATE_EXHANDLERS=y
- Appears to boot, but crashes early.  MSC error:
    2A 000: *** TLB Refill Exception on node 0
    2A 000: *** EPC: 0x0 (0x0)
    2A 000: *** Press ENTER to continue.


CONFIG_NUMA=y is true for all tests above, because that seemingly staves off
the hardlock bug a little longer....though mdraid seems to really exacerbate
the thing now.

--J
