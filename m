Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 19:37:51 +0100 (CET)
Received: from mail-bn1on0082.outbound.protection.outlook.com ([157.56.110.82]:51857
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006641AbcCVShtPp4Ch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Mar 2016 19:37:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-caviumnetworks-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A9uQPUYYWkPEqqu96dysbhBAO4QsUJDf+K34psNN1Q8=;
 b=24ihI+/vH5c+UD2WWZYTdR1dbQWrAl0yljLy1ieWwqv+uNqOcNm0xtP6b3PpYFlC3R3tQFusFg0BblR/lqqWKtr3uOSll2ltAWanUoQYgP42vHu7WjcC/Qq2pKk1pOAl0XsqhtotPCEThnQOhcWA5T2G96hXV5izQqLr6ty67nI=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14) with Microsoft SMTP
 Server (TLS) id 15.1.434.16; Tue, 22 Mar 2016 18:37:41 +0000
Message-ID: <56F190F2.9090300@caviumnetworks.com>
Date:   Tue, 22 Mar 2016 11:37:38 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <rt@linutronix.de>
Subject: Re: FROZEN transitions in hotplug notifier
References: <alpine.DEB.2.11.1603221822560.30089@hypnos> <20160322183350.GC1670@linux-mips.org>
In-Reply-To: <20160322183350.GC1670@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR07CA0006.namprd07.prod.outlook.com (25.162.170.144) To
 CY1PR07MB2136.namprd07.prod.outlook.com (25.164.112.14)
