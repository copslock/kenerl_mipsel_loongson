Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 05:22:53 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:47162 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491970AbZJODWp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 05:22:45 +0200
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9F3MELA000490;
	Thu, 15 Oct 2009 12:22:14 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay31.aps.necel.com with ESMTP; Thu, 15 Oct 2009 12:22:13 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Thu, 15 Oct 2009 12:22:13 +0900
Message-ID: <4AD6956F.4050605@necel.com>
Date:	Thu, 15 Oct 2009 12:22:23 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Baruch Siach <baruch@tkos.co.il>
CC:	linux-i2c@vger.kernel.org, ben-linux@fluff.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
References: <4AD3E974.8080200@necel.com> <4AD3EBDD.50105@necel.com> <20091014185327.GD11789@tarshish>
In-Reply-To: <20091014185327.GD11789@tarshish>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Hi Baruch,

Baruch Siach wrote:
> On Tue, Oct 13, 2009 at 11:54:21AM +0900, Shinya Kuribayashi wrote:
>> This will ease our testing a bit with i2c-tools.  Note that DW I2C core
>> doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave-
>> addressing-only I2C transactions.
> 
> Is this supposed to be applied to mainline?

Yes, I hope so.  But I have to admit I blindly added several flags for
my testing, and should have audited them before submitting patches.

>> @@ -529,7 +529,14 @@ done:
>>
>> static u32 i2c_dw_func(struct i2c_adapter *adap)
>> {
>> -	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
>> +	return	I2C_FUNC_I2C |
>> +		I2C_FUNC_10BIT_ADDR |
>> +		I2C_FUNC_SMBUS_BYTE |
>> +		I2C_FUNC_SMBUS_BYTE_DATA |
>> +		I2C_FUNC_SMBUS_WORD_DATA |
>> +		I2C_FUNC_SMBUS_BLOCK_DATA |
>> +		I2C_FUNC_SMBUS_I2C_BLOCK |
>> +		I2C_FUNC_SMBUS_I2C_BLOCK_2;
>> }

As far as I confirmed the requirements for having I2C_FUNC_SMBUS_*
from drivers/i2c/,

>> +		I2C_FUNC_SMBUS_BLOCK_DATA |

>> +		I2C_FUNC_SMBUS_I2C_BLOCK_2;

should be removed.  About the former, we have not implemented proper
I2C_M_RECV_LEN handling yet [ I'm not sure what it's for ... ], and
the latter doesn't seem to be used anywhere in the kernel.
As for the rest, BYTE/WORD/I2C_BLOCK transaction works for me.

So the resulting func() would be,

static u32 i2c_dw_func(struct i2c_adapter *adap)
{
	return	I2C_FUNC_I2C |
		I2C_FUNC_10BIT_ADDR |
		I2C_FUNC_SMBUS_BYTE |
		I2C_FUNC_SMBUS_BYTE_DATA |
		I2C_FUNC_SMBUS_WORD_DATA |
		I2C_FUNC_SMBUS_I2C_BLOCK;
}

and will be fixed up in the next patchset.
-- 
Shinya Kuribayashi
NEC Electronics
