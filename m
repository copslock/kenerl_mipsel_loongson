Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 09:09:17 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51089 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991859AbcJNHJKAlEXU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 09:09:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To;
        bh=nhkFRpBtXQv74Uy/MFFH3SVBBXhPuACrok9Aboufdrw=; b=UM8Gr7mwQfsjBnBaDhMJI5wjqW
        Gbd+KDOKUK6dddry/qv6RNtBZI7rZlICp06w/iXbEmeWaspF/X96iNLLxcGVPXB1pBniFlu719tMo
        pWqUrhuRE7UT+SHn6TJ+R5JDCPn3MEMv2tDJJMPY5H8R7BL76YEJhMyMzssXcUiZLoFWyR9FJuIFp
        2FTL+Krn2Yp+kuGv9uZlewoO26/CN9O+1pOZ/zX0swNJZmfopSSjLRfXH3mY0dkm91blDI5/P4jmF
        /Q8StsdmRGOYnJwCFEqb7VuDKPWODGKY2JBqyjykQTtUEXpHVQ3YIHJ8TMlScXUW+dKzLQzc6Sf5P
        Yeryw3cQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56512 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1buwbz-000fut-99; Fri, 14 Oct 2016 07:08:59 +0000
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Commit 'MIPS: Malta: Use syscon-reboot driver to reboot' in -next and
 changed reset behavior
Message-ID: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
Date:   Fri, 14 Oct 2016 00:09:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
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
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55427
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

Hi Paul,

with commit 'MIPS: Malta: Use syscon-reboot driver to reboot' in -next, the value written
into the reset register is changed from 0x42 to 0x4d. Is this change on purpose,
or a copy-and-paste error from the SEAD3 changes ?

Reason for asking is that qemu only accepts a value of 0x42, which causes the reset
in qemu to fail. Question is if qemu or the new reset value is wrong.

What values are valid ? Can you shed a light ?

Second question is endianness. Even when changing the value to 0x42, the system still
did not reboot for me. After a while I found out that I needed to add "big-endian;"
to the syscon node when running a big endian image. However, when running a
little endian image, "big-endian" did not work. In that case, I had to use the default,
which is little endian.

Which makes me really wonder how this is expected to work. Does the real hardware accept
any value written into the reset register ?

Thanks,
Guenter
