Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2015 18:34:07 +0100 (CET)
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:51952 "EHLO
        cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012573AbbBNReFb4XeZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Feb 2015 18:34:05 +0100
Received: from cpsps-ews04.kpnxchange.com ([10.94.84.171]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:34:00 +0100
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:34:00 +0100
Received: from [192.168.10.104] ([77.173.140.92]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:33:59 +0100
Message-ID: <1423935239.9418.25.camel@x220>
Subject: Re: MIPS: FP32XX_HYBRID_FPRS
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 14 Feb 2015 18:33:59 +0100
In-Reply-To: <1423933022.9418.8.camel@x220>
References: <1423933022.9418.8.camel@x220>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2015 17:33:59.0653 (UTC) FILETIME=[6AABC150:01D0487C]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45818
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

On Sat, 2015-02-14 at 17:57 +0100, Paul Bolle wrote:
> Your d8fb6537f1d4 ("MIPS: kernel: elf: Improve the overall ABI and FPU
> mode checks") is included in yesterday's linux-next (ie, next-20150213).
> I noticed because a script I use to check linux-next spotted a minor
> problem with it.
> 
> That commit removed the only user of Kconfig symbol FP32XX_HYBRID_FPRS.
> Setting FP32XX_HYBRID_FPRS is now pointless in linux-next. Is the
> trivial commit to its entry form arch/mips/Kconfig.debug queued
           [....] to remove its entry from [...] 

> somewhere?


Paul Bolle
