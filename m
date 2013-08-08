Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 17:04:03 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34281 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823121Ab3HHPD4MVA00 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 17:03:56 +0200
Message-ID: <5203B1B3.3010304@openwrt.org>
Date:   Thu, 08 Aug 2013 16:56:51 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org> <5203AF83.30101@imgtec.com>
In-Reply-To: <5203AF83.30101@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 08/08/13 16:47, James Hogan wrote:
> On 08/08/13 14:31, John Crispin wrote:
>> From: Thomas Langer<thomas.langer@lantiq.com>
>>
>> Enable the clock if one is present when setting up the console.
>>
>> Signed-off-by: Thomas Langer<thomas.langer@lantiq.com>
>> Acked-by: John Crispin<blogic@openwrt.org>
>> ---
>>   drivers/tty/serial/lantiq.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
>> index 15733da..ce1ea35 100644
>> --- a/drivers/tty/serial/lantiq.c
>> +++ b/drivers/tty/serial/lantiq.c
>> @@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
>>
>>   	port =&ltq_port->port;
>>
>> +	if (ltq_port->clk)
> I think that should be !IS_ERR(ltq_port->clk)? The same problem appears
> to be elsewhere in that file too.
>
> Cheers
> James
>
>


Thanks, i will send an updated series
