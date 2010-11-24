Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 21:29:02 +0100 (CET)
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41249 "EHLO
        na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab0KXU2m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 21:28:42 +0100
Received: from source ([209.85.216.170]) (using TLSv1) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
        ID DSNKTO11cbmIaIv+20ohfyxYiDH/DyWkX5Jc@postini.com; Wed, 24 Nov 2010 12:28:42 PST
Received: by mail-qy0-f170.google.com with SMTP id 10so3568272qyk.15
        for <multiple recipients>; Wed, 24 Nov 2010 12:28:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.91.194 with SMTP id o2mr7950058qcm.250.1290630512831; Wed,
 24 Nov 2010 12:28:32 -0800 (PST)
Received: by 10.220.194.74 with HTTP; Wed, 24 Nov 2010 12:28:32 -0800 (PST)
In-Reply-To: <4CED5F83.6070301@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
        <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
        <AANLkTikQ=oen3jmz=BfY7y=s6Qo7R8DQ1-79puby-Snt@mail.gmail.com>
        <4CED5F83.6070301@openwrt.org>
Date:   Wed, 24 Nov 2010 15:28:32 -0500
Message-ID: <AANLkTinjRRkpzEmgCzNpKTkSNwTr30M5KdHHEQ33Y11R@mail.gmail.com>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
From:   Ben Gardiner <bengardiner@nanometrics.ca>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <bengardiner@nanometrics.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bengardiner@nanometrics.ca
Precedence: bulk
X-list: linux-mips

Hi Gabor,

On Wed, Nov 24, 2010 at 1:54 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> Hi Ben,
>> [...]
>> Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>
>
> Thanks!

You are most welcome.

>[...]
>
> Thank you for the valuable comments. I will create a new patch.

Actually, I've done a little hacking on the patch here while
integrating with the da850-evm changes. I will post the series here,
feel free to pick an choose the changes as you see fit -- hopefully it
can save you some time.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