X-MS-Office365-Filtering-Correlation-Id: 89e64b00-503e-4dc2-dd17-08d352810d81
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;2:J4Y6J1ghFLXamSeNgU11njXkv2PscdUuEq2+3QpChDo2Qhia5ScWYpMH3JxS2Gmsd339pVjWYxqnVPIo825PtIIGR7BF/ONIXtGKj+0NRCuVBGwRUitu2362Rj7BnTBQtkmPnhh85gdtG8PN7CQ4RFoWJ2BOuqQCRoptR8B1q151bvTgChydEMliQP+FUVAD;3:jCtc1Dh/GCMrhMEpMNDVml/kff5M7Yi3Pw3MrNHiw6qIZcXzwUrOJW/KCxfVriFWtYc0pVGXYHO6DyVER5/qaigoy5Kg1bBTNQa52oO+tVdUxsoku7L3OZdDgLeiumhi;25:ExW4Y8BthuEVwvT4D/CuL93oi/eV6KTlJHPJj8E5tPlVw60XB5STB22ap0w75OOWy4Hqsv7LJK2LG9FNgKZ6jZyYMz9lf4f/5JhRu8pM/7UJcntuSjC/UOJlJvUS6P++TMiB0m2H0OHCG61WuDEHSf+CRl/UfVVttC0YSg5gm6ez5mB2CdmaMjNc6gV8KTOml1ELnA0yzrAlyuzbGQyvt/8SLOHGIo7RGB1LKNNxLLuBjy4a6PX6J9enI/DDBTW7ADlZxkrrECVpy7ofDFRan3qihsw+SdOOgjjEWL8xsi2jpgY2Y+63wlcNmPzNXth1v+hSFt3fwZdH97VUf92KpcdDwyvytIBKbGVWSDSigD/uu+hh4QZ2HQpgm8sfubI6QABHbiGq9UwDS76HdSuxK6jz084K7gJlTz10ss9Q5pdzCZHjeq1jclbLRZwFweB4xtLkGE9gEpbvUW6a8YR0HjYfE80j2ks8Bn+PtSB2t86XIKbgpDtPFXbwxS+dXZnIDisc+2vAZHQwASCj37C44rnkSpfN/V2STK2VthRxFFRbvmdk9/YEV90dVDSZDcK7NBsKtrdu8xxkTiU6+ALdzw8wslkZNqyKlCBT6h1Hc6U=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;20:JZkSJfo1N3Tm6H1xApEutS5+WrQ1ytNlSiHCKHneaP2F44klYEV78SOBZh+Drz/h1HQnzipe/YQleuf6uZJYdY5jdBHjccIavxWGGrxeQEE3P0oSzEGTrhuHjtsGeF9s3SSzgZz5Qsdv2JMZXgtR4WUswglBLEM6Pp2duoH2Qt5kmhVL/ZAzymGl939wDEE1CyMI3+G3XJou4lTB5/wG1WT+owgRJboN73YO0NZaFqOq/a+WTC2islynXgSccCzikObFn4UaklSnI1UPCfFwba7+f3lDhvioB0GGYg5XPh+a1Z/ZFeYP4OqpKwTv94g8N1kLzcYuocC61iimpkxwmroaFFtGztQf8tn4k+GHjzjtkjr9kOMSdWJ4wDnDNeJYKYadvROuznUHDlQRmBCAecuqbJ1DN+mDv0WymcuniRQVxgueTILYdumsJDHygcwtPmQA9Ds2+DFHlCTKjjRPqgcmHzvFu7MEX+ZqNi/8Q2JX0yoRBez8oek9h81bfuU+FlyJVKZE6ANHmDite3JKekpeeYyPFOtCk90MeoYMYEItmb7HP4V0TlQp88OBUpIkgAnW0JqeQRhyKMk8uhU1IeLECMaBRysBXWYy3nDVi2c=
X-Microsoft-Antispam-PRVS: <CY1PR07MB21361EEDA3A190BB02FB99FF9A800@CY1PR07MB2136.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2136;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;4:788hIs+gTajorRDrsvU0orHS9FKOPslHKEkcrMXdP1JiJcn/n//l4cikogv/WfeETh4oADli1H9NeSGBn9nO/FSn18ElmQsfrKN1Lyxme+cjmbU98K17vv4rvqnY9zmcWTtJ3BRlC2XFVi/LVsNzEtrT8C9I0nePKEKIWWJIz5vz29U6A2vuk05TSBIc5NehxOz2zaaKO5cl38q25VAocQmrOulSyt+LpgyD21YJYBonixoK0JWsAysKkcej9Eq81LYbjt8LFwsOMiJFQzXrf0LA/5GkPAdH92lnshBiKhlp7ElAcHsyhu+LzTUXBT3Trj7UFam6fd0a2AzbRT+rN5JQ92q5kqlsk5o/mJo02lBwP/zWA8CKu/XHxnH7fLkD
X-Forefront-PRVS: 08897B549D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(24454002)(377454003)(5001770100001)(4001350100001)(47776003)(65806001)(189998001)(65956001)(66066001)(50466002)(33656002)(23756003)(64126003)(65816999)(76176999)(50986999)(54356999)(36756003)(92566002)(5004730100002)(87266999)(42186005)(53416004)(4326007)(5008740100001)(1096002)(6116002)(3846002)(81166005)(80316001)(230700001)(2906002)(77096005)(586003)(2950100001)(83506001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2136;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR07MB2136;23:+cDONhNa5wbYDI6zU4dO4N2KRSsCtEtSzjWTEYT?=
 =?iso-8859-1?Q?JkAWAWE480GuCEj3D8tm8uQkScL9UryB3dk0bJ46VxLgOX1CVSGSByRjaf?=
 =?iso-8859-1?Q?9OTSekQ5wnyY8SvHK3UoYc+d3V9m/jRxKWPih6FOwtdRBvCQTgzrrzHoBm?=
 =?iso-8859-1?Q?87HFWwxd7Ecyf1sGvnf783zrHpPXiRKP32ns+UqPIxx76MPYpajqbY8pDQ?=
 =?iso-8859-1?Q?nY9Q/FP3tJMmremtssJ1wq3MBMVDQ5BwArkItqhDxSVrG8bL1G8Rb0Avax?=
 =?iso-8859-1?Q?xHvzAEi/D96Ng/ngQYAgaSE5rPp2PCGReNTytwOrDqMttyhZGqxQZTZI83?=
 =?iso-8859-1?Q?uiL7vBUsyny7Sa1F3VWOaBzz3GKOHNoOJKMaHOqoUC5X/y5bbuSuN8K9by?=
 =?iso-8859-1?Q?KgbvQrNmqMULjroMCskiP09p3VWi5qIFkNwq7DdYXuTnDtSGTZZV2Mt8/b?=
 =?iso-8859-1?Q?MW/ZA1bEsKKfjAGWaJQX8rdv6kd+6LzTj0UR55WpIpytaeglmbkkZZh8Xo?=
 =?iso-8859-1?Q?mK8YEcDNS3WeUOCCPczw2gBnxjvvEKA9iPbDtiOFiIE5g1kYF+XC5z76fm?=
 =?iso-8859-1?Q?pr3djl6IMugUSYu+aVGxHtA/SbNRn84UiHw5hZ/lwGAH0sx9Ku3VWDCV2C?=
 =?iso-8859-1?Q?EvSRVh2BS3/zClBxmHkGN6vPNurSmj0H8mlQ6SX5xRhyLL1YZHiFdM6B+N?=
 =?iso-8859-1?Q?/KQbmidSVNEN+zJb7Hr3KmlS5ffVlF3gNMxPBG/9b84v1/VKpCyf1HtEnW?=
 =?iso-8859-1?Q?wIgnBoGOOOFkHZ0G5h9bEOJT4obZWLarVTCUJE3lSBWz9fqi47SnQRQDzz?=
 =?iso-8859-1?Q?ukQLSgWGB6W9yne9vavInty3CMeESiYweZhbWb1ir6xJG9M0LpAz1LcpqY?=
 =?iso-8859-1?Q?B+TjjoDm+/RiFJ8LO6K7xJct+bXGbvtHt0DhwIb9Fah3x5NLE/7yq0SHKB?=
 =?iso-8859-1?Q?rR2nyovZ187VieZ04ojh7hgSguwxHQBi/PXmwdraG3xfJ1uELq0pKy/tSL?=
 =?iso-8859-1?Q?vUBRurVBmecFhnpgFoby/eRbkMvakh7TIej5Zvm3iL4McYHMb8+tKloTAV?=
 =?iso-8859-1?Q?0rCXmKNPKWPCaAGvUpo7g=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;5:u119QL0YCtwUUMai6nKnycUhMpfAXzauVROBoLsCAiJ49nsRTYCVL+LMM9NefXkyfWXb6PyIUuNKGZa7SoaYdh+IDtyZMMuHLcLpN+D6ATP5Qm95JRihFJFMRLegc1sS3a07iW/JQA+eY/1ctTcarw==;24:tI50wZnDhpcF0611rUey8TZi+lJdz5PFm1VvVYE9ulcTAkA5zkteTKhB0FkEhp7AuSdwFcsuFQT7Q5LJGs8lKsaJDTQ4EEPi7avEStwMm3I=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2016 18:37:41.5870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2136
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52680
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

On 03/22/2016 11:33 AM, Ralf Baechle wrote:
> Hello Anna-Maria :)
>
> On Tue, Mar 22, 2016 at 06:24:20PM +0100, Anna-Maria Gleixner wrote:
>
>> the hotplug notifier in arch/mips/cavium-octeon/smp.c doesn't handle
>> the corresponding FROZEN transitions. Is there a reason for it?
>
> My guess would be bitrot.
>
> David?

That is correct.

We have some updates to the CPU hotplug code that may improve things, 
but its current state is definitely bitrotten.

David.
