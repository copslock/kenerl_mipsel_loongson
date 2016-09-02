Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 09:08:52 +0200 (CEST)
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:52352
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990522AbcIBHIoWWr1q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 09:08:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6lEtbpNSlFoVlaodU4cBWd5PbJwsTkAmEXb/T2Tt7xc=;
 b=gJHOkQHUlprZcFZoodb7ve0mbWTf0EYKsT6KVPuPmUWznc7881naNVmcUxK6JSeXaHPU49QVozc84DltvFagTPO2mhCzcQuF3q/MM8QZwRQyDmKfO8AAkdMpqyW6ieeO+KklURWAuePsuJ+WjJrjglCtn/KtS2h/LK0UpnNOCLw=
Received: from DM5PR02CA0056.namprd02.prod.outlook.com (10.168.192.18) by
 SN1PR0201MB1503.namprd02.prod.outlook.com (10.163.129.157) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.609.9; Fri, 2 Sep 2016 07:08:36 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by DM5PR02CA0056.outlook.office365.com
 (2603:10b6:3:39::18) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.609.9 via Frontend
 Transport; Fri, 2 Sep 2016 07:08:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 07:08:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfiaW-0006zK-Sn; Fri, 02 Sep 2016 00:08:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfiaY-0001xF-T2; Fri, 02 Sep 2016 00:08:34 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u8278STx013948;
        Fri, 2 Sep 2016 00:08:29 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfiaS-0001vK-Ks; Fri, 02 Sep 2016 00:08:28 -0700
