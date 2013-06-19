Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 18:45:42 +0200 (CEST)
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:3214
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835004Ab3FSQpkE0r08 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 18:45:40 +0200
Received: from BLUPRD0712HT001.namprd07.prod.outlook.com (10.255.218.162) by
 SN2PR07MB064.namprd07.prod.outlook.com (10.255.174.152) with Microsoft SMTP
 Server (TLS) id 15.0.702.21; Wed, 19 Jun 2013 16:45:31 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.162) with Microsoft SMTP Server (TLS) id 14.16.324.0; Wed, 19 Jun
 2013 16:45:31 +0000
Message-ID: <51C1E028.2040700@caviumnetworks.com>
Date:   Wed, 19 Jun 2013 09:45:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com> <2302882.NVjP8DdXWY@wuerfel>
In-Reply-To: <2302882.NVjP8DdXWY@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-Antispam-Report: SFV:SKI;SFS:;DIR:OUT;SFP:;SCL:0;SRVR:SN2PR07MB064;H:BLUPRD0712HT001.namprd07.prod.outlook.com;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37011
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

On 06/19/2013 03:01 AM, Arnd Bergmann wrote:
> On Tuesday 18 June 2013 12:12:53 David Daney wrote:
>> +static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
>> +{
>> +       offset <<= p->regshift;
>> +
>> +       return (u8)__raw_readq(p->membase + offset);
>> +}
>> +
>> +static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>> +{
>> +       struct dw8250_data *d = p->private_data;
>> +
>> +       if (offset == UART_LCR)
>> +               d->last_lcr = value;
>> +
>> +       offset <<= p->regshift;
>> +       __raw_writeq(value, p->membase + offset);
>> +       dw8250_serial_inq(p, UART_LCR);
>> +}
>
> This breaks building on 32 bit architectures as I found on my daily ARM
> builds: __raw_writeq cannot be defined on architectures that don't have
> native 64 bit data access instructions.

I will rework the patch to avoid this problem.


> It's also wrong to use the
> __raw_* variant, which is not guaranteed to be atomic and is not
> endian-safe.

We do runtime probing and only use this function on platforms where it 
is appropriate, so atomicity is not an issue.  As for endianess, I used 
the __raw_ variant precisely because it is correct for both big and 
little endian kernels.

David Daney
