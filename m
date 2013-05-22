Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 23:50:13 +0200 (CEST)
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:29884
        "EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822972Ab3EVVuHHa9Jl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 23:50:07 +0200
Received: from mail168-co9-R.bigfish.com (10.236.132.232) by
 CO9EHSOBE012.bigfish.com (10.236.130.75) with Microsoft SMTP Server id
 14.1.225.23; Wed, 22 May 2013 21:50:00 +0000
Received: from mail168-co9 (localhost [127.0.0.1])      by
 mail168-co9-R.bigfish.com (Postfix) with ESMTP id 6AA8B1C01E1; Wed, 22 May
 2013 21:50:00 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.242.245;KIP:(null);UIP:(null);IPV:NLI;H:BL2PRD0712HT004.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275bhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail168-co9 (localhost.localdomain [127.0.0.1]) by mail168-co9
 (MessageSwitch) id 1369259363843219_1990; Wed, 22 May 2013 21:49:23 +0000
 (UTC)
Received: from CO9EHSMHS026.bigfish.com (unknown [10.236.132.249])      by
 mail168-co9.bigfish.com (Postfix) with ESMTP id C17428C027A;   Wed, 22 May 2013
 21:49:23 +0000 (UTC)
Received: from BL2PRD0712HT004.namprd07.prod.outlook.com (157.56.242.245) by
 CO9EHSMHS026.bigfish.com (10.236.130.36) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 22 May 2013 21:49:21 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.37) with Microsoft SMTP Server (TLS) id 14.16.311.1; Wed, 22 May
 2013 21:49:21 +0000
Message-ID: <519D3D5F.8050509@caviumnetworks.com>
Date:   Wed, 22 May 2013 14:49:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] MIPS: OCTEON: Remove vestiges of CONFIG_CAVIUM_DECODE_RSL
References: <1369259183-29076-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1369259183-29076-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36541
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

On 05/22/2013 02:46 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> This config option doesn't exist any more, remove the leftover code
> for it too.
>
> Signed-off-by: David Daney <david.daney@cavium.com>

Well I screwed up the subject line it is really [PATCH 1/1], but it is 
still mergeable :-).

David Daney
