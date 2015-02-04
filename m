Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 12:05:01 +0100 (CET)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:50818 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011464AbbBDLFAEUy2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 12:05:00 +0100
Received: from cpsps-ews08.kpnxchange.com ([10.94.84.175]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 12:04:54 +0100
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews08.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 12:04:54 +0100
Received: from [192.168.10.108] ([77.173.140.92]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 12:04:53 +0100
Message-ID: <1423047893.23022.13.camel@x220>
Subject: Re: watchdog: SOC_MT7621?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>,
        Ralf Baechle <ralf@linux-mips.org>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Feb 2015 12:04:53 +0100
In-Reply-To: <54D1F248.4090406@openwrt.org>
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2015 11:04:54.0003 (UTC) FILETIME=[6772C430:01D0406A]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45647
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

On Wed, 2015-02-04 at 11:19 +0100, John Crispin wrote:
> On 04/02/2015 11:13, Paul Bolle wrote:
> > Is SOC_MT7621 still being worked on?
> 
> yes we dropped the series as it collided with the gic rework that
> chromiun.org was working on. i hope to push it during the next merge
> window. the 1004k support has just been flaky till now as there was
> never any real silicon to test it on. the chromium people really did a
> good job at making the gic code nicer.

Thanks for explaining this. Unless SOC_MT7621 takes a long time to land
in linux-next I won't be bothering you again about this. (I think I'll
use "by the end of the v3.20 series" as a definition of a long time.)

> quite an impressive Cc list you have there

Yes, that's the way it works with problems that span two (or more)
subsystems (in this case watchdog and MIPS). Actually, much longer CC
lists are used regularly on lkml.

Thanks!


Paul Bolle
