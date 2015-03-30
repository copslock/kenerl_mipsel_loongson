Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 20:59:27 +0200 (CEST)
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:39840
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010081AbbC3S7ZmrVII (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Mar 2015 20:59:25 +0200
Received: from dl.caveonetworks.com (64.2.3.194) by
 BLUPR0701MB1713.namprd07.prod.outlook.com (25.163.85.14) with Microsoft SMTP
 Server (TLS) id 15.1.118.21; Mon, 30 Mar 2015 18:59:17 +0000
Message-ID: <55199CFC.5070307@caviumnetworks.com>
Date:   Mon, 30 Mar 2015 11:59:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        David Daney <david.daney@cavium.com>,
        <linux-watchdog@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi> <551992F0.5050809@gmail.com> <20150330185150.GD571@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150330185150.GD571@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA006.namprd07.prod.outlook.com (10.255.174.23) To
 BLUPR0701MB1713.namprd07.prod.outlook.com (25.163.85.14)
Authentication-Results: iki.fi; dkim=none (message not signed) header.d=none;
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1713;
X-Forefront-Antispam-Report: BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(51704005)(24454002)(52604005)(479174004)(377454003)(50466002)(40100003)(36756003)(122386002)(80316001)(92566002)(65956001)(64126003)(33656002)(59896002)(46102003)(62966003)(66066001)(87976001)(53416004)(50986999)(99136001)(65816999)(76176999)(2950100001)(54356999)(23756003)(110136001)(77156002)(42186005)(83506001)(87266999);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1713;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Antispam-PRVS: <BLUPR0701MB1713ED5FE47B124C264333069AF50@BLUPR0701MB1713.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5002010)(5005006);SRVR:BLUPR0701MB1713;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1713;
X-Forefront-PRVS: 05315CBE52
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2015 18:59:17.5630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1713
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46610
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

On 03/30/2015 11:51 AM, Aaro Koskinen wrote:
[...]
>
>> Thanks for doing this, I had been meaning to make the conversion myself.
>
> One further improvement idea would be to get the register dump logged
> also with printk() or panic() so that it could be captured with netconsole
> or mtdoops (at least in some cases). Not sure what it would require.
> Calling printk() or panic() from the NMI handler didn't quite produce
> an expected result...

In the handler we are running with a private stack, and at 
CP0_Status[ERL].  The result is that no access to the current task 
structure is possible, and interrupts are disabled.  So there is very 
little you can do.

Polling characters out of the UART works fine though.


>
> A.
>
