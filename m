Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 15:26:23 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:34492 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010937AbaJIN0VjrcXx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 15:26:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=2/gHyzsLTqaRFZOEm05U7zQlKhS2kf6xMIiRg56L4fA=;
        b=5k181G/1XMXMtFGYcUQV7udaZag2HFlGtEObkS/YcVH+yU/klD/++9PDXAwwjq/KlXZl9Wj35D3Vri3GJAwK+OHTXTFZ4MidX7Yb92MoZoZdGUDDz6BdyRlPy7nQefTuGRtuvcZ+KsMiE5sugo22R1w0II0z7Wu2obnrFCH9Qd4=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XcDjT-000kPm-Gf
        for linux-mips@linux-mips.org; Thu, 09 Oct 2014 13:26:15 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36587 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XcDio-000j0a-Uc; Thu, 09 Oct 2014 13:25:35 +0000
Message-ID: <54368CC9.7020100@roeck-us.net>
Date:   Thu, 09 Oct 2014 06:25:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>,
 driverdevel <devel@driverdev.osuosl.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 lguest@lists.ozlabs.org, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, 
 "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
 Cris <linux-cris-kernel@axis.com>, linux-efi@vger.kernel.org, 
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 linux-m32r-ja@ml.linux-m32r.org, 
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-tegra@vger.kernel.org, 
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 openipmi-developer@lists.sourceforge.net, 
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-c6x-dev@linux-c6x.org, 
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, 
 open list:METAG ARCHITECTURE <linux-metag@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, 
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>, 
 Linux-sh list <linux-sh@vger.kernel.org>,
 xen-devel@lists.xenproject.org, 
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Stuebner <heiko@sntech.de>, 
 Romain Perier <romain.perier@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@ucw.cz>,
 Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>      <1412659726-29957-2-git-send-email-linux@roeck-us.net> <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
In-Reply-To: <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020203.54368CF7.01AB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 44
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43129
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

On 10/09/2014 04:31 AM, Geert Uytterhoeven wrote:
> On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> +int register_poweroff_handler_simple(void (*handler)(void), int priority)
>> +{
>> +       char symname[KSYM_NAME_LEN];
>> +
>> +       if (poweroff_handler_data.handler) {
>> +               lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
>> +                                  symname);
>> +               pr_warn("Poweroff function already registered (%s)", symname);
>> +               lookup_symbol_name((unsigned long)handler, symname);
>> +               pr_cont(", cannot register %s\n", symname);
>
> Doesn't %ps work to look up symbols?
>
> pr_warn("Poweroff function already registered (%ps), cannot register
> %ps\n", poweroff_handler_data.handler, handler);
>

Hi Geert,

That is great. One never stops learning. I'll use that.

Thanks!

Guenter
