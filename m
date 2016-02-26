Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 08:49:57 +0100 (CET)
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:58368
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012140AbcBZHtzxTnVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Feb 2016 08:49:55 +0100
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (10.152.72.51) by SN1NAM02HT106.eop-nam02.prod.protection.outlook.com
 (10.152.72.103) with Microsoft SMTP Server (TLS) id 15.1.409.7; Fri, 26 Feb
 2016 07:49:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (TLS) id 15.1.422.5 via Frontend Transport; Fri, 26 Feb 2016 07:49:47
 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1aZD9m-00008O-MC; Thu, 25 Feb 2016 23:49:46 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1aZD9m-0004y1-Gv; Thu, 25 Feb 2016 23:49:46 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u1Q7nfcW005012;
        Thu, 25 Feb 2016 23:49:42 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1aZD9h-0004wS-IY; Thu, 25 Feb 2016 23:49:41 -0800
Subject: Re: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
 <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
 <20160204175325.GB31145@NP-P-BURTON> <20160225154326.GE8120@localhost>
CC:     Rob Herring <robh@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "Ley Foon Tan" <lftan@altera.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Duc Dang <dhdang@apm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <56D00390.7030600@xilinx.com>
Date:   Fri, 26 Feb 2016 08:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160225154326.GE8120@localhost>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22154.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(164054003)(199003)(24454002)(189002)(377454003)(87936001)(65816999)(6806005)(11100500001)(23746002)(63266004)(87266999)(76176999)(54356999)(50986999)(189998001)(230700001)(4326007)(36756003)(93886004)(1220700001)(47776003)(86362001)(5001960100002)(65956001)(1096002)(2906002)(5001770100001)(36386004)(5008740100001)(586003)(64126003)(83506001)(92566002)(65806001)(106466001)(77096005)(19580395003)(19580405001)(80316001)(2950100001)(33656002)(7059030)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1NAM02HT106;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;MLV:sfv;A:1;MX:1;LANG:en;
X-MS-Office365-Filtering-Correlation-Id: bf45f768-8c93-45a5-f014-08d33e8166c3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:SN1NAM02HT106;
X-Microsoft-Antispam-PRVS: <09108835da56428e9e457c8c5ee5bf5f@SN1NAM02HT106.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(13017025)(13018025)(8121501046)(13024025)(13023025)(13015025)(3002001)(10201501046);SRVR:SN1NAM02HT106;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM02HT106;
X-Forefront-PRVS: 0864A36BBF
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2016 07:49:47.8785
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT106
Return-Path: <michal.simek@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52330
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

On 25.2.2016 16:43, Bjorn Helgaas wrote:
> On Thu, Feb 04, 2016 at 05:53:25PM +0000, Paul Burton wrote:
>> On Thu, Feb 04, 2016 at 11:46:28AM -0600, Rob Herring wrote:
>>> On Thu, Feb 4, 2016 at 10:10 AM, Paul Burton <paul.burton@imgtec.com> wrote:
>>>> Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
>>>> used on the MIPS Boston board.
>>>>
>>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - Split out from Boston patchset.
>>>>
>>>> Changes in v2: None
>>>>
>>>>  drivers/pci/host/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>>> index 75a6054..0aee193 100644
>>>> --- a/drivers/pci/host/Kconfig
>>>> +++ b/drivers/pci/host/Kconfig
>>>> @@ -81,7 +81,7 @@ config PCI_KEYSTONE
>>>>
>>>>  config PCIE_XILINX
>>>>         bool "Xilinx AXI PCIe host bridge support"
>>>> -       depends on ARCH_ZYNQ
>>>> +       depends on ARCH_ZYNQ || MIPS
>>>
>>> Why don't you just remove the dependency? Then it gets better build coverage.
>>>
>>> Rob
>>
>> That seems like a call best made by whomever has to maintain this - if
>> that's the preferred way to go I'm fine with it.
> 
> I'm in favor of removing the dependency if possible.  I guess Michal
> would be the person to ack that.

Not a problem to remove dependency on archs. There is pending support
for Microblaze anyway.

Thanks,
Michal
