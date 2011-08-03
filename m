Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 20:40:42 +0200 (CEST)
Received: from void.printf.net ([89.145.121.20]:38955 "EHLO void.printf.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S2100417Ab1HCSke (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Aug 2011 20:40:34 +0200
Received: from 173-166-109-241-newengland.hfc.comcastbusiness.net ([173.166.109.241] helo=bob.laptop.org)
        by void.printf.net with esmtp (Exim 4.69)
        (envelope-from <cjb@laptop.org>)
        id 1QogMr-0006ve-CV; Wed, 03 Aug 2011 19:40:33 +0100
From:   Chris Ball <cjb@laptop.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 12/15] MMC: au1xmmc: remove Alchemy CPU subtype dependencies
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
        <1312307470-6841-13-git-send-email-manuel.lauss@googlemail.com>
        <20110803120627.GA856@linux-mips.org>
Date:   Wed, 03 Aug 2011 14:40:26 -0400
In-Reply-To: <20110803120627.GA856@linux-mips.org> (Ralf Baechle's message of
        "Wed, 3 Aug 2011 13:06:27 +0100")
Message-ID: <m2y5za5of9.fsf@bob.laptop.org>
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 30828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cjb@laptop.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2557

Hi Ralf,

On Wed, Aug 03 2011, Ralf Baechle wrote:
> On Tue, Aug 02, 2011 at 07:51:07PM +0200, Manuel Lauss wrote:
>
>> Replace all occurrences of CONFIG_SOC_AU1??? with runtime feature
>> detection.
>> 
>> Cc: <linux-mmc@vger.kernel.org>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> I'd like for this patch to go in via the mips tree since a few more depend
>> on it.
>
> Patch is looking ok.  Since MMC is orphaned I've just queued it and it
> will go to linux-next after -rc1.

MMC isn't orphaned anymore -- I've been maintaining it for a year.  Feel
free to merge this yourself since there are dependency issues, though:

Acked-by: Chris Ball <cjb@laptop.org>

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
