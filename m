Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 19:51:09 +0200 (CEST)
Received: from mail-bl2lp0206.outbound.protection.outlook.com ([207.46.163.206]:9668
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825866Ab3FNRvIDAl2C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 19:51:08 +0200
Received: from BL2PRD0712HT001.namprd07.prod.outlook.com (10.255.236.34) by
 CO1PR07MB111.namprd07.prod.outlook.com (10.242.167.17) with Microsoft SMTP
 Server (TLS) id 15.0.702.21; Fri, 14 Jun 2013 17:50:48 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.34) with Microsoft SMTP Server (TLS) id 14.16.324.0; Fri, 14 Jun
 2013 17:50:47 +0000
Message-ID: <51BB57F4.9000106@caviumnetworks.com>
Date:   Fri, 14 Jun 2013 10:50:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS/OCTEON: Override default address space layout.
References: <1371157847-17066-1-git-send-email-ddaney.cavm@gmail.com> <20130614084125.GA11911@linux-mips.org>
In-Reply-To: <20130614084125.GA11911@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-Antispam-Report: SFV:SKI;SFS:;DIR:OUT;SFP:;SCL:0;SRVR:CO1PR07MB111;H:BL2PRD0712HT001.namprd07.prod.outlook.com;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36904
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

On 06/14/2013 01:41 AM, Ralf Baechle wrote:
> On Thu, Jun 13, 2013 at 02:10:47PM -0700, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> OCTEON II cannot execute code in the default CAC_BASE space, so we
>> supply a value (0x8000000000000000) that does work.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> Thanks, applied.
>
> I assume this also should be applied to all -stable branches?
>

It is really only needed in conjunction with kexec, and that is somewhat 
broken at the moment

David.
