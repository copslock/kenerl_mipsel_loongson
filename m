Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 18:55:06 +0200 (CEST)
Received: from mail-bn1bon0069.outbound.protection.outlook.com ([157.56.111.69]:34194
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010170AbbJNQzB3VWjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 18:55:01 +0200
Received: from BL2FFO11FD016.protection.gbl (10.173.160.32) by
 BL2FFO11HUB044.protection.gbl (10.173.161.120) with Microsoft SMTP Server
 (TLS) id 15.1.293.9; Wed, 14 Oct 2015 16:54:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2FFO11FD016.mail.protection.outlook.com (10.173.160.224) with Microsoft
 SMTP Server (TLS) id 15.1.293.9 via Frontend Transport; Wed, 14 Oct 2015
 16:54:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60158 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmPKF-0005QN-TQ; Wed, 14 Oct 2015 09:54:51 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmPKF-00015y-P0; Wed, 14 Oct 2015 09:54:51 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id t9EGsHd9002869;
        Wed, 14 Oct 2015 09:54:17 -0700
Received: from [172.19.74.49] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmPKE-00015l-SS; Wed, 14 Oct 2015 09:54:50 -0700
Date:   Wed, 14 Oct 2015 09:54:50 -0700
From:   =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
Message-ID: <20151014165450.GS15287@xsjsorenbubuntu>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
 <20151014151813.GL15287@xsjsorenbubuntu>
 <561E7B65.3090704@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <561E7B65.3090704@metafoo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-21878.004
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD016;1:FQv09gKoDVc5PinNUAIQd4lWq+7h98HuuBK9tLTwJlxTS36ALrS8nJpjDQtJLduw3UMMZq34MhhX3PRN+L++4x5Fkcj2bMiMNTdvlKGK96riMO/cqojyjrqBrFeseegR+mf9Khs5zlqBC99dII1s2VPA9x+EwEEGCRu05gOLVlmR1Lhul3MgdAur7E7V1h48wmbszITKdSy0JUhgYoXIBGwl1QTIxzjUQ0Tjb6nL3It4DWHOeTsQBK3TxJUy35VSZgFok2eL44sjqI0BW1FdZgWurpGIOIdJx/YXaNsrkz0a9MgwzCbKV/1YGuagamO3bndoZ3uO5LVW0XzyafOfn4kQAcGpi3fr+Xb2mzRAhk+o/79xKi3B8tdw2w/WSU06C8bBYH8OiCKDh5lS88p6sg==
X-Forefront-Antispam-Report: CIP:149.199.60.100;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(189002)(479174004)(24454002)(199003)(377454003)(377424004)(189998001)(63266004)(5001960100002)(57986006)(106466001)(2950100001)(5007970100001)(76506005)(11100500001)(19580405001)(6806005)(83506001)(19580395003)(23676002)(110136002)(64706001)(50466002)(77096005)(93886004)(33656002)(86362001)(47776003)(46102003)(92566002)(85202003)(54356999)(81156007)(4001350100001)(76176999)(50986999)(5008740100001)(85182001)(87936001)(4001150100001)(33716001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2FFO11HUB044;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11HUB044;2:6QE1q8O0j8UtE860mSiB9vsOVQyL68MPaww/n7eWylnE9SdYegQGDnh84B1BmOJYWPaWwDCNx99Pslkh5PdDGkq15XgWYMOJoVUcs53XGy73Oc4QirhmruoC1D2rXI/sUDgGPPYG91g/Q6TBzp++8ga0o7cOxjkuFN+znt1K/w4=;3:WVT9KwDTmrw+qisv/OQooCsyV2VHYx+wye6F+oGs9JZXVY3r4Fo5oP/MWlg9cq14S1OOOq1lD5uRUvrSoy+l7MOIloSnOBjZzezRMWSnXgzC/BF/y+KLzJT0OaSUS+A56NCcj3WhzyUrpdxHAeM66POlqitaRbkdcNiQmone9Han99aKp4WSUwaCIaGc/H9vnjU+nLK4sDAepUCTSY65AWYF46T2VbOosKEjcE3FDA5Ye1g9PNy6f7Ox980XXaI1Vh499v6yOV4mHPrDllQKfQ==;25:hNpqYiqd4mPMhhoQccHAI64QF40f0hBap+kLSp6tg+q6g0UVcvJq/+X2qpNlBz54MAcBZqtEqGTgAKF8cTCt970aqZ2B1EbZeFV2OwufxmFUCAlcbeddraiY5M+UkG65b+kBho3PLkM2KIU7w96EdNSbZAcTzvrWOG+n0ayc5HimSrWuTxxdK2IB0b57mpNIB24epdvdSWZSU40twldlLJnJQYE84FB4d6MH5fIrME6C1haaoGMEdUYeifBlZ4OgZlMKkuxVTEXBpnx/+yQkQQ==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501001);SRVR:BL2FFO11HUB044;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11HUB044;20:ako4Op+udy/a8YwOYcYszhEec/guBtkClpoyGBn6XW1pWSdrFC9VNswsydFXz/0BEKQ7IDXTFXoVTwN6cMTg2I4FIxWyNBAHojB0taqPU0aCJS8nIfaXN+PSqvcNytqqxqdf1uRHHAKWsi+6NcjFY7a55cSvpJzO6lOQ1xjEv1HrNWBYTmIbqNOwkK6dcddO4xX0ggV1vLo21lO+SU1O1nohCfjtmARADpAKtmmOZ4EZi2j2Y8CGdU3JkuutxLNx5CSItRwl4tW1xU06euhWNQz2onW4839Wt/SjZapCiW/ZytVs4uaMolqT2hwEzRdstgZdrmARE/Ntv6tCUrBQbu8kDXflr0NlR9EAX9UftK+n6B7qH1Gr1g3q3YI77USAtjefb8tEdJ4+z4c6DPgoxCCSv+3Cq735y4DtfPl5oOxp60eKOZdKfgEM5g5dTshQppY9qNhlltXp3Nkz2cURAmNOkybJ6HNjDyLK/owbjlc+iLhLpqrdLgPzjxdPCFnF;4:g/JCprQYemtyslRFTefeiiL/PEJ1BCqnK0Aca1eddWd7NnbVXiPwGJVfwvPpCqhUcYqpJPhzHOFyMChtqKfVDooZo8ALGRmL3zYZQfUHaGoEZHzRxfCLxe52xrMdtDewRU+m3WkQuftvxkNokSF/WOKIQ/d54xSdqVgJawyxc6SC6B1PBRMsbGZK2FAvm82x1dD6n+r9iFEPjpRshDH1H1rusqaq57EGueD44ENCl97FEJxUwZnSw8lf7k+D/iDwprG3KGIAcaK3HrPRuw9OhOSalmWqr2VZaoKpEXcYcKq+/ZJEWgTvNwjUrKDCEPcUQG1YmL8lVzttGr7kUMdDIEPy7SKDMJbywpr2tAUX6UbY4J8YSGG4B/uQmOduoNpF
X-Microsoft-Antispam-PRVS: <BL2FFO11HUB04444D8259CAC72FFA24FBE8C3F0@BL2FFO11HUB044.protection.gbl>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(8121501046)(5005006)(3002001)(10115024);SRVR:BL2FFO11HUB044;BCL:0;PCL:0;RULEID:;SRVR:BL2FFO11HUB044;
X-Forefront-PRVS: 0729050452
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJGRk8xMUhVQjA0NDsyMzpkbHEwZjBvTXhQOW5vcXVoOWtvR2NZY1NR?=
 =?utf-8?B?aUl2eDR2N0ZneHBGUlplblk1dkJzS1Y2emJqL2ZWcVhIa0NSQVJMRTdMM0V6?=
 =?utf-8?B?S1NvbDU0OEQ5SldWMFBGZk5zWU05TnlpZDNQS1k5WnVQL2tralZPMkRXekgy?=
 =?utf-8?B?WSt4Y1VUTENkYmZGa05Yc25iTEJ4bUp2U2ZHTVk0Uit0T3J6Rlp0TVRXSEVC?=
 =?utf-8?B?eC9uSDhnbVFwWnQ5c3ZmMm9XZ0o3U2oxOUpIQ21PdHd1dXhDNHd2enN1eEx6?=
 =?utf-8?B?WWZkSm9ZbFhkQU92N1BiR2NTTkc0RUo1cWRjWGZpcC9JODlsbjZ1ZWppUk4r?=
 =?utf-8?B?KzlnR2F2VEYyV2haVGd1M05aeW1ZY2VOY0c2NGN0TTVsV3AxQnkwRWxLS3Vx?=
 =?utf-8?B?YVNyckh5SWZjL0JJK3RLVEtiUW54Mnk3bEdTQUNnNDhBdFAwVUVLc3lTQU9Y?=
 =?utf-8?B?clF2WFZUNndERkNMZ2FhQW0xclpMcEZhaDkrb1BKNHpQN3pLK2oyRDlMSFdi?=
 =?utf-8?B?blVmdy9SMkxJd1NOY0hYd2pJUVhPeXl1dHEzYWkxWU1JeVBsNURYT041blpx?=
 =?utf-8?B?S2cvVUxqVnFsVkZtUVVJVnhwQ05pNFI3Z0NSc2tJQzV4SVZSbjVxQmRTREFC?=
 =?utf-8?B?dG44SlFncXRxSnZwUGVuNHZmMm90eXEzQzBzK2tYRzVRVVpKaVlJZURWaG5r?=
 =?utf-8?B?NzQ1VFhsc3p4YmZQeFJUZWd5WkUyTDZhQ1pxUmI3c1gydDN0aWdXRHdqTXRX?=
 =?utf-8?B?dUZCbDVJYWMrTFRMTmxOeWY3cDIyVDFrb1MydGR3OUNTOTlReWdVeHZtUXBj?=
 =?utf-8?B?QVJvbjBMNDZYVVJnT25ELy9Va2ZtU2lrWEFjZC8xeTFaemtiNVVaS3BhejV5?=
 =?utf-8?B?cjNaRDh3UE5yYXREM2hTN0VYUlhPR3hRemxmWmtPeStrdW9oNU9nVWgyQlUx?=
 =?utf-8?B?NDR0N1dMaDVaNDBVQUYzWkF0N1gxNXlINUR3Z3ErRlEwV0tYTVF0dWFza0RX?=
 =?utf-8?B?UTk1ZFdtYVNuS1Z0T2U1bTYxOENXVkRYbG1xcjRFVVp6ZlBHNllPalBpRjZM?=
 =?utf-8?B?S09TaFRWNW1CejdpTDhSeWVoV3hiKzQ0YnlGN2hGakVyWUFxSFdhb2tacXBD?=
 =?utf-8?B?aDdHMDJTeTJDZ2FoV0dhYW9UM1h2YnAzZUhvRmZIL3dpbUFMdCtSODhGV1Js?=
 =?utf-8?B?ZnhNY2VWRmNUOFkrTTBZbnBnaDBZZ2J5YVZsamxDMzBVVWRiVmVoK3BDekhX?=
 =?utf-8?B?dmJPM3EwL2JuVW5QaFRvZDczdTFhVTJNS3UwdFM4SHVDWkFNK29VcGlHVE1T?=
 =?utf-8?B?RGNEU1ZPelpJSmp3WlNuaGlkaWV2NVkrOHJreFREQlB2YzZmOGcrYmFSVHJM?=
 =?utf-8?B?N1dQL2ZXRE5MbUlJN3hMVldURTkyTzZjVEpDRHNCTW83QnZIcGdybVpuUHZK?=
 =?utf-8?B?bGVMNWZ3WFJvMWJLMnVLSWRrNkI0Wk5LOFN3d3dwOGxVdk83VjRRQnpHNWw3?=
 =?utf-8?B?VUtmdDV0eGg3WFlCR21XTDErRUxLT0hsZTFPZmpwWXAxNkQyckQ4a08vcU9V?=
 =?utf-8?B?emhGem5VMDh5QWtQY3RubTEvNFZaMzNJQW1xVDJsRUwrVUszc2xvRUN5TGda?=
 =?utf-8?B?elcyTVdzNVNTQ01KdGRpZnNDaUROTWtSVy96S282b3RwWlA5c2oxMW1Zdz09?=
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11HUB044;5:iE8/MWo3nvnOAeZXsdudbSxbvv9qz3IBFg+hPp1p3KinEkbu3rEakxSebcE42uzhIcu75R1ijLv3QGJEhKCmyneXNmeonoJjJivDCkTr7mLtltxDjHm5Ig7rJFUEULjwJqqv5p1f1LEaEj+U6mwv2w==;24:NvC3NKdC/fEv2ClV4kVJI6Yo7OlWyfWnHj6nQDebfpoONpObx1HazqfMRyNCoHd/DTlO6tjYyqmAaozQfYaCqbQYMaeQi4ptGL7Gt58uDzg=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2015 16:54:53.0589
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2FFO11HUB044
Return-Path: <soren.brinkmann@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: soren.brinkmann@xilinx.com
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

On Wed, 2015-10-14 at 05:57PM +0200, Lars-Peter Clausen wrote:
> On 10/14/2015 05:18 PM, Sören Brinkmann wrote:
> > On Wed, 2015-10-14 at 01:51PM +0100, Zubair Lutfullah Kakakhel wrote:
> >> MIPSfpga uses the axi gpio controller. Enable the driver for MIPS.
> >>
> >> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> >> ---
> >>  drivers/gpio/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >> index 8949b3f..58e9afd 100644
> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -508,7 +508,7 @@ config GPIO_XGENE_SB
> >>  
> >>  config GPIO_XILINX
> >>  	tristate "Xilinx GPIO support"
> >> -	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86)
> >> +	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86 || MIPS)
> > 
> > Hmm, in general, this driver is hopefully generic enough that it doesn't
> > have any real architecture dependencies. And I suspect, we want to
> > enable this driver for ARM64 for ZynqMP soon too. Should we probably
> > drop these arch dependencies completely? It seems to become quite a long list.
> 
> I've been thinking about this a while ago. This is certainly not the only
> driver affected by this problem. But the thing is people always complain if
> new symbols become visable in Kconfig that don't apply to their platform.
> 
> Maybe we should introduce a HAS_REPROGRAMABLE_LOGIC (or similar) feature
> Kconfig symbol and let platforms which have a FPGA select it and let drivers
> for FPGA peripherals depend on it.

Sounds like a good idea to me. But, does that work for all use-cases.
E.g. if you plug some PCIe card with an FPGA into an x86(_64) machine.
That would allow you to use those drivers, but I'm not sure how that
could pull in the new config symbol.

	Sören
