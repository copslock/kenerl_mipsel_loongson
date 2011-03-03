Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 12:57:39 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:55216 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491076Ab1CCL5g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Mar 2011 12:57:36 +0100
Message-ID: <4D6F827B.8040902@openwrt.org>
Date:   Thu, 03 Mar 2011 12:58:51 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3 05/10] MIPS: lantiq: add watchdog support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-6-git-send-email-blogic@openwrt.org> <4D6F7F1C.5040001@mvista.com>
In-Reply-To: <4D6F7F1C.5040001@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips


>> +    /* write the first paswword magic */
>                               ^
>    You still didn't fix the typo here. :-)
>

Hi,

grml... changed it in the wrong folder :) i'll add it for the V4

thanks,
John
