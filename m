Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 22:00:03 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:12156
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823114Ab3FRT77CinuU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 21:59:59 +0200
Received: from BLUPRD0712HT001.namprd07.prod.outlook.com (10.255.218.162) by
 BLUPR07MB180.namprd07.prod.outlook.com (10.242.200.143) with Microsoft SMTP
 Server (TLS) id 15.0.702.21; Tue, 18 Jun 2013 19:59:30 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.162) with Microsoft SMTP Server (TLS) id 14.16.324.0; Tue, 18 Jun
 2013 19:59:30 +0000
Message-ID: <51C0BC20.2070501@caviumnetworks.com>
Date:   Tue, 18 Jun 2013 12:59:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        "Jamie Iles" <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <20130618193618.GA1401@linux-mips.org>
In-Reply-To: <20130618193618.GA1401@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0881A7A935
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(51704005)(479174002)(377454002)(189002)(199002)(24454002)(74366001)(76786001)(50466002)(80022001)(74876001)(76796001)(74706001)(65806001)(65956001)(81542001)(69226001)(81342001)(16406001)(50986001)(47976001)(51856001)(76482001)(47736001)(63696002)(64126003)(49866001)(54316002)(54356001)(66066001)(53806001)(56776001)(77096001)(59766001)(79102001)(77982001)(53416002)(47446002)(23756003)(56816003)(33656001)(47776003)(74502001)(31966008)(4396001)(36756003)(59896001)(74662001)(46102001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB180;H:BLUPRD0712HT001.namprd07.prod.outlook.com;RD:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36999
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

On 06/18/2013 12:36 PM, Ralf Baechle wrote:
> On Tue, Jun 18, 2013 at 12:12:50PM -0700, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> Get rid of the custom OCTEON UART probe code and use 8250_dw instead.
>>
>> The first patch just gets rid of Ralf's Kconfig workarounds for the
>> real problem, which is OCTEON's inclomplete serial support.
>>
>> Then we just make minor patches to 8250_dw, and rip out all this
>> OCTEON code.
>>
>> Since the patches are all interdependent, we might want to merge them
>> via a single tree (perhaps Ralf's MIPS tree).
>
> Looks good - I was trying to come up with a kludge good enough for 3.10;
> this may be a bit too large ...
>

At this point I think it is fine if some random configs for OCTEON fail 
to build in v3.10.

I was thinking that this would be for 3.11


David Daney
