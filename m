Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 07:58:36 +0200 (CEST)
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:37792
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990511AbcIBF62j3oo0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 07:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ur99J23R9qZLiMuaC8k3C7aulvEZMrZPoE21WFBWzTQ=;
 b=IuDec6gilkH++IgXpNFJoITwFyhAboxLIDR0hN164tnkxLYOwyZnpBj35fB446uR7oeqBRgKv/fuluUHrsJGZVyZZhiFFz+WKKOVqnV2qwwXv4Y+IzEHeMjCXZRayMLBAqXw3W4Wejf0TNWC7jtKgDxKtLIsTcnMoxlh3APfCzw=
Received: from BN1PR02CA0020.namprd02.prod.outlook.com (10.141.56.20) by
 BN3PR02MB1143.namprd02.prod.outlook.com (10.162.168.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.599.9; Fri, 2 Sep 2016 05:58:20 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN1PR02CA0020.outlook.office365.com
 (2a01:111:e400:2a::20) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.609.9 via Frontend
 Transport; Fri, 2 Sep 2016 05:58:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 05:58:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfhUW-0004NZ-V4; Thu, 01 Sep 2016 22:58:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfhUY-0006IX-VM; Thu, 01 Sep 2016 22:58:19 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u825wCtC012704;
        Thu, 1 Sep 2016 22:58:12 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfhUR-0006Hs-Sk; Thu, 01 Sep 2016 22:58:12 -0700
Subject: Re: [Patch v4 03/12] irqchip: axi-intc: Rename get_irq to
 xintc_get_irq
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-4-git-send-email-Zubair.Kakakhel@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d5777f16-0eaf-c3e9-c012-faa5da6ed600@xilinx.com>
Date:   Fri, 2 Sep 2016 07:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22548.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(24454002)(189002)(81156014)(230700001)(77096005)(47776003)(586003)(65806001)(106466001)(65956001)(2201001)(23746002)(63266004)(65826007)(92566002)(2906002)(87936001)(19580405001)(19580395003)(9786002)(8936002)(33646002)(626004)(356003)(5001770100001)(31696002)(4001350100001)(305945005)(54356999)(11100500001)(50466002)(76176999)(7846002)(31686004)(2950100001)(36386004)(81166006)(8676002)(64126003)(189998001)(5660300001)(36756003)(50986999)(83506001)(4326007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR02MB1143;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:mYDU3kvwtgrds2Df+UCeemY09jQ7DDh8F/YRmvha/Wwg29rgnR2jgaH3HyOi05PXF44k0xHrBP7VULMZybLBwRyO9ZjVYVPiLBTmp3qH2RcsXzm4fI93mjYCiMuTH97vh9EGSQmtEsmpWlu9HEwXoZE+YRs6rT15L1d/Mn2WK3M4MD9M46jdzHEFj8m/LpSt6206HHPSR/5tgzE69E72r3UuXY2nGdqP3A49FaB3Te94Zh6JAmw/v1t/DUxcpdW/GwLZ+MsOWHRZGmJKXzjZpAcyNnQCefXH6ESmJKb/wM49vuE74vYwdUP0DWudR7/6c8LMXP1UttuCLFHON77WAsjxvxfHpf921pdPbyAiTVobYQi/nmQXEnK+AWQWYnM82R59IybPtdvegBActXM/BMF5dO/YJX7YXZ1cdzRUWa5MaMuzLWNlf7U0AONAESExKeTQajHLQmYCj9UOPOKlgIPZ4MpAM+QCSBeFg9MqirQDs9EgzoTIBPiY6NqQ99hkkwXtgyOGkg5oDoe7jBaF3/PkVvabMXdQ4SHsci7YW6H2kx7tkPOxvLmFHIfkbaZaqScq8JqtFOS8No9Ybr2++g==
X-MS-Office365-Filtering-Correlation-Id: 0e41fb6b-937b-4f3e-7ba5-08d3d2f62405
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1143;2:Y+zM88NPm3zVRY9FuTzzqrYF95PUXlKoBnAT3+3WWDnlrTI9FZ4RdcuVnUpsMJ+iAWswaElUVkSx8/CdIe4/179ThHWWbCFBwc+FZjEquLtxq+BnYz05OO7Xw1ASgKEI88EjtxKlgb3A3/AtB0zBxnBxO+V5AdWCq5I3Qxmj4EnVWCURn+gXgrRE4zLrC2N9;3:G4eTeACuPzbfFFuowpjWrDTPvbuwE8qq1PuUGB4fXw/IrFggcMifbbbu73ftAtPRWLaAv+dTmI9cSSS2z2Vr0j7mSosz/JG/MAhE6lRT//XTVM4dmqmpurMOc40vAWOO6rUsCXtF11WiJ0qOtybeZtDOphyOx88hEgj9GcBdueIYldT/fxFLqbnP8U/ia+EBv0Id31CdLg5/TqXtB0IoQrsn34rU1bcWCUeER+ZEXn0y8Kkj2a3/TBidDV1jAuMAx4P1zwoYKMoAuCNvQXiD2g==;25:yHTju6cvoqt82tfECqMVZR06JpYb94nCAtIu+L6cNY4URi8/tssaHvB8S5m5CJBchsvD2WEhgvBWRi1TI3dpZ521lIJquqjP2g9Bn4Tzhp877fDLfqs5T6UYkV1Gd9L2iZGMnOQPmHqFhwF7Rez0qdxCzOCgqWNScDqOGDp4muoh11LE+VU1v1cVhe4L0mF5UTlRVQaVjSKejeuPb1k9qUcFJOiM+al766+tmaq8XZ20ZlOY+uyAsCBuldFhwSlopATsdD15aKt0Y86y0na3pX55YE22uoH+jySKKvcoJCN1jv7/7SvS0xZwf5mLjUd1smenQFkr9GFcaX3Jdhqg4D+JqPTSwhLt57ef6tzdB3rxcf/UE2Tqp8vddUVEV6glA9eUVX8cDD6nxd7kt+tMtAGH1HGJFRUuizWIeEMeZ94=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BN3PR02MB1143;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1143;31:Vy+W7Hxn36HtjHo2McNO/plXx3704Ti6hpBtjZd7D3FMms/Py6UgRpNizhhJzUzuVeX/ANrMkcDDlmIhVjVDQN+5VCd2ruH33Fb8GZRU2M0FMcDLAYPkCPON99mCDy+bd+FzjRwnFC49yyXdCDQaLSY/Z6oSDCTp/xx+umgSt60Ct8nwBP9/ceS5J0Ixql5cKK93zXchT2VDj0bN8/hXCohjNSNuYpj5kLUsSRZTSMo=;20:8bJfeHQJP0/Edckix+d3aeVafY3bO3+M2B9xbJoJUp70T5QWy0kdZYSwhxItQgMWwOYeDzI5CcIp7nP1YHvXpWnQhwL7wS1KlRj/TSJCS+eqVv7y7SEi7zao5I3wsPNEGDHtBWfca1r6ZEOkhAmNOOOCxh5k0h+qunHRIwNhL7wGHml8STLdTfWqJoUeWNskZgvz62pZeap/pnX/1+EPMOJMoxK48IBS+NY3+ny6N4RbewykoMLhMvlKnsrsOf8q0j4eLnT41dhcNcq8QeFKUtxLFAcaXuggBTbdVoaNfGKVSgXOts2/NjpeA7JXj9XTkSFEYRk3kVaMe/lIJ3NKBuQybEeMOsBDB7EMLOXIRGspt6hOoGzmaOweE1TRDlBlnOD7kd1CmS/7QoOxkjgas5JfuIZxaoql27SMV00fVWkAwA4r/oh51Y2gtBzJ7pGMINElrjDlXJMW7qNHLhfhMOTW9vLFUy21eN4sXodkVoEAE246MOmggf+RgEy6Xs0k
X-Microsoft-Antispam-PRVS: <BN3PR02MB114330814695F124970243E2C6E50@BN3PR02MB1143.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(13015025)(13023025)(13024025)(13018025)(13017025)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:BN3PR02MB1143;BCL:0;PCL:0;RULEID:;SRVR:BN3PR02MB1143;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1143;4:BHi1XIgXYvlg7ab9m5cmHPDZsj5x/TRIg0uesg14BNbLxFDRTJg5fb+1MkDL21n0dX0P5a/pZqeYRjbDKmlvsz2WyPSzzgqdcfE0RQjDpvxgGaHLZ1cDPE5tZdujUYq19U75m/RO7sdiWKeSFGdafKYgvaJ8idJsi6NtgWPa2P15HDheQTJg+WmkkLY7FzYM20z5Se8E+gc0RTO56523Cpiq/1S+YEbL22wVgIF0h7azJ+1TsNN8TDThARjgolwB3ic3hfXHR1Q224w3dZPckBrGl9wy8NoaWwf+wFbvYwTaByIXZiAU99kpcs3E4OO/2Sr9fFllCBQNJIIi9pVSIeADpTiD77qKXMJYn2Q0JCNIClN5gzvg5w/YZyi0vpOahzlH0z+WfN9XBiOO6MxwiTk7HymOT3Sk1ZFsmgZWV7KKc0t6paYBYZNwcoGucbipDaIZfDhELWMzOP+gxJMrTiJ1//M77j/AB4qvQCkDBsmH1n26QpVOVY8/t8Uc6GGQ
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN3PR02MB1143;23:hQdhxKyEUCGePs9qVeeQeI7UiQ8S3MKqqppsk?=
 =?Windows-1252?Q?IE9ySo3QmOj8yofnudtlkAfHcZSDD/uUQLFdjFKSiUGo40LFXtbnLS+N?=
 =?Windows-1252?Q?+JGD63nJdSioRe0ivJPkDkXFJSKxXam8Po8jw6OY4e+/owBZC4pe+7cD?=
 =?Windows-1252?Q?lGT16mEvz41Ibi+MZVlNVR/dscq2LuaVVzz7C3Q3PfXXB09Xx8xlkhLq?=
 =?Windows-1252?Q?HVRzW58dL03vT2Ls7tdlMnHl8qR8Gx0eltrP0nNSy4aRM9QqjVlw9RYH?=
 =?Windows-1252?Q?0N9h2EzFdsmz2rMyiCnyXqQ6G2fYXs2l1va8PDrmk4mwBcxTW/b9ZRRd?=
 =?Windows-1252?Q?qatblVE8agg/t/2GVO3QI+kaQZHg3rGrNMQzMCvMkTtvqSReHRySZ1/N?=
 =?Windows-1252?Q?m8J9sPud0DDxsVxY4qKgEZE7jWbaqOIqoygCDKZ1xZb/VHbvoAHm7XkM?=
 =?Windows-1252?Q?IXTPWN6RkXoJzOXl1o0wEAKBzNStZoofAK7lTobC2GFOO/eMXi5qbOeU?=
 =?Windows-1252?Q?PMNpUdu1NXsx/WwbaA4naWGFB8b2XmOY/ini7PoqJkrd6W5jWRKX5gUu?=
 =?Windows-1252?Q?N6RmeZqhqCljfMAxXuecuVTtp77/tZvq2nGAHZegrmg3Vycf7E3PNSW1?=
 =?Windows-1252?Q?YfKFN8DToVBpaPxiS5PUY/L4wnZ/UWA79gELBAp6N3tvdoPX/BMlO65v?=
 =?Windows-1252?Q?xNEp7lRfmrT4sHfKQccr9RkgtdAqjKwQyN/I8BoYusg/TL2qv1xGjaAQ?=
 =?Windows-1252?Q?TV+w+MU/4BXgbPqQbAg7CYUSNhrayRoFIq/HhbM994/IyhfTcBSQjo/b?=
 =?Windows-1252?Q?KBnlV044AxMi+sj+y2rZXVZ8A/woOoW6pkfOQKmMYEOlSRZ/mzvP6KRj?=
 =?Windows-1252?Q?NO+3hl754iPpFtkWK6q6aOcpTOhm8jM19/rImafxpJcgbtBg9r49vgSl?=
 =?Windows-1252?Q?8pC7rP0jAYRes/2qgMJyRAqN0jzvDK5J+MocY487DmONFSg1DktlbeKM?=
 =?Windows-1252?Q?aXoKoBHdNZakIOTJyhIx7NAOp5Wcu8RfEWIm8pXLeKxJMceElzzDocjG?=
 =?Windows-1252?Q?E9g+zw+dQ68CsGSGiDDsYCgBAT0asZVbaqhIaoLibjICd2osq+UiLj/k?=
 =?Windows-1252?Q?cW8QePt4Suy5vrHaIC4B62ybnnZD/TADXBKtWdxt3Tny0MFxiW/rQ+FV?=
 =?Windows-1252?Q?TfbXZLRDsJkrHEUBIKoM5MMS3kT+nGKf+XiTJKR/zUfIo/lQ3mj9SKEU?=
 =?Windows-1252?Q?ImrA5dbCXk/hl7kTsZdqTXCDIMV5bZeBSgnf7eoqfn9Uebrw0J3hNrmT?=
 =?Windows-1252?Q?NbW67OER47sV8s3VuYAgaSmBw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1143;6:SDQBWcdOoI6TrWPQYJlwM2HNd5odmqx4/lSAbk5CENsdox48iUKVZJ4uiOiRAK3blrJBj4hCFnqd5Jzs3dRWpyTSpUej45mpA6BQivzndjtSs3W7jWCoZpbguMCD55mxQLpN/G+E1Y47/IiOExsHhRMFsfAhUg5Vq7+ZFRaGI7U87qY/BTv9BvIWr+XdqXnSgb09KzRpe/aFo3ybzsbNkA0RIlNFvU0t8wtxjDUhoknzQqpqdEeSBSuUpsfOjIHgVoBzasZOELcGikNdXLTXq/WLUB5AS03NU02oHz9lm+uGdBvUUfWiGpmERNX3/WoMDdwmjxI/3GsCxxu2XH8sSw==;5:zbzPyUOXmUMrLFEKtfnOlebZpskC/0lulc6g8SbX2YcaFKd8cP2HOcMA5JMyJkBDJq7qj1+ikefyQHkfhfEORs3pK4dB3afqEMnccg9rt8X0dBKUvlDTwm9DhEe3XWl3X4/XycP9VTK8bNGbyqS5vQ==;24:y5rH+edYO7Nxj8KHugvh40j0OGKQl9AW297FRqVpGI4PqNivPXprOWOAb0tmriaPRdm5RhA9LjuRat/8IHz6ghLSY9QDQO/r8cciZKjCR+s=;7:YnU25k7EEGrE1ezKkgvAOaCU+vp4O61NzWwDzWAfZmDYP+LZJ8EuCBxZd61lgtNNcnKMMxd4MbjnGn0KMuCAWDgfVV7fxQwD5nru1Q9sSMFE2/XI0hy7qHpGU4U248ux29D3TJD9+DnfATHtitDZayExlViRhYBc/WaLas/wQcWjuTvT8oktFbz5LORHxBR2wsn/YhvGSSd9t/MsLzsmegdVGk9lhkWeNMXWHhMwSQajUg8t35OHIAdQO412I9aj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 05:58:19.3748
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR02MB1143
Return-Path: <michals@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
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

On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
> Now that the driver is generic and used by multiple archs,
> get_irq is too generic.
> 
> Rename get_irq to xintc_get_irq to avoid any conflicts
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V3 -> V4
> New patch.
> ---
>  arch/microblaze/include/asm/irq.h | 2 +-
>  arch/microblaze/kernel/irq.c      | 4 ++--
>  drivers/irqchip/irq-axi-intc.c    | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
> index bab3b13..d785def 100644
> --- a/arch/microblaze/include/asm/irq.h
> +++ b/arch/microblaze/include/asm/irq.h
> @@ -16,6 +16,6 @@ struct pt_regs;
>  extern void do_IRQ(struct pt_regs *regs);
>  
>  /* should be defined in each interrupt controller driver */
> -extern unsigned int get_irq(void);
> +extern unsigned int xintc_get_irq(void);
>  
>  #endif /* _ASM_MICROBLAZE_IRQ_H */
> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
> index 11e24de..903dad8 100644
> --- a/arch/microblaze/kernel/irq.c
> +++ b/arch/microblaze/kernel/irq.c
> @@ -29,12 +29,12 @@ void __irq_entry do_IRQ(struct pt_regs *regs)
>  	trace_hardirqs_off();
>  
>  	irq_enter();
> -	irq = get_irq();
> +	irq = xintc_get_irq();
>  next_irq:
>  	BUG_ON(!irq);
>  	generic_handle_irq(irq);
>  
> -	irq = get_irq();
> +	irq = xintc_get_irq();
>  	if (irq != -1U) {
>  		pr_debug("next irq: %d\n", irq);
>  		++concurrent_irq;
> diff --git a/drivers/irqchip/irq-axi-intc.c b/drivers/irqchip/irq-axi-intc.c
> index 7ab0762..ac31548 100644
> --- a/drivers/irqchip/irq-axi-intc.c
> +++ b/drivers/irqchip/irq-axi-intc.c
> @@ -119,7 +119,7 @@ static struct irq_chip intc_dev = {
>  
>  static struct irq_domain *root_domain;
>  
> -unsigned int get_irq(void)
> +unsigned int xintc_get_irq(void)
>  {
>  	unsigned int hwirq, irq = -1;
>  
> @@ -127,7 +127,7 @@ unsigned int get_irq(void)
>  	if (hwirq != -1U)
>  		irq = irq_find_mapping(root_domain, hwirq);
>  
> -	pr_debug("get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
> +	pr_debug("xintc_get_irq: hwirq=%d, irq=%d\n", hwirq, irq);


%s and __func__ instead.

Thanks,
Michal
