Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 11:40:29 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49027 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491063Ab1C3Jk0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 11:40:26 +0200
Message-ID: <4D92FAE6.1000407@openwrt.org>
Date:   Wed, 30 Mar 2011 11:41:58 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Wim Van Sebroeck <wim@iguana.be>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V5 05/10] MIPS: lantiq: add watchdog support
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org> <1301470076-17279-6-git-send-email-blogic@openwrt.org> <20110330093618.GH3974@infomag.iguana.be>
In-Reply-To: <20110330093618.GH3974@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

>> * add __init to probe function
>>     
> What were the changes for V5?
>
>   

v5 was related to irq handling in the mips specific code. the wdt did
not have changes between v4 and v5

thanks for the comments, i will fold them into the next series

John
