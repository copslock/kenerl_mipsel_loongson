Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 08:25:43 +0200 (CEST)
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com ([104.47.33.70]:5232
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990522AbcIBGZenwfkC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 08:25:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fD2GbJpP6KwYu827S2/hQHYay7ikMMNqiiXboWP5RZE=;
 b=3mW/Zy8+q62yc3a1wVs9aPUiAM1vYw2Jbq7f6M9gwxfeZsI1zL3o0XR0KGdzJJTuIq/eV+RhX2LDrz+IsHJFKJtwYIMb/0ld/kO21bB1pPOKp0/IJKHx2ca0g5Q0TDtJRFEiRKFgNm638cl6/+mtK9Xow3xjbz33v6RZ0vi9efk=
Received: from BY2PR02CA0107.namprd02.prod.outlook.com (10.163.44.161) by
 BLUPR0201MB1492.namprd02.prod.outlook.com (10.163.119.158) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.609.9; Fri, 2 Sep 2016 06:25:28 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BY2PR02CA0107.outlook.office365.com
 (2a01:111:e400:5261::33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.609.9 via Frontend
 Transport; Fri, 2 Sep 2016 06:25:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 06:25:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41327 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfhup-0002Zo-0a; Thu, 01 Sep 2016 23:25:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfhun-0006BR-1t; Thu, 01 Sep 2016 23:25:25 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u826PKSH028378;
        Thu, 1 Sep 2016 23:25:20 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfhui-00069R-A5; Thu, 01 Sep 2016 23:25:20 -0700
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <772f883f-79fe-9197-f27c-3ffe91019aaf@xilinx.com>
Date:   Fri, 2 Sep 2016 08:25:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22548.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(24454002)(189002)(63266004)(19580405001)(19580395003)(83506001)(36756003)(81166006)(36386004)(65826007)(50986999)(76176999)(54356999)(64126003)(7846002)(50466002)(189998001)(106466001)(230700001)(2950100001)(77096005)(92566002)(586003)(31686004)(4001350100001)(87936001)(9786002)(5001770100001)(2906002)(23746002)(5660300001)(47776003)(65956001)(81156014)(626004)(65806001)(305945005)(33646002)(31696002)(8676002)(356003)(8936002)(4326007)(2201001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1492;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT010;1:+XeMffqDHk6Kj4YHQUJmhJ+fHxxxOeqTVIJ8MYxKX7HGnwvSFf0c2dQYFfJ8+HDTqkGwkAm9St2EE5n99IPKfqr3PW+0P4BCJvOcsjsooWXNRggw2LxmxIOu3Wj1QinBiPy6LyhkckIQ6wqDFq1kH3ngk9T7UCLrq14WVOJimBzAih+9CkjfdwHzDRooJRi/Dv3TnW18edkWG6g5RZdFjspR++lkhuyY8vNuoW99bhae9+5xpi6ZRPJMslSHJl5ButX/vOkuGYafVekej9vdl3nesm0JvClVst+RB0iF2lebRl2tZyhNeIjBXL+6Jfoo2ZYtSfz6JY0p7fdeb3c2NoZCxEWzHP4TDRJcwylUCmyw/oHVlvFAbHXLK2/bJj0sURNVXBiofR62dJiA43T5JExBk5oGl5qGhJkHHZrIiYePDtoinMd8iZncUlJ1109hgdhLig4KMpKKQUsWMP5Ea2gItIOj3MjmsyKCgaGWMJwVJfLFjniMdUFF1eVvU72O2ml4WXFgkGoO2Uteos5NqQFHDqxEcvSJZ6Q83mVqwGbT9XUL3IhYOoSSKpxQxX436YgDyvxRK3CLcnBFD0rSvw==
X-MS-Office365-Filtering-Correlation-Id: 2a6608e2-d536-45dd-45c1-08d3d2f9edc3
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1492;2:2qWTsQBNcdxKKfTBa/z1QqK0fB+eiOoF+DRHs6VAvT9me9kPsSuqieaaGk0jg1OXcn792pdkT/cZlBEfjAcKIF6W9R1Kut6BEZanCjxO60RzJRAmEcQDEl3bQUdcO5Qln7zMw+by16I/37WpoCB5iDk1fdjPdU4zzXmgWH2kPFOWzs/eALh/MMKVLYM9z49h;3:YCylKTMauXoX3CUS1VkIO1BQVzaFWQSVZQsA4Solk7oKdxHGWxa+WwmFMhPE7yFy1/FPyBn12kP3MfzQVmhszbDIrCb6EeOPbWdt0fnpH1dETi8jl9g0EGPTNQgMx7qo2qP4gfxyYCTcClHO2G4MiMiLURSgWcsEQZX9g6AKL/5NW3nrq4x7tDekD25KOxxKIN23fNz68CBcD7d6DfV/O5hLaGnW/YCxIzv4fwcHVhwMJIu8OipKdAb7s2TxfKuh4XRx9GwfnYmkt0DO3s82hg==;25:1FHY/iR3DkQM9MCIf/tBHIZBvXGNcdds4Lwd9yCrJ0uM8yUbpXoCN80imUzH2+x7+PcnXdK/oNT7IUNW1YlnpbdPMByAiz3Mxgoa22JqmYOjmkFi6mdqrF5ObcW8e/c+6ayxT0ZU+FL8OELB74Bi61d/s+0uYpyivTEpM+RR3cpr60ds7n+XzoXhZh2GaR31qPJXjSq6LN/KQISP3zAvTV2H9ckXutcElPVHIjuBjLZzLaVFlw1RFTrG6XOhyXo3/+hKMSaxtFD6smGVUHMiNFWO1GHS4w9Pl7WpgfTlqgB9JTAuE53hqvtdV4GuB7g2tPHypTVT01nqtSJ6HFC7/+FJ4bqIf+1L4FW7C3CGdrD0mwdVbL3B5mt8awdP8MKTZCVbNNcpOaKzIGa4lNkOejTNR1k3CdlbsgrMy6dS4tE=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BLUPR0201MB1492;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1492;31:Dm5AYD0iOORijLycyPyRldrtJS2f4n9Se/3Kwf/SgYrNqByBcUhDWTRvh1CpCJuAnw6U/mb7/QySSY9V+Ld9DiKW8Qv5BQXUejCB+QiSuwSkOPRetdtL9szPSp83bYo4jOFOocl+zFIfQge73u57HyaLsPrdHZtSTmZTIDSFwvW116EH8CaoQVK2E0PvLDG7FhLwA94WDkQ/cOjwKF+5/DUTimQ8f+loGghLONOivLo=;20:qhizrjvpJkqsyvI4MU2AKZ0YOvFofjmXw8AlNUgcFNq2EmQdUniykRnsnhx/g5fvy1UHkuuWEu70i4+Qz3Ved3veY4XEjIT8NGnzN0+Fc2JL4aNnpmnkQV+j1mc+SqLUgpPpcbQQ+sfERgf7bJBud8TpyGi851TfRiDWxQHa4l2fV8GKXXYVkhgfV4vchbyLbas8gXKZP+/R87MZVW2efrzoj+7IAaMAcV1lftPBl+ynoPhILmqK9TdRko+cc5zFLQf0EAJwLjbJjks1qkcQciIzJbAOWAlJ3PB0muRvnY9ixwcoT0Xd3w+94/j9fGdvp/q9fP6X5THPcGV5EM01j5FgODVqSbtBd0d4N7vnFnBoNQqTzNWMYFPw1Moo3EccOeGLdEWRsJN3+yiGYjGhKKwL15SpolKQWzRymqv+gtOKpxfvsnWVb0BuEttSYi4cB2SRUcGgDzCGO8J5A6vHs0Jkv5SQ/bubsAO6Z1FDzUCYvQsu7FKkokgeNd5w181w
X-Microsoft-Antispam-PRVS: <BLUPR0201MB1492C104F9C15431697A4211C6E50@BLUPR0201MB1492.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(13017025)(13024025)(13023025)(13018025)(13015025)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:BLUPR0201MB1492;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1492;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1492;4:PsDEVbkSqJcyA5COyfwpMKMSu0H2pjJ7SCECX3yK3gLTyNiu3eW8EGfC+aiyQAdoiwSegoYtc9ZR0o+GyvdMfRrhqsAS9yjVFmh/T9D7EJG5Gg1a/8+ORvqdp4Rnws1OwHnpLnS/LyJ+SWDV5gxW1TIppIHQu4XCit7zjbljQHJVUryxSzr6QHdEIIuuCv3r/5n6FZAMWCfSgrHJ1YLwYtTiCnNWn6x9ZsQSGi+OFH3F22GG85UNYwi8hk1/tNX9taI51hGcerX/krQTtkn3MLTxdLeRYxsbqNaDDLejYLbCUHwCxLdy0yqxHPTPAOKiUzYR6mPPqUsalMN23+XICyMyPTwlFXM8Ziivo8orihHhPcvnmuo0EnA7qjHMwF78urjV2keX+Hj64OVPvidrWW01NMCBnSM8IjC9iTwE86c5nhjEzl+PeH92tU9YhZk+gst7Pm2DPh8kgT6reN5264n6cCOMvtW0HrHYQvoqroLhITYaAUKCQYQMABWspFn0
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BLUPR0201MB1492;23:Z0rpthQBSxbMXkj6zOIdd9DmtDP0dKzs7m8?=
 =?Windows-1252?Q?rvYwPG3DceSoSCVnCsM1E6CNpdZVTTXqn2bJaeOeX7E4+O1Y7ismOZdo?=
 =?Windows-1252?Q?7MH+c3gNjE1VKIDxw7DsPXD4dk3TeM9+ha92VlY/j31zf2wObx2OFxEe?=
 =?Windows-1252?Q?N94ZhIvbQAvUNgZ3YEILLbhJDUWixddpJbk6yVzqD+D/UYWDKUDFjGSe?=
 =?Windows-1252?Q?nw8u/KenqAZHlTqaky9I9NKTyszeHoyn0qKQ13w3wgOgZvrASBYWeLkj?=
 =?Windows-1252?Q?d1FSVjK5ZQ6zm3IFLqu4aoddp0/OUFTOdSXzFiDPP8uvqV0Z79/0bb5O?=
 =?Windows-1252?Q?MxL4Y/5+VByUnMpPBnqwLx1rNjNRUu2dgbe0QC7bvW7NMcXk+VOsEs5v?=
 =?Windows-1252?Q?VTZRLkM1hfvnD3YGvTEj2eQ3Nmcv8wzTGDNDOecqv67JMp8JtKB8p8+D?=
 =?Windows-1252?Q?1WzWwf9ruwslQkkuCVOoJUQCGiU2Ry9p2TqsAK9YlmRi2EU8g8iR79LE?=
 =?Windows-1252?Q?XxNmc0gHYOE8cjznbYTnCqCpiz6MOt3CH0KaCADPG5BFVtgf5BZN86DN?=
 =?Windows-1252?Q?CR97fR4pL8e9luuEPFTcuH98koV7VdgkowPyQSy6y33LW93PdoVX8bSJ?=
 =?Windows-1252?Q?yU78d1UREOUhRZsWbboeZelXtuMq4pGxsMfmllRAkd1+gbH8dUy4LDYU?=
 =?Windows-1252?Q?Tw4K/kPaqKN+ZK6gwsXYawjp0OnSuWTuHGySd5y3Y8SvtyE05niZVdxy?=
 =?Windows-1252?Q?fjF8zPFW7+kf7TXU5mm1jHH3JofdEVi2dZLwyULxub6D7zGJAQQAyEg7?=
 =?Windows-1252?Q?DBqoqYrHoz+RJbu+cRaWKTIbfgTpnO6XnuPMIkkDV0RFLRf7bsTz9oWN?=
 =?Windows-1252?Q?AvR9VNBQvjKwa9fVpfNmXeeEi13JNXQ4WWDJsXB6oqdmYLDq54oLdO8S?=
 =?Windows-1252?Q?7jx37GTPqhPj4IRFS1O+Ei9UZwO7WIxZ6P3j4/Uyg/UfxjNVDiR5nf6q?=
 =?Windows-1252?Q?tn3lnnsdjSwjyEkBRSfSgUv0qm/1hzi3g9ol/00RpSZDIZZm7sqWQ862?=
 =?Windows-1252?Q?+kYK72paAA+/rT8AuXU3GjUK9ZWx7JRx6lOVGq74xdv1sDcgfO1yrSdA?=
 =?Windows-1252?Q?d/V9WVaiWslqD0WrL9jWqeJgCgEThwyJSQpeMEUwgVdXEodDKF5AwLGw?=
 =?Windows-1252?Q?KhJrzCOIu89p20fznH+bHxD6Y/Qxqx5XhhMcqgy70B+Pvtpu9jBrSWbS?=
 =?Windows-1252?Q?6/hQac5aJuNldcvcggIf9bvSmlsz4xIcaHjqt1dhIY1jw+tiyoUo7WDs?=
 =?Windows-1252?Q?bC3SNJPRjHXIyvsRZzNs191VnFw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1492;6:/toKsNnk0++1EncorYpmJF4YZveJ6CBZxyo8QpD+alRkDrBPnUpIMrXG8+og74zr79rJHOdQy4v/sWicsBOtOYAvlKEDfVevQ/7IvL3VE8uC8UiKTG3alKktSbdvLXGi+en7rxPwOYCkAzwV3D4XJWRdvpaYlsSyDpJ/ZteU2w9AZXBDqSCaoxYd9iyN6jAFO1L8X39TIRrBHCni7AP2tbjBV0dMcRgInyYBIX3fIbchESKjRui+kP8lnWNnwgDsmh5YZA8Kx9Ef0tqHiz/m8HLGvB2aiMQHDfmRiOlYX8Aj69U5d3XTCNU2nT/DU1tr1yG1Vy6SH4TIaySoQOm5lQ==;5:tLgcUNRa8uhQgHNkF7XMSjYBLggqJAc3W3T9kl5FPyA4Mc73kZ/vOSf6SC8v+EOsovM+XxBlK34AV41fy4U27hYgWbxdCGcxx/mUtIER1+aoxSVVmb5Q4mmGtbDuPS6ckaM0Zx6N5jl7P3jet1+nmg==;24:jpRgH6o4x67om2W/R8ICw/530tYDXbmvX1JBst6+V/Sc1naQQRq+BHsh4V7xO8jSKmMIVVhXS2bw20KsFpAzrwPkmHkxlNDGVinbrzQfONM=;7:FMhatMM2+kgFcdEcOXTU6n1m2F4l1DFZq1Da5wir18jnKBApup1P179J+o8nfFwuM/4hDtK9QRm127siFx/EQavYnHEW3lpayCzxaQa3JRUvt/+ywKVtvhPKNAm+KrpDCPkAw7bG1tjihqnk/UINabvE8m8AGrqK0PQmHM5ovjsMKQ9bcns/f71mBXv8ZBn5W0UOEqKiyc6o88nFI2/fI0svge06EUsqZ8tNOmjDI31T+F44VcF5GWk65uOirWy2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 06:25:26.5184
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1492
Return-Path: <michals@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54967
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
> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
> based xilfpga platform.
> 
> Move the interrupt controller code out of arch/microblaze so that
> it can be used by everyone
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V3 -> V4
> No change
> 
> V2 -> V3
> No change here. Cleanup patches follow after this patch.
> Its debatable to cleanup before/after move. Decided to place cleanup
> after move to put history in new place.
> 
> V1 -> V2
> 
> Renamed irq-xilinx to irq-axi-intc
> Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC


I see that this was suggested by Jason Cooper but using axi name here is
not correct.
There is xps-intc name which is the name used on old OPB hardware
designs. It means this driver can be still used only on system which
uses it.
Also there is another copy of this driver in the tree which was using
old ppc405 and ppc440 xilinx platforms.

arch/powerpc/include/asm/xilinx_intc.h
arch/powerpc/sysdev/xilinx_intc.c

These should be also removed by moving this driver to generic folder.

Thanks,
Michal
