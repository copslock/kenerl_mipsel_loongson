Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 06:01:29 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60657 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816831Ab3DPEB22h2wq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 06:01:28 +0200
Message-ID: <516CCC26.5000504@openwrt.org>
Date:   Tue, 16 Apr 2013 05:57:26 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
References: <1365845973-16164-1-git-send-email-blogic@openwrt.org> <20130415181527.GA25341@kroah.com>
In-Reply-To: <20130415181527.GA25341@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36202
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

On 15/04/13 20:15, Greg Kroah-Hartman wrote:
> On Sat, Apr 13, 2013 at 11:39:32AM +0200, John Crispin wrote:
>> With every Ralink SoC that we add, we would need to extend the dependency. In
>> order to make life easier we make the symbol depend on MIPS&  RALINK and then
>> select it from within arch/mips/ralink/.
>>
>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> ---
>>
>> These 2 patches in this series should be merged via the mips tree. Patch 1/2
>> requires an Ack from the tty maintainer.
>>
>>   drivers/tty/serial/8250/Kconfig |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
>> index 80fe91e..24ea3c8 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -295,8 +295,8 @@ config SERIAL_8250_EM
>>   	  If unsure, say N.
>>
>>   config SERIAL_8250_RT288X
>> -	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
>> -	depends on SERIAL_8250&&  (SOC_RT288X || SOC_RT305X || SOC_RT3883)
>> +	bool
>> +	depends on SERIAL_8250&&  MIPS&&  RALINK
>
> This patch doesn't create a select anywhere, so how can a user know what
> to do here?
>
> greg k-h

Hi Greg,

The select happens in patch 2/2. i split it up as it touches a different 
subsystem. I can put both changes into the same patch. would that be 
acceptable ?

     John
