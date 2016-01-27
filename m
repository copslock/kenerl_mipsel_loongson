Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 16:47:05 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:36942 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011466AbcA0PrEHYpVw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 16:47:04 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 27 Jan 2016
 08:46:56 -0700
Subject: Re: [PATCH v5 10/14] serial: pic32_uart: Add PIC32 UART driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
 <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
 <56A7A729.10008@microchip.com> <20160126173322.GA1664@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        <linux-serial@vger.kernel.org>, <linux-api@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56A8E858.4090804@microchip.com>
Date:   Wed, 27 Jan 2016 08:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160126173322.GA1664@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

On 01/26/2016 10:33 AM, Greg Kroah-Hartman wrote:
> On Tue, Jan 26, 2016 at 10:04:41AM -0700, Joshua Henderson wrote:
>> Hi Greg and Jiri,
>>
>> Ping!  Need an ack for this or pull it upstream.
> 
> The merge window _just_ ended, please give us a chance to catch up on
> patches to be reviewed.  There's no reason you need a response for this
> right away, it can't be merged until 4.6-rc1, right?
> 

No problem.  There are a few dangling drivers in this series to complete a bootable platform, including this one, that have been stale for awhile now.  I just want to make sure they are ready.

Thanks,
Josh
