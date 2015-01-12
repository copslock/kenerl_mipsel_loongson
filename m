Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 13:32:17 +0100 (CET)
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:63097 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010604AbbALMcNzNaQM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 13:32:13 +0100
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 12 Jan 2015 13:32:08 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 12 Jan 2015 13:32:08 +0100
Received: from [192.168.10.106] ([77.173.140.92]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 12 Jan 2015 13:32:07 +0100
Message-ID: <1421065927.22660.61.camel@x220>
Subject: Re: MIPS: ralink: CONFIG_SOC_RT2880?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jan 2015 13:32:07 +0100
In-Reply-To: <1414404391.28499.10.camel@x220>
References: <1414404391.28499.10.camel@x220>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2015 12:32:07.0887 (UTC) FILETIME=[C795D5F0:01D02E63]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45085
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

John,

On Mon, 2014-10-27 at 11:06 +0100, Paul Bolle wrote:
> Your commit 0b162e003c2c ("MIPS: ralink: add rt2880 pci driver") landed
> in today's linux-next (ie, next-20141027). It adds a check for
> CONFIG_SOC_RT2880. But there's no Kconfig symbol SOC_RT2880.
> 
> Did you perhaps mean CONFIG_SOC_RT288X here?

This too ended up in v3.19-rc1 and later. There's still no Kconfig
symbol SOC_RT2880 and therefor arch/mips/pci/pci-rt2880.o will never be
built. Can someone please look into this?

Thanks,


Paul Bolle
