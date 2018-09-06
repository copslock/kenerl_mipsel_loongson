Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:50:17 +0200 (CEST)
Received: from mail-cys01nam02on0717.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe45::717]:9420
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994642AbeIFVuK3uJBw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 23:50:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wX7M3rOMltKSkDDEFyNUr1sWqSbuv1FtNWFlRYHxkA=;
 b=OhNNEuB45r5JNNWJnrn6chLBPJxzlyO6zi1jqmYI6hch9KdC2biX1s2LpUn2ybc2mqIEr3DBi9cYHlFIhREh3Q2GzInK29YoXCn6gkuAGGVtbjOTGv0l0uvQYz50BSoT1z/W3qzweXdYmJRjXLMw/il0RhjUj3IO9dj9g+el2e8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 21:49:57 +0000
Date:   Thu, 6 Sep 2018 14:49:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
Message-ID: <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-9-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536266581-7308-9-git-send-email-jim2101024@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cec524d-b737-470d-37c1-08d61442b077
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:6D9bnCR/kUJeWWXMohJQ2WCxRnOOX++z8qps/LdhN+8XF+Vs4/TL8g5+kj/Wqc5/AjdpclT4ZsGsqzlKFguXrb5ZSg9F/JRlcIXQDBTjwvyQFU3pbvHs5UdqIMdVwhsRqvlEI6pwg+9RxoD+fduXHf5E4llicFadiKLT9GdU93zTaP+Wj8NpObWe4TP1PHDWxIRgUVeq4Bm+vko/2Iv9wxmmw0bZ++YVwsIbWQrg1+DALlL1TMlMRUikgL5mWGCS;25:hUGqryCxHHrAWNgeNecYm536E0oHpfnZrd12eQqCs+1NjxejYICOq6w2hBmsGUSITYt81p/YzPUNrHxht+zFSlqGwnOpGM8ousjKW7vrnkisT/gXjphVTurQcHmqGeWX6cpjH/pjF1ESL1avEVwidle49HlErNo9hu9/WG9m8zpjEyzLb19Z6HFxXY3mIHF9HrhA1bV/B6Jqixl86q6SIgIf8aQ63BIZrn8YsAYkLglsKWRTnm/n/fa+fyWyrorbgyUcUUjDVmYvLxdc0iUNtcEgekH6lzvqWxbmQI2nzMwfLb8R/TF+mhkHaf05D/euVoio4zOMY9THrwKq5gSYMQ==;31:6CM2lso8sRvU87wM022XiC7snTVBVFGfdB91/X6/3VltDsuZmjjazjydGKX4ubu197xgS1hAsUSnsBbx5/dPNgkS3b2ogaUG3MmPxsjfRrOc6USPTakEMQJ5tN/brGQ3sx3KE7I6CGbyUehRlDn84vhbMY01lEGYY1C6nOdXA2cXfIuSR34yPXft/A9Kse05zQz68IJnMbkafMCdSniQaMVlESwaneB7wFUPwFmzlO4=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:bwQjxWHw0OIQZf8TjYweS+i4T7r5jQNVBqpbM3JI+yJ9kFA05trePYqb6cSq8O52x4lm1F/spVdDBhEZfEg6EW521We/8tE3Fn1kHMh/EtPOixAIzec2E2tTBsmoLjugHEuuFFuuaOTTz9yHuXEc2iXtt5kqT++zZJ/jVb0w0yjCMwurJoDCTfxlj63hQh2FuVcX6T/5rHGPAnYD+JafNwdQs1dPvapwOiELWloeVRgyq3renQIXfjtbQj7dtG/6;4:8Y71/H+W9WFIQkmlDt4WOmryCTHA26US6gHXBtrXu5NS1n/VcQ7NiTL+s7Huoua9C/BQtKys7diTVNARXX9xB/0QGd8XuMwp3Vh0Da8HPIimp2RYE+FHgQk1MUtZMyZpwrl/yX5JzOU3vlaFTwDYi2JS+dN/JdyjFRS4cDbnxxfeKty6RvWigZRByqwrZyh6eb56hO8jFHS+t0xOV2Kv5W9aVk5wvlPADhxJhfiR+u+Oig7Jp4213sa9YFz653uV7uMS2/J8KXcTx0quVW00F7TDsgzTyYNjg1UpGSEvQ/Lzj32PMgus2lb1I2l2EXSl
X-Microsoft-Antispam-PRVS: <DM6PR08MB4938D8F4F82DD809B75F2426C1010@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(39850400004)(136003)(396003)(376002)(346002)(189003)(199004)(54906003)(58126008)(33896004)(186003)(26005)(76176011)(6496006)(52116002)(42882007)(16526019)(476003)(956004)(2906002)(11346002)(1411001)(33716001)(478600001)(316002)(7736002)(305945005)(8676002)(81156014)(81166006)(16586007)(229853002)(97736004)(6486002)(386003)(1076002)(66066001)(76506005)(47776003)(44832011)(50466002)(105586002)(106356001)(6916009)(7416002)(7406005)(9686003)(53936002)(7366002)(68736007)(446003)(8936002)(5660300001)(4326008)(23726003)(3846002)(6116002)(486006)(6246003)(39060400002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:bToK8Qbc8wmrNHVY5D24NBvueVQ6uAKB0rNGn2aE3?=
 =?us-ascii?Q?S72LAbtOnBrteEjPgDtmDD714JerXz4RxCzeeai7aVg/OZ5R4+5ToZIwKtQr?=
 =?us-ascii?Q?PqZduD/wRzNG6dwjTd/VL71lIUCGPOPCM5mEyZMZEW2IdATrf6T0CaGaAqsF?=
 =?us-ascii?Q?5UYFIwQ6it6iv0B6uEvr4kpbQrjMUzquvkxrOwvwPMf2M3qvip7ysubG/rBO?=
 =?us-ascii?Q?vpDHO5yVLA+gKKymiOk7SS1q2qET0NiTldDrYiFKGx5cAd6g8Sz79X89fF1Y?=
 =?us-ascii?Q?KLu3kL/ojFK02rdqUNMuOmPYMBMluQnj7eq5LweEWqrRkFj8I6oA8iOs3uAi?=
 =?us-ascii?Q?meEemAoOFlL2bDLj+wXk1YAAH6VMFbqgMRpIdEhug25jFt76Hu2VaCIKGthO?=
 =?us-ascii?Q?DJzzWHr7QSyyTAGotR6YTypwqa2ciCPi5L5h/b7jTHaAp7EZT34kpanByiAh?=
 =?us-ascii?Q?8d4mq4SufADl01QeKJwh7nDZrTMiRszpl8HwASZD5vOWMh43pd1WBKr7rtDK?=
 =?us-ascii?Q?aIko2ods72x7fZAZvGqVvcXh2VLh/wp8AEmsbT8pt0CSApJltT4JxrziUeka?=
 =?us-ascii?Q?rymACCnKp7WsOiBl7JaUJ0mMYNKkBwLDYQP+UFCSVobU9TpHB/Ln54Tcc0lc?=
 =?us-ascii?Q?VzWr7TXn3ZaBX/ROzgbT0fR/5O1Kd6BNrsgx8+/jlJ9sYreO8JFAMb0EpVLj?=
 =?us-ascii?Q?JKLxcWCDVaH8RfbpUZJ/e3ZBIOWq032XWvEY7gJGRQyhqTZVvUIhe+51eU7V?=
 =?us-ascii?Q?/XwgNH4manR5ZgbtXsSqu4uYeEJVfn1zQKPE15pnjp8Y2ldfE7K3cw6ZyeNY?=
 =?us-ascii?Q?MONBUkYupaj1HvmXn/9PT/MgiTgaiIaAqRs/Bpr+YnnXLz/J7vghUfEEY2eZ?=
 =?us-ascii?Q?qRODiBbKFgxvzunqTbPHDa3W//Dly9o7MATK/z641MO+VFjFrwdkMco8F4qv?=
 =?us-ascii?Q?/tnTj2tbGv9RN2oSwYyVfP1bFLwIgCjqBbbEf77zMQStIbNkz5ztcYhoq/09?=
 =?us-ascii?Q?2QPKrCy6UV8cryXwR2eLa835PL1B1iykdnXZExfk1diUG9bDuS046o60Je31?=
 =?us-ascii?Q?LbwTPpx11yN9SsQsng8MTF4YOHCc/ScU1Ba4mTkRQZXkxT+HEGpWtsi4k+5K?=
 =?us-ascii?Q?v6QGvaZIjq7zZhscqVl2DNuln1FTwKainRa+xjn/vfRw1WqfjWwU1nAZh4cw?=
 =?us-ascii?Q?dyHOYGSylsxGrgxrKv+zYr5vHGrkefAnn76WGKRFsEzkOXDKXFzbrgzvOntt?=
 =?us-ascii?Q?n9u4qUGNnr4AxhqeUM6zE1XqhPmzlmBDY1kzOjWn345FFjx6DB0LvgEUyDMN?=
 =?us-ascii?Q?74SFviTyFauwWMostTZ957nPK6BQp+WlowHJnUbaNXE4NgW6JWLLgJ+KfZjn?=
 =?us-ascii?Q?h9pCRqxyeTsGE5WV9BQgJjY5eHE6dpPkz+ttW5QcMsNQyho?=
X-Microsoft-Antispam-Message-Info: 4Kw9R02AbOSvMCLOLWAoUoTM+mooFUrrKlI1BtMfCMlI9wQCcdHcLjqGkbv2gVA8y0ZbQj6ntHwJkzxaOJZrW3g+ImvZws9vEbnQDx05MWqJymGkrbN1OZsj8p8JV/w+rgqTVlnRDBC8/xNPvYNzgNRaFd7HHWIVqFpPODBXRPzBmYQe2a5YXwAcZO0LlnoG+y3N8mplhdC8MVO6+Yw1k5n7rgj58rpuBHE9aoWY+wgrEgj5TyhvaDtbE0JXtfYBJSP17RNf793xSXrOIvfLCVantgWHSV+GBDqyejjaw3R2CY82DSKiauNOJVef/SRouzc2QAqHtM7s/BaZRRIT0OTt/ci4VyqFH14E7FPEDh0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:GAncr1G9BR2/sOUs4iyVTUAYXx9HVXkxngotw6Lths5pN0ZPh8YsPSp6buaGzGMmMj3WPGWAmG7ivoLAl9WQp/hF/KSY/dOJx7jjFH7h5njWVroZ1cBCEEYYC6A/EJdBaNOpBqKrrWOj58NZgJB07bK4IQv/IqU7tlrEP/eMJRHJ/bkWPImH52zRNEvhNbPB5HOp/7bJtK4H5suB6HJg2AGYDTkaMzPhPa1naT33eHDIPHDJhhGIlxG+97kpdM9GqhcoUzpfRWk+ukIICGIWDOyR2WDgNF7zVzymg6+YOA/H0djOgk2KytkP8awLqF01kVuTfSQFC3FIfSugig8g+r0W++16HSpE3RXaLYcZ8mZKah4KvLFKquKDV38rA7r5tH/LTbcBdVdDiO9l2AOvFRv84Hm8UNXBnJZZKk6Eu/S5oQbYosTS0XlDxSXf7I3bL/S6tKVLZoPDPoYWgZARyg==;5:UaYWLIrNaXc9qMVX1K5A7HchhGbTov0ozh5ucAjVH41IDLOJkYnTN+ua2N4dwXNdSN6zN9qoSsr827NapDnnE52g77Blo9enhgMoidpmFx2CMFilb+aMB/zdhkE46cG5MeMPjouo+Dm6+NEEYFuxSFWOwqGPJU6GhTPQ2VaPrLA=;7:VYCBYu34UfGmA9s5slVYQ/43xtj2uEZ6RILtg8oq9yDVopJ+c2PRzrCLmlM96lZT1n770925t5uLvJOktGna6HsAKeNdG17k7KL7B3XrHTCBfVI4/f7J69Vu9vBdobbwWKiCpHJilaInaDmG2/QioAk97D8UNcPp2CAGiiQR0mLWs8Y+QTv6+CGnJURtH+DgFkVhQ/VRG4l1a2Zj+nV68A0TO4E+EWxU3CXL+P9qm3EBaJU02g53nTAMODfmNS60
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 21:49:57.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cec524d-b737-470d-37c1-08d61442b077
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Jim,

On Thu, Sep 06, 2018 at 04:42:57PM -0400, Jim Quinlan wrote:
> Adds the PCIe nodes for the Broadcom STB PCIe root complex.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
>  4 files changed, 64 insertions(+)

Do you have a preference for how this gets merged? If it goes via the
PCI tree then for patches 8 & 9:

    Acked-by: Paul Burton <paul.burton@mips.com>

Still looking at patch 6.

Thanks,
    Paul
