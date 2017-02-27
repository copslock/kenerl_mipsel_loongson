Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 00:35:05 +0100 (CET)
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:24566
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992178AbdB0Xe6XMa0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 00:34:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cKpLF8wPveUP7n+BAFxT14uaVYkBSD9mDtXOiSNwCLA=;
 b=g6TO9Dnykdo9h/m7doTfuLZPpZzmf3xZKOOdqgaIcznFxyWpT9m9hr97y4jeWqgAWo0bfEet/4JMkfKaILKhkO3tBZ5GTVzyqS7GGbLmRuIqFj8BviW8Aw9iQhRL3xNSR/QuYmKWngzkVj5NBZ7nx5XjN/AtlzXpWFAv/+C2nlg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2428.namprd07.prod.outlook.com (10.166.195.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Mon, 27 Feb 2017 23:34:47 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <8fb467e8-2ab9-e52b-ea47-083947b9cfe4@caviumnetworks.com>
Date:   Mon, 27 Feb 2017 15:34:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN1PR07CA0053.namprd07.prod.outlook.com (10.255.193.28) To
 CY1PR07MB2428.namprd07.prod.outlook.com (10.166.195.17)
X-MS-Office365-Filtering-Correlation-Id: b4606938-9460-4eb1-d89b-08d45f69395b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2428;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;3:m6gtxwLpvQy2tHzlUIQlXkuJOengpMaAsOu3WMok+xZj6mHgfNx4usqkLDZWjteYtfk0bg8NlBSSLqpZ7601MnuhEggzcsUE+SVHVMyuHzBtO7crQ02wFH1g0ejheWkg+DKK9JZCi1ixWV4ZwnIg0VLofZgKZIsuHiBH1yKa/lZunVlH7FdwYfjQ0FT3EkgMgdYu97y6/wK3zS2PspRQo/9WjPn0ZwgOV5cfo3VfTvlh+MUBQeiS5l471JYvIsijGr0KVrX9eyYrvce2MV+hBw==;25:f5RA3UXv5A4VdNc5kWi5SgYDDhuuGVqlEy/INxMcTFKtfFm0+xkQMj/PbOve7lisw1MV7QMC40tb0TCpy0zF51DTfiFtxBzHVZ6yO8xScJl9RA7EvooV/7yDCmQBLif5pJgV7M87/d8ASMFe8fGJicPTUQwa0ym2SJfe6zedRfVmsn4CzJ2wT9xhb4HklHYHMFwuT0GjwIAuP2E9c5Q1IwTnpcsmPT1gUuQRwJTJs9X0A2N3PBDmFz+IUKMGDirGHyAzgy7SnX0Mib/39vHpwHVw8aqaT2qRAxWHJ/RXKJXxKvs9PHoheW5tISiqjaZV9+SX18OPH94l309CyZDnwCjkHbdPCtRXhb3ARnVCSVi5GaCBiIXZLJ78pUo7MNcD4zfGVhfnjgtxtGTIquxGRo54LTQ1rrDQcu5+/XkwIr8ZJMSbg2ohe7+FCLJJJ2oAJHPAL7Wc/ZHFWuD1E5SeBA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;31:Ua5ycOQEe0b2m2DZ3mU/hieiycTWIFvwG4bAGPv/gj05Bnn7MnnP3sVnZHIzFE5m+fQI+5KQC4ILfuKf7QUGIsCVdsT3RRuUIWbV31ZusnRsOeu3m9EN+s/rWFjBHu0K+KlCQkRKQGXH7iEv6wC6sd6TogtbCGhUo1GaszaFdNzPHHOJ3Vzc1v6AKiyrWRslqNCI5B0RVQIiXpWkhh+HzB3mCr641w5PYYd+shYk1KhTbUxTim0bG4VA2xpCo+kkNoqWdS4XsGT8VTI90MjDMA==;20:vsu32TD9k9GLcg7pz1unelaeBSkscdeJg3YNmreZVKguCAJd04GgMelMCLq1ZIJ8zY89ZNOJtj1C6awj+UUPi0Mi4lLS6HusogkGvYFejYwlrp1NX6KV/K21z0GWn9L0mbGPwsVamcqAzWHfuUYS675Lwmt3nzX11uMWf4HJC5waXovXnagC9fFRxPfFRZK8RehlHm3nU/Gk0lw0XhGR4a/SLHQBiM6zcWZWS9fLXOzW6UkfWX2xaNYMjrOoLXT+FAny/3P8WIDEXBgeu/NOGi2mmfwPPGZI412ZMRZXi625S1vm0t7xEg3u34g0raKqkOE/ITwFVj+zD5lLHZ8Q66YFcbt3xBMdMfOiptDqa350xiIxAJdNecXmVQxpT1HpcsXBLz1Y3pZ1deulwQgz8KW+guOMdGzUAn5AU10sCbH1e5PcQ1glCyn4TnrBshAxJzKUDn57/gtxdYQF4S23RlgADAxCqicZgG/vTR11nHWtAJweUwK2QdTyHcm6weSHoaCy1zzbwVQVR+iCYnnKOUfdq3ihYebgEsJ6wr5qBXcPpejxsjbE+/izlwCXxfWrDaBvDNTfWAdQhH0TAIZzN8xdIP582UNgRlOSihZxvu8=
X-Microsoft-Antispam-PRVS: <CY1PR07MB242872AEBB2F40F367BAFC0797570@CY1PR07MB2428.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY1PR07MB2428;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2428;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;4:XFFzgEq0PWgdHZrfJE8gweSVSuGns6KXqfUEzxYi4uWAwqiXF5dbIyvgMWS5CEu4IT9xT2pbAJq2fj7eRNQHkKM+1GJyqWdgwdu8VXDOWzYj1GFNcyfXM94c/jK6dO7v4saVp5THcvdrzvVYWCTwLAr+ZSJ3NHaACJJYy4heFZVXNFT6Rj/7lhxrUpnEu5EAfNfhbl94jUe0kx1nUCFbmp9Ugfaph4QOBOZ3cObnoqVzEkylB75J+PHAhFP7jWuqqU8hlGFacn2LUPjmP+xhX6F1ZGvcp1QFUE4kG8MJgwfCmrWfXCWbtLgWq8exN72VYCopBvWmHhVvgXHVB/F07ylLRwFQ1y52MQedV3V5qcrMAdZ/lZsbPI9d5IUZwXpGVIWl2lVgrp9hKaduQMTZ9J8+EBaf0iaWB9XIjs4x71PgugspWz4QlvOHWny3hFsKycKTX4QRw7OAduec1S/gXfKo0A4YDnDVy11M64uEwcCKqhByTlcwPPyDk25p4Om85WzS4abFLXksXkCrHPqTw9oN6TNbR33F6X0DHqvW6tCS+1ZQz468sHNPyHTh+7NGhHXvODZIcFpqfKveApqOzp+s9wfKaHxuwV0oiSWN7wg=
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(199003)(24454002)(189002)(51914003)(377454003)(64126003)(6486002)(93886004)(65806001)(66066001)(81156014)(229853002)(65956001)(8676002)(6506006)(50466002)(81166006)(23746002)(305945005)(25786008)(69596002)(4326007)(2906002)(6116002)(3846002)(83506001)(7736002)(6512007)(54906002)(230700001)(189998001)(68736007)(38730400002)(2950100002)(54356999)(50986999)(42882006)(97736004)(7416002)(53546006)(5890100001)(92566002)(101416001)(53936002)(6666003)(42186005)(53416004)(105586002)(47776003)(31686004)(6246003)(106356001)(65826007)(31696002)(36756003)(33646002)(5660300001)(76176999)(4001350100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2428;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2428;23:vNNM2RboZLZKE8tc9kqVBUU0R5/Vm/EmTsEq9?=
 =?Windows-1252?Q?/3pY35N+pSmU9pvg9oQbkoQelxRn3bVmRQzNyxAvTSKZRLLoGGsC8bBX?=
 =?Windows-1252?Q?AqB2foA786A27HPns2qibjPOezdRDIHwtuuUliN8Mf8rPF8SVJ+L+IIa?=
 =?Windows-1252?Q?ZYDWEz7+VTa+XiyoNRKDk+RA1wuy8jYwJDO8DZE0RwhNGwolVc+dXs2r?=
 =?Windows-1252?Q?UQAWBRa7WI2w6k40/Hl60uITl39rwZ5malpQ0nmq+gJ+GmYzgSyyA2Tk?=
 =?Windows-1252?Q?ggEvaNMwNlJoz3ABTMix5YRz46wldhK2jYHvLs0CfKCsW6JYUYyYZTp3?=
 =?Windows-1252?Q?qBPhqxQEu85slst+A2AWl8Gx/IhPFSNFR8B9zI9ylAJCxrxKHs8AeQ5e?=
 =?Windows-1252?Q?Gi64KtgcA6Q26LkB9vl+jVmEE5OfeEfpsmmS/nvahgoMmISjZS7lTgf5?=
 =?Windows-1252?Q?T+Hv40Z1khsKdnXJycNk1VyWUOsL6cmtyNwcDY/DZkW+XEJcS5NjgERZ?=
 =?Windows-1252?Q?WBZq1JkNQLoorkxZmX+IuFcPPYgGed62HrpkchiAewm3B8IygcWkwbEa?=
 =?Windows-1252?Q?Cfzgy6LIdTWX0GJFLS2Z+Le9BRBl0jdfBDMhLS5XZSzI4bftnYGAxX2M?=
 =?Windows-1252?Q?IFLyHTfxDyKzRvxW8xLQk3sU/U50Ifhd1DtuMYWuIEiMgbfGGu48Gtuy?=
 =?Windows-1252?Q?o5MN4x4YTboVDXhu6KVyd0VXsTA4xa9U4BcQoMsoEzcQxhAcH4uGaeA/?=
 =?Windows-1252?Q?i1cANiEQ4BHroXfc52dzpUwqTfRtAgsG1lY6wp7ExliRNE/gHIB9JIks?=
 =?Windows-1252?Q?cibtQ2wf5dqoSPyYj2EKjZqXSBydeSTnTDQCcYUJSuw+9hPhYbQQZDZJ?=
 =?Windows-1252?Q?3tVeIaFIdgAjCBYDHpEDg7vLPtBfncH6QUsv2iyXEplHi994GsPjMSNj?=
 =?Windows-1252?Q?7Nld97F8ro3cdviL1XPWftT8mVX3K0q35LqwTsUhx2mngghNJ51czfz+?=
 =?Windows-1252?Q?7rQnuw+X+qAHMJsXrK3jCUSOj9CgORJOaFKb1eEKNq9z13yHicMnCaC/?=
 =?Windows-1252?Q?qFu8z/+OfQeZLUt4+sTeRKbTommIrubbS/Uqs9m2HPeSVTG1IEn7JMCL?=
 =?Windows-1252?Q?RA8w7H99C43FRZqS51uajj3wpMvklaMwp7AFH1fPQrP9f3GmdJTYsXzC?=
 =?Windows-1252?Q?GwPrehaPPU5hGWeruJ0RqhcZyAlRmFTAEk9KeUK1DrLl9U1GEdzVDOZH?=
 =?Windows-1252?Q?xAg9QW4vW25VAHal9NC/GRClnl8yEp9XgO5t7ypmhV4yLnrOqelpVl0s?=
 =?Windows-1252?Q?FbRy/DhQvI2bHyB7XroDka4TrLkHd/m6fPq/F7ji0ryfKLj05loNk366?=
 =?Windows-1252?Q?XndWzYhuOZe7BUi86FIkOQQ4EE2dhOlaCnCwNWEz0hi0G66CyTzdprCf?=
 =?Windows-1252?Q?zikYV6bSzfkp2SDZ6UPdY4oUsQZWXbZ+vNoUDIjkcQHItM3shYzOmaJ4?=
 =?Windows-1252?Q?QduDuYskXSU3STOWDZW4IQUQ1kF6RPMXg6deF5JXuhxt9apIKtxkUvMf?=
 =?Windows-1252?Q?GXXZGidExBMbXObtOT0hNNoTJMb6uNWdmPqP0erFlKpbeAQvw3NPS5hE?=
 =?Windows-1252?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;6:Atk30GcEgGolCLg8lgkxFcbydsDbfSLUh1lqvr16ddjUzM5phPWePb2QJDa0T02diYFZ+s+xnMWtVvfayHQ/7sRgt2S53EBYZShB7LqgbQRXwR3VC0LH4Qo31cUtYStgeEurY+aXV95hleOTFwfIuNTKTs6aDjb86PiNwyRl6oTJH+mU6zkKXnQylo0XiTLC4wkNlO8lSMe4rOWmcvinfh67RjaJUDX7TR2osc7tfTsB3FPVDLipyIxoj7uS3Xahrs4Xz1hyDG1JU3iTZcABsW0ac03yAhCsucGvX1VQVvH1RGJFq1DDc49w2k0Y8n9LJFMmvI8mECWHEpbQHBiGWliAG8layOovapPteJovDIUqpXi4WR302SkHCTktrdgQxHB3fECy8wnX3r0+TgAwMA==;5:Gtd7CaFgmkZ1YmZhmYfxVPjC+5PyyOVsD8MAGo3+MkvBRYbbq6wxGDqgg1rgdVUeQQr59Sf2/wekRVF977WlwPVrNUu+kFiTovhXdQZ14zntogQGrAPRO3IW1nksdn8n+yCn4wyo1gXRCVARZw9Vsw==;24:7lP5MujQSzcJ4el98D+UMd5Jnm7+yjQ3HV/2EAaQohCYwzsxIQM+i/qWhKEK69He+Ba0eUyMfjagMvHecUcnc1ETPU5EK/0aiqs7MttGTyo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;7:1lUDQrh3cNpoiXoCpptFwc+9dV6W0TrSXeoP95nYUDyPP0e8G1Xyy+iMZec/Zh78dPDJ8GkKefxNDtaMkWZhRnEDRs3JurIRTvQmJIPYKUg+ufbjlHSC01kb4WPUpQoUdhQ2r8R1c0mFr6JDM1b+DBHRuzyBXJvgof5T+3ZFjChirFY8ny0cIarBoSHAYF1/cK/PR3Tx7+SlBWc7fRvE8+icX/pIsv+D7IByyJrXWz3m0/s4BJA/UsqQZgPr/bV084LqpwAJdhapwRPYTlfnENo5Id357j8GX9klP0/OI3nQEnOwxSoh+dLpZQzs7ESnH51Pw3MCrqaocsqoYKwikA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2017 23:34:47.9919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2428
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56915
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

On 02/27/2017 02:50 PM, Jason Baron wrote:
>
>
> On 02/27/2017 05:45 PM, David Daney wrote:
>> On 02/27/2017 02:36 PM, Steven Rostedt wrote:
>>> On Mon, 27 Feb 2017 14:21:21 -0800
>>> David Daney <ddaney@caviumnetworks.com> wrote:
>>>
>>>> See attached for mips.  It seems to do the right thing.
>>>>
>>>> I leave it as an exercise to the reader to fix the other architectures.
>>>>
>>>> Consult your own  binutils experts to verify that what I say is true.
>>>
>>> It may still just be safer to do the pointers instead. That way we
>>> don't need to worry about some strange arch or off by one binutils
>>> messing it up.
>>
>> Obviously it is your choice, but this is bog standard ELF linking.  In
>> theory even the arrays of power-of-2 sized objects should also supply an
>> entity size.  Think __ex_table and its ilk.
>>
>>
>> The benefit of supplying an entsize is that you don't have to change the
>> structure of the existing code and risk breaking something in the
>> process.
>>
>> David Daney
>>
>>
>
> Thanks for the suggestion! I would like to see if this resolves the ppc
> issue we had. I'm attaching a powerpc patch based on your suggestion.
> Hopefully, Sachin can try it.
>

If there are problems, you could try something like:


$ find . -name \*\.o | xargs mips64-octeon-linux-gnu-readelf -eW  | grep 
'File:\| __jump_table'
File: ./drivers/firmware/built-in.o
File: ./drivers/built-in.o
   [3249] __jump_table      PROGBITS        0000000000000000 1838c8 
0022c8 18 WAM  0   0  8
File: ./drivers/spi/built-in.o
   [82] __jump_table      PROGBITS        0000000000000000 008cb0 000048 
18 WAM  0   0  8
File: ./drivers/spi/spi-cavium-octeon.o
File: ./drivers/spi/spi-cavium.o
File: ./drivers/spi/spi.o
.
.
.

Look for files where the size of the __jump_table section is not a 
integer multiple of the entsize.



> Thanks,
>
> -Jason
