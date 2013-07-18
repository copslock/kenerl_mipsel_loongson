Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 22:37:51 +0200 (CEST)
Received: from mail-bn1lp0156.outbound.protection.outlook.com ([207.46.163.156]:51782
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827417Ab3GRUhpUq-7F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jul 2013 22:37:45 +0200
Received: from BY2PRD0712HT001.namprd07.prod.outlook.com (10.255.246.34) by
 BLUPR07MB113.namprd07.prod.outlook.com (10.242.200.28) with Microsoft SMTP
 Server (TLS) id 15.0.731.12; Thu, 18 Jul 2013 20:37:37 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.246.34) with Microsoft SMTP Server (TLS) id 14.16.329.3; Thu, 18 Jul
 2013 20:37:34 +0000
Message-ID: <51E8520E.2050604@caviumnetworks.com>
Date:   Thu, 18 Jul 2013 13:37:34 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, Corey Minyard <cminyard@mvista.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mips/ftrace: Fix function tracing return address to match
References: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com>  <1374178262.6458.266.camel@gandalf.local.home> <51E84CBC.80206@gmail.com> <1374179160.6458.269.camel@gandalf.local.home>
In-Reply-To: <1374179160.6458.269.camel@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0911D5CE78
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(479174003)(377424004)(24454002)(51704005)(189002)(199002)(377454003)(56776001)(83072001)(49866001)(53416003)(46102001)(80316001)(74706001)(47776003)(76786001)(81542001)(47736001)(59896001)(74366001)(74502001)(56816003)(83322001)(79102001)(47976001)(76796001)(53806001)(65956001)(51856001)(65806001)(81342001)(33656001)(47446002)(54356001)(80022001)(64126003)(77096001)(31966008)(36756003)(16406001)(4396001)(50986001)(59766001)(66066001)(76482001)(74662001)(69226001)(23676002)(74876001)(50466002)(77982001)(19580385001)(54316002)(63696002)(19580395003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB113;H:BY2PRD0712HT001.namprd07.prod.outlook.com;CLIP:64.2.3.195;RD:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37329
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

On 07/18/2013 01:26 PM, Steven Rostedt wrote:
> On Thu, 2013-07-18 at 13:14 -0700, David Daney wrote:
>
>> There is an mcount ABI difference based on which GCC version you are
>> using, although I wouldn't think it would effect this bit.
>>
>> We are using GCC-4.7 FWIW.
>>
>> David Daney
>
> I'm using 4.6.3 which I downloaded from
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

I would expect that version to be fine too.  The option in question is 
-mmcount-ra-address, which I added to GCC-4.5

>
> I can down load the 4.7 version and see if that makes a difference.
>
> -- Steve
>
>
>
