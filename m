Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 04:16:13 +0200 (CEST)
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:39831
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990393AbeGYCQKNYYiu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 04:16:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEwNmgGIROX2Xjl5sMUV3KyPrUPtMQg/J+OgBz/NPaQ=;
 b=eVCE8RmVLEarOPYZ6PGYiSSZcQQYP2orGW2DH6LjAUk4ncpKuQzFzDsErldzxpqV3v6fYB/+VNkS2R7bU7hzCZ0haVshBfiORXrEbZlJ2y90zrB+LSaucF12Q3VaLFjb/WIZ0wjIgjIi2kR+35gHC4wx0k3meeqGMfomyPoedIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Wed, 25 Jul 2018 02:15:59 +0000
Date:   Tue, 24 Jul 2018 19:15:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 00/25] MIPS: ath79: convert target to pure OF
Message-ID: <20180725021555.rol2kafsztwqqkgt@pburton-laptop>
References: <20180720115842.8406-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:405:2::28) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 672b1797-3e5c-48a3-d715-08d5f1d4902d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:Yh3StO/KH5J9uCS7PTETHBdrpEd5d/STACZdY+DYXe5igBi8qY8E0wV6lDQvrvyisudHihwkWN3vWGs/KplioJrRSMNgb/h+K9TB29BB6ZoVi6x2rLmGokzXTNWYLGvhFu847ogqk4KnQxPEJ9WxEpiJPwF9rTP2RoJ3ODXQ/L0PYq70ocTcE3ohTXQ9yyNzOWvXqgd/gef/dCHZCdYjyeR1pajaG4cjK2m9gdol2qtSANVKviOy9+/0NDmPmdWX;25:oF6wV/PqgOXqQE9bC38uRUHv/ltvCXXZhDuHItvSXcvJCP6vE04YANEhSw9Vn9bmuat1hyXUmk9yFXTGxA2KIi6zTLfcIjPJjNRMtdCAWqkasAZ0CZM1CRbTU/lGm/EN/i9z61Bp0y3O+6opdsBwf6frQw11/lQH8gGu9qd9+m/5EVCM9+HB4OL7OhvV7LIOGLI0uoOOoOOdQaRhPUcKJ9OKssp6dWEGJxvwLLq2rQDF8NsFWaQcpY+E0DdCZRHaqHS/Nqj4K8YzXInHkFCuUBUqaQmeet4P93yfIa3iq3FkolXdyVLT5y/0vlNwOI57O3J1dACt0bK61rUthDcAqg==;31:tdTEwGonMCDxVOKlJRq0gtv2Suy527Q6xy9LVQ3doQR+JIZpv6LZl/nOUw+huk7OYoF3Sp8qThlvgeKnXfxmgA70STNGgXLdTqXMe05gDw1xVtXvshzCC2RrStOsnTzXxJZgXPU3mtrxE3kjxzdDhwtp4p00LqffvGhKnpjWoV7/elHghyfL4HWnb0wJQQV989OJJeO3M9DFjya9VNUj86kfi4GXlGzvhiN3ggxGFHo=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:z6ZxGXsHyMSFvBWfOkybXtRbJPrHy5oXKYY3BQD3zUh39X7fxj0N+eDi2KdWGZ0aa7QVRpuiLGbAX0XNkUivjTP89kbjZjS9wDipZxV+KxgrCw4jCYk1CasmS7l1xVKhpleU/c6+lA/lIwOI07uTVXn4X/AfOuhe850dpGms7co7WknMo0unVrFPQLQxxd7TV/xBRezN1Fm6ec1t1HfrQyECVGESemwPYKxkKtOwhWcIoMWgja5szUBjd39ZAOio;4:859dN0Gz+ZxwkZegdCi8RA8FTjPCyDN56X5kvk+2t78jnsCTuDsPyv4B28y3YYRz4ewAqryr2iWi+27Y+YJhYIBrbtR4Ohw4UiI6uZHqvhjCj1SKaOG5wvsn5segLJK810/OEGc5VU6RiPoqP7/lXRIB0VdizXdiePz8/Fq9tEIAmRm4/oQtvFpPUbntIIHnWKwPHffjrLUZplJcjjhglcBBg172jnuwsHmnZhpbb4NDErxc5UWr6VC/ikjpUMqrYNaCdhXeRJvD4L4+js5kLglLBD4fVqi0FOg/o9uetNeaMzxJplmzzhO1Nh/XRgbu
X-Microsoft-Antispam-PRVS: <BYAPR08MB493415A639B3E4BCE8038D15C1540@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39840400004)(396003)(366004)(136003)(376002)(189003)(199004)(50466002)(386003)(105586002)(2906002)(305945005)(186003)(16526019)(5660300001)(76506005)(476003)(106356001)(8936002)(446003)(6666003)(6916009)(68736007)(11346002)(4326008)(7736002)(8676002)(26005)(9686003)(33896004)(42882007)(956004)(25786009)(478600001)(52116002)(316002)(66066001)(33716001)(54906003)(1076002)(229853002)(58126008)(44832011)(97736004)(6246003)(53936002)(6486002)(6496006)(81166006)(486006)(6116002)(76176011)(3846002)(47776003)(16586007)(23726003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:UhhejF85zljydUG3/erAw6Ih+vdh22ULX85FwyZ0h?=
 =?us-ascii?Q?XjIO4u0v3u1xl9/Lpxct0YNjXJv1WXpu+y6DCp71YgdnzAQIzmIJ1lj8GPdT?=
 =?us-ascii?Q?p6FfFaVH8SiK6trFUXZPOspn6z+ypVpbsb0Vi7XJ573OA2ANu2ngQoyEeUb9?=
 =?us-ascii?Q?FoTHradjNJGTTFOG4SKezVOEoZ4zjd7yNDzKVGNpHBfqfmNbDO7EdWesuY1+?=
 =?us-ascii?Q?YPX0L0uLzsxQhK0n5O0O5xurYPnSuWANW6aqvjvzIPaOZb/MmNhlpF8k8v8O?=
 =?us-ascii?Q?xUP1ZqJfQJvi8EbG3VEnGBDIh5zRW0IFrD44KPvhssq66nvMko9y0OmCG1uA?=
 =?us-ascii?Q?stEgFebTlXa6lTuyJVXOjHbRS6GxiQm6lRxalKYMvFgEPyGiJZ4Gz30XnQqV?=
 =?us-ascii?Q?xQB04lio1T3qhYb2YwAXoPPAgpXnManqvHpFrIea8oGTS9rkDa8EykPx0XQ9?=
 =?us-ascii?Q?0KByFMKX5lT9G6d8sj3yy1rwlbvD4MfKvC2gL6Ohpgf1LMK7eMN6HHgVK+Ox?=
 =?us-ascii?Q?PIg55EesVI4lXnZh8ki0hGqtl11YorHrCLeMYJHMUSwxSy5ZTGZQGuNb7CpR?=
 =?us-ascii?Q?acnayedrgT7VfuQn9Tn2KmzFkRHZmlcmeTgzahLyv6llJkvXPB868ZHQXjeQ?=
 =?us-ascii?Q?iq8KTvDkJaS0/5lOHUVHDDL0xqi7N6ZzKkf4KNv+eRN8xTU6+j7mnTD4rhza?=
 =?us-ascii?Q?Z0+S+allotQje/jPWW9RnUDcMp6/UC8mUi89e4vj92wVSfAoln5t8JJMEeau?=
 =?us-ascii?Q?eVETzn+LUy0RN1yLGq872eiF8LP5SfN/pgpbxx/7Ibkx+lpMavGuUrcpXN42?=
 =?us-ascii?Q?ZXJWf0xvBrqsKjGYytDR1oPCGANHNhEPttIRFIf7i5na0PP8XXHwtpMErvfW?=
 =?us-ascii?Q?mBj4viRvCTuESXPL7qI9haK/IL/FNI1FhswkHTzH+EGbbqWbsIBz16gk7iMk?=
 =?us-ascii?Q?md3BmYu5PsThkBhtv2zXynXYYeqVMqVhNrsyuInTU0W1EV0mCvtkCEJ4AprS?=
 =?us-ascii?Q?3GWFQMjfrFl4OJagx31Q1PFgSFadU/hKHtZZRSzzqqL5HCfs6w37AxoO7fNy?=
 =?us-ascii?Q?6X0KPsCccDv9HYRu8P8kIKBCEBaXTdvB2n42GEOl5akBFpXzMHVHioqkqICV?=
 =?us-ascii?Q?wzHqvB/ZqeA55LD3nJ/YstztFY8x+umY576e85J381lKUkMBrl6QWl0SPIjT?=
 =?us-ascii?Q?ihmDL0hGtQTSK4/jgaRO339RS/6HniTVdPgvbFv+WZhHy8tyvrvRVZoQ+TEo?=
 =?us-ascii?Q?PjOvNXbmiF28Ecza4YKGtviBqmqQj4nsqvx+t/4Lz3YX+Q3DNfNoPZk4cYmo?=
 =?us-ascii?Q?yLKliuR18+IT08ppQHHfAw=3D?=
X-Microsoft-Antispam-Message-Info: GOASRGZ3rwd1Q7ixGLpbjTP55zIgG83oMyshC91ebF/eDGHORkGsIIZon+swt5zzsFu1s38BT8Vag3UwAD6SrCjW9V8ZwpkECK1EZTAs/EgKuZ/HrXl0kxBkhQFxXPYIYVrlZ7R5kv3FD7Fs52k3n1ftYK5qzFmpVXuxepOG5xZ7UPtdJY+riMOExA3elWZu5xglSKS3j6xvkXErrk3qe1WREfP1UGUondwCeMeNHhUDTUz3nXiYeEe6iT2koe5TSV2CnlT6DqRPb0Pujg+TlQbO4k9P1RUDRuCMU+1Gi9OEbFaCGMCnoITdqnRaQzeBj5Zr3An4atmj0f8AFRWEz6HB/PD/11ZNPg7x6QraxEI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:ing0xnSgIsyC0hPMtTzaHztdCC/rKmNWqLGOERrJFgLC1Ju0h6rE97oFk/CvDpDdW3+ZEbPnPASqS5YfZytLhS9lOTinL4UMbfGxKr8B4bxQ3mGIap/0mhyzLrdUsGpSCocUx0/4FTgQHPi2cuM/If+bDjVFC3k+RhtOrJG3n4NanuwgVagaJA1n6cwCJE6QYcbh/2vZXM4U+DG91oySU1U9kzLQSNZx0zn9e48fuKTnNtrDgqu9XP42uKGOa5l9ahkiGNbwDjJMNNJRB6ySUL5xGKNMFKmZ6qhV4C8hus18DCo0h3U1UoKAPgRanC4cdjqJUH6LFVEJBraE+tnHrlNonAjAPnj9qnTmPmveLxOBYm1gYxWGuj6Qw0kUW8JkSSlB7wPQb1jWDqstzfy8fXqlm2yovRBTkp6CSY0wodL1YA+xHsx3ELa3eHaD0osDIbdTx7vHC/rIr49NU5pDVg==;5:KC+IByT20DlEDfJU/3EGZohmwz5JYctG9YpfqerrBtbT1dIe+k3Rt8Kvlo3L1R7vd3/fvFgFbXDuB/AUHEchZiqiQu1kCKVnJ5svyEUGJ5ZwjMMQJ16JqWLb7wbxCmFLsLtGs2uXR6ULV6g+POoWSOWs/Lc/yw6ZlRvBwfg31CE=;7:CnNy+82SLVt+VTyh+qzqyvc5/+J+Vx4pHerNkJEA3R8GPB8qYruJj0obnvEkJ4LFMX4N5n4iFx+CeCx6TiIxmO9jVv9yI37y8THLZASCDaZqGrnnXFKlb9rgdC3Nwi/d+uDSxd27aBLkUsZY+rjn25mkGd47G8OVX8jE0hbXC7x+/sd5M6Q1b4rUAOm0nDFPeSOSXhz28Fy+PSnzWmbtVK0eW/WI8Ai99TdGrxdMzqC87Wb6cueWAoJCMzPp3VsX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 02:15:59.3795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672b1797-3e5c-48a3-d715-08d5f1d4902d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65128
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

Hi John,

On Fri, Jul 20, 2018 at 01:58:17PM +0200, John Crispin wrote:
> In the last couple of months we have been conevrting this target to OF
> inside OpenWrt. This series is an aggragte of all the patches that have
> been produced in that period. There have been plenty of dts contributions
> already and we hope to be able to drop the old mach file based target in
> the not too distant future.
> 
> Felix Fietkau (9):
>   MIPS: ath79: fix register address in ath79_ddr_wb_flush()
>   MIPS: ath79: fix system restart
>   MIPS: ath79: finetune cpu-overrides
>   MIPS: ath79: add helpers for setting clocks and expose the ref clock
>   MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc
>     init
>   MIPS: ath79: pass PLL base to clock init functions
>   MIPS: ath79: make specifying the reference clock in DT optional
>   MIPS: ath79: support setting up clock via DT on all SoC types
>   MIPS: ath79: export switch MDIO reference clock
> 
> Gabor Juhos (2):
>   MIPS: ath79: add lots of missing registers
>   MIPS: ath79: enable uart during early_prink
> 
> John Crispin (12):
>   MIPS: ath79: select the PINCTRL subsystem
>   dt-bindings: PCI: qcom,ar7100: adds binding doc
>   MIPS: pci-ar71xx: convert to OF
>   dt-bindings: PCI: qcom,ar7240: adds binding doc
>   MIPS: pci-ar724x: convert to OF
>   MIPS: ath79: drop legacy IRQ code
>   MIPS: ath79: drop machfiles
>   MIPS: ath79: drop legacy pci code
>   MIPS: ath79: drop platform device registration code
>   MIPS: ath79: drop !OF clock code
>   MIPS: ath79: sanitize symbols
>   spi: ath79: drop pdata support
> 
> Mathias Kresin (1):
>   MIPS: ath79: get PCIe controller out of reset
> 
> Matthias Schiffer (1):
>   MIPS: ath79: add support for QCA953x QCA956x TP9343

Patch 4 is in for v4.18-rc7.

I've applied patches 1-3,5-8 to mips-next for 4.19 (with a couple of
tweaks to patch 7 addressing Sergei's comments).

Patches 9-25 need DT binding review.

One general question I have: where is the DT for these systems being
maintained? It doesn't appear to be in-tree - could it be? Because I
don't see the DT source it's difficult to see what impact the remaining
changes will have - for example would they break backwards compatibility
with any systems?

Thanks,
    Paul
