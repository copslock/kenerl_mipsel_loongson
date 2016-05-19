Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 23:05:28 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34339 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028753AbcESVF0MgyEv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2016 23:05:26 +0200
Subject: Re: [PATCH 1/3] MIPS: ralink: fix MT7628 pinmux typos
To:     linux-mips@linux-mips.org
References: <1463688456-23795-1-git-send-email-noltari@gmail.com>
 <9918e3d9-b929-8391-d995-0bf555684264@phrozen.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <4203bd44-0594-bb6b-82e7-42f15f640d62@phrozen.org>
Date:   Thu, 19 May 2016 23:05:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <9918e3d9-b929-8391-d995-0bf555684264@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 19/05/2016 22:58, John Crispin wrote:
> 
> 
> On 19/05/2016 22:07, Álvaro Fernández Rojas wrote:
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> 
> Hi Alvaro,
> 
> I think my SoB is missing as i am the original author of these 3 patches.
> 
> 	John
> 

my bad, these are different patches to mine, sorry for the noise

	John

>> ---
>>  arch/mips/ralink/mt7620.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
>> index 0d3d1a9..caabee1 100644
>> --- a/arch/mips/ralink/mt7620.c
>> +++ b/arch/mips/ralink/mt7620.c
>> @@ -223,9 +223,9 @@ static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
>>  #define MT7628_GPIO_MODE_GPIO		0
>>  
>>  static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
>> -	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
>> +	GRP_G("pwm1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
>>  				1, MT7628_GPIO_MODE_PWM1),
>> -	GRP_G("pmw0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
>> +	GRP_G("pwm0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
>>  				1, MT7628_GPIO_MODE_PWM0),
>>  	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
>>  				1, MT7628_GPIO_MODE_UART2),
>>
> 
