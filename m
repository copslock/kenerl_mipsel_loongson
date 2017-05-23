Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 20:59:50 +0200 (CEST)
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:17056
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994771AbdEWS7gX-eTD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 20:59:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ieLUnCXkBQH5C7zlOVvjOStSx/KSAQn4c4VbpcIQvIs=;
 b=VhCVkKFgUntbOJ66Eh+PPanPepBtXr2ETSTtR6GIc0cEL/YY7KPtjHVuXPRLWpV6sd7dTKwtTRaxtiC4Ue62ElFVssirCCf7eIyTLw07QzPjyUvFsoaJXBolQun2tmgNzwI24iUHF1tP5yflRDnNDJYlFwbRRM24zXGnSOfm47k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Tue, 23 May 2017 18:59:25 +0000
Subject: Re: [PATCH] MIPS: Octeon: Delete an error message for a failed memory
 allocation in octeon_irq_init_gpio()
To:     Joe Perches <joe@perches.com>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
 <1495565752.2093.69.camel@perches.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <8d364af1-62c0-db76-a912-7e1baf298948@caviumnetworks.com>
Date:   Tue, 23 May 2017 11:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <1495565752.2093.69.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0011.namprd07.prod.outlook.com (10.173.33.149) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-MS-Office365-Filtering-Correlation-Id: 707305a4-eb46-46d3-c909-08d4a20dd5dd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:+6OwgHPvBuu1odFVzQaRCrt8INqCtNpIC6HnnrneAGMAJU78U/pMbBuzxU6ChwllFvVLKkQom79Fi4Ry7K65VwP7iimfPhoE0UgiYPVVe0KPddq2Rki3roKWyFhI54zQFBUdMczbwtKt5Y+JG21UL732vX8Eu3aYRYTxPusgie5yjnzjXmERJnKc5v+nDHwEFxXrlZmywLl6wY8ayjblrQhB8bO9YaA8VbwaZqBqB9WOVuX3yrzijHEjxrFTTBKFZtNlGbj4qd7dhpOi4/pq9+yBqpYGkJ36Uy8N4lKSPZpkMlS5WwHBid4od3xw1hGuv0wRZiZ9Dk2ixwLrPHaOeA==;25:mRzq1uxA+n/tSCGQN5mbgGkteh205Kr7vMCHPWC7wzod89VDACpueqA8DLDw8iKnXA6eCg8miE3XoWRi0VqWi5IMFLhmAEFCoWLeUpKXJugGEAM+XLINCOJ6qvTU48ZyQbLXxHbuiRz8mCRNJTSd8KHbKg/iQ5r3pD+OoKMD+bOxpmpjjDMllX5W5hh3gglEXQIllXb0e32uetp7+3YCVNapGzi0m8vJGuhyXeoS+y5pOKioAkK4DNduv8dzSehbVNOn3VdqVwL1a06pbEJX32wBHcb/6hrc5LRxIcmP+lldcmuhIVLbUIt99NGrE8kD98jFgPPRW8rnk9TOefChTJgOJdORQdLlmy/qiq6rIGiOZ7RLjGhBcYWP0x4ye3sCG1iGoOckKNns5lNU5Wh2h5HIMegqpd+d9QIQ5sz6sAjzs14LRQ+z+6M1qQGvcB1I9Qj9rf4gIRvVYIBWAvjwvGg1dCrVJvpColUZmU028Xo=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;31:g09CkirMmuyVNlEnvQXS8W+tvgFQZ8QMXJT47t7lG4XN4d5RCfHgDiePFcsHf652Fc4ly7b2XW6VNgqYhQLWP5eNrouInNmaDQyVzu6ayhkMt7MR4vYKlM8QxYxH1niP2+sMtkJJhEImuhA8BV9GFc+0u22UxK2gZ/XShPj9bAn0olDOH0l91m50kVd6zwt6F9cfATH+05sysc/GWtzrvPxJXAGtcQP5e+lhvk8dlao=;20:UQLIfOCxZvEZskRiHGlqJzL2zOC7wLbxX+MB0xVhz0opU3YaWJ0/dmEPA3v59WxNsQmlLap63V0A+eA4hIHYXAgy3coaY9PUDpLKm1Pa+7mQc9qJycTGkkc9UovQtN7BaReZwZ6vxQTZbYvkFjkaOOSPVT2CaL2oSH0bbArmV0Cd5LSYK02+8F5Qve+kW7Rw53m+2ST57ffOUaMdgoSA9U2gUmLeIMrP53mhThoCG9HRvhf9WPiZI9tbuRFI+oYm0jCBpSIyZeZH2RWxjbVosFBUIrDVVls0hM/I1B8gieM7OgaDm+P9cvGdmqV1xlSRSwbAYOs3XhbOJ4emmbv5khogtCdZ5HE7OeVUO3T8BCjNpntue250rl7k6Do3MvEq4cgDBFKa0A/mqDtz/0jlUXb0pBB6+zzXI6SAVZ6tiD9Y2G8Sf0hC9tHjN90MgaQMz9GC8bmhTWQb8/nzSiLCKzsgXqt9duZSiL9PTx2IZoeTPqBUa8WM+QhUq+zNCjFznnorsljltWptSd3qWAFaWnuaZu2I39CoU2T8MDLC8f46mgRs07G0tsii5gHFC9t5wm9JVHjtR9edA4NoEayknEl9FoXITxut96N9uu0KREk=
X-Microsoft-Antispam-PRVS: <MWHPR07MB35030890F77F38CBFFBAAFE597F90@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(6041248)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;4:8ODqXzRhg3Cv1Py+1LNYn5yPdf3YQxX6w4C/t106NfScShMLiQ3fTHqLP8J1GkgO3xSqaUW5AIvig3wK/hQalxIvDGkX+wFo7HwW0Yxcfz/qd6ya+hD/9e84RJWJrPoMZUQNbO9ChwOSPmHQoHlf4w9EdmLFXKHnKPR7s8HGLwNxIu6jasEY+9GLJbGMs2KLU3ekMLwsBCJykmN8wPkHkG3q71SIoPCD/0DMC2t9x606e0QYJD/yUL4rRkABG+zEl/sEZiiUSCoIE33xbnBRmJCbMvTLfcN/JrRP4emd0LEiG/KYUxORcUsFMv1U6vNge0/vxr7H8KUN7cIJ5ZZP/qSnD/XLlPTNQhSDMijj1yBhZ+pZeQYg1/tc/V9GkWLZn4cx1nC2h1Px5ZPP3kXAW9MuWV6NlGlHPs0CxdSGTu/RKmOyn+M5iOY8ByV3vynj8aET5JdZ9I7VK+q/OPLJ61dBet9TW0Pvq7QplpzlTVbh99EYybl0S7Ap5M7svaJfoPmpeK9aZYe0oLz/cnsSoOwIRXQ/8x6E21/WYDhsndlPynONKCam/iIDwbZzF64oFnGbCGWpVnqm+bMuA/lAGrlTW79jwvdQIsOzi8fO4sEGRVDh6PEKhaqbgBJymqfhpupQNNgUTz16lpBK+PKdqBSo3G0GqPUSbkr4kLrowGyDPxnTd9+ZfS8737hmyS5kZRTm/lSfS1BPwcQMQ0P/4glmsAyvH9KMCOY6eSgrEHA3grXUsD8VmpoOnLGD3WyRoXSbpJMOVs0Zq/utYthVfSZkF1OwqOJAiNadgOQjdrSEw9UUuh53T8Z5mAJTOphv
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39840400002)(39400400002)(39450400003)(39410400002)(377454003)(24454002)(377424004)(23676002)(3846002)(6116002)(6506006)(31686004)(66066001)(53936002)(38730400002)(65956001)(6512007)(47776003)(478600001)(4326008)(42882006)(2950100002)(53416004)(8676002)(42186005)(81166006)(72206003)(7110500001)(305945005)(53546009)(189998001)(25786009)(7736002)(229853002)(31696002)(6306002)(6666003)(4001350100001)(50466002)(64126003)(50986999)(54356999)(6246003)(76176999)(33646002)(83506001)(230700001)(36756003)(15650500001)(6486002)(2420400007)(65826007)(5660300001)(966005)(2906002)(10710500007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOnQ3L2dmSmh6RERVc2MyRXkweGExZmZsRXU1?=
 =?utf-8?B?c2lxVmhrRGNCMng1ZFBvd3FDWmpIcGdpWlplbng0TkE3cWIyTjM3VzhuQXVJ?=
 =?utf-8?B?Mml6TDQvRm8yamF6V1YvelNFcEhHckZxdC9ZT2FhOXZTNzdQakl1RG9mSXVU?=
 =?utf-8?B?cE5zRnorOXpVMnhrV2VSQVpZTXgrWlBES0YzVlVSczVhbi91NGdMcThtd3Fj?=
 =?utf-8?B?VUt3QVQrL3hvQWpjblh2Njk4Y2NjUDJkcWQ1ZjlBNzNnZzVWZFJUSlZBM2xJ?=
 =?utf-8?B?aTNCVUIza0JWWWhVUmVPc2U5Mm10N2FjOHpYNEVnTngwclA1UXR0SHMzZGgr?=
 =?utf-8?B?Zy92WDJrMmJiVDV2aXcvWFVLdklvaGcxcHNMVE5HQnNyZ1FuL3c0dkR0anpt?=
 =?utf-8?B?QzQ1aVZEV3RjYVREN0ZOZmR5L0wxRFBUNG9UbXM0QVY3YVJxSGlTaDdkTzhZ?=
 =?utf-8?B?dHFyM2ZkVlZKQWdUSGs3T1RnQitXUzhqZjk3M1F0K1pNM05WcXRDUkEzYTNz?=
 =?utf-8?B?dWRENFdLZ3VsUXhQWWdKU1J5bmNNdTlFQ0I2Nkh2Z2ZXdUdaVWN2RjBhZHBF?=
 =?utf-8?B?T2xoUWoxUWxYU0kxV3lhQy9RNU5DQlYwbnB2amxXTGFOUGMwMmVnTWhIL1NK?=
 =?utf-8?B?YTNjVHZpYTJCaGQ2TU8wZnVWOU80Zi9ORVF0Q05yQ0gyaTE2MXZQalVrbVFw?=
 =?utf-8?B?M1gyTk9CckZTYlc0elV2MHU3ZWk0NVA1c0c5NHR4SStpY3NqdCtzV0IzUFNw?=
 =?utf-8?B?SFRxZHJSRlJlelpTMlBjWHMvVkxwazhPRFVVaG9MSzZzOFJrajVobXFkRnRR?=
 =?utf-8?B?cXVRVC90TW85N091bWtscnlJLzRmUEdBN2dna0Z1QXhGNDJrcWRHMEpvQTVi?=
 =?utf-8?B?WEFNS1NhZ3NrM2MwTlRydE9aS3E0SFduOGx2dlQvSTdBZTZoZHpSdW9BMEg5?=
 =?utf-8?B?Tm4xeFYvdkVuVHdiRGFtQTJ5MXFzeEtkZHB3akhhS2J3cVl1Q0RoQ21QZ0gx?=
 =?utf-8?B?ZWV6eXNXUnJoOVYxU2VDU0pzQU01SnN5ZjZNMDNPRkxxb01mVTY0Y2hMMGVM?=
 =?utf-8?B?blBFYkEzb3lYN1hqZ2RHN1NVZkRSVGxlY0NDUnl3ampHUVFnOW9kVmorWGZJ?=
 =?utf-8?B?VHZPdVF2UGRHelVrWE1QUGNoeG5iSzB0N2VIRFlDSmtyQUZDdHl1WDZqbkd3?=
 =?utf-8?B?TWFjQmUxdzhwMHdVUlprRXdkSWxHMVI0NVN2dnJHbGdvTEJUVjc5SEFKQU9D?=
 =?utf-8?B?Z2xRM2g5SlFyRDVmdWFqUGhCZEpYTS9XN3dlU3FvOEt4a3dYNzVMZjFrOEdr?=
 =?utf-8?B?MkVSZW9zbVpFRS9rWks4QnNabEZ3NlVZMUZ0cU53K3BteGhKTGpjRnZXemRR?=
 =?utf-8?B?R0NJWjVHTzFGam9EWGZBTEIvL2F1TTBGRGRQbmxrQlkzTXY3WFpOdkhacFdx?=
 =?utf-8?B?S0FHRXV1M2x5S0xqSTA0cWVQOCtCc3dDUjJaZGFyOFhSMFhtT01EK2EyaGhI?=
 =?utf-8?B?SWkxcVFoSWNGQXI5RHRMZUdUVHRXSW01WG5NM0d0NzdrbjFLd25Uc2R0SDZt?=
 =?utf-8?B?eWRwT0x5SmZMSVMzQUEvSVJwaHJuYWN1TWJscFM1Y0J2RHdEVmVNVHczajRE?=
 =?utf-8?B?MndGS1RGOVdsZTc0T3BLNldGcU82c0FIQUlNSGhtT0c5QXZ0YWhkUGhwM2Ja?=
 =?utf-8?B?ZEErU0FQSXRsdHdROW9RZGswdGs1Vlp1V3liVDQ3aWs5aVRJKyt5bmtBeHFw?=
 =?utf-8?B?cHJUbDQvMGgvOWx0SU95V3pzdHBta28wMnRUSEMyR0ZCNmNBVUduWVIzbzFi?=
 =?utf-8?B?Ykk1bVg1dFMybTEwWVpQS1RhRDhzcnYvbkV6TkpqemM1VjBEM1d3dFZDU2xv?=
 =?utf-8?B?SWoxemZObzdGQitZd2xTVkdJTTZVRFRKUjM1b01qdU56Y2VCTm5BTTFQbm5a?=
 =?utf-8?Q?DrriC0UG758D5D7CWyionLZ5pXZGu0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:NSYZu9M1KzUWM+fnDSVTmytF+MiX7GxhAOOEqbA0uUpq/VicN08sBZFjnz7IhXu8zV7W+WHCgip8UwIOJtyMnFh3cfGxoG0BJ9kGzmwY+7YC7LQ3jDABMLQzzOSeyv24VE59ZlMJ9sBRi5zWCBr8MfbSFrKBeF6XIXWx1iMCSBEjW5hCBeBqnPz6Nu4nsKbaGg6g6S3U3F9LRxDEvQrSK/9CUbwXzoRrVGhlhqjxuiCNYP1r+Ar0ZFR0VEvGQ5j4rtjP/e5QuIfiTR0/0tM0Y4nAsJqVE+hUtMpyBn3yJweG2jagR5zaEzp6PqvI8VGi0SBDDQi4BOy/b5vy4XPNk2BLFJj/ugYcM5lCOr2p7I0//JGgeswSk4P8hd1VW4vMObWfA9uaCkVYcNC5yBgOp1jgy/rSHELcj3gr2KWSTwUE4yYm7QP47VjCxl1DwpsQ46PNVLJXDnV/aGCKIYYNEMZvZjq9vTzYij2wgjVi0NWnEc46qDH9LcOVPhEUYWhg7JfMyDTlMfhm9smf0mLEJA==;5:nHhCq0uZKr1eQHhv75G9VD4ejbFNunNUxnzYnuKE/A4TBDHu8THr1i8BRbJm1k0grdtZVUh84Fni0ZRAWMVSAIEiyQSF89tP5l1qDhv6fbEviqlxJEFviRPeOS+9kCzNYeJyLk79lL73jtLFW2/N9w==;24:3Qk+sNIfExRGcQfBsIMlplDAaEvSbov3crmQ+BvE/7b9ckL0AmOE5oZGc3PVEBKp5tytFIAzOEe7PhaEn/kbPd8Nr9/UejmpTazJRIaqm58=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;7:5+w9P3uk/wcEk4V402M+dIRNepuibnZfO1DNrUmHOS9N95fyHQHgKfNpxD+sWsmvpynFZNXyoLrqFNKgIwQsgd4TG2+g7FOOwstploPU1mevhQR4ZRy1a2U50IOY8PTVOJaArUHXSPHOwQyU5hYPxLTWr5x51T9oQz1XMkn4ypdlVBe4mgrKVE5T4nQkmamTtsJTRWbOMf0qN75XlNIKKZwWUqs1BFNLuoObJmHQuYApqNpWmjKwS6+nmFWCviHx1K2RbDefLzwtgkf/qX7cIzRYA7X+yEiftfWh+fi7ZM9tGqWQFM42pupEbt3YUus8qv3GJdqUQCYg7jm0V+vqhw==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2017 18:59:25.5967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57953
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

On 05/23/2017 11:55 AM, Joe Perches wrote:
> On Tue, 2017-05-23 at 20:10 +0200, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Tue, 23 May 2017 20:00:06 +0200
>>
>> Omit an extra message for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>   arch/mips/cavium-octeon/octeon-irq.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
>> index c1eb1ff7c800..050c08ece5b6 100644
>> --- a/arch/mips/cavium-octeon/octeon-irq.c
>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
>> @@ -1615,7 +1615,6 @@ static int __init octeon_irq_init_gpio(
>>   		irq_domain_add_linear(
>>   			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
>>   	} else {
>> -		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
>>   		return -ENOMEM;
>>   	}
> 
> You really should reverse the test here and
> unindent the first block.
> 
> Again:  Don't be mindless.
>          Take the time to improve the code.

Quite right.

For  Markus Elfring's version: NAK

For Joe's version:

Acked-by: David Daney <david.daney@cavium.com>



> ---
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octe
> index c1eb1ff7c800..2bdc750f2f2d 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1609,15 +1609,13 @@ static int __init octeon_irq_init_gpio(
>   	}
>   
>   	gpiod = kzalloc(sizeof(*gpiod), GFP_KERNEL);
> -	if (gpiod) {
> -		/* gpio domain host_data is the base hwirq number. */
> -		gpiod->base_hwirq = base_hwirq;
> -		irq_domain_add_linear(
> -			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
> -	} else {
> -		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
> +	if (!gpiod)
>   		return -ENOMEM;
> -	}
> +
> +	/* gpio domain host_data is the base hwirq number. */
> +	gpiod->base_hwirq = base_hwirq;
> +	irq_domain_add_linear(gpio_node, 16,
> +			      &octeon_irq_domain_gpio_ops, gpiod);
>   
>   	/*
>   	 * Clear the OF_POPULATED flag that was set by of_irq_init()
> 
