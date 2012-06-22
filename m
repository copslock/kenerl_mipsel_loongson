Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 19:54:28 +0200 (CEST)
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:38652
        "EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903701Ab2FVRyV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2012 19:54:21 +0200
Received: from mail185-va3-R.bigfish.com (10.7.14.249) by
 VA3EHSOBE004.bigfish.com (10.7.40.24) with Microsoft SMTP Server id
 14.1.225.23; Fri, 22 Jun 2012 17:52:44 +0000
Received: from mail185-va3 (localhost [127.0.0.1])      by
 mail185-va3-R.bigfish.com (Postfix) with ESMTP id C5D751605AB; Fri, 22 Jun
 2012 17:52:43 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.234.149;KIP:(null);UIP:(null);IPV:NLI;H:SN2PRD0710HT005.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -5
X-BigFish: PS-5(zzbb2dI98dI9371I1432I4015Izz1202hzzz2dh2a8h668h839hd25he5bhf0ah)
Received: from mail185-va3 (localhost.localdomain [127.0.0.1]) by mail185-va3
 (MessageSwitch) id 1340387562242196_25333; Fri, 22 Jun 2012 17:52:42 +0000
 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.250]) by
 mail185-va3.bigfish.com (Postfix) with ESMTP id 2C63136004C;   Fri, 22 Jun 2012
 17:52:42 +0000 (UTC)
Received: from SN2PRD0710HT005.namprd07.prod.outlook.com (157.56.234.149) by
 VA3EHSMHS010.bigfish.com (10.7.99.20) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 22 Jun 2012 17:52:39 +0000
Received: from dd1.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.118.40) with Microsoft SMTP Server (TLS) id 14.16.164.8; Fri, 22 Jun
 2012 17:54:08 +0000
Message-ID: <4FE4B13E.10709@caviumnetworks.com>
Date:   Fri, 22 Jun 2012 10:54:06 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Yoichi Yuasa <yuasa@linux-mips.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>,
        <linux-kernel@vger.kernel.org>,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org> <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com> <20120620152759.2caceb8c.yuasa@linux-mips.org> <20120620161249.GB29196@linux-mips.org>
In-Reply-To: <20120620161249.GB29196@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 33782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/20/2012 09:12 AM, Ralf Baechle wrote:
> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
>
>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
>
> Thanks, fix applied.
>

Where was it applied?

It doesn't show up in linux-next for 20120622, which is where it is needed.

David Daney
