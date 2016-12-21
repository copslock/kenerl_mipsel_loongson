Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2016 19:08:33 +0100 (CET)
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:32096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993349AbcLUSIYd0mVh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Dec 2016 19:08:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ohitocDlH83ltQg7+4tOMjSyhST6i6wD90GPswgzK4E=;
 b=A4R52DxqJqNyw3y55w85hUdXx281bwqTFTpELyClUUjJSt3tHb770wvvcJgZG6xjjuHywR3f3jFC7oMPGr5UU6CHzn5Mhx+IakvUQgYtpqnwspGf8xUzg56SL8TkKKM/K26qTeb4AuON5NZEDZi2qbqcP0PtIKJ0qUcIhw/rJaM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.789.14; Wed, 21 Dec 2016 18:08:15 +0000
Subject: Re: [PATCH 1/5] MIPS: FW: Make fw_init_cmdline() to be __weak.
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
References: <b14ef49d-f39c-4e13-2da8-ab94804395a2@cavium.com>
 <20161221171015.GA13689@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <892fff47-d83e-fbb5-92a5-248d6e3a3eea@caviumnetworks.com>
Date:   Wed, 21 Dec 2016 10:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161221171015.GA13689@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0011.namprd07.prod.outlook.com (10.162.170.149) To
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14)
X-MS-Office365-Filtering-Correlation-Id: 451ba8a9-5ac1-432c-91f0-08d429cc55b4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;3:WpfuIkVsDD6xJHg4oWbbQSynPcEGgTvHOAwdDEltRrXtTq8UoRrHzpuuRmd/CwNgsLnSNIzhEpT+rR2kzH/8Hs1gmvkJttJunO56qhOGzl5HfaXQvGYvMTLQZjno05DK6ShNV+mpzYrOKzErUYhPR03N3MQwLdem2qI4syS9raD9vH3IXOao1jni7XEOiCG+24wR7B9/Wrz4GkUTEvpAmPDk/EYTz1Ow2/NnMMrfrfrUAwiEQM1xrby0Z4BhCf+1eXaW3PoOWa/TU2Vk0jonBg==;25:J3mVBvq2YyTo2+IQP/hmFGkTtsCrK9eHFFdL0Rlc8R0CPvFK51Ksb6s+mSNpYRUIseSpE/MXMnplbwhLTbljbGxpoIC+aehTBa7OdCNCmPhnIdWR1Hj1DZTTyOitnsRfYYlNN3wFdtGo5mGRy/H7FLR+2YrNmf1yHMILTnLAgX0s7jQaXyJeKbI8IP/8O9plPxo2+McixzXH62w4EZO8JgtrukUtkpKvr+mjQOz4mnnewa99DHrgL/2poiHziEa9GNEuksjk31zro7QvnUeW3QGp18iQ78ErqqQ+9nstFgJtycfOpe2RKdEdw6MXJHzwn//JJv2pMnDbvWdPK4M9MqZX3z8AasfU1AFXtNw8agpRcY1evyB9M4Ym1DIENGpx+XADkxZv3YLK5pEeNfMWWaBQGgPYNHxYRLt8ZEHgyyGegTW78BpyC0wk12ncLmKqf0E6/pI9nYxr5IH8vnJFlQ==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;31:+R+zhOS37D1lKSFNVIdFEOVG/7bpZ6z4TEzPUAgpwCrNKVBVXsKyTZFJW566vDccaMqTcj57Rk2N70irPXzIGnspAWMkO14bicy8nxJ0bc/42I6LU+BW5N7zxrZxwe4omWGv1VWaWID9cdWXVW/fLcacOhTRJIFftclMVgTAhAXGsAjK3ghorYCwFet0KRGg8ttT+IGH7LqGO6CgksPyEXueOm34HZP90TtVqCuTRkO6RJxiN+muV1jV1n72x/YhvZUp9iHExAtPKIGF8bDiTw==;20:jne3wsOr18iZOgtE+HhBlveT+O24oUgfkn1zwJEK7hKMAxtd1POJTwcNSjLF6XSxWqsShxuUADHf3vJI0fLiT1tWc8SL7ieBWwRvG+j9siiry3xLL/p5z0bbyS0NcEargFzWnNxxCPwj62wXnxlR1DZnKN3+btnkV41Dh5ZgAasxjpaIZTNWtTAf2unQfP7DQ3fSudSBKHqBhm2L2ZBIVrd1ivI/QB76N222W+riyELQG9q0cm9NTXKTpSLJT3vvYDXeu6K3KYWEg5PhMlfCZa6vWnWU49kH/iI+/IWqZCHTlVlEObxyFn14tVHsHMdlP/oqs0GYhytDU/2tUMdG3A99IphWEColCIQcD4RjWyPfwL9ka7Joabgvh0gaySRdg7WXgwsz0/T67vPvsqogYE/XVCCiWTnQPDVKeuJ2ZXeH5Tp2mXomHb7RRQhJI2ekRpCFerCU+gOGM9AKw1XQuye4kB4oF6SFAWUN46xhTi69Zt9wLxChK9FZKi5q8YPWTRfDSOaIwjlKpOiD5dPyD9D89CmPKHawX7EuHgSIMOhwAXjgOuGWcNPnW6ofLfP9JpHQ+eQRa1maWY06lFEagKu9fbA6Ri9N3aVl8RYaNcA=
X-Microsoft-Antispam-PRVS: <CY1PR07MB21367D413618677D9D682B5F97930@CY1PR07MB2136.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123558021)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:CY1PR07MB2136;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;4:xg0TZK/8Tv64qG8eIuMBh7i2Pp9aLMVJSmPndl6orYkXxW9BjQeCiO0YHoKra1yOXibll3gi2X9SDkFOJtFtaOp1b+pz7iObHdUS3hE8wsAgDb2vfuptRXWyO7iM95AVJOHHsMlLz1DCC71ae3W3xXl++zBbYGl6CuxaJQSE7wT88mnHIcIGK/gvHuiLSIKyYUG0+WsBwBpVbPqBS/n72kux/omasqydS75gClDe6XphdeD6xZFOJlWzcEaklUnuk05hxw3+xXpeRKEhx2ivc+Ft7uJ/dKs1XpkkbcCRjKLce7QarRde5/4KSz/4UNSZERIrs4cpWosVI/zV+6W2FDRPFTn/MPNr0Iv+kghiA4CdnmaOmJoyrArLm3TkNV0cnb5woT7PgKvySLJNFlWpf2bC6WJXX/p3RZ9K/iKG5IdOxDRNZ9N29IhUEwlLtyuxnXoo2H9yRwcoIlc450zODw5saOV2SY+j/w9U82jCFBHrnQ1j7Q+hsCK6YYq0C0g1GvVWOgoJ+O1+AJprn9uWEu/F8NVzH3x0d1RZaqMOqtRMITVuHKRMUmc/EiilIWwTtIiG/+ttrykdYE+OtaZXBjZTVp2Tvi+Pm1wVh6sdExc=
X-Forefront-PRVS: 01630974C0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(24454002)(199003)(189002)(377454003)(38730400001)(230700001)(229853002)(65826007)(68736007)(36756003)(6116002)(3846002)(50466002)(450100001)(4326007)(5660300001)(83506001)(69596002)(23746002)(31696002)(6862003)(575784001)(64126003)(92566002)(6506006)(42882006)(6666003)(106356001)(5001770100001)(97736004)(66066001)(65806001)(50986999)(6512006)(54356999)(65956001)(305945005)(7736002)(81156014)(81166006)(47776003)(189998001)(4001350100001)(2906002)(31686004)(101416001)(8676002)(33646002)(42186005)(53416004)(105586002)(25786008)(2950100002)(76176999)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2136;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2136;23:4MAQTSlfpK36uY2MlD1edsrRU4wcwqUbFNqLt?=
 =?Windows-1252?Q?OnqPd80Wu8txj8nPJvJ73aCNEi3rsW/ORy27E3wenoR/7JKbC/6d/ACS?=
 =?Windows-1252?Q?8E6IMrti64Wc3732XP9e/XEbQ91uMt39FtgNL86B8sojqt5iCKcWFSKM?=
 =?Windows-1252?Q?6K7NAeXPuDNBoqt/6e8SMjEQ8snZbEKUfWn5MgkyZHuws1rjMj27JgUU?=
 =?Windows-1252?Q?r1vyXTz9wnkiHcl5DiJAzABZdXA8OIVjYaE+Y6YkQ1PQ0189OxNf+btv?=
 =?Windows-1252?Q?ZpOh03JUfBL0+mK5sfKoV2rPcMLevJofE+7o4eLXla6tQ6iUow20UDXM?=
 =?Windows-1252?Q?XM1tfFKFhURf3a2qyJM3bB96fWynv5EIYKcPrnIHzYUoGM0cjekRnvDK?=
 =?Windows-1252?Q?LFtWz0CDVNhBrpH9hW0Rf+W8/jC7pyJRLBjvTQl+mpi9mWx+ipRy5LqP?=
 =?Windows-1252?Q?Vys9sPkxcHjSKQJ5rjqH+/8YEQKUHwWtCAmfOw6oWU/v/h9N4lSX+6aB?=
 =?Windows-1252?Q?UgQeEMB1cMv2MAK+6HsCLsEpb1hXOLS7847RZi5K/N1WFK9rraRZ7DBm?=
 =?Windows-1252?Q?IIRfcOITlDg/TGll++m3PNdE2wk/FIoIZXxy4lejoE2KA9ajhGCY/f4N?=
 =?Windows-1252?Q?zyJUqrfz9d2UgQ2ZGtTzROvZMJL/+AqWG+BZrcj6Of9AQFRZbnyc4Dw7?=
 =?Windows-1252?Q?7CEsa7Rl1dDO8dAeOKsmLGg9ZjXFiuLPlSTAInTYpzkEWZ/A/Vyt9tFw?=
 =?Windows-1252?Q?AyVsR+jsX+8rsa7RV+NJZ6bE5ibusqwUv6ClFh7UhmzuB0sv2I1wQBHZ?=
 =?Windows-1252?Q?o3kV1Q1lBpI+WNXJomF2drYdRVi4GXV3Xp4He2ZjqDnk/4SpUw0m7zub?=
 =?Windows-1252?Q?ngYMj66RUGWPMJQKFx2czcvdsFbzmioMsWIXUWcoeJLFFxopiC8CFWtp?=
 =?Windows-1252?Q?aodt8GoYtSzob1CRQ/S9xraB/oBx8wB0Iw4HGQzxy+YC2FyQqkNRSPlq?=
 =?Windows-1252?Q?3/tI9IPKA+OtdtENA2qcL+p1ux4WTKsW5wPV9gFB7w4hyFdMTS4vpeng?=
 =?Windows-1252?Q?j9bpXJTi+YSMG86DdkfNW5DDVAccfNnzT1SCBa1IMFMWqNdEhiPPz8bn?=
 =?Windows-1252?Q?dwuknIjNt208lp1aJnkcFo3n/rKAaACBq0zSX3B7HJqv1JrVhtVbfgRL?=
 =?Windows-1252?Q?cC6hmcL0nqAOJJK5bsoNxUVKCnIRwfb1j9RC2C7jKgyOCSLmS2AHv5jF?=
 =?Windows-1252?Q?mLite0UpGLmICJiQ7/twvXenX0VO4CSQfUns/1nCFTRp671vtJmogOxW?=
 =?Windows-1252?Q?PQxUXMYL+G2qEudPMgXmvjBucWeDSvZKZIIgZ5yzbzi+weXiwy5q7WSg?=
 =?Windows-1252?Q?4fFqTYxlLBj7uTrpJB8fOslGA3ScNOjrsIb080sTxAAjZN6z0CTZtMpe?=
 =?Windows-1252?Q?u9khkMUJQmLKrB9Ac7K+Hsvv/eSf/LycYcUnUN/cSKg8TRYUSO6gl73+?=
 =?Windows-1252?Q?ieOqYte4L4drD75WyrTrHfnlXjnT5znEATn1F6OiEZdKLCRPQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;6:zS7qStKoJC2GvhVQgONSOf76IfwAAU6HR+DIFMXPIGi+awcXsmCNSEJjFr3LqopcZRkOp0274LtrCuNK8UhhwHzNY3LnV0Bi81VTqVhu/plxDVuJrB2chre7j9ZNT+7BLTWL5des1jByW5Gds6SIJdNfvdcA4G68xz4ZR9S7tKrOw8lhW74f/bI/3e0Dew3PeiE/E0GbtAr6gGT7EuD92YJ+W+idzO7MnG0oJ4cFu8y3rMOaTYw26rFN7NAbcZXrpEu2yjYU4eWbf43qd5jhlbe261JlP4IumP36KWCNtolX+KI6tXxDFq4cXLcYefSen8bVJBS19RIRpq3T018Ko3C6SmqQTPQeEysTlI0an52Jo/VO4U02YGVNTJbDpcqoPsLdquA4GOuZs5V/L+06AJTlmvCYehjusz4sUal255I=;5:LmWCVDzRsfHUDqon1K04wpv37jeytaeA81qdyqoKf3WO2USjxVHVFI493rGKnVzPMpg9mHLQVzm1Xtz6cAAdhSLBtlHOKjG8i1+9sQhtvRprHWb8GzxmbQZ2CQ0x+KcKygj27gi0AhmsOb0a00ba3w==;24:iY5NaYa5nMy19YRTUzMiFskLn8DF2HocTxovnMAJDtLgnzNmv+wB5lDVGQRkxQ0qAphE7xq8qRZBm9mivH10Drcb3+LUFLpMnNG9Io0tTMI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;7:SOeNDxnnEtD4NGG//csWUjkpF3USTQd+I74xxPgMlvmuM1claGwfm3ryU+EXP5qLjRiJHk3VqO+oWVk0y+q/vXUWhuPzL4DUMQpabRpnrvgXyariglsjv9P23zVITT0tPDyREz6RkcwCJdEYFtx7c4VEa/tAtw/LaG0LBsb+fjrcWpLkALgaAJb2bCSYjfkyk8RC2kyobcXK/cbanPwrZ6EQPs/7X1IPyUoVLEy9kqdGjz1l97KGR5vsYyg6K2/1c6c0vCmySfjEoMquDKj9AeMQngNh6NlqiP+BFFvnNdVx5YHH5AnFDZHPAKHIeLze+wbsZ9OFJE/bGsqeH5vfWqBOotSmO6u7Om89qgmGBhEnTDIHosEEYOLIUg3VK1tFaxEAo4V83KByCfIH/q7jD6ydpRl4dEmX7xPZmfBvAqARb3gbh4C5MoAXrGgHjIbtJiJ8NHtAnQiOooLdbx+vAg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2016 18:08:15.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2136
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56113
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

