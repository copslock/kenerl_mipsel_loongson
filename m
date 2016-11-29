Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2016 19:22:54 +0100 (CET)
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:32650
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992128AbcK2SWrqWDJ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2016 19:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ayL0jGXezmWqkSzJs7jRM924n1nUcd+Ybbszw5GP3F8=;
 b=PH1JoUsG9LUANsJfgeLDwJ2ls1GFldd2MNMv1419ifEJmKlHVmG0C0ekfaUG0upYqkqx66CBNknlz3YUYJzvnh+Yx1YhX2MKgugLRs1kjEpPp8XmoN0Wxnq0fhwu2yPIjSHfjUC/IBthkfu4+BGlIxzZSN3CgYVHzczIPA7ZVWA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.747.13; Tue, 29 Nov 2016 18:22:39 +0000
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
To:     Jan Glauber <jan.glauber@caviumnetworks.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana> <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana> <20161129091928.GB29487@hardcore>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
Date:   Tue, 29 Nov 2016 12:22:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161129091928.GB29487@hardcore>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CO1PR15CA0036.namprd15.prod.outlook.com (10.166.26.174) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-Office365-Filtering-Correlation-Id: 47f17638-08e5-45a0-5f40-08d41884b429
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:vYGeeQqbCzB3D6ufRZMxK3PalHFknmDqlh+lom2yenJ79BCMsYDPPDkBVxJS/kROY0yam9Vj9uIwlqaXYR4q2c/fKjuL07SYgswNv2f5g0dn2qMDCUrytDzXrk7DFWUOX3Ke65fEdljBAxr/ZxYcJQvpwq8sCSuxaLu8+zuQ/xY0kugot84NUZh51npfr2vEAO9XSaJ5Y2jWoZYjMB/oieum3LcF8SvXw3+m6xgeVr7CLZ24sUBwjzJm2be8CwZsGEMxtZsZOcf7UBJUKNvu3Q==;25:yAhUMW6nqNMgixGsw4LzCt5/hAckAIy+HjelX3lSi2HNhCf13ih1GWzsHul1pBfRDEUvFBoaq+7Mf/W/WJ9sIriAfMCEyvvBbD2Wvx8xv3DWtaJDZFqKDUwWQf0uWg0HofAymRoG6KgyW5TATOTRXiv4ANOYySesmjnmXn9XP1Y9/k7/Y9bRyKaraBoCvTomaeysDexyD1hPEVs6uqxmuxhmQVHADK2cmWt5oclMIUa0kKm0MJpMtcEn4tNqY5rwKBJOgipD9Can8UHJsEV4Ib9qp9xONeNAjrV+5fnhIFQhhwg54FK+h51CsP3Q/roYyJZnB+fO5Ce8BFO+6ixO3RirpGIpTLhxaEYu96UFq2PNkERE5EiPop8eqfoZ7VOYITLI8GIEg96b6uW8aJw+BNwe5VAzwmFsGBBWSd41SxzAS9z7VUGJBh2q1GBKqxZ1QM2RqgkGTqAcKP38FhHzqw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:qnhpkZYDUIlh0RXGgn3My0n/PtckNmjaQfHHH+iBJZAuAArvU4sJIUTJsGf8GyXy0ZhuOfJ0EBsalOX0BShdArnl1kpn12Tb6WeDc2OnsoW1raTOH8RFmHR3ofxzwDXK02BgD8+5wamvlTrYU5tVX3nVLb0qrc4TPkxl9r+mxhQeC85LlUN2eXwyJIQZF8SajaT9oEwBSy40DgPMwVgQxuPGxHip4Ff8qj564ioBqlJrJQRacueG6OmwSeaHNnH/XxWiFm7XQb34+0GXO4+vwQ==;20:J75+qV1JBEAnQGfcKzqP8BcRzImdz4TUXeTcHHZaQxgLl7Su1TqZpUSMnaT6ZBBPKvfitk4nO/2u7MX2OPkh2GcGXEdcyzieglTlllHfPGPYEZOXwMpPpR5Z9YqUECXm1YYBMBYksgtAH4SVOfVdqvyPxke9qDMSmuZ/nC2rUhSjI4fS+Wl1GplbgF8ZH5gNJyrSzO3dfrLwyHHDx/INSr7cei5s041fS9nYlZIVBpV5KEIwoumwhcGIoUStAnvQ0H5umMGA9oGmB7mO6+NgEM9Jb1zUeV6NjOOCvnw/QTNXl9uMHrUgZ4wyixnkKgreLsiF2oAFSdy4qukjEJgC0T0Qy8hDDHfCMi+DxHRKm2iyPVNGv5/XEkkUO4mv1FCfT6A5nTGBdsnjGRhaiM1W3XPGvcO5Nq/rq0Vqq3Y1jna2mUXGp3ccPuZ1qsM2D0EH/T+w3T5KtkiuWVeO9dnS4s7uuMJe4lGSZ7Qo+g9/KoazkI087Y6+M2WYJKAIl8W7
X-Microsoft-Antispam-PRVS: <CY4PR07MB32069B61AA46110902F209DA808D0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040361)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(6061324)(20161123564025)(20161123562025)(20161123560025)(20161123555025);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:UqntoX+5pIDpxEtlZGLwX4ytmdpy/URWuBRzhwSz3+coJUaGFnxtb78IMVrIwLDyvD5Uy/H9LnZj0whtfwJu8BlI2uIvPi22auiF6zne+KpwapS/Zn7o5m5j2qhy4fBOKgO8ftyy7wO9sppzs36E3kP2wgRfOCjN5p/4HZY/QWnsW/cZNHN/LgnAlpNTYd4OJGgvoU9DpaCNxcwJbkVl6ELQ8ia1TZq1WkIseQkL+MnASp447OrHFc5ReOcHVuiYEfcm2GcqL99T3qM3C6ffQKIX+EnuVwCbQrElX+zvyywTKRlegvwwNNqSzbfZLLdcQVWkQv2C669aJYzomM/Ic4tghlcsotsW9qn8c+TMv26LNDK7WrpGce3rkq94M0AZ1CJZHr94IFJXVynlc8EAwJGV522SHeY1wF496/GpkpzZIzC3ByEuqaUIMIAoawhCJtNzr1DVKwk8INoS2J+T559Rj+3LCCs9vMsRXDD99zj6by7ML7hgoKI0YNBZ5CZWvxvst82xqx350u9KV4pUtVhZyMSJluUTzKZn3E9x46uYv1gphjeS8k+DlNLV3gVcIwEs9GvU2uGSgwBscRc0jphW0MQkc2RDDQ6KlxpW5qk=
X-Forefront-PRVS: 01415BB535
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(189002)(377454003)(199003)(24454002)(31696002)(47776003)(5660300001)(65826007)(39410400001)(64126003)(33646002)(105586002)(31686004)(50986999)(86362001)(76176999)(42186005)(68736007)(106356001)(65806001)(54356999)(6666003)(66066001)(65956001)(101416001)(7846002)(3846002)(7736002)(107886002)(305945005)(6116002)(8676002)(4326007)(39400400001)(39450400002)(4001350100001)(2906002)(733004)(50466002)(39380400001)(77096006)(6486002)(4001430100002)(93886004)(230700001)(36756003)(38730400001)(97736004)(23746002)(81156014)(81166006)(189998001)(92566002)(229853002)(83506001)(5001770100001)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3206;23:Drr6L8G7wM8kR3JrIPQB+EXcQsu6ArInkUPt9?=
 =?Windows-1252?Q?b8RLHToHRMywzsb91ZCIP/25MM92PdGvp74IEDHjVov6nFAEtOmO/h4f?=
 =?Windows-1252?Q?fWtLNDg/vNEtEAmF6G4A5TbwohYDkzRFYIAr7cwaU2SGQRYxd4WR373a?=
 =?Windows-1252?Q?Y25il4WB33GTdVxrWpbeevtNqTKZkDZDlhzYjv9S0FrZDtrgTB4tpGV0?=
 =?Windows-1252?Q?aAXILJ37Tz2UaMmdPH19Fya6CuJ7/FeUR2UXsK4LDl3VxVDA+5VBn7Ic?=
 =?Windows-1252?Q?BVYBTOtwmoDFwj28Nyz0gpAA7eXo4Fo7stVlN5sBpiMCTRzWFqohCDxa?=
 =?Windows-1252?Q?x/P60nv82XfbrcC74Bw7Pj7qFkIAtuhmRevTdVPHYZgbDZOpIm4gOv1y?=
 =?Windows-1252?Q?nJDVYjkkG7FM0fiGZfmkm0y5uO2Z4HzzJ7uuxV4O5BlqOkY4Bv0HI3Xr?=
 =?Windows-1252?Q?frBO0KQefGL7tKH/w4zxqOhogmB9mnpiAb8AajBkXh7XnMQljB724RXw?=
 =?Windows-1252?Q?GPLihfEEChyhutGzJx8uSXdPvzURLNtAeAerrKraIHsyqbtzfocsw/yW?=
 =?Windows-1252?Q?hJ4MMhyExYHuKTuInf74sijpYlbkFuNBGZxyc90Hkd2stebsyEq83LSI?=
 =?Windows-1252?Q?mBqvwSzn4FI6r8ybpf4cGVhl7hRXAO0R1PWkI7jJRYIXjVUQddhXGhYz?=
 =?Windows-1252?Q?EnSUu2dA0W9tjFL5FjZg/xd0fnAdl8flup2tPoJfTEhwzkLqdoYt1gmw?=
 =?Windows-1252?Q?lP0jdi7zBidF/HezVOL7UqEQ6BIARMxkC8VCbcbYLqxpNp125VXlMfOS?=
 =?Windows-1252?Q?NW6kEMQFRFTIq+N2D9MjrRgDEUhXLR7jssVNTKxpcFnLVKsjGC7mTePm?=
 =?Windows-1252?Q?2bLjACt1PlsgvOqjuH3PJajOb3OEuaIsRNoMZNNJS5rB4C4gRPjHvYsM?=
 =?Windows-1252?Q?xiX05hucJNCf8Gvm0BzrZsBmOdX1NjyYnADcIWJlk4dB5J3dnYt3miH3?=
 =?Windows-1252?Q?HvgdpXh2X6GCT9UGsIMC5NzXKItqGH3eCeBhRt2ZubEE7CjqpgPSe3Nk?=
 =?Windows-1252?Q?V/4vDyglY8wrFhKPfHmec19RUZVkhfmygmiN31IBv5DCm2thsEualql5?=
 =?Windows-1252?Q?Z6fMYhez6obqHWpvfVFDF1E4gdD7xRyYeQEj4tAZQAW7LszJRSA0TLHc?=
 =?Windows-1252?Q?Aap+3P3/5UbneAVR9HPQ7JY7Ufo/9YDqDIFf4sPBvj25jDT+7tnkCfBQ?=
 =?Windows-1252?Q?fB0HZ4Nm0EMkgG/9AdMB8/cnJdu2flzQpdAUd5btNNbXtMtOsQ+hkC4r?=
 =?Windows-1252?Q?l6ZWt3cmRYTmPRfRJy3xc1WdHftuXCf8PUebdeiffDGJrk/sC+hJ8FvU?=
 =?Windows-1252?Q?5j0hMDC4+4lwDCz1n/ovoqcAMUnKzNu7VO2MsiIL/Gty7P5WiwUtNwn9?=
 =?Windows-1252?Q?CUxIdJMyyb2sEwe6F7wPBv0kjh+07frdsAlPoRX6BQdrAvbM7GPakJVj?=
 =?Windows-1252?Q?47w3DPxbKnNFm17kQgO0T/6Dwy/5CtOmb3R3tyRlOapT8dEAFS2sdXOz?=
 =?Windows-1252?Q?/cVE/tm/6W11dlb9tRUcf0YX6sr4Ef3mK1oN+aQvYe2vS69zKEoKldp0?=
 =?Windows-1252?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:D9JuhCczmr1XtzJOFo8cb5+/SE3G1pEglzf4NVNW2gfQ0aLNyBrr8wHxSfkLXcCOexDIFmB43p5hkvkYnyQmBMa6lQUwTK1xl+OuqO+V94gFvJXibEZ2gsDiEu4wl/XrJ/P04e8JzjLBrW4wcoNEVfCJbunOoP+rS/8eMDib7hXhX4LbbrLH22GeE8iLRdCgCnS2J+Vg/co+jme7+qRd2uDJY4OAl+UQUmotVHO4eOEFLzTaXNZ8Dd98rsU5btSZa5mn/XqJXAmuoL938TTTtoXpXX2Poh+PrvelxnuEp51H1LRHyKpQ1sE5TN9TNMBVArAcWFDD4FkCOc7MspM61GuOAeq0pyHbM0tjml5KaaIHqii/o1FbspcXlgQjdZuStW7DcxNrdFxKUGJmRMsuqMY87Ca/GENq2zvIlY2JBwgLDehrEwuGGTqHddS5+wtcx8iE90qeZ3dfgBaGMjdF7g==;5:gBL8lYq/By1i7lG/Fe1YYHgg79BTbmdnhV3VOL67HjgqU8Ro1BTVTzOvWM9Sl3fetnHKCV6rXiP1N3Gn9b7Vq+4B9dmaECy1USlZKt6FX84CQr4zyj3rPe07+9CcTpyo8JmEblDJO7QIumjVzA4loKSScJSikYW0s2/XRRywvtY=;24:B2X7B12SC4EXVcmhdF10jYcT7qWPHcV79X2Ny5amzog9YBHovd6ExzoGHhdQcs5KJgPyBZ4f7vhg9OZ21CIHal1dB8V6FBrIXYY0e3uMTPk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:P+pZ51C3KsN2VQQ5QyAh890EUA9F9wF3K4JsjqXQZRg7D/4kQkC7QDWd7BIOTSKRnEVYb6iMBWryeEcOC/pz/nBhOiYrju1SErAAcY+daDmLrBpswm1HPDtdlHy8hRGkt0fEmGk+WuDuXI/4ywOFVJG2bQYjNB7OGyr0Wmkr4tKC9weBD//A1n0dMfCRNLxCIVVIaXU8opsjzequHvZbgTtsJ22LaIFMWet0e9BYWos9Sf7G6002RXCbVxmBfJdz9PtVDv58ofmpGjPQxo5yWMFQ+27E1eWtg2kyQL8EcKwsmM0qfhjbQjoPv9nfUdvkBudU5iw0YRzT7ECIqfZhGYEsdBXrT+eRUKrlNQUXl2f9rveYx/GVuUyZV8mW4d3D0R/z6SO7708pUrWwfDo3mXLUNFIHihftSvXJ6zEjBauCmxsIWgGTMaouAtMZa7Z4CpGoagMBbwBkJK2dFBSurA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2016 18:22:39.3193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 11/29/2016 03:19 AM, Jan Glauber wrote:
> 
> if possible we should at least revert commit 70121f7f3725. I should get
> access to an Octeon 71xx board tomorrow, but I'm afraid we'll miss the
> deadline for a well tested fix that works across all machines.
> 
I second Jan's advice. Please revert the commit and we'll have the
fix for the next release.
