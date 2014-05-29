Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 19:59:21 +0200 (CEST)
Received: from mail-by2lp0240.outbound.protection.outlook.com ([207.46.163.240]:1032
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817294AbaE2R7UCndBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 19:59:20 +0200
Received: from BLUPRD0711HT001.namprd07.prod.outlook.com (10.255.120.36) by
 BLUPR07MB051.namprd07.prod.outlook.com (10.255.208.151) with Microsoft SMTP
 Server (TLS) id 15.0.954.9; Thu, 29 May 2014 17:59:09 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.120.36) with Microsoft SMTP Server (TLS) id 14.16.459.0; Thu, 29 May
 2014 17:59:09 +0000
Message-ID: <53877569.9060906@caviumnetworks.com>
Date:   Thu, 29 May 2014 10:59:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Greg KH <greg@kroah.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb host/MIPS: Remove hard-coded OCTEON platform
 information.
References: <1401358203-60225-4-git-send-email-alex.smith@imgtec.com> <Pine.LNX.4.44L0.1405291100320.1285-100000@iolanthe.rowland.org> <CAGVrzcZuo2MvMv20W4zJQxkK3JBxD8L_tfkZoP=s175__kDQ3Q@mail.gmail.com> <20140529173759.GA7889@kroah.com>
In-Reply-To: <20140529173759.GA7889@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(199002)(189002)(479174003)(377454003)(24454002)(377424004)(51704005)(102836001)(19580395003)(19580405001)(23756003)(83322001)(83072002)(92726001)(85852003)(74502001)(79102001)(20776003)(74662001)(21056001)(101416001)(36756003)(53416003)(99136001)(87936001)(64706001)(31966008)(50466002)(46102001)(92566001)(99396002)(80022001)(59896001)(77982001)(65806001)(66066001)(65956001)(81542001)(83506001)(76482001)(64126003)(54356999)(81342001)(47776003)(4396001)(50986999)(65816999)(76176999)(87266999)(62816006);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB051;H:BLUPRD0711HT001.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:3;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40363
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

On 05/29/2014 10:37 AM, Greg KH wrote:
> On Thu, May 29, 2014 at 09:55:08AM -0700, Florian Fainelli wrote:
>> 2014-05-29 8:03 GMT-07:00 Alan Stern <stern@rowland.harvard.edu>:
>>> On Thu, 29 May 2014, Alex Smith wrote:
>>>
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> The device tree will *always* have correct ehci/ohci clock
>>>> configuration, so use it.  This allows us to remove a big chunk of
>>>> platform configuration code from octeon-platform.c.
>>>
>>> Instead of doing this, how about moving the octeon2_usb_clocks_start()
>>> and _stop() routines into octeon-platform.c, and then using the
>>> ehci-platform and ohci-platform drivers instead of special-purpose
>>> ehci-octeon and ohci-octeon drivers?
>>
>> How about they get their changes in now, and eventually they cleanup
>> the octeon driver in the future?
>
> Nope, sorry, we don't do that for kernel development, you know that.
>
>> My personal experience with that sort of request, is that I had to
>> come up with 50+ patches to clean up the Kconfig mess that USB drivers
>> had back then and I still have not re-submitted the bcm63xx USB
>> patchset.
>
> Well, that's not our fault you haven't resent them :)
>
>> It is fair to pinpoint what *should* be improved and what the next
>> steps could look like, it is not fair to ask people submitting changes
>> to come up with a much bigger task before their patches can be merged.
>
> Of course it is, that's how we do Linux development, again, you know
> this.
>

Several points of clarification:

1) I wrote the patch in question, not Florian.

2) I agree that OCTEON ehci/ohci support could probably be refactored 
along the lines of Alan's suggestion.

3) This patch is a relatively minor change to an *existing* driver 
rather than a completely new thing that hasn't yet been merged.

4) There is a lot of precedent for merging minor enhancements and bug 
fixes instead of requiring a complete refactoring of *existing* code.

All that said, I haven't dug into the ehci-platform and ohci-platform 
enough to be able to opine on the best course of action in this 
particular case.  I hope to be able to make a more educated follow-up 
next week.

David Daney
