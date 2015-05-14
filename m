Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 10:53:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22798 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011186AbbENIxvGkX6- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 10:53:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F2966FA37F758;
        Thu, 14 May 2015 09:53:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 14 May 2015 09:52:45 +0100
Received: from [192.168.154.77] (192.168.154.77) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 14 May
 2015 09:52:45 +0100
Message-ID: <5554625C.4070403@imgtec.com>
Date:   Thu, 14 May 2015 09:52:44 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix regression in reading WiFi SoC SPROM
References: <1431589370-30147-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1431589370-30147-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 05/14/2015 08:42 AM, Rafał Miłecki wrote:
> In the recent SPROM commit:
> MIPS: BCM47xx: Read board info for all bcma buses
> a proper handling of "fallback" argument has been dropped. Restore it.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
Hi,

if the "MIPS: BCM47xx: Read board info for all bcma buses" is not
upstream yet (I can't see it) it might make sense to fold this fix into
it and repost it as v2.

-- 
markos
