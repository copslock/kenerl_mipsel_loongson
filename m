Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 21:05:34 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:56443 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827297AbaAOUFbt2bPr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jan 2014 21:05:31 +0100
Received: by mail-pd0-f181.google.com with SMTP id p10so1574863pdj.12
        for <multiple recipients>; Wed, 15 Jan 2014 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Q921tOot2HkQznTMfP0gj26/eRDOj7j00b7FZqr3Q4c=;
        b=LiRdLwGzociZEVFWPPXM9Kfb3SixM4pxeugYvHh/NuRNcKHNnLYhuFTyYB72SQNL/a
         HIpLaTv+vo8B6uF6HbXpM9b4oASoN9gR4w6XCK/C2gOAsFD2ergIzEdZr8PF1i91QxDZ
         VjB/CRatrJW1dHoTuadLLMRmGc066jCGChuD/ZIiT1KwFyuYSx0IBoF3qpRbfsEOT78/
         cNf8gOU5KBM6DXa6ZpMuq+IC1DFITCntDTqaXSkoy48uqdQo6eIRMEuN7L+yVvcTNRCU
         N+Mj5tHRjOUTPoz11BTP88p6yZc6DEKzak3vr5Gf070L7wGis6DnXbUVjXcSJM83eYQ7
         yqVA==
X-Received: by 10.68.17.7 with SMTP id k7mr4939616pbd.119.1389816324873; Wed,
 15 Jan 2014 12:05:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Wed, 15 Jan 2014 12:04:44 -0800 (PST)
In-Reply-To: <52D6DD74.60308@caviumnetworks.com>
References: <1389812784-30085-1-git-send-email-florian@openwrt.org> <52D6DD74.60308@caviumnetworks.com>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 15 Jan 2014 12:04:44 -0800
X-Google-Sender-Auth: SgFuumjJKHZxY0kUiiMveENfoik
Message-ID: <CAGVrzcYQaY=0ciN-__sU34idRaiU71Sca190HTtcRkrO7-0mzg@mail.gmail.com>
Subject: Re: [PATCH mips-for-linux-next] MIPS: check for -mfix-cn63xxp1
 compiler option
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>, david.daney@cavium.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014/1/15 David Daney <ddaney@caviumnetworks.com>:
> On 01/15/2014 11:06 AM, Florian Fainelli wrote:
>>
>> Attempting to build for Cavium Octeon with an unpatched or old
>> toolchain will fail due to the -mfix-cn63xxp1 option being unrecognized.
>> Call cc-option on this option to make sure we can safely use it.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>
>
> NACK.
>
> If the chip you are building for needs -Wa,-mfix-cn63xxp1, then building
> without this option yields a system the generates random errors.  So I would
> argue that if -Wa,-mfix-cn63xxp1 is not supported by your assembler,
> breaking the build is the proper thing to do.

Fair enough. Maybe the condition should be refined to be based off
CONFIG_CAVIUM_CN63XXP1?
-- 
Florian
