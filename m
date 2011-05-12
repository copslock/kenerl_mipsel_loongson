Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 19:13:43 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59231 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491191Ab1ELRNj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2011 19:13:39 +0200
Message-ID: <4DCC15A1.2020103@openwrt.org>
Date:   Thu, 12 May 2011 19:15:13 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: lantiq: Add missing include to mach-easy50712.c
References: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com> <1305145347-32605-2-git-send-email-ddaney@caviumnetworks.com> <20110511212538.GB17315@linux-mips.org> <4DCB76E5.3070703@openwrt.org> <4DCC1450.6060006@caviumnetworks.com>
In-Reply-To: <4DCC1450.6060006@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips


> It is best to keep the include pushed as far to the leaves of the
> build as possible.  That makes compiling other files that need
> devices.h faster.
>
>> this got lost int he folding and i thought we fixed it yesterday
>> already .
>
> In any event I think Ralf has it sorted out now.  linux-queue is now
> building for me with no patches.

yes its solved, current queue builds and runs as expected on lantiq socs