Subject: Re: [Patch v4 09/12] net: ethernet: xilinx: Generate random mac if
 none found
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-10-git-send-email-Zubair.Kakakhel@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <97b7241b-941e-006c-498f-2dbffdb9d951@xilinx.com>
Date:   Fri, 2 Sep 2016 09:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-10-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22550.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(189002)(24454002)(199003)(77096005)(230700001)(2950100001)(31696002)(65956001)(50986999)(305945005)(36386004)(65806001)(47776003)(8936002)(4326007)(64126003)(9786002)(5001770100001)(50466002)(92566002)(23746002)(4001350100001)(7846002)(83506001)(63266004)(65826007)(2201001)(5660300001)(2906002)(36756003)(189998001)(19580405001)(87936001)(33646002)(19580395003)(106466001)(54356999)(8676002)(31686004)(586003)(81156014)(76176999)(356003)(81166006)(626004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1503;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:PTvFvPYX0R7OOC4stNINeuiPlywr5c+chgkptDyk69/A4ipWZ0bfAKaQ5/uyPzNGC6ZkE2zbSgEhx5SbWzpGy4seKL6Hv96rxA+J1AFHJIPhbAI/O/deUSyrUCgP1Pcvtl4h9DUhteWXa8xpyCd0O4XVtXmBW7EpN3RCIlljlFeNn7GQa5BcNAyolRJqc/PJHoStE+KiMvIyxWoGUu/8nXylNfEpbna7DamQZl4HZnsJC0p1Cnj+MqDnTEYzy3NhARWqp8TzkrtXmxUd1vmALbZAdYiWb6PpDrx8A8fhFnVzUJeiv1i5BJo7JqAs7uuQL9zhPDqG9oHC4gz1Ii1FZzm8AndYvSPkZkDkhNNnNmRB4/62VRTls60rN//cmv7UP7MkCf+kHNFCECkxOHO+khZuuonrUA0d8ht2kEbuJ9dON2vJbzKWeOGVgy6rPu+x9dl30dBuXrZ+c08CpHK9jfVVocrbhnkydkihVsI++hOf+ZRYuv5+NCXssnYWyV6yD0dy4CSMT+sbMUb4jnHvkzj7RXNq216XftvTfnJPdWrxGVc0fcirCpCgQc6SU/zW7y9D0s+IuNxtacJQfOjuyw==
X-MS-Office365-Filtering-Correlation-Id: e2811e0c-7e1a-4ebc-b541-08d3d2fff514
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1503;2:Yt51uzdJFvoHH1vNDDw2xo9hr8aMX89OGBOwqt2P5MI6lLDsOwssGbBcnuFCLCag2mw9N62gUTSO5aH80Gdta5Pz1SlzUelviadp8qal8+hMyrOvFCJDZA+D6V990qSWPPYQnE/Z7gQjOB8zKyEr1LDDYDREUyyFjbNQA8acKG0I2A71rrgt+ABcq2XBL0xq;3:j09g5f+l+ToEnxxN1EMKFVwS8HONpuJwNQSCrrMpnCxxUkG7f9MrZBsqmI+qZi+qVi1OgWyi4j68DVDV5w9SqsfHGkEbxTHgCpAhH36RMbFG0X/pg4hIFYd2wyFzA2fYPq71fNFq+jhGV7Mye2KS7uMeEUFuBV+mpHhncUrYmUy5FuGcGp4emoPUb8MI94TnxHCn74XRO7zGm0E+GW958fETOe/XHdbd/FW+vDl6M5ysApGhNVxA3ucdgy2q6+qjEAKjzkUNv9k+ZoHGQtxAlA==;25:U3ewS6Euws3OGxtP8GKnMfv3i0gZiA9r+EC1DrHFM2FH91W7oyFhUs7pqqJYtuvNgsR1MgRn+QZhdFyCJW8Dd/kp5TaRxSjKJq9V7fvFLZUx3BH5/d01LnprjYV1HrvBMIdNIaoGiMKW9jDetqeKGPP+Xctsh1FbPRypq/F1a1nMDHOVzYbV5YOP2GUh+ExWUrIePYXpAhoR/Tcx/h4VhBKojpBTbQHSLEaQYohrDgzidzyQMir+QBcaJopJe0dAQfk+M/Qd3BlwjlSZBei9VIfkpDVGhm28777AF/aeIz44Hrov6cv98gZ+WRWGBN4cT7SdIMM6LwC9NoMiI6RRhx81iQhtDvXrK7rkXDSPkbiNnfCRisAPdmJO6A63noacPeqa+dLd2e6vRrIx9a5raqO+C/Qx2+Gfhz43ZtBEYzM=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:SN1PR0201MB1503;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1503;31:n2LOKIhba9jeYF7jd3Rhf3rqlaTJtCVTgZoM56a3WX9R9ZMXeRrGtdmL/miaLX0hwt00zLvYNP5G0AeTAxCSBWm96tzMr+E2LgkxL3+kawh716zhVrJrRRucVTUfe+UuD9liga6kCA7TAZQuHtHosJNmo16CPvDAW8+eGpy6F7h752fkdS5ITrzoDskCNSyJ72VK/WiCzrSJNtF+N1LaH/meEvTGZO3ybGUNoszSKRc=;20:9z4bskA/ySfRxHZbWIfc9UADfjiEKsrvCYEh8pgJD67ZQ+l1E1YQmJ9lRY/pqoCaqMA/UKmHk60D5NaAJZaB4x1YsYhaeS89h50zNvdvtri3r01NsfDadVnLmSru4fE5unTRpCtwfnQFBZOpkB5xdf1iL2r5LZ0U0b9rSFoiimnMS6xwzKpUjCtnazPZq8NK2DaCqY/QWka+xv4hj/G+7y6/NHX46y0ud3+jCassl9/kyQGeZTxxIpoC+/3v/hgdtWrXbvM54WBBDAT6LXImiObpotzFmsbh4rkaLBHEtRpseY0Nx0RSOD9ZizgsyaVpfnWspEER/XCRt3EG0WDqWZUMraKDrSbzyrs/RZc4dC6LSqVcBmLNVOShLUuGpgyTY0/jweCN1UnlmAPD57Yu3Ebn01ov2nzcOlA38DBFaxs2D86vci18y5UEs+xOmn51L/ggDnt3safMmDPiYblHoMop1vLt++Fb9uerizwlEDl10i+fz47Oj4pNGQNrw6ZG
X-Microsoft-Antispam-PRVS: <SN1PR0201MB15039C125483049BA523B782C6E50@SN1PR0201MB1503.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(13017025)(13024025)(13023025)(13018025)(13015025)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:SN1PR0201MB1503;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1503;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1503;4:EcgS9k38DRfw/rymuBKPfnDZDvJsCM2PeFTS9jDdScm79VuiVyWmdvpzuQtIoDlnJ7BWJT/nV+EcXBSTRvd0ZxRk7VmYcQa18xYmQTlz2utMKJZtZDUFqdcTAsLCJoVxv3IPL4nEcNA1lwrW5yRM+1KiL1G92agJfOURFsaGFHtDuCjnUgVn124P1QkCrqaorBCDfIa0u/WugwF0M6wZdBScjycjHkcFnx8T01Y4ygEggIJm0g09wokW3iK4Ckpcb3jzV4PyoJtW6gsXaiC4kpC934lB61Btt07AecGDL4sokt7n+Ccst9+oAltSFl5zlpL3ds3j4LEbB1AkugYoldUnwuxDKxGWFTrsMHJHwSdiNiVyjPlUBKhukbvs+5HiurIPqkUX0RJOyft9NkAi/Pua+ffxbPwCFG8/pAgptz+SlzbmB7JERpMTGQEfybHesj36tXgft2ly4+/BM86c1yQUB6mby70/3pNeuScYea7p8OewgRf7bRFtaLRz8hJb
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR0201MB1503;23:nRxviXCAEr38hsxPfu3aFmbIr50kPgJ1bBa?=
 =?Windows-1252?Q?mChgJPfIOtdWct9X82oIIzpU9ZfJwJM5wLaIQuQmOb2syrJmSmjPfZEs?=
 =?Windows-1252?Q?FbKEAmXrfFTVZkVtzgwffo+bju3PTAGMSlLArT+Y0/4NCG7Nq1Dfq+Ic?=
 =?Windows-1252?Q?dX6fUuE2kOUAbli1vwc/x3msE5Wbsk5e4qStcfcGJnjEb5Y4RmDSoHcd?=
 =?Windows-1252?Q?lMfdaFyzwvpnKpin0gdFDpZ7kN+3G+o1ZKnDmlsar/7N0f81rvNZoFa7?=
 =?Windows-1252?Q?hyRKcs4/1yrJV0gd86q5HKKYtTYZOQdzokBmbyr/nGhbrZiYZIqAaRS6?=
 =?Windows-1252?Q?oUoQjfFIWSfcpbq19oVSoZP23xtdzaH/7zYrb3jHi+L9/f25aNE/vwCi?=
 =?Windows-1252?Q?+PY1dB1yN9TpGpfFakQRVlyHSkuFpez5ntTbCGjNdD0leb1qBsHoIP6D?=
 =?Windows-1252?Q?SrvqWBn4MVRmnDMKq2iOW6pB1p5UR3e/B0wOSsIQ5jPvrfO1SpvNyqeq?=
 =?Windows-1252?Q?y+5t5l53rAC5zvdLci3pHTPKn0CRfoO8C7BxX1gJ5a0j1r4PpoRYXp4h?=
 =?Windows-1252?Q?PBZaF8tNz2j07ZOhiJDeoXgHxi3r41kCaDuNgT8lq+Zc5+LosV0czAM7?=
 =?Windows-1252?Q?OUrYwp1SNCYM7lXTmaIr4CZ71F1sUc+XWtJCZrvzkLF4cHq+MpUSKXjL?=
 =?Windows-1252?Q?oDwg1F1NKaZ3HV89RU5WOLW/xjMAXWIFZmlnHK4wgE2qJ+1cyoT8DBcM?=
 =?Windows-1252?Q?MaJIoU55+kYjfbA+IutT+CEW8O0LqK5lD98N93epL6k9gIL6xULQmuBC?=
 =?Windows-1252?Q?rVa97ZQ+BB3fA6XpfC2JzDp4Xr1G5EzlXb+MjzdTaqgtknEaxHQvsvOG?=
 =?Windows-1252?Q?nxmgpzQC78bcA5nEGChm4CSuHT+jw1GeW776hlg8PlFt/YqfPffOOxuN?=
 =?Windows-1252?Q?62qPpKeqCQYBsQpsQaIoGofmsCeb7YyEPee47pJc648LNSsJwAta6k3J?=
 =?Windows-1252?Q?OYXx6FrtlEiZ2IVsghpK3JDwwYnFdaxdnN/gZb85YCsxUQwQlylXqt5c?=
 =?Windows-1252?Q?CmNl8Opy1eZSTx0I3olKzTB+WwWPm8B5p4ToIre6aPNpHiCjWuvn7/O0?=
 =?Windows-1252?Q?/WTpoYRrdirtpvZpUTqWtLfmkZeBNuv8ee2YxF3axAkcL8JgPm1Hvn/I?=
 =?Windows-1252?Q?UGbCDQwIhAG6PkqYlMjWu4DCLmLO3h5H1fWmYxx3W0HrKNkbcwjZ4Kna?=
 =?Windows-1252?Q?FnJoBXpMmmTDa6WJ4GGm78bp7+LYLlyPkzXgtKjcSvuBBpx4AZC3u1g3?=
 =?Windows-1252?Q?t8kQ+?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1503;6:xamizw/CR0vHYRUv6Mlo51n5JaLY4aj/u6MwDYsoMutL5UsalWbbW6Skd8gseg86VXcO0+2ssDlkfpRto2k3lXPGYCH1MYf8Dd2bSb7lMa1FEKaY8tbxkDw/HNy7yySH3taKhD9fXGtDnzC/8uddhXOQ6qu4fnybsvwX8q9b+cpNxAngefDknEEj2UHsKjRc9g5YyHItoN4qG+w33fokP+p3k/OFPvIws/F8ylImudmdtuBKALtmiZc/57CRdheIcby6EMlScXiDqtVRgKwc5LD/Mqk9udigybKDooNv8yenv2R7IWpmoUAcqzLcNIRtpENbpCwnin5RUOzs9HXwLw==;5:q03GC0HWcadVEqLhIh8lgl5bgcnfBNLa1Mj3Jy+K2X66lKudcDUradWsHlOc63T5Be5PvPWveM2DLJlCALvBk43PhGSQ+D1b0dsqjFLB+O+kaA4dt67UmQuQnoWzt6JP7m7nifK3lK3Z/Rc5SIhlHg==;24:UKTxpR4y+Pxtp+6tZbr+bkGlCgDonTqIYUl//eOJSIuT3rMeaIFD2vFJtJ13oMXsI7dd6PKR1ieAmGxEBnZUIyZNqssnLxvyXSjYeNYp3ZA=;7:Ys/EUpu4uEfdn7mvYZrmq3aZtxpWuH86wyl3ZqcntKzDNaYek6hjUuviw0Ri20NFp28/dZk4pGmby2pRp7y7rFRBdPQbZjmFfolyUe462UW2V3tjjNhQ4Z7sV5rwsphWSdnxbAWqcmro1M6EE1eZbTuR8CxBDnyCe+Hcjpr0qjbOI3bkamWynV5earjhuf7QuUNYA0Jzc9Sc6Bx5s5TETsdA1W8CDAF6sfw+0I/b3tdV6J1coa53hG91bPByoeCP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 07:08:35.5890
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1503
Return-Path: <michals@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54970
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

On 1.9.2016 18:51, Zubair Lutfullah Kakakhel wrote:
> At the moment, if the emaclite device doesn't find a mac address
> from any source, it simply uses 0x0 with a warning printed.
> 
> Instead of using a 0x0 mac address, use a randomly generated one.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V3 -> V4
> Curly braces after if check for correct styling
> 
> V2 -> V3
> No change
> 
> V1 -> V2
> New patch
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index 3cee84a..efc8d2e 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -1131,11 +1131,13 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>  	lp->rx_ping_pong = get_bool(ofdev, "xlnx,rx-ping-pong");
>  	mac_address = of_get_mac_address(ofdev->dev.of_node);
>  
> -	if (mac_address)
> +	if (mac_address) {
>  		/* Set the MAC address. */
>  		memcpy(ndev->dev_addr, mac_address, ETH_ALEN);
> -	else
> -		dev_warn(dev, "No MAC address found\n");
> +	} else {
> +		dev_warn(dev, "No MAC address found. Generating Random one\n");
> +		eth_hw_addr_random(ndev);
> +	}
>  
>  	/* Clear the Tx CSR's in case this is a restart */
>  	__raw_writel(0, lp->base_addr + XEL_TSR_OFFSET);
> 

You should remove these 2 emaclite patches and send them separately
because they should go via netdev tree.

Thanks,
Michal