On 12/21/2016 09:10 AM, Ralf Baechle wrote:
> On Tue, Nov 22, 2016 at 01:43:54PM -0600, Steven J. Hill wrote:
>
>> Some bootloaders pass the kernel parameters in different registers.
>> Allow for platform-specific initialization of the command line.
>>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> ---
>>  arch/mips/include/asm/fw/fw.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
>> index d0ef8b4..0fcd63e 100644
>> --- a/arch/mips/include/asm/fw/fw.h
>> +++ b/arch/mips/include/asm/fw/fw.h
>> @@ -21,7 +21,7 @@
>>  #define fw_argv(index)		((char *)(long)_fw_argv[(index)])
>>  #define fw_envp(index)		((char *)(long)_fw_envp[(index)])
>>
>> -extern void fw_init_cmdline(void);
>> +extern void __weak fw_init_cmdline(void);
>>  extern char *fw_getcmdline(void);
>>  extern void fw_meminit(void);
>>  extern char *fw_getenv(char *name);
>
> Nice try - expect it doesn't work.

Ralf,  Can you drop this unneeded patch, and still apply the other 
OCTEON KASLR patches in this set?

Thanks,
David Daney


>
> The definition of the function needs to be marked __weak; marking the
> declaration will only kindly express your wishes to GCC and it being
> GCC will ignore them ;-)
>
>   Ralf
>
