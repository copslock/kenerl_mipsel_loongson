Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 13:22:32 +0100 (CET)
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:59623 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011536AbbBDMWbOpnOt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 13:22:31 +0100
Received: from cpsps-ews28.kpnxchange.com ([10.94.84.194]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 13:22:25 +0100
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews28.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 13:22:25 +0100
Received: from x41 ([77.173.140.92]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 13:22:25 +0100
Message-ID: <1423052553.30076.6.camel@tiscali.nl>
Subject: Re: watchdog: SOC_MT7621?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>,
        Ralf Baechle <ralf@linux-mips.org>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Feb 2015 13:22:33 +0100
In-Reply-To: <54D1FE0F.3030308@openwrt.org>
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>
         <1423047893.23022.13.camel@x220> <54D1FE0F.3030308@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10 (3.12.10-1.fc21) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2015 12:22:25.0968 (UTC) FILETIME=[3C3C4B00:01D04075]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

John Crispin schreef op wo 04-02-2015 om 12:10 [+0100]:
> i think wim should just drop it and we leave it in openwrt with the
> other 1/2 million patches that we have. i prefer to upstream the stuff
> without feeling pressured to hurry up, that kills the fun.

Once code is mainlined you'll get fixes written for you, updates done
for you, etc. But you'll also get pointed at defects that require you to
fix them yourself, or see the code removed eventually.

> @Wim, can you drop the patch please ?

Why should Wim drop more than the
    || SOC_MT7621

snippet?


Paul Bolle
