Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 14:51:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44305 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010762AbbDWMvVPqI6R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 14:51:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4D273D7653DBB;
        Thu, 23 Apr 2015 13:51:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Apr 2015 13:51:17 +0100
Received: from [192.168.154.77] (192.168.154.77) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 23 Apr
 2015 13:51:16 +0100
Message-ID: <5538EAC4.2010902@imgtec.com>
Date:   Thu, 23 Apr 2015 13:51:16 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] MIPS: bcm47xx: Move the BCM47XX board types under a choice
 symbol
References: <1429792093-8160-1-git-send-email-markos.chandras@imgtec.com> <CACna6rwvnWtD0T2hXju-YUFxt2iEqigj=fVkKxOC_19+=2_FzA@mail.gmail.com>
In-Reply-To: <CACna6rwvnWtD0T2hXju-YUFxt2iEqigj=fVkKxOC_19+=2_FzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47016
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

On 04/23/2015 01:33 PM, Rafał Miłecki wrote:
> On 23 April 2015 at 14:28, Markos Chandras <markos.chandras@imgtec.com> wrote:
>> Since the build system expects one of the two types to be selected,
>> it's better if we move these symbols under a new choice symbol.
> 
> Nack, it doesn't allow building kernel with *both* buses support.
> 
I see. I didn't know that this was a valid configuration. Perhaps the
choice statement needs some rework to add a third option to select both
buses.

-- 
markos
