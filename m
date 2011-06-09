Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 20:08:27 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43997 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491059Ab1FISIX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 20:08:23 +0200
Message-ID: <4DF10C76.6000408@openwrt.org>
Date:   Thu, 09 Jun 2011 20:09:58 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: lantiq: adds missing clk.h functions
References: <1307642253-8770-1-git-send-email-blogic@openwrt.org> <BANLkTikWCDhUPDX_fJ20+TVoqaq4Y9q5ug@mail.gmail.com>
In-Reply-To: <BANLkTikWCDhUPDX_fJ20+TVoqaq4Y9q5ug@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8301

On 09/06/11 20:06, Manuel Lauss wrote:
> On Thu, Jun 9, 2011 at 7:57 PM, John Crispin <blogic@openwrt.org> wrote:
>   
>> The 2 functions clk_enable() and clk_disable were missing.
>>
>> Signed-of-by: John Crispin <blogic@openwrt.org>
>> Cc: linux-mips@linux-mips.org
>> ---
>>  arch/mips/lantiq/clk.c |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
>> index 9456089..aba91db 100644
>> --- a/arch/mips/lantiq/clk.c
>> +++ b/arch/mips/lantiq/clk.c
>> @@ -100,6 +100,17 @@ void clk_put(struct clk *clk)
>>  }
>>  EXPORT_SYMBOL(clk_put);
>>
>> +int clk_enable(struct clk *clk)
>> +{
>> +       /* not used */
>> +       return 0;
>> +}
>> +
>> +void clk_disable(struct clk *clk)
>> +{
>> +       /* not used */
>> +}
>> +
>>     
> Shouldn't those be exported as well?
>
> Manuel
>   

you are right they should be.

will resend in a sec, thx !

John
