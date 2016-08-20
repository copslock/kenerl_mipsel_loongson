Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2016 03:55:20 +0200 (CEST)
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:31074
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992028AbcHTBzOITZJI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Aug 2016 03:55:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AjphhHMj7RTCp8zUp+bvGhdbRBxVazKluUCkEEiPuvQ=;
 b=RQruWhLhRMNzXUIn+P5/NjDrqcqA81ZBt/DGt3YwmC+1dn/x9lQ5Km+BHTX7YeyNFKHxRX/j1m3eEHifxlud/PPekzzf/+EoFvVVOVclgS6JvgVvxmtwm73FY9JnqUeR4Ip5j0hhBU2DKYpAyiyOYW17c5IkodXELzj6jdqJyH8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=cmetcalf@mellanox.com; 
Received: from [192.168.1.62] (148.74.104.201) by
 VI1PR0501MB2767.eurprd05.prod.outlook.com (10.172.11.17) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.587.9; Sat, 20 Aug 2016 01:54:49 +0000
Subject: Re: [PATCH v8 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
To:     Petr Mladek <pmladek@suse.com>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-2-git-send-email-cmetcalf@mellanox.com>
 <20160818141242.GK26194@pathway.suse.cz>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aaron Tomlin <atomlin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Ralf Baechle ralf @ linux-mips . org David S. Miller" 
        <davem@davemloft.net>, <linux-mips@linux-mips.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <233b9270-2f35-b3c5-2520-bf513153f260@mellanox.com>
Date:   Fri, 19 Aug 2016 21:54:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160818141242.GK26194@pathway.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [148.74.104.201]
X-ClientProxiedBy: BY2PR08CA0004.namprd08.prod.outlook.com (10.163.62.142) To
 VI1PR0501MB2767.eurprd05.prod.outlook.com (10.172.11.17)
X-MS-Office365-Filtering-Correlation-Id: 6470335f-bce8-489c-ea2f-08d3c89cffd0
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2767;2:oaqMMWqahhU9fGhJnlYDSHAK1ItKho9K96BFfiNTyXZIEI9iBctOQ0iTw59pvuYKsnIXecUIgiPfy+JiA/t9kHurZERUODcoYGuspW/2YULgsdPx77/RMr3TRN97IqXNdmyN7ML+isutrfR1j6cFLmv+6v/1k1JCQcyzg94mOc1T6cUcG4qQpRjwSZjiHla6;3:RSxtvqpL0G+SacwRVVst1kke4XCYeY6i26gpl40peC2N3Kkx1dGdypEUAE/7qPqsCcI5SZsKKmEdFdySU63N4sa/1nCTMrXdgdMUlqqL2GVg2mlhuAkEmaHnVoeERbkR;25:uE4ePxgrV+m4XWhV+nfW4u+8CTWd+pYI68sEfqh0miydEqROPCsPenG3JSlIj0IL1cDLqP1/p/fk9qHYdPHrtnuHtRRcJhuJzJWzE/PjUPRMGJExYICUYI2VF31TsbLMqHw1xkjIEHQ5GE9bQE+EAbRosG4K7t5eD5s5swoFUHKmMwCOc0t1ZmbNlDy1QKY06RuySviXGTFCVy8tdlYmDPYEbV9+rMUILjAsjWV0cNZHZIg7mp12ED3eCZOtNo3lugpo3tlb/rCOuQgtga1Fk8l2fwcIG7VSoENQ/nSpvUbuFXY5S/QE+lwoB9WXUs0JbYtjpaHdZByzzumvozvuUln8U1Gj88+YxetM4cUd/UQeA8xxESrDHGTIWAckU2YlJ7MY6g6C2mOowT54FNL8D23UdWOTIHdZ92ba2yQl33s=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2767;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2767;31:kT9CQmPR9JESXRlgNPpXdxJshii17V3w7PEdhdaa2Bjkt15FptnW4ERcZtTPoBXkw/IBRVIHLkYIUSuHgVeGFdIFpJMzF8IW776OW7aKw4sDBxEW42kFfJTyV5NdCkwyCiOFYTEW7WMlvf8XVQbXfO0Ojga1iljxmAG6U0xV+5K9chzoAUhwvwGfmsDVEGuxxlujsByD7wXG7gVENgizdb1q08+q3/xTsNUNHbToS3w=;20:lapTqWSVIZe/yOqd0fSPwGf7OXoR2pWrL1SUMTqe/lBv2mZbCM1MWhGPgHSsR1zRoClw0iJz4s8gFuL4f4KlJTomea7r6hainA2/UvEZyJ2We/Sqe3aR7dWFAblT21inAEAqcoPLwt6fk/djjMI9om3zdMItJk2xSKGB0VwZtk4J2BZKHgD2jsT3DjfVosOHUL++/+iNgKE+5hR7aWMKFBHm7y8brZ6exQvaN8LGBTYPSg4d32znZCWyrqEcCQ4XS8rEN4wOEDbvZaGSMf7sT/X0DXvL4gaxE0yp7UdmBHyVUcyYw8Ktj0uN3xcid4jJBAj7XfRQIsAsOLjcLWY4tVDmdLfJ1Qj5vr0DxlMTgBW3+SKJL+AlHjpwVUDV0DKkeiiXEOTVUH6XBGpRy+F16/kxkFpMAAd/W0F9NUkvwaHYnd8JXbmstGFLssJ5HIS7vm6QOguyfae6ns7KLWGPKQkSZhVjUH6H7Y/FmBWNpe3VGZF3kDQ3ojUlRgfkXjsC
X-Microsoft-Antispam-PRVS: <VI1PR0501MB27679C7C01F6B5B1A7FEAC75B2170@VI1PR0501MB2767.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(171992500451332);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026);SRVR:VI1PR0501MB2767;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2767;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2767;4:hWuOA3Tqsu3ra2Qj44oPvC/Lnayt7K+QFStHQcRmO6AB6SPX+KyHCvnI7ucg8tNbDXNxyXd9YcQWfESpW44S48jh9+hk96GBy4aavy/5hPGeJNdCqepWTdX3l6QGVw1Em3EmW/0DW458RYEo6OvSg8VHhQmACONdJylCCESWPFTjcHfMQp/3G97g6zGBWr3H+rSjx01Iqqi1ZTQFwAv80YtzymWu1lHx/DqoiUFiTv6J7NGhIC/jONcK2o4G3KZlhRgPCXgxEhB5naMjfO83mIr9ScN63i/nbIL6dExU17N6+wWWx+Jc9owcucct8T2XBUlP7KuYexujcRFKYRm2HbnQdmXim4NgKVnadFS0zHzjX7gNtbdEhq/SvEtZKTveGlBG+/GEhEIVZ3LQenw3Mr+X+GltamxciIP0zNNB6EaUA623LqAEX4M/D+RdLt1urHbzTO5X9aQT3m6N6qVRCA==
X-Forefront-PRVS: 0040126723
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(979002)(6049001)(6009001)(7916002)(189002)(24454002)(377454003)(377424004)(199003)(105586002)(68736007)(92566002)(4001350100001)(97736004)(2950100001)(31686004)(5660300001)(110136002)(19580395003)(31696002)(36756003)(106356001)(189998001)(7416002)(23746002)(47776003)(33646002)(6116002)(305945005)(64126003)(4326007)(83506001)(3846002)(15975445007)(50466002)(77096005)(230700001)(76176999)(7846002)(7736002)(50986999)(86362001)(117156001)(81166006)(2906002)(42186005)(66066001)(101416001)(65806001)(8676002)(586003)(54356999)(65956001)(81156014)(65826006)(18886065003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2767;H:[192.168.1.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR0501MB2767;23:zDj/Mmq7oS31O3MHHG2+zzpAFh4pO35Wl+0?=
 =?Windows-1252?Q?rTEEdlOfPxMiDytNiLf7VzROfvsodlmsN34LqaFgqUfwh1NUT0+PL/0u?=
 =?Windows-1252?Q?AaI93WjcTI6fJq32TGshyoBwXn3a8+uZl/qLF8tn/O7ibS9X7+ezr20e?=
 =?Windows-1252?Q?l9D6iimZXU4mVKAI5bnvxsmqcK4FaORAH5smTel16b7+nJobp1Vl5NKP?=
 =?Windows-1252?Q?efmyK5xsSROJtGZminpKyASEWLG3hr7qGbXXYH1sHf5oy8PtFMlm/tco?=
 =?Windows-1252?Q?/cfwChSVKq7PipewZkLf4kh5AgASwTRpCXvFl39EAcXSfQSnEzeQNtz4?=
 =?Windows-1252?Q?/xs4z9wzz43/S4xxJ4zwW1aD1ze3JRUGBSqEwzOUhzamL0dRMC0tn816?=
 =?Windows-1252?Q?6nW5+CJyd8hDIYEqWY7ATCyEJkBip7jq/QWH8/JMUGiE3R81CXLG7eXl?=
 =?Windows-1252?Q?dPVFBxbMW+BZrWhuI8O2EM1Q5QK7UdZ3dTs6yDqB3jvaGhQHK3iIYiMJ?=
 =?Windows-1252?Q?eJrZeT3512AIMoKGtdn0DdU1UKvMox1i2yWYyJ4ED4nvj+DqDS4QGZ72?=
 =?Windows-1252?Q?Vr/s+p0owm0PfGX4TcEbHPxPzGnpP0+bNQhtQkg8yPqivlgIpJZbrKXm?=
 =?Windows-1252?Q?insEl6d/Ql+fQeExZ5fj6qUS2pyqjHBVLGymA4nZtPrUoOQ2P4jLHGta?=
 =?Windows-1252?Q?ulWchBoA1hZrHIP0Syt79Ohtm/0QfPJBHXvUc+TjJsPfwC3QtsxqirwL?=
 =?Windows-1252?Q?d07rmfrP/KzbjuYcs4Lg2JFK0dKx3MHeL48eNkjqNWJtj+bVmTdZnGg1?=
 =?Windows-1252?Q?E4pQ9G40L86v4FLvJfrptKehQfVWM87P8bn8q2oH9R9oQfWInlaca2KE?=
 =?Windows-1252?Q?zHZZgin/4+ehOgFDyxWZgCSXGEPZAxkkIn9DwLYx2xnPqlp2V3obTZd4?=
 =?Windows-1252?Q?wiGDhAxxVlLFtA92OYkWQzdzIyMFVNK0ATgQnjYaY/2TTmKdOe2TmvTJ?=
 =?Windows-1252?Q?f7o+NbCwvbug/JXhPz6uWh8MkPnxiz62graqNYLWKDmBSgbPBoaKKSr1?=
 =?Windows-1252?Q?xMBUSMSQaEVFxLoccFBDZS/8Cf9Z8zUwh6wbudTO/+EHiwCxLEbUWrqn?=
 =?Windows-1252?Q?BDxRtw4vSNnX579ZinzqrdopFzLthT9eYk6zxEJP3faOlbpJ5Es79W7N?=
 =?Windows-1252?Q?mRJu1Hryo5MwQrS4gT1i0BRt1NJ1A8ayGQ1NoJfvyNTNCdrFKrN+x6tj?=
 =?Windows-1252?Q?UFnGm92ytwq3yVgFzy2QJyIZhpoWpeCbG10pAkXkiI37UDa9I4uPbjbh?=
 =?Windows-1252?Q?S/aC0UHINuYulHJdllfKrVbb1HWbciptrBH89A5Bzewr888m1n3uIdxc?=
 =?Windows-1252?Q?Jdn2lQhrOlE2sY1hhN+FO1vyRzEXLdXPu05seh4AL/u1UJjr/8xduw83?=
 =?Windows-1252?Q?8CcZNkIxqF+F1yBV44pIzkcF3alV7h/HfQ5EW5sWxRyMQjTYgRDocEvq?=
 =?Windows-1252?Q?cIXOk08KeO7Ek0ehTjmvx07lB4sCy0vjLWdxJBLCDz8/zc2e8juIsfjb?=
 =?Windows-1252?Q?mtFe24ab90B6C0YyyHdY2HoBghOxf0rsodNpB1oEKTJTBP22WABDcJKc?=
 =?Windows-1252?Q?NXQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2767;6:LDv/cHgWBKSFtfGuYfNc8xvOMzbEPJ7i2NSuVYLuE0IEW8um+8Y/HS1WeQRQFX7uS8uZY+Zy4rAhydsTWTO0pYx/i4Uvv4XDiEIt8Fc9EgMZZDvwOJGgYRcMO9Tzkg/eq2T89wMhCFPzyQvZfFE9YCZYL7DKfNwaSX1sVypeWVDYngRXDT7QhZXAP/U6r9A0BRql0Bmr4utYT9sjLWg7Ivk2LRHhhpbIejoL1r4cVSyLyg8NbpfRLPmDQekSeduDLYEsZeR4/B7xxSUCvJp7QD9z60PawEiXmy9tLL/AxVImf/+kuAGbUCBTLCajEfBZ79AP+udPdD+KNyHkiAmrfA==;5:J0pysgjDGg3CjGLZXznXZ630CP/yisldP2S8bsJwWfmo3FX0kONtk163HSq4TzJRhnEIifktY2nuJ8tr3gp16es6SZEI1hXqdMuFnLgdEwS4EhUP2iyUe++0BCDgbg1HfvEyiNt9ocOCqY5Aq3lGbw==;24:SHqMlCkaTH9Ewlo4yLdXf5oKvbQmF8NbN5vEWhwTHFoMI6g8IhVO8aTsxlpPgi9qKjbkf7iEMcwI/UOuzSjzOXBz79y62QSc9XJRq/VxRvM=;7:w8KZ5xeaNlPzfCj6rhdCZeKHDuyVhYlLmMIRWOad0pkCJYcjFmxR3uE7bZ5U11TWZ1g2g3XQASjazp74WB/Eplqhb+QmUQ5LIF4bVF55fLNf74SbltFSGHSM2ka79FFQ+jjixwoky0YWkRCVEbGfOALdBNn6TEMPozPxzq27yJy9x6O4yXXkxjLHd8OPJWmFmggDFnbC9lqwc//iJ6qgK1d9z1JQb1Y87cgR8KuDLsQxsTxhyG2bAtwGcKggfmWr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2016 01:54:49.9074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2767
Return-Path: <cmetcalf@mellanox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@mellanox.com
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

On 8/18/2016 10:12 AM, Petr Mladek wrote:
> On Tue 2016-08-16 15:50:21, Chris Metcalf wrote:
>> Currently you can only request a backtrace of either all cpus, or
>> all cpus but yourself.  It can also be helpful to request a remote
>> backtrace of a single cpu, and since we want that, the logical
>> extension is to support a cpumask as the underlying primitive.
>>
>> This change modifies the existing lib/nmi_backtrace.c code to take
>> a cpumask as its basic primitive, and modifies the linux/nmi.h code
>> to use the new "cpumask" method instead.
>>
>> The mips code ignored the "include_self" boolean but with this change
>> it will now also dump a local backtrace if requested.
>>
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index 7429ad09fbe3..fea1fa7726e3 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -569,9 +569,16 @@ static void arch_dump_stack(void *info)
>>   	dump_stack();
>>   }
>>   
>> -void arch_trigger_all_cpu_backtrace(bool include_self)
>> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>>   {
>> -	smp_call_function(arch_dump_stack, NULL, 1);
>> +	long this_cpu = get_cpu();
>> +
>> +	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
>> +		dump_stack();
> The bit is not cleared in the mask. Therefore arch_dump_stack
> will get called for this CPU as well.

Actually, and kind of confusingly, smp_call_function_many() never calls
the current cpu, even if it is in the mask.  So this code is OK as-is.

> Otherwise the patch patch looks good to me.

Great, thanks!  Should I add your Reviewed-by?

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
